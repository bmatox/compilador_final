package compilador;

import java.io.*;
import java_cup.runtime.Symbol;

public class TesteAnalisadorLexico {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java compilador.TesteAnalisadorLexico <arquivo_entrada>");
            System.exit(1);
        }

        String inputFile = args[0];

        try {
            System.out.println("Analisando arquivo: " + inputFile);
            Scanner scanner = new Scanner(new FileReader(inputFile));
            Symbol token;
            do {
                token = scanner.next_token();
                if (token.sym != sym.EOF) {
                    System.out.print("Token: " + sym.terminalNames[token.sym]);
                    if (token.value != null) {
                        System.out.print(" \tValor: " + token.value);
                    }
                    System.out.println(" \tLinha: " + (token.left + 1) + " Coluna: " + (token.right + 1));
                }
            } while (token.sym != sym.EOF);

            System.out.println("\nAnálise léxica concluída com sucesso.");

        } catch (FileNotFoundException e) {
            System.err.println("Erro: Arquivo não encontrado: " + inputFile);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Erro de I/O ao ler o arquivo: " + inputFile);
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Erro inesperado durante a análise léxica:");
            e.printStackTrace();
            System.exit(1);
        }
    }
}

