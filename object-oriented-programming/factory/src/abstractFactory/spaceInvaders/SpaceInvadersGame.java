package abstractFactory.spaceInvaders;

import abstractFactory.framework.PartsGameFactory;
import abstractFactory.framework.InvadersLikeGame;

public class SpaceInvadersGame extends InvadersLikeGame {
    public SpaceInvadersGame(PartsGameFactory fabrica){
        super(fabrica);
    }

    public static void main(String[] args){
        SpaceInvadersGame spaceInvadersGame = new SpaceInvadersGame(new SpaceInvadersFactory());
        System.out.println(spaceInvadersGame.toString());
    }
}
