package compilador;

import java.io.*;

public class Compilador {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java compilador.Compilador <arquivo_entrada>");
            System.exit(1);
        }

        String inputFile = args[0];

        try {
            System.out.println("--- Iniciando Compilação do Arquivo: " + inputFile + " ---");
            
            // 1. Análise Léxica (Scanner é chamado pelo Parser)
            System.out.println("\n--- Etapa 1: Análise Léxica (Tokens gerados pelo Scanner) ---");
            // O Scanner será instanciado e chamado dentro do Parser.
            // Para demonstração separada (opcional), poderíamos rodar TesteAnalisadorLexico aqui.
            // Mas a integração já demonstra isso implicitamente.

            // 2. Análise Sintática (Parser)
            System.out.println("\n--- Etapa 2 e 3: Análise Sintática e Integração (Parser processando tokens) ---");
            Scanner scanner = new Scanner(new FileReader(inputFile));
            parser p = new parser(scanner); 
            
            // Executa a análise sintática. 
            // As ações semânticas no .cup (System.out.println) serão executadas durante o parse.
            // Se houver erros sintáticos, o parser os reportará.
            p.parse(); 

            System.out.println("\n--- Compilação Concluída (Análise Léxica e Sintática) ---");
            System.out.println("Arquivo \"" + inputFile + "\" processado com sucesso.");
            System.out.println("Nota: A árvore sintática não está sendo explicitamente construída ou impressa neste exemplo, apenas mensagens de reconhecimento de regras (se houver) e erros sintáticos.");

        } catch (FileNotFoundException e) {
            System.err.println("Erro: Arquivo não encontrado: " + inputFile);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Erro de I/O ao ler o arquivo: " + inputFile);
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            // Captura erros de análise sintática ou outros erros inesperados
            System.err.println("\n--- Erro Durante a Compilação ---");
            System.err.println(e.getMessage());
            System.exit(1);
        }
    }
}

