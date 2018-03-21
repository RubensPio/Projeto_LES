package LES12018.controle.web.command;

import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;

public interface ICommand {
	public Resultado execute(EntidadeDominio entidade);
}
