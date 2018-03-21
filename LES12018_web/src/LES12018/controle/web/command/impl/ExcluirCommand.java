package LES12018.controle.web.command.impl;

import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;

public class ExcluirCommand extends AbstractCommand{
	
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.excluir(entidade);
	}
}
