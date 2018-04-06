package LES12018.core;

import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;

public interface IFachada {
	public Resultado salvar(EntidadeDominio entidade);
	public Resultado excluir(EntidadeDominio entidade);
	public Resultado ativar(EntidadeDominio entidade);
	public Resultado alterar(EntidadeDominio entidade);
	public Resultado consultar(EntidadeDominio entidade);
	public Resultado visualizar(EntidadeDominio entidade);
}
