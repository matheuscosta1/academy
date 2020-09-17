package abstractFactory.tenisMesa;

import abstractFactory.framework.PartsGameFactory;
import abstractFactory.framework.InvadersLikeGame;

public class TenisMesaGame extends InvadersLikeGame {
    public TenisMesaGame(PartsGameFactory fabrica){
        super(fabrica);
    }

    public static void main(String[] args){
        TenisMesaGame jogoTenisMesa = new TenisMesaGame(new FabricaPecasTenisMesa());
        System.out.println(jogoTenisMesa.toString());
    }
}
