package abstractFactory.framework;

public interface PartsGameFactory {
    Control createControl();
    ScrollableObject createScrollableObject();
    Obstacle createObstacle();
    Ground createGround();
    Bullet createBullet();
}
