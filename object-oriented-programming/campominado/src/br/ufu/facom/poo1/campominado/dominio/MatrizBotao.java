/* TRABALHO FINAL DA DISCIPLINA "PROGRAMA��O ORIENTADA � OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERL�NDIA (UFU)
 * TEMA: CAMPO MINADO DA SELE��O BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.dominio;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Random;

import javax.swing.BorderFactory;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import br.ufu.facom.poo1.campominado.interfacegraph.*;

public class MatrizBotao {
	
	private Cronometro cronometro;
	private GridBagConstraints cons;
	private GridBagLayout layout;
	private JFrame janela;
	private JPanel contadores, campo, cont, cr;
	private JLabel contBomba;
	private JButton smile;
	private Icon ney;
	private Botao matrizBotao[][];
	private int tamanho;
	private int qtd_bombas;
	private int qtd_bandeiras;
	private Audio audio;
	private BotaoMina icones;
		
	public MatrizBotao(int tamanho) {
	

		cons = new GridBagConstraints();
		layout = new GridBagLayout();
		janela = new JFrame("CAMPO MINADO");
		
		cont = new JPanel();
		cr = new JPanel();
		contadores = new JPanel();
		campo = new JPanel();
		contBomba = new JLabel();
		ney = new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\Ney.JPG");
		smile = new JButton(ney);
		
		this.matrizBotao = new Botao[tamanho][tamanho];
		cronometro = new Cronometro();
		audio = new Audio();
		icones = new BotaoMina();
	}

	public void atualizaTamanho(int tamanho) {
		// SETA O TAMANHO DO CAMPO
		this.tamanho = tamanho;
	}
	
	public void atualizaBombas(int bombas) {
		// SETA A QUANTIDADE DE BOMBAS DO CAMPO
		this.qtd_bombas = bombas;
		this.qtd_bandeiras = bombas;
	}
	
	public void atualizaIcone(ImageIcon icone) {
		//ATUALIZA O ICONE
		this.ney = icone;
	}
	
	public void janelaSize(int i, int j) {
		// ATUALIZA O TAMANHO DA JANELA
		janela.setSize(i, j);
	}
	
	public void criaMatriz () {
		// CRIA A MATRIZ DE BOT�O 
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				matrizBotao[i][j] = new Botao();
				matrizBotao[i][j].inicializaBotao(i,j);

				campo.add(matrizBotao[i][j].retornaBotao());
				janela.getContentPane().add(campo, BorderLayout.CENTER);				
			}
		}
		 
		
		// COLOCANDO CRONOMETRO EM UM JPANEL E DETERMINANDO CARACTERISTICAS
		cr.setBackground(Color.BLACK);
		cr.setBorder(BorderFactory.createMatteBorder(4, 1, 4, 1, new Color(139, 71, 38)));
		cr.add(cronometro.init());
		cr.setPreferredSize(new Dimension(135, 60));
		
		
		// COLOCANDO CONTADOR DE BOMBAS EM UM JPANEL E DETERMINANDO CARACTERISTICAS
		contBomba.setText(Integer.toString(qtd_bandeiras));
		Font digital = cronometro.getFonte(50);
		cont.add(contBomba);
		cont.setBackground(new Color(28, 28, 28));
		cont.setBorder(BorderFactory.createMatteBorder(4, 1, 4, 1, new Color(139, 71, 38)));
        contBomba.setForeground(Color.GREEN);
        contBomba.setFont(digital);
        cont.setPreferredSize(new Dimension(60, 60));
        
        // BOTAO CENTRAL
        smile.setMargin(new Insets(0, 0, 0, 0));
        smile.setBorderPainted(false);
		
		// ORGANIZANDO JPANEL SUPERIOR
        contadores.setLayout(layout);
        cons.fill = GridBagConstraints.BOTH;
        cons.insets = new Insets(0, 110, 0, 100);
		contadores.setBackground(new Color(255,255,000));
		contadores.add(cont);
		contadores.add(smile, cons);
		contadores.add(cr);
				
		// ORGANIZANDO JANELA
		campo.setLayout(new GridLayout(tamanho, tamanho ));
		janela.getContentPane().add(contadores, BorderLayout.NORTH);
		janela.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);	
		cronometro.iniciarCr(); // INICIAR CRONOMETRO
	}
	
	public boolean verificaTamanho() {
		// VERIFICA O TAMANHO
		if (tamanho == 0 || tamanho < 0) return false;
		else return true;
	}
	
	public int retornaTamanho() {
		// DEVOLVE O TAMANHO DO CAMPO
		return this.tamanho;
	}
	public void abreJanela() {
		// ABRE A JANELA DO CAMPO
		janela.setVisible(true);
	}
	
	public void posicionaMina() {
		// POSICIONA AS MINAS ALEATORIAMENTE NO CAMPO
		Random geradorLinha = new Random();
		Random geradorColuna = new Random();
				
		int qtd_minas = 0;
		
		while (qtd_minas < qtd_bombas)
		{
			int i = geradorLinha.nextInt(tamanho); // VAI DE 0 A TAMANHO-1
			int j = geradorColuna.nextInt(tamanho); // VAI DE 0 A TAMANHO-1
			
			if (!(matrizBotao[i][j].ehMina()))
			{
				this.matrizBotao[i][j].colocaMina();
				qtd_minas++;
			}
		}		
	}
	
	public void imprimeMatriz() {
		// IMPRIME A MATRIZ CONTROLE
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				if (!(matrizBotao[i][j].ehMina())) matrizBotao[i][j].contaMinas(this.checaVizinhos(i, j));
				
				System.out.print(matrizBotao[i][j].qtdMinas() + " ");
			}		
			
			System.out.println();			
		}
		
		System.out.println();
	}

	public int checaVizinhos(int i,int j) {
		// CHECA QUANTAS BOMBAS UM DETERMINADO BOT�O POSSUI AO REDOR 
		int contador = 0;
		
		if (i-1 >= 0 && matrizBotao[i-1][j].ehMina())
		{
			contador++;
		}
		
		if (i+1 < tamanho && matrizBotao[i+1][j].ehMina())
		{
			contador++;
		}
		
		if (j-1 >= 0 && matrizBotao[i][j-1].ehMina())
		{
			contador++;
		}
		
		if (j+1 < tamanho && matrizBotao[i][j+1].ehMina())
		{
			contador++;
		}
		
		if (i+1 < tamanho && j+1 < tamanho && matrizBotao[i+1][j+1].ehMina())
		{
			contador++;
		}
		
		if (i-1 >= 0 && j-1>=0 && matrizBotao[i-1][j-1].ehMina())
		{
			contador++;
		}
		
		if (i+1 < tamanho && j-1>=0 && matrizBotao[i+1][j-1].ehMina())
		{
			contador++;
		}
		
		if (i-1 >= 0 && j+1 < tamanho && matrizBotao[i-1][j+1].ehMina())
		{
			contador++;
		}
		
		return contador;		
	}
	
	public void trataBotao (int i, int j, MouseListener trataClick) {
		// CANCELA UM BOT�O
		matrizBotao[i][j].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i][j].qtdMinas()));
	}
	
	public boolean posicaoValida (int i, int j) {
		// VERIFICA SE OS INDEX i E j SAO VALIDOS
		if (i>=0 && j>=0 && i<tamanho && j<tamanho && (!matrizBotao[i][j].ehBandeira())) return true;
		else return false;
	}
	
	public boolean botaoValido(int i, int j) {
		// VERIFICA SE A RECURS�O DEVE CONTINUAR NESSE BOT�O OU N�O
		if (matrizBotao[i][j].qtdMinas() == 0 && matrizBotao[i][j].estaHabilitado()) return true;
		else return false;
	}
	
	public boolean botaoHabilitado(int i, int j) {
		// VERIFICA SE UM DETERMINADO BOT�O ESTA HABILITADO
		if (matrizBotao[i][j].estaHabilitado()) return true;
		else return false;
	}
	
	public void revelaBotoes(int i, int j, MouseListener trataClick) {
		// FUNC�O QUE REVELA OS BOTOES CASO N�O SEJA BOMBA
		if (matrizBotao[i][j].qtdMinas() != 0) // SE N�O � 0, S� REVELA O CONTE�DO DELE
		{
			matrizBotao[i][j].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i][j].qtdMinas()));
			return;
		}
		
		else // CASO N�O SEJA 0
		{
			matrizBotao[i][j].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i][j].qtdMinas())); // CANCELA O BOT�O
			
			// LINHAS DE CIMA
			if (this.posicaoValida(i-1, j-1)) // VALIDA POSI��O
				if(this.botaoValido(i-1, j-1))revelaBotoes(i-1,j-1,trataClick); // SE O BOT�O == 0 E ESTIVER HABILITADO, CHAMA A RECURS�O NELE
				else if (matrizBotao[i-1][j-1].estaHabilitado()) matrizBotao[i-1][j-1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i-1][j-1].qtdMinas())); // CASO O BOT�O N�O SEJA == 0 OU N�O ESTIVER HABILITADO, APENAS REVELA ELE
				
			if (this.posicaoValida(i-1, j))   
				if(this.botaoValido(i-1, j))revelaBotoes(i-1,j,trataClick);
				else if (matrizBotao[i-1][j].estaHabilitado()) matrizBotao[i-1][j].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i-1][j].qtdMinas()));
			
			if (this.posicaoValida(i-1, j+1))   
				if(this.botaoValido(i-1, j+1))revelaBotoes(i-1,j+1,trataClick);
				else if (matrizBotao[i-1][j+1].estaHabilitado()) matrizBotao[i-1][j+1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i-1][j+1].qtdMinas()));
			
			// MESMA LINHA
			if (this.posicaoValida(i, j-1))   
				if(this.botaoValido(i, j-1))revelaBotoes(i,j-1,trataClick);
				else if (matrizBotao[i][j-1].estaHabilitado()) matrizBotao[i][j-1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i][j-1].qtdMinas()));
			
			if (this.posicaoValida(i, j+1))   
				if(this.botaoValido(i, j+1))revelaBotoes(i,j+1,trataClick);
				else if (matrizBotao[i][j+1].estaHabilitado()) matrizBotao[i][j+1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i][j+1].qtdMinas()));
			
			// LINHAS DE BAIXO
			if (this.posicaoValida(i+1, j-1))   
				if(this.botaoValido(i+1, j-1))revelaBotoes(i+1,j-1,trataClick);
				else if (matrizBotao[i+1][j-1].estaHabilitado()) matrizBotao[i+1][j-1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i+1][j-1].qtdMinas()));
			
			if (this.posicaoValida(i+1, j))   
				if(this.botaoValido(i+1, j))revelaBotoes(i+1,j,trataClick);
				else if (matrizBotao[i+1][j].estaHabilitado()) matrizBotao[i+1][j].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i+1][j].qtdMinas()));
			
			if (this.posicaoValida(i+1, j+1))   
				if(this.botaoValido(i+1, j+1))revelaBotoes(i+1,j+1,trataClick);
				else if (matrizBotao[i+1][j+1].estaHabilitado()) matrizBotao[i+1][j+1].cancelaBotao(trataClick, this.icones.retornaIcone(this.matrizBotao[i+1][j+1].qtdMinas()));			
		}
	}
	
	public void revelaMinas(MouseListener trataClick, ImageIcon addmina) {
		// REVELA ONDE EST�O TODAS AS MINAS DO CAMPO
		for (int i=0;i<tamanho;i++)
		{
			for (int j=0;j<tamanho;j++)
			{
				if (matrizBotao[i][j].ehMina())
				{		
					matrizBotao[i][j].abreTodas(trataClick, addmina);
				}
			}
		}
	}
	
	public boolean testaBandeiras() {
		// TESTA SE TODOS OS BOT�ES MARCADOS COMO BANDEIRA S�O MINAS
			// SE RETORNAR TRUE, O USUARIO GANHARA O JOGO
			// SE RETORNAR FALSE, N�O ACONTECE NADA POIS O USU�RIO COLOCOU BANDEIRA EM UM BOT�O QUE N�O � MINA
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				if (matrizBotao[i][j].ehBandeira() && (!matrizBotao[i][j].ehMina()))
				{
					return false;
				}
			}
		}
		
		return true;
	}
	
	public void zeraMatriz() {
		// ZERA A MATRIZ DE CONTROLE
		for (int i=0;i<tamanho;i++)
		{
			for (int j=0;j<tamanho;j++)
			{
				matrizBotao[i][j].resetaBotao();
			}
		}
	}
	
	public void reiniciaJogo(MouseListener trataClick) {
		// REINICIA O JOGO AO CLICAR NO "SMILE"
		janela.setVisible(false);
		qtd_bandeiras = qtd_bombas;
		this.zeraMatriz();
		posicionaMina();
		imprimeMatriz();
		
		qtd_bandeiras = qtd_bombas;
		
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				matrizBotao[i][j].reiniciaBotao(trataClick);
			}
		}
		smile.setIcon(new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\Ney.JPG"));
		janela.setVisible(true);
	}
	
	public void fimDeJogo(MouseListener trataClick) {
		// TRAVA O CAMPO MINADO QUANDO ACABAR O JOGO
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				matrizBotao[i][j].fimDeJogo(trataClick);
			}
		}
	}
	
	public void jogarCampoMinado() {	
		// TRATA CLICK DO MOUSE
		MouseListener trataClick = new MouseListener() {
			public void mouseClicked(MouseEvent e) {
				JButton botaoClicado = (JButton)e.getSource();
				int ifixo = botaoClicado.getX(); 
				int jfixo = botaoClicado.getY();
				int l = 0;
				int c = 0; 
				
				// PROCURA QUAL BOTAO FOI CLICADO
				for (int i=0;i<tamanho;i++)
				{
					for (int j=0;j<tamanho;j++)
					{
						if (matrizBotao[i][j].getX() == ifixo && matrizBotao[i][j].getY() == jfixo)
						{
							l = i;
							c = j;
						}						
					}
				}
				// FIM DA PROCURA
				
				if (e.getButton() == MouseEvent.BUTTON1 && (!matrizBotao[l][c].ehBandeira())){	// SE O CLICK FOI COM O BOT�O ESQUERDO	
					
				if (matrizBotao[l][c].ehMina()) // VERIFICA SE � MINA, SE FOR O JOGO ACABA
				{	
					cronometro.pararCr(); // PARAR CRONOMETRO
					ImageIcon addIcon = new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\Galvao.JPG");
					ImageIcon addmina = new ImageIcon("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\BOLA.JPG");

					revelaMinas(this,addmina); // MOSTRA TODAS AS MINAS DO CAMPO
					smile.setIcon(addIcon); // MUDA O ICONE DO "SMILE"
					audio.playSom("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\Gol.WAV"); // SOLTA O AUDIO DE GOL DA ALEMANHA
					fimDeJogo(this); // ACABA O JOGO
				}
				
				else { // CASO N�O SEJA MINA
					revelaBotoes(l,c,this);	// FUN��O QUE ABRE OS BOT�ES 	
				}									
			}
				
				else if (e.getButton() == MouseEvent.BUTTON3) // SE O CLICK FOI COM O BOT�O DIREITO, COLOCA OU RETIRA BANDEIRA DE BOT�O
				{					
						qtd_bandeiras = matrizBotao[l][c].PosicionaBandeira(qtd_bandeiras);
						contBomba.setText(String.format("%02d", qtd_bandeiras)); // MOSTRA QUANTIDADE DE BANDEIRAS
						
						if (qtd_bandeiras == 0)
						{
							if (testaBandeiras()) // SE TODOS OS BOT�ES MARCADOS COMO BANDEIRA FOREM MINAS
							{
								audio.playSom
								("D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\acabou.wav"); // SOLTA AUDIO DE CAMPE�O
								cronometro.pararCr();
								fimDeJogo(this); // FINALIZA O JOGO
							}							
						}
					
				}
				
			}
						
			public void mouseEntered (MouseEvent e) {}; 
			public void mousePressed (MouseEvent e) {};
			public void mouseReleased (MouseEvent e) {};
			public void mouseExited (MouseEvent e) {};			
		};
		// FIM DO CLICK DO MOUSE
		
		for (int i=0;i<tamanho;i++)
		{
			for(int j=0;j<tamanho;j++)
			{
				matrizBotao[i][j].adicionaListener(trataClick);
			}
		}
		
		// REINICIA JOGO 
		ActionListener reiniciaJogo = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JButton botaoClicado = (JButton)e.getSource();
				
				if (botaoClicado.getIcon().equals(smile.getIcon()))
				{
						// REINICIA CRONOMETRO
						cronometro.setContagemTempo(0);
						cronometro.getContagemTempo().setText("00:00");
						cronometro.iniciarCr();
						// REINICIA CRONOMETRO FIM
						
						contBomba.setText(Integer.toString(qtd_bombas)); // REINICIA O CONTADOR DE BOMBAS
						
						reiniciaJogo(trataClick); // REINICIA O CAMPO
				}
			}
		};
		
		smile.addActionListener(reiniciaJogo); 
		// FIM DO REINICIA JOGO	
	}
	
	
}
