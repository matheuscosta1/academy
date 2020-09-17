
public class Revista extends ItemBibliografico {
	private String org;
	private int vol;
	private int nro;

	public Revista(String titulo, int ano, String org, int vol, int nro) {
		super(titulo, ano);
		this.org = org;
		this.vol = vol;
		this.nro = nro;
	}

	@Override
	public String toString() {
		return "Revista: " + getTitulo() + " | Org.: " + org + " | Vol.:" + vol + " | Nro.: " + nro + " | Ano:" + getAno();
	}
}
