package LES12018.core.impl.negocio;

import java.util.ArrayList;
import java.util.List;

import LES12018.core.IStrategy;
import LES12018.core.impl.dao.ClienteDAO;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Cliente;

public class ValidarLogin implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente) entidade;
			ClienteDAO clidao = new ClienteDAO();
			Cliente cli = new Cliente();
			List<EntidadeDominio> clientes = clidao.consultar(entidade);
			System.out.println("Entra na regra de negocio");
			if(clientes != null) {
				for(EntidadeDominio c:clientes) {
					cli = (Cliente)c;
					if(cli.getsEmail().equals(cliente.getsEmail()) && cli.getsSenha().equals(cliente.getsSenha()) && cli.getFlgAtivo()){
						System.out.println("Entra no if ?");
						cliente.setsNome(cli.getsNome());
						cliente.setId(cli.getId());
						cliente.setIsAdmin(cli.getIsAdmin());
						cliente.setCartoes(cli.getCartoes());
						cliente.setEnderecos(cli.getEnderecos());
						return null;
					}else {
						System.out.println("Passa pelo else");
						return "Erro no Login";
					}
				}
			}else {
				System.out.println("Passa pelo else 2");
				return "Erro no login";
			}
		}
		System.out.println("Passa pelo ultimo return");
		return "Erro no login";
	}
	
}
