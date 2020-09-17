/* TRABALHO FINAL DA DISCIPLINA "PROGRAMA��O ORIENTADA � OBJETOS 1" (POO1) - 2018/1
 * UNIVERSIDADE FEDERAL DE UBERL�NDIA (UFU)
 * TEMA: CAMPO MINADO DA SELE��O BRASILEIRA DE FUTEBOL
 * AUTORIA: @BiancaCristina e @alberttneto 
 */

package br.ufu.facom.poo1.campominado.interfacegraph;

import java.io.File;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

public class Audio {	
	public Audio() {}
	
	
	public void playSom(String somNome){
	//RECEBE AUDIO FORMATO WAV E REPRODUZ
	   try 
	   {
	    AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(new File(somNome).getAbsoluteFile( ));
	    Clip clip = AudioSystem.getClip( );
	    clip.open(audioInputStream);
	    clip.start( );
	   }
	   catch(Exception ex)
	   {
	     System.out.println("Error with playing sound.");
	     ex.printStackTrace( );
	   }
	 }
	//FIM DO METODO PLAYSOM
}
