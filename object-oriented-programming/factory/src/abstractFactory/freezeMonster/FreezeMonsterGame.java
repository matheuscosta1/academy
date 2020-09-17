package abstractFactory.freezeMonster;

import abstractFactory.framework.PartsGameFactory;
import abstractFactory.framework.InvadersLikeGame;

public class FreezeMonsterGame extends InvadersLikeGame {
    public FreezeMonsterGame(PartsGameFactory factory){
        super(factory);
    }

    public static void main(String[] args){
        FreezeMonsterGame freezeMonsterGame = new FreezeMonsterGame(new FreezeMonsterFactory());
        System.out.println(freezeMonsterGame.toString());
    }
}
