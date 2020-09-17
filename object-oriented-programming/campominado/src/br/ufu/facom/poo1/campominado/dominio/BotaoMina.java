/* TRABALHO FINAL DA DISCIPLINA "PROGRAMAÇÃO ORIENTADA À OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERLÂNDIA (UFU)
 * TEMA: CAMPO MINADO DA SELEÇÃO BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.dominio;
import java.util.ArrayList;
import javax.swing.ImageIcon;

public class BotaoMina {
	// CLASSE QUE GUARDA OS ICONES COM QUANTIDADE DE MINA
	private ArrayList<ImageIcon> botoesMina;
	
	public BotaoMina() {
		botoesMina = new ArrayList<ImageIcon>();
		
		// GUARDA AS IMAGENS
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\fundo.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N1.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N2.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N3.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N4.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N5.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N6.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N7.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N8.PNG")));
		botoesMina.add(new ImageIcon(("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\N9.PNG")));
		// FIM 
	}
	
	public ImageIcon retornaIcone(int index) {
		// RETORNA A IMAGEM COM A QUANTIDADE DE MINAS À PARTIR DE UM INDEXADOR QUE ACESSA O ARRAYLIST
		return botoesMina.get(index);
	}
}
