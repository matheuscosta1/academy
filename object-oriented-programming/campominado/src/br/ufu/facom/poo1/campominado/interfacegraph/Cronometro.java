/* TRABALHO FINAL DA DISCIPLINA "PROGRAMAÇÃO ORIENTADA À OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERLÂNDIA (UFU)
 * TEMA: CAMPO MINADO DA SELEÇÃO BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.interfacegraph;

import java.awt.Color;
import java.awt.Font;
import java.io.File;
import java.io.FileInputStream;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JLabel;



public class Cronometro {
	// OBJETOS DA CLASSE
	private JLabel contagemTempo;
	private Timer tm;
	private int contador = 0;
	private boolean rodando = false;
	
	public JLabel getContagemTempo() {
		return contagemTempo;
	}
	public void setContagemTempo(int contador) {
		this.contador = contador;
	}

	public JLabel init() {		
		// METODO QUE RETORNA O UM JLABEL COM O CRONOMETRO
		Font digital = getFonte(50);
		
		contagemTempo = new JLabel("00:00");
		contagemTempo.setFont(digital);
		contagemTempo.setForeground(Color.GREEN);	
		
		return contagemTempo;
	}
	
	public void iniciarCr() {	
		// INICIA A CONTAGEM DO CRONOMETRO
		if (!rodando) {
		tm = new Timer();
		tm.scheduleAtFixedRate(new TimerTask() {
			@Override
			public void run() {
				contador++;
				rodando = true;
				int seg = contador % 60;
				int min = contador / 60;
				min %= 60; 
				contagemTempo.setText(String.format("%02d:%02d", min, seg));
			}
		}, 1000, 1000);
		}
	}
	
	public void pararCr() {		
		// METODO PARA PARAR CRONOMETRO
		if (rodando) {
			tm.cancel(); // PARAR TIME SE ESTIVER RODANDO
			rodando = false;
			contador = 0;			
		}
		// FIM DO METODO
	}
	
	public Font getFonte( int tamanho ){ 
		// METODO QUE CRIA UMA NOVA FONTE INFORMANDO O TAMANHO.
	    Font font = null;  
	    
	    try{  
	        File file = new File( "D:\\Users\\Bianca\\Desktop\\Facul\\2018-1\\POO1\\CAMPOMINADO - ITENS\\FontDigital.TTF" );  
	        FileInputStream fis = new FileInputStream( file );  
	        font = Font.createFont( Font.TRUETYPE_FONT , fis );  
	        
	    }
	    catch( Exception e )
	    {  
	        System.out.println( e.getMessage() );  
	    } 
	    
	    font = font.deriveFont(Font.PLAIN , tamanho );  
	    return font;  
	    // FIM DO METODO
	}  
}
