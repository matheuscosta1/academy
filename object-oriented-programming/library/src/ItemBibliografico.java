public class ItemBibliografico {
	private String titulo;    
	private int ano;    
	
	public ItemBibliografico (String titulo, int ano) {        
		this.setTitulo(titulo);        
		this.setAno(ano);    
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
}
