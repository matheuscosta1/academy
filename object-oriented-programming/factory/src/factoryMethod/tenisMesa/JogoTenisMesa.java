package factoryMethod.tenisMesa;


import factoryMethod.framework.JogoPongLike;
import factoryMethod.framework.ObjetoDeslocavel;

public class JogoTenisMesa extends JogoPongLike {
    public JogoTenisMesa(){
    }

    @Override
    public ObjetoDeslocavel criaObjetoDeslocavel(){
        return new BolinhaTenisMesa();
    }

    public static void main(String[] args){
        JogoTenisMesa jogoTenisMesa = new JogoTenisMesa();
        System.out.println(jogoTenisMesa.toString());
    }
}
