def generate_write_stimulus(weight_matrix, delay=2):

    if len(weight_matrix) != 16:
        raise ValueError("weight_matrix must have exactly 16 banks.")
    for bank in weight_matrix:
        if len(bank) != 4:
            raise ValueError("Each bank must have exactly 4 rows.")

    code_lines = []
    for bank_id in range(16):
        for row_id in range(4):
            value = weight_matrix[bank_id][row_id]
            # 转为无符号 8-bit 整数（0~255）
            if not (0 <= value <= 255):
                # 支持负数输入（如 -1 → 0xFF）
                value = value & 0xFF
            # 构造 addr: [8:5]=bank, [4:3]=row, [2:0]=0 (col ignored)
            addr = (bank_id << 5) | (row_id << 3)  # col=0
            addr_bin = format(addr, '09b')
            addr_formatted = f"{addr_bin[:4]}_{addr_bin[4:6]}_{addr_bin[6:]}"
            
            hex_value = f"{value:02X}"
            code_lines.append(f"        op_code = 2'b01;")
            code_lines.append(f"        data_in = 16'h0000;")
            code_lines.append(f"        addr = 9'b{addr_formatted};     // bank={bank_id}, row={row_id}")
            code_lines.append(f"        data_bank = 16'h00{hex_value};")
            code_lines.append(f"        #{delay};\n")

    return "\n".join(code_lines)
def print_array_structure(data_matrix):
    if len(data_matrix) != 16:
        raise ValueError("data_matrix must have exactly 16 banks.")
    for bank in data_matrix:
        if len(bank) != 4:
            raise ValueError("Each bank must have exactly 4 rows.")

    print("\n=== In-Memory Computing Array Internal State ===")
    for bank_id in range(16):
        print(f"\nBank {bank_id:2d}:")
        for row_id in range(4):
            val = data_matrix[bank_id][row_id] & 0xFF  # 确保是 8-bit
            # 将字节转为 8 位二进制字符串，MSB 在左（bit7 ... bit0）
            bits = format(val, '08b')
            # 可选：按 col0 ~ col7 显示（col0 = LSB = bit0）
            # 如果硬件中 col0 对应 LSB，则显示顺序应为 reversed
            # 这里假设：data[7:0] → col7 ... col0（常规 Verilog 高位在左）
            # 若实际 col0 是 LSB，可改用：bits = format(val, '08b')[::-1]
            print(f"  Row {row_id}: {bits}  (0x{val:02X})")
    print("\nNote: Bit order shown as [b7 b6 b5 b4 b3 b2 b1 b0] → col7 to col0")

if __name__ == "__main__":
    # 示例：bank0 row0 = 0xFF, bank1 row0 = 0xAA, 其余为 0x00
    write_data = [[0 for _ in range(4)] for _ in range(16)]
    for i in range(16):
        write_data[i][0] = i+0
        write_data[i][1] = i+1
        write_data[i][2] = i+2
        write_data[i][3] = i+3

    # 生成激励代码
    verilog_code = generate_write_stimulus(write_data, delay=2)

    print_array_structure(write_data);