/* TRABALHO FINAL DA DISCIPLINA "PROGRAMAÇÃO ORIENTADA À OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERLÂNDIA (UFU)
 * TEMA: CAMPO MINADO DA SELEÇÃO BRASILEIRA DE FUTEBOL
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
		// INICIALIZA O TIPO BOTÃO
		mina = false;
		habilitado = true;
		bandeira = false;
		qtd_minas = 0;
		botao = new JButton();
	}
	
	public void resetaBotao() {
		// RESETA AS FUNCIONALIDADES MARCADAS PELO BOOLEAN DO BOTÃO
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
		// DEFINE QUE ESSE BOTAO É MINA
		mina = true;
		qtd_minas = 9; 
	}
	
	public void desabilita() {
		// DESABILITA O BOTAO
		habilitado = false;
		botao.setEnabled(false);
	}
	
	public boolean ehMina(){
		// RETORNA TRUE SE FOR MINA, FALSE SE NÃO FOR
		return this.mina;
	}
	
	public boolean estaHabilitado() {
		// RETORNA TRUE SE O BOTÃO ESTÁ HABILITADO, FALSE CASO NÃO ESTEJA
		return this.habilitado;
	}
	
	public void contaMinas(int minas) {
		// SETA A QUANTIDADE DE MINAS AO REDOR DE UM BOTÃO
		this.qtd_minas = minas;
	}
	
	public int qtdMinas() {
		// DEVOLVE A QUANTIDADE DE MINAS AO REDOR DO BOTÃO
		return this.qtd_minas;
	}
	
	public void adicionaListener(MouseListener trataClick) {
		// ADICIONA UM MOUSE LISTENER AO BOTÃO
		botao.addMouseListener(trataClick);
	}
	
	
	public void cancelaBotao(MouseListener trataClick, ImageIcon icone) {
		// DESABILITA O BOTÃO E RETIRA SUAS FUNCIONALIDADES
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
		// RETORNA A POSIÇÃO X DE UM BOTÃO
		return botao.getX();
	}
	
	public int getY() {
		// RETORNA A POSIÇÃO Y DE UM BOTÃO
		return botao.getY();
	}
	
	public void abreTodas(MouseListener trataClick, ImageIcon addmina) {
		// REVELA ONDE ESTÃO TODAS AS MINAS
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
		if (qtd_bandeiras >= 0 && bandeira == true) // RETIRA BANDEIRA (PROVAVELMENTE USUÁRIO ERROU ALGUMA BANDEIRA)
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
			ImageIcon bandeiraTaça = new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\BandeiraTaça2.PNG");
			botao.setIcon(bandeiraTaça);
			bandeira = true;
			qtd_bandeiras--;
			return qtd_bandeiras;
		}
		
		return qtd_bandeiras;
	}

	public boolean ehBandeira() {
		// DEVOLVE TRUE SE UM BOTÃO ESTÁ MARCADO COMO BANDEIRA, FALSO CASO NÃO ESTEJA
		if (bandeira == true) return true;
		else return false;
	}
	
	public void reiniciaBotao(MouseListener trataClick) {
		// REINICIA AS FUNCIONALIDADES DE UM BOTÃO
		botao.setIcon(null);
		botao.setFocusable(true);
		botao.setContentAreaFilled(true);
		botao.setEnabled(true);
		botao.setBackground(new Color(144, 238, 144));
		botao.addMouseListener(trataClick);
		botao.setText("  ");
	}
}
