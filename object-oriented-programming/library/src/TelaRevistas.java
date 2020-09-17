import javax.swing.*;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TelaRevistas extends JFrame {
	private JPanel mainPanel = new JPanel();
	private JPanel buttonPanel = new JPanel();

	private JLabel lbTitulo = new JLabel("Titulo: ");    
	private JLabel lbOrg = new JLabel("Org: ");    
	private JLabel lbAno = new JLabel("Ano:");    
	private JLabel lbVol = new JLabel("Vol:");    
	private JLabel lbNro = new JLabel("Nro:");    

	private JTextField tfTitulo = new JTextField(20);
	private JTextField tfOrg = new JTextField(20);
	private JTextField tfAno = new JTextField(6);
	private JTextField tfVol = new JTextField(3);
	private JTextField tfNro = new JTextField(3);

	private JButton btIncluir = new JButton("Incluir");
	private JButton btListagem = new JButton("Listagem");
	private JButton btLivros = new JButton("Livros");

	Acervo acervo = new Acervo();
	TelaLivros telaLivros;
	TelaListagem telaListagem;

	
	public TelaRevistas(String tit, Acervo a) {
		super(tit);
		this.acervo = a;		
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(400, 200);
		this.setLayout(new BorderLayout());
		this.add(mainPanel, BorderLayout.CENTER);
		this.add(buttonPanel, BorderLayout.SOUTH);
        mainPanel.setLayout(new GridLayout(5,2));
		mainPanel.add(lbTitulo);
		mainPanel.add(tfTitulo);
		mainPanel.add(lbOrg);
		mainPanel.add(tfOrg);
		mainPanel.add(lbVol);
	    mainPanel.add(tfVol);
	    mainPanel.add(lbNro);
		mainPanel.add(tfNro);
	    mainPanel.add(lbAno);
	    mainPanel.add(tfAno);
	
	    buttonPanel.add(btIncluir);
	    buttonPanel.add(btLivros);
	    buttonPanel.add(btListagem);
		btIncluir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				String tit = tfTitulo.getText();
				String o = tfOrg.getText();
				int v = Integer.parseInt(tfVol.getText());
				int n = Integer.parseInt(tfNro.getText());
				int an = Integer.parseInt(tfAno.getText());
				Revista revista = new Revista(tit, an, o, v, n);
				acervo.addItem(revista);
				limparCampos();
			}
		});
		btLivros.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				telaLivros.setVisible(true);
				TelaRevistas.this.setVisible(false);
			}
		});
		btListagem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				telaListagem.mostrar();
			}
		});
	}

	public void setLinks (TelaLivros telaLivros, TelaListagem telaListagem) {
		this.telaLivros = telaLivros;
		this.telaListagem = telaListagem;

	}
	private void limparCampos() {
		tfTitulo.setText("");
		tfOrg.setText("");
		tfVol.setText("");
		tfNro.setText("");
		tfAno.setText("");
	}
}
