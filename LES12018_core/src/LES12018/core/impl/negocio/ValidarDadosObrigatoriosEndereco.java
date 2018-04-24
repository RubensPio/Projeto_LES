package LES12018.core.impl.negocio;

import java.sql.Date;

import LES12018.core.IStrategy;
import les12018.dominio.Cliente;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;


public class ValidarDadosObrigatoriosEndereco implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
            Cliente cliente = (Cliente)entidade;
            Endereco endereco = null;
            
        
            if(cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() != null) {
            	try {
            		endereco = cliente.getEnderecos().get(0);
            	}catch (Exception e) {
					// TODO: handle exception
				}
            	
            	if(endereco.getCidade() == null || endereco.getBairro() == null   ||  endereco.getCEP() == null ||
	                    endereco.getTipoResidencia() == null || endereco.getTipoLogradouro() == null || endereco.getPais() == null || endereco.getNumerologradouro() == null ||
	                    endereco.getLogradouro() == null || endereco.getEstado() == null)
	                return "Todos os dados cadastrais de endereco são obrigatórios!";
	            if(endereco.getCidade().trim().equals("") || endereco.getBairro().trim().equals("")   ||  endereco.getCEP().trim().equals("") ||
	                    endereco.getTipoResidencia().trim().equals("") || endereco.getTipoLogradouro().trim().equals("") || endereco.getPais().trim().equals("") || endereco.getNumerologradouro().trim().equals("") ||
	                    endereco.getLogradouro().trim().equals("") || endereco.getEstado().trim().equals(""))
	                return "Todos os dados cadastrais de endereco são obrigatórios!";
            } 
            
        } else {
            return "Deve ser registrado um Livro!";
        }
		
		return null;
	}
}
