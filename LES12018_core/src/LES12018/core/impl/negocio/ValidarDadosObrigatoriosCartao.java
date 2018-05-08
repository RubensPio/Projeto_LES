package LES12018.core.impl.negocio;

import java.sql.Date;

import LES12018.core.IStrategy;
import les12018.dominio.Cartao;
import les12018.dominio.Cliente;
import les12018.dominio.EntidadeDominio;


public class ValidarDadosObrigatoriosCartao implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
            Cliente cliente = (Cliente)entidade;
            if(cliente.getId() == null)
            	return null;
            Cartao cartao = null;
            
            if(cliente.getId() != null && cliente.getCartoes().get(0).getsNumCartao() != null) {
            	try {
            		cartao = cliente.getCartoes().get(0);
            	}catch (Exception e) {
					// TODO: handle exception
				}
            	
            	if(cartao.getsNumCartao() == null || cartao.getsNomeTitular() == null || cartao.getsCodSeguranca() == null || cartao.getsBandeira() == null || 
            			cartao.getDtDataVal() == null)
	                return "Todos os dados cadastrais de cartão são obrigatórios!";
	            if(cartao.getsNumCartao().trim().equals("") || cartao.getsNomeTitular().trim().equals("") || cartao.getsCodSeguranca().trim().equals("") || cartao.getsBandeira().trim().equals("") || 
            			cartao.getDtDataVal().trim().equals(""))
	                return "Todos os dados cadastrais de cartão são obrigatórios!";
            }

            
        } else {
            return "Deve ser registrado um Livro!";
        }
		System.out.println("Entra na regra de Cartao");
		return null;
	}
}
