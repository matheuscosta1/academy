package abstractFactory.spaceInvaders;

import abstractFactory.framework.*;

public class SpaceInvadersFactory implements PartsGameFactory {

    @Override
    public Control createControl() {
        return null;
    }

    @Override
    public ScrollableObject createScrollableObject() {
        return new Player();
    }

    @Override
    public Obstacle createObstacle() {
        return new Enemy();
    }

    @Override
    public Ground createGround() {
        return new Map();
    }

    @Override
    public Bullet createBullet() {
        return new Shot();
    }
}
