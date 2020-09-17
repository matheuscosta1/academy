package abstractFactory.tenisMesa;

import abstractFactory.framework.*;

public class FabricaPecasTenisMesa implements PartsGameFactory {

    @Override
    public Control createControl() {
        return new RaqueteTenisMesa();
    }

    @Override
    public ScrollableObject createScrollableObject() {
        return new BolinhaTenisMesa();
    }

    @Override
    public Obstacle createObstacle() {
        return new MesaTenis();
    }

    @Override
    public Ground createGround() {
        return null;
    }

    @Override
    public Bullet createBullet() {
        return null;
    }
}
