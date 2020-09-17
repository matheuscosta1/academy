package abstractFactory.freezeMonster;

import abstractFactory.framework.*;

public class FreezeMonsterFactory implements PartsGameFactory {

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
