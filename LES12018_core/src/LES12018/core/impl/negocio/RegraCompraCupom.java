package LES12018.core.impl.negocio;

import LES12018.core.IStrategy;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Pedido;

public class RegraCompraCupom implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		System.out.println("Alou");
		if(entidade instanceof Pedido) {
			Pedido ped = (Pedido)entidade;
			if(ped.getCupomPromocional() != null && (ped.getCuponsTroca().size() == 0 && ped.getCartao().size() == 0)) {
				return "Não é possivel pagar Apenas com cupom de Troca";
			}
		}
		return null;
	}

}
