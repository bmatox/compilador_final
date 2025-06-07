package compilador.ast;

public class VarNode extends ASTNode {
    public String nome;

    public VarNode(String nome) {
        this.nome = nome;
    }

    @Override
    public void imprimir(String prefixo) {
        System.out.println(prefixo + "Variável: " + nome);
    }
}
