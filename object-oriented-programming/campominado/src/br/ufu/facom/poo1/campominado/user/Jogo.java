/* TRABALHO FINAL DA DISCIPLINA "PROGRAMAÇÃO ORIENTADA À OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERLÂNDIA (UFU)
 * TEMA: CAMPO MINADO DA SELEÇÃO BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.user;


import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;

import br.ufu.facom.poo1.campominado.dominio.*;

public class Jogo {
	public static void main(String[] args) {		
		final JButton iniciante = new JButton("INICIANTE");
		final JButton intermediario = new JButton("INTERMEDIARIO");
		final JButton dificil = new JButton("AVANÇADO");
		final JButton impossivel = new JButton("IMPOSSIVEL");
		
		// DEFININDO PARTE VISUAL DOS BOTÕES
		iniciante.setBackground(new Color(255, 255, 000));
		iniciante.setFont(new Font("Impact", 0, 30));
		intermediario.setBackground(new Color(000, 255, 000));
		intermediario.setFont(new Font("Impact", 0, 30));
		dificil.setBackground(new Color(255, 255, 000));
		dificil.setFont(new Font("Impact", 0, 30));
		impossivel.setBackground(new Color(000, 255, 000));
		impossivel.setFont(new Font("Impact", 0, 30));
		
		
		final JFrame janela = new JFrame("CAMPO MINADO SELEÇÃO BRASILEIRA");
			janela.add(iniciante);
			janela.add(intermediario);
			janela.add(dificil);
			janela.add(impossivel);
			janela.setSize(400, 400);
			janela.setLayout(new GridLayout(4,0));
			janela.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);			
			janela.setVisible(true);
		// FIM DA DEFINIÇÃO VISUAL DOS BOTÕES
		
		ActionListener trataTecla = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JButton botaoClicado = (JButton)e.getSource();
				
				if (botaoClicado.getText().equals("INICIANTE"))
				{
					MatrizBotao campo = new MatrizBotao(8);
					campo.janelaSize(500, 500);
					campo.atualizaTamanho(8);
					campo.atualizaBombas(1);
					janela.dispose();
					campo.criaMatriz();
					campo.posicionaMina();
					campo.imprimeMatriz();
					campo.abreJanela();
					campo.jogarCampoMinado();
				}
				
				else if (botaoClicado.getText().equals("INTERMEDIARIO"))
				{
					MatrizBotao campo = new MatrizBotao(16);
					campo.janelaSize(700, 700);
					campo.atualizaTamanho(16);
					campo.atualizaBombas(40);
					janela.dispose();
					campo.criaMatriz();
					campo.posicionaMina();
					campo.imprimeMatriz();
					campo.abreJanela();
					campo.jogarCampoMinado();
				}
				
				else if (botaoClicado.getText().equals("AVANÇADO"))
				{
					MatrizBotao campo = new MatrizBotao(22);
					campo.janelaSize(800, 770);
					campo.atualizaTamanho(22);
					campo.atualizaBombas(106);
					janela.dispose();
					campo.criaMatriz();
					campo.posicionaMina();
					campo.imprimeMatriz();
					campo.abreJanela();
					campo.jogarCampoMinado();
				}
				
				else if (botaoClicado.getText().equals("IMPOSSIVEL"))
				{
					MatrizBotao campo = new MatrizBotao(30);
					campo.janelaSize(1300, 770);
					campo.atualizaTamanho(30);
					campo.atualizaBombas(360);
					janela.dispose();
					campo.criaMatriz();
					campo.posicionaMina();
					campo.imprimeMatriz();
					campo.abreJanela();
					campo.jogarCampoMinado();
				}				
			}
		};
		
		iniciante.addActionListener(trataTecla);
		intermediario.addActionListener(trataTecla);
		dificil.addActionListener(trataTecla);
		impossivel.addActionListener(trataTecla);
	}
}
