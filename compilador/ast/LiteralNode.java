package compilador.ast;

public class LiteralNode extends ASTNode {
    public String valor;

    public LiteralNode(String valor) {
        this.valor = valor;
    }

    @Override
    public void imprimir(String prefixo) {
        System.out.println(prefixo + "Literal: " + valor);
    }
}
