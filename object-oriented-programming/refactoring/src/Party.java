abstract public class Party {
    protected String name;

    public Party(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public abstract int getAnnualCost();
    public abstract int getHeadCount();
}
