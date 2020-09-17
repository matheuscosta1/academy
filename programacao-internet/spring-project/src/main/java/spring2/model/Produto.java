package spring2.model;

public class Produto {
    private String nome;
    private String price;

    public Produto(){

    }

    public Produto(String name, String price){
        super();
        this.nome = name;
        this.price = price;
    }

    public void setName(String nome) {
        this.nome = nome;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getName() {
        return nome;
    }

    public String getPrice() {
        return price;
    }
}
