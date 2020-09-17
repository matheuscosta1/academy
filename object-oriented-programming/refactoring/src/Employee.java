import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;


class Employee extends Party {
  private int annualCost;
  private String id;

  public Employee(String name, String id, int annualCost) {
    super(name);
    this.id = id;
    this.annualCost = annualCost;
  }

  @Override
  public int getAnnualCost() {
    return annualCost;
  }

  @Override
  public int getHeadCount() {
    return 1;
  }

  public String getId() {
    return id;
  }
  public String getName() {
    return name;
  }

}

class Department extends Party{
  private String name;
  private Vector items = new Vector();

  public Department(String name) {
    super(name);
  }

  @Override
  public int getAnnualCost() {
    int result = 0;
    Iterator i = items.iterator();
    while (i.hasNext()) {
      Party each = (Party) i.next();
      result += each.getAnnualCost();
    }
    return result;
  }

  @Override
  public int getHeadCount() {

    int headCount = 0;
    Iterator i = items.iterator();
    while(i.hasNext()){
      Party each = (Party) i.next();
      headCount += each.getHeadCount();
    }
    return headCount;
  }

  public Enumeration getItems() {
    return items.elements();
  }
  public void addItem(Party arg) {
    items.addElement(arg);
  }

}