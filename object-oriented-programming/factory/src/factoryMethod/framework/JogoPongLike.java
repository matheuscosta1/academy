package factoryMethod.framework;

public abstract class JogoPongLike {
    ObjetoDeslocavel deslocavel;

    public JogoPongLike(){
        deslocavel = criaObjetoDeslocavel();
    }

    public abstract ObjetoDeslocavel criaObjetoDeslocavel();

    @Override
    public String toString(){
        String result = "O objeto deslocável é " + this.deslocavel.getClass().getName();
        return result;
    }
}
