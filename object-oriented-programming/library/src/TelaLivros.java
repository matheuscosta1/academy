import javax.swing.*;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TelaLivros extends JFrame {    
	private JPanel mainPanel = new JPanel();
	private JPanel buttonPanel = new JPanel();

	private JLabel lbTitulo = new JLabel("Titulo: ");    
	private JLabel lbAutor = new JLabel("Autor: ");    
	private JLabel lbAno = new JLabel("Ano:");    

	private JTextField tfTitulo = new JTextField(20);    
	private JTextField tfAutor = new JTextField(20);    
	private JTextField tfAno = new JTextField(6);    
	private JButton btIncluir = new JButton("Incluir");
	private JButton btListagem = new JButton("Listagem");
	private JButton btRevistas = new JButton("Revistas");   
	
	Acervo acervo;
	TelaRevistas telaRevistas;
	TelaListagem telaListagem;
	
	public TelaLivros (String frameTitulo, Acervo a, TelaRevistas tR, TelaListagem tL) {        
		super(frameTitulo);        
		acervo = a;
		telaRevistas = tR;
		telaListagem = tL;
		this.setSize(400, 150);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);        
       
		this.add(mainPanel, BorderLayout.CENTER);
		this.add(buttonPanel, BorderLayout.SOUTH);
		mainPanel.setLayout(new GridLayout(3,2)); 
		mainPanel.add(lbTitulo); 
		mainPanel.add(tfTitulo);
		mainPanel.add(lbAno);
		mainPanel.add(tfAno);
		mainPanel.add(lbAutor);
		mainPanel.add(tfAutor);
	    buttonPanel.add(btIncluir);
	    buttonPanel.add(btRevistas);
	    buttonPanel.add(btListagem);
		btIncluir.addActionListener(new ActionListener() {            
			@Override            
			public void actionPerformed(ActionEvent e) {                
				String tit = tfTitulo.getText();                
				String aut = tfAutor.getText();                
				int an = Integer.parseInt(tfAno.getText());                     
				Livro livro = new Livro(tit, aut, an);                
				acervo.addItem(livro);                
				limparCampos();            
			}        
		});        
		btRevistas.addActionListener(new ActionListener() {            
			@Override            
			public void actionPerformed(ActionEvent e) {                
				telaRevistas.setVisible(true);                
				TelaLivros.this.setVisible(false);            
			}        
		});        
		btListagem.addActionListener(new ActionListener() {            
			@Override            
			public void actionPerformed(ActionEvent e) {                
				telaListagem.mostrar();            
			}        
		});    
	}    
	public void limparCampos() {        
		tfTitulo.setText("");        
		tfAutor.setText("");        
		tfAno.setText("");    
	}    
}
