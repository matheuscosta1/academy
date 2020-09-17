/* TRABALHO FINAL DA DISCIPLINA "PROGRAMA��O ORIENTADA � OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERL�NDIA (UFU)
 * TEMA: CAMPO MINADO DA SELE��O BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.dominio;

import java.awt.Color;
import java.awt.event.MouseListener;
import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JButton;

public class Botao {
	private boolean mina;
	private boolean habilitado;
	private boolean bandeira;
	private int qtd_minas;
	private JButton botao;
	
	public Botao (){
		// INICIALIZA O TIPO BOT�O
		mina = false;
		habilitado = true;
		bandeira = false;
		qtd_minas = 0;
		botao = new JButton();
	}
	
	public void resetaBotao() {
		// RESETA AS FUNCIONALIDADES MARCADAS PELO BOOLEAN DO BOT�O
		this.mina = false;
		this.habilitado = true;
		this.bandeira = false;
		this.qtd_minas = 0;
	}
		
	public void inicializaBotao(int i,int j) {
		// INICIALIZA UM JBUTTON
		botao = new JButton("");
		botao.setBackground(new Color(154,255,154));
		botao.setBorder(BorderFactory.createLineBorder(Color.BLACK));
	}
	
	public JButton retornaBotao() {
		// RETORNA O BOTAO
		return this.botao;
	}
	
	public void colocaMina() {
		// DEFINE QUE ESSE BOTAO � MINA
		mina = true;
		qtd_minas = 9; 
	}
	
	public void desabilita() {
		// DESABILITA O BOTAO
		habilitado = false;
		botao.setEnabled(false);
	}
	
	public boolean ehMina(){
		// RETORNA TRUE SE FOR MINA, FALSE SE N�O FOR
		return this.mina;
	}
	
	public boolean estaHabilitado() {
		// RETORNA TRUE SE O BOT�O EST� HABILITADO, FALSE CASO N�O ESTEJA
		return this.habilitado;
	}
	
	public void contaMinas(int minas) {
		// SETA A QUANTIDADE DE MINAS AO REDOR DE UM BOT�O
		this.qtd_minas = minas;
	}
	
	public int qtdMinas() {
		// DEVOLVE A QUANTIDADE DE MINAS AO REDOR DO BOT�O
		return this.qtd_minas;
	}
	
	public void adicionaListener(MouseListener trataClick) {
		// ADICIONA UM MOUSE LISTENER AO BOT�O
		botao.addMouseListener(trataClick);
	}
	
	
	public void cancelaBotao(MouseListener trataClick, ImageIcon icone) {
		// DESABILITA O BOT�O E RETIRA SUAS FUNCIONALIDADES
		botao.setFocusable(false);
		botao.setBorder(BorderFactory.createLineBorder(Color.BLACK));
		botao.setContentAreaFilled(false);
		botao.setBackground(new Color(255,000,000));
		botao.setIcon(icone);
		habilitado = false;
		bandeira = false;
		botao.removeMouseListener(trataClick);
		botao.setBackground(new Color(255, 000, 000));
	}
	
	public int getX() {
		// RETORNA A POSI��O X DE UM BOT�O
		return botao.getX();
	}
	
	public int getY() {
		// RETORNA A POSI��O Y DE UM BOT�O
		return botao.getY();
	}
	
	public void abreTodas(MouseListener trataClick, ImageIcon addmina) {
		// REVELA ONDE EST�O TODAS AS MINAS
		botao.setFocusable(false);
		botao.setBorder(BorderFactory.createLineBorder(Color.BLACK));
		botao.setContentAreaFilled(false);
		botao.setBackground(new Color(255,000,000));
		botao.removeMouseListener(trataClick);
		//addmina.setImage(addmina.getImage().getScaledInstance(50, 50, 100)); // COMANDO QUE PODE SER UTIL PRA AJUSTAR A IMAGEM
		botao.setIcon(addmina);		
	}
	
	public void fimDeJogo(MouseListener trataClick) {
		// TRAVA O CAMPO MINADO QUANDO O JOGO ACABA
		botao.setFocusable(false);
		botao.setBorder(BorderFactory.createLineBorder(Color.BLACK));
		botao.removeMouseListener(trataClick);
	}
	
	public int PosicionaBandeira(int qtd_bandeiras) {
		// POSICIONA AS BANDEIRAS 	
		if (qtd_bandeiras >= 0 && bandeira == true) // RETIRA BANDEIRA (PROVAVELMENTE USU�RIO ERROU ALGUMA BANDEIRA)
		{
			botao.setIcon(null);
			bandeira = false;
			qtd_bandeiras++;
			return qtd_bandeiras;
		}
		
		else if (qtd_bandeiras > 0 && bandeira == true) // RETIRA BANDEIRA
		{
			botao.setIcon(null);
			bandeira = false;
			qtd_bandeiras++;
			return qtd_bandeiras;
		}
		
		else if (qtd_bandeiras > 0 && bandeira == false) // COLOCA BANDEIRA
		{
			ImageIcon bandeiraTa�a = new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\BandeiraTa�a2.PNG");
			botao.setIcon(bandeiraTa�a);
			bandeira = true;
			qtd_bandeiras--;
			return qtd_bandeiras;
		}
		
		return qtd_bandeiras;
	}

	public boolean ehBandeira() {
		// DEVOLVE TRUE SE UM BOT�O EST� MARCADO COMO BANDEIRA, FALSO CASO N�O ESTEJA
		if (bandeira == true) return true;
		else return false;
	}
	
	public void reiniciaBotao(MouseListener trataClick) {
		// REINICIA AS FUNCIONALIDADES DE UM BOT�O
		botao.setIcon(null);
		botao.setFocusable(true);
		botao.setContentAreaFilled(true);
		botao.setEnabled(true);
		botao.setBackground(new Color(144, 238, 144));
		botao.addMouseListener(trataClick);
		botao.setText("  ");
	}
}
