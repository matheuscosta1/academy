package spring2.model;

public class Endereco {
	
	private String CEP;
	private String Logradouro;
	private String Cidade;	
	
	public Endereco()
	{
		
	}

	public Endereco(String cEP, String logradouro, String cidade) {
		super();
		CEP = cEP;
		Logradouro = logradouro;
		Cidade = cidade;
	}	
	
	public String getCEP() {
		return CEP;
	}
	public void setCEP(String cEP) {
		CEP = cEP;
	}

	public String getLogradouro() {
		return Logradouro;
	}

	public void setLogradouro(String logradouro) {
		Logradouro = logradouro;
	}

	public String getCidade() {
		return Cidade;
	}

	public void setCidade(String cidade) {
		Cidade = cidade;
	}
	
}