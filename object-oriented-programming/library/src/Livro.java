
public class Livro extends ItemBibliografico {
	private String autor;

	public Livro(String titulo, String autor, int ano) {
		super(titulo, ano);
		this.autor = autor;
	}

	@Override
	public String toString() {
		return "Livro: " + getTitulo() + " | Autor: " + autor + " | Ano: " + getAno();
	}
}
