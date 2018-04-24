package LES12018.core.impl.negocio;

import java.sql.Date;

import LES12018.core.IStrategy;
import les12018.dominio.Cartao;
import les12018.dominio.Cliente;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;


public class ValidarDadosObrigatoriosCliente implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
            Cliente cliente = (Cliente)entidade;
            String Nome = null;
            String email = null;
            Endereco endereco = null;
            String telefone = null;
            String CPF = null;
            String Genero = null;
            Date datanasc = null;
            String passwd = null;
            
            if(cliente.getId() == null) {
	            try {
		            Nome = cliente.getsNome();
		            email = cliente.getsEmail();
		            endereco = cliente.getEnderecos().get(0);
		            telefone = cliente.getsTelefone();
		            CPF = cliente.getsCPF();
		            Genero = cliente.getsGenero();
		            datanasc = cliente.getDtDataNasc();
		            passwd = cliente.getsSenha();
	            }catch(Exception e) {
	            	
	            }
	            if(Nome == null || email ==null || telefone == null   || CPF == null  ||
	                    Genero == null || datanasc == null || passwd == null || endereco.getCidade() == null || endereco.getBairro() == null   ||  endereco.getCEP() == null ||
	                    endereco.getTipoResidencia() == null || endereco.getTipoLogradouro() == null || endereco.getPais() == null || endereco.getNumerologradouro() == null ||
	                    endereco.getLogradouro() == null || endereco.getEstado() == null)
	                return "Todos os dados cadastrais de um livro são obrigatórios!";
	            if(Nome.trim().equals("") || email.trim().equals("") || telefone.trim().equals("") || CPF.trim().equals("")  ||
	                    Genero.trim().equals("") || passwd.trim().equals("") || endereco.getCidade().trim().equals("") || endereco.getBairro().trim().equals("")   ||  endereco.getCEP().trim().equals("") ||
	                    endereco.getTipoResidencia().trim().equals("") || endereco.getTipoLogradouro().trim().equals("") || endereco.getPais().trim().equals("") || endereco.getNumerologradouro().trim().equals("") ||
	                    endereco.getLogradouro().trim().equals("") || endereco.getEstado().trim().equals(""))
	                return "Todos os dados cadastrais de um livro são obrigatórios!";
            }
            
        } else {
            return "Deve ser registrado um Livro!";
        }
		
		return null;
	}
}
