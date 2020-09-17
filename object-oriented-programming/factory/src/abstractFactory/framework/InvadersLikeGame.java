package abstractFactory.framework;

public class InvadersLikeGame {
    PartsGameFactory factory;
    Control control;
    ScrollableObject scrollable;
    Obstacle obstacle;
    Ground ground;
    Bullet bullet;


    public InvadersLikeGame(PartsGameFactory factory){
        this.factory = factory;
        control = factory.createControl();
        scrollable = factory.createScrollableObject();
        obstacle = factory.createObstacle();
        ground = factory.createGround();
        bullet = factory.createBullet();
    }

    public InvadersLikeGame() {

    }

    @Override
    public String toString(){
        String result = "O controle é " + (control != null ? control.getClass().getName() : "Nulo")+ "\n";
        result += "O objeto deslocavel é " + this.scrollable.getClass().getName()+ "\n";
        result += "O obstaculo é " + this.obstacle.getClass().getName()+ "\n";
        result += "O mapa é " + this.ground.getClass().getName() + "\n";
        result += "O tiro é " + this.bullet.getClass().getName();

        return result;
    }
}
