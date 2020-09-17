import javax.swing.*;
import java.util.ArrayList;
public class TelaListagem extends JFrame {    
	private JTextArea textArea1 = new JTextArea();    
	
	Acervo acervo;
	
	
	public TelaListagem (String frameTitulo, Acervo a) {        
		super(frameTitulo);        
		acervo = a;
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);        
		this.setSize(400, 400);        
		this.add(textArea1);        
	}
	
	private void preencherTextArea() {        
		textArea1.setText("");        
		for (int i = 0; i < acervo.size(); i++) {            
			textArea1.append(acervo.getItem(i).toString()+ "\n");        
		}    
	}

	public  void mostrar() {        
		preencherTextArea();        
		this.setVisible(true);    
	}    
}