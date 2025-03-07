`timescale 1ns/1ps

module monociclo_tb;

    logic clk;
    logic reset;

    // Instancia o processador monociclo
    monociclo_top DUT (
        .clk(clk),
        .reset(reset)
    );

    // Geração de clock: alterna o sinal a cada 5ns (período de 10ns, 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 1;
        
        // Pulso de reset
        #10 reset = 0; // Após 10ns, desativa o reset

        // Espera algumas instruções serem executadas
        #100;

        // Fim da simulação
        $finish;
    end

endmodule
