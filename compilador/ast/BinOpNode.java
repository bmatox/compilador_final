package compilador.ast;

public class BinOpNode extends ASTNode {
    public String operador;
    public ASTNode esquerda;
    public ASTNode direita;

    public BinOpNode(String operador, ASTNode esquerda, ASTNode direita) {
        this.operador = operador;
        this.esquerda = esquerda;
        this.direita = direita;
    }

    @Override
    public void imprimir(String prefixo) {
        System.out.println(prefixo + "BinOp: " + operador);
        esquerda.imprimir(prefixo + "  ");
        direita.imprimir(prefixo + "  ");
    }
}
