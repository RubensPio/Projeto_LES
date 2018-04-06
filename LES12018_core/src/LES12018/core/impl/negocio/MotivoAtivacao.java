package LES12018.core.impl.negocio;

import LES12018.core.IStrategy;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;

public class MotivoAtivacao implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Livro) {
			Livro livro = (Livro)entidade;
			String motivo = livro.getAtivacao().getMotivo();
			
			if(motivo == null || motivo.trim().equals(""))
				return "É necesssário informar um Motivo de Ativação de um livro";				
		}
		return null;
	}

}
