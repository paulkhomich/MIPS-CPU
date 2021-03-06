// Счетчик команд
// stall - остановка изменения
module pc(
    input stall, clk, rst,
    input [31:0] nextaddr,
    output reg [31:0] addr
);
    always @(posedge clk) begin
        if (rst) addr <= 32'd128; // 128 — адрес пользовательской программы
        else addr <= stall ? addr : nextaddr;
    end
endmodule