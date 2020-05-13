// Регистры процессора (32)
// $0 — только для чтения (Константа 0)
module regfile(
    input clk, rst, writeReg,
    input [4:0] ra1, ra2, wa,
    input [31:0] wd,
    output [31:0] rd1, rd2
);

reg [31:0] list [0:31];

assign rd1 = list[ra1];
assign rd2 = list[ra2];

// Запись стоит производить по negedge'у такта (Т.к. иначе данные просаивают целый такт)
// Чтение комбинационное — значит в конце такта на выходах будет нужное значение
always @(negedge clk) begin
    if (rst) for (integer i = 0; i < 32; i = i+1) begin 
        list[i] <= 32'd0;
    end
    else if (writeReg && wa != 32'd0) list[wa] <= wd;
end

always @(posedge clk) $writememb("./memory/reg.mem", list);

endmodule