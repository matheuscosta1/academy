package spring2.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import spring2.model.Endereco;

@RestController
public class EnderecoController {

	private	List<Endereco> enderecos = new ArrayList<>(Arrays.asList(
			new Endereco("38408100", "Joao Naves de Avila", "Uberlandia"),
			new Endereco("38970000", "Getulio Portela", "Campos Altos")
			)
	);
	
	@GetMapping("/address")
	public List<Endereco> getAllAddress()
	{
		return enderecos;
	}
	
	@RequestMapping("/address/{cep}")
	public ResponseEntity<Endereco> getAddress(@PathVariable String cep)
	{
	    for (Endereco end : enderecos) {
	        if (end.getCEP().equals(cep)) {
	            return ResponseEntity.ok(end);
	        }
	    }
	    return ResponseEntity.notFound().build();
	}
	
	@RequestMapping(method=RequestMethod.POST, value="/address")
	public void addAddress(@RequestBody Endereco endereco)
	{
		this.enderecos.add(endereco);
	}
}




