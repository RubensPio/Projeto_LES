package LES12018.core.impl.negocio;

import LES12018.core.IStrategy;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;

public class CategoriaInativacao implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Livro) {
			Livro livro = (Livro)entidade;
			int CodIna = livro.getInativacao().getCategoria().getId();
			
			if(CodIna == 0)
				return "É necesssário informar um Motivo de inativação de um livro";
		}
		return null;
	}
}
