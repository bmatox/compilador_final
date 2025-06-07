package compilador;

import java.io.*;
import java_cup.runtime.Symbol;
import compilador.ast.*; // Importa as classes da AST

public class TesteAnalisadorSintatico {

    public static void main(String[] args) {

        if (args.length == 0) {
            System.err.println("Uso: java compilador.TesteAnalisadorSintatico <arquivo_entrada>");
            System.exit(1);
        }

        String inputFile = args[0];

        try {
            System.out.println("Analisando sintaticamente o arquivo: " + inputFile);
            Scanner scanner = new Scanner(new FileReader(inputFile));
            parser p = new parser(scanner);

            // Captura o símbolo retornado pelo parse (contém a AST)
            Symbol s = p.parse();

            // Extrai a raiz da AST
            ASTNode raiz = (ASTNode) s.value;

            // Imprime a árvore
            System.out.println("\nÁrvore Sintática Abstrata (AST):");
            raiz.imprimir("");

        } catch (FileNotFoundException e) {
            System.err.println("Erro: Arquivo não encontrado: " + inputFile);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Erro de I/O ao ler o arquivo: " + inputFile);
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("\nErro durante a análise sintática:");
            System.err.println(e.getMessage());
            System.exit(1);
        }
    }
}
