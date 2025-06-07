package compilador.ast;

public class AssignNode extends ASTNode {
    public VarNode var;
    public ASTNode expressao;

    public AssignNode(VarNode var, ASTNode expressao) {
        this.var = var;
        this.expressao = expressao;
    }

    @Override
    public void imprimir(String prefixo) {
        System.out.println(prefixo + "Atribuição:");
        var.imprimir(prefixo + "  ");
        expressao.imprimir(prefixo + "  ");
    }
}
