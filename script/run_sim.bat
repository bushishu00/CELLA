@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: %~nx0 ^<module_name^>
    echo Example: %~nx0 row_decoder
    pause
    exit /b 1
)

set "MODULE_NAME=%~1"
set "TB_NAME=%MODULE_NAME%_tb"
for %%I in ("%~dp0..") do set "PROJECT_ROOT=%%~fI"
set "SRC_FILE=%PROJECT_ROOT%\src\%MODULE_NAME%.v"
set "TB_FILE=%PROJECT_ROOT%\tb\%TB_NAME%.v"
set "SIM_DIR=%PROJECT_ROOT%\sim"
set "WLF_FILE=%SIM_DIR%\%MODULE_NAME%.wlf"

if not exist "%SRC_FILE%" (
    echo ERROR: Source file not found: %SRC_FILE%
    pause & exit /b 1
)
if not exist "%TB_FILE%" (
    echo ERROR: Testbench not found: %TB_FILE%
    pause & exit /b 1
)

REM 清理旧库和旧波形
if exist "%SIM_DIR%" rmdir /s /q "%SIM_DIR%"
mkdir "%SIM_DIR%"

REM === 1. 库设置 ===
echo [1/3] Setting up library...
vlib "%SIM_DIR%\work" >nul
vmap work "%SIM_DIR%\work" >nul

REM === 2. 编译 ===
echo [2/3] Compiling...
vlog -work work "%SRC_FILE%" "%TB_FILE%"
if !errorlevel! neq 0 (
    echo ERROR: Compilation failed.
    pause & exit /b 1
)

REM === 3. 仿真（关键：加上 -wlf）===
echo [3/3] Running simulation...
vsim -c %TB_NAME% -wlf "%WLF_FILE%" -voptargs="+acc" -do "log -r /*; run -all; quit"
if !errorlevel! neq 0 (
    echo ERROR: Simulation failed.
    pause & exit /b 1
)

REM === 4. 检查 WLF 是否生成 ===
if exist "%WLF_FILE%" (
    echo WLF file generated: %WLF_FILE%
) else (
    echo WLF file NOT generated! (Check permissions or path)
)

REM === 5. 启动 GUI（使用正确的 WLF）===
echo Opening GUI with waveforms...
start "" vsim -gui %TB_NAME% -wlf "%WLF_FILE%" -voptargs="+acc" -do "add wave -r /*; view wave"

echo Done.
pause