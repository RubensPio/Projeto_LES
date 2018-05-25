package LES12018.core.impl.negocio;

import java.util.List;

import LES12018.core.IStrategy;
import LES12018.core.impl.dao.ClienteDAO;
import les12018.dominio.Cliente;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;

public class EnderecoCobrUnico implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente) entidade;
			if(cliente.getId() == null || cliente.getEnderecos().get(0).getCEP() == null)
				return null;
			if(cliente.getEnderecos().get(0).getFlgCobranca() == true && cliente.getId() != null){
				ClienteDAO clidao = new ClienteDAO();
				Cliente cli = new Cliente();
				List<EntidadeDominio> clientes = clidao.consultar(entidade);
				if(clientes != null){
					for(EntidadeDominio c:clientes) {
						cli = (Cliente)c;
						for(Endereco end:cli.getEnderecos()) {
							if(end.getFlgCobranca())
								return "Essa conta já possui um endereco de cobranca";
						}
					}
				}
			}
		}
		return null;
	}

}
