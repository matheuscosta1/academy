public class BibliotecaApp {
	public static void main (String args[]) {
	   Acervo a = new Acervo ();
	   TelaListagem telaListagem = new TelaListagem("Listagem", a);
	   TelaRevistas telaRevistas = new TelaRevistas("Revista", a);
	   TelaLivros telaLivros = new TelaLivros("", a, telaRevistas, telaListagem);
       telaRevistas.setLinks(telaLivros, telaListagem);
       telaLivros.setVisible(true);
	}
}
