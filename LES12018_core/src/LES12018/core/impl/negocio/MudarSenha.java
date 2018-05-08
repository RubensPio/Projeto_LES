package LES12018.core.impl.negocio;

import java.util.List;

import LES12018.core.IStrategy;
import LES12018.core.impl.dao.ClienteDAO;
import les12018.dominio.Cliente;
import les12018.dominio.EntidadeDominio;

public class MudarSenha implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente) entidade;
			String novasenha = cliente.getNovaSenha();
			ClienteDAO clidao = new ClienteDAO();
			Cliente cli = new Cliente();
			if(cliente.getsNome() != null || cliente.getEnderecos() != null) {
				return null;
			}
			List<EntidadeDominio> clientes = clidao.consultar(entidade);
			if(clientes != null) {
				for(EntidadeDominio c:clientes) {
					cli = (Cliente)c;
					if(cli.getsSenha().equals(cliente.getsSenha())){
						cliente.setsSenha(novasenha);
						return null;
					}else {
						return "Senha Atual Inválida !";
					}
				}
			}
		}
		return null;
	}
		
}
