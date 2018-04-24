package LES12018.core.impl.negocio;

import java.util.List;
import java.util.ArrayList;

import LES12018.core.IStrategy;
import LES12018.core.impl.dao.ClienteDAO;
import les12018.dominio.Cartao;
import les12018.dominio.Cliente;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;

public class AlterarEndCobranca implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente) entidade;
			if(cliente.getEnderecos().get(0).getCEP() == null)
				return null;
			if(cliente.getEnderecos().get(0).getFlgCobranca() == true && cliente.getId() != null){
				System.out.println("entra aqui");
				ClienteDAO clidao = new ClienteDAO();
				Cliente cli = new Cliente();
				cli.setId(cliente.getId());
				List<EntidadeDominio> clientes = clidao.consultar((EntidadeDominio)cli);
				if(clientes != null){
					for(EntidadeDominio c:clientes) {
						cli = (Cliente)c;
						for(Endereco end:cli.getEnderecos()) {
							if(end.getFlgCobranca() == true) {
								cli.setCartoes(new ArrayList<Cartao>());
								cli.getCartoes().add(new Cartao());
								System.out.println("Flg: "+end.getFlgCobranca());
								end.setFlgCobranca(false);
								System.out.println(end.getCEP());
								clidao.alterar(cli);
							}
								
						}
					}
				}
			}
		}
		return null;
	}
	
}
