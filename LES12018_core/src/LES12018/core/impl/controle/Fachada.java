package LES12018.core.impl.controle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.java.swing.plaf.motif.MotifBorders;

import LES12018.core.IFachada;
import LES12018.core.IDAO;
import LES12018.core.IStrategy;
import LES12018.core.aplicacao.Resultado;
import LES12018.core.impl.dao.LivroDAO;
import LES12018.core.impl.negocio.LivroCategoria;
import LES12018.core.impl.negocio.MotivoInativacao;
import LES12018.core.impl.negocio.ValidarDadosObrigatoriosLivro;
import les12018.dominio.Livro;
import les12018.dominio.EntidadeDominio;

public class Fachada implements IFachada{
	private Map<String, IDAO> daos;
	private Map<String, Map<String, List<IStrategy>>> rns;
	private Resultado resultado;
	
	public Fachada() {
		daos = new HashMap<String, IDAO>();
		rns = new HashMap<String, Map<String, List<IStrategy>>>();
		
		LivroDAO livroDAO = new LivroDAO();
		
		daos.put(Livro.class.getName(), livroDAO);
		
		ValidarDadosObrigatoriosLivro vDadosObrigatoriosLivro = new ValidarDadosObrigatoriosLivro();
		MotivoInativacao mInativacao = new MotivoInativacao();
		LivroCategoria lCategoria = new LivroCategoria();
		
		List<IStrategy> rnsSalvarLivro = new ArrayList<IStrategy>();
		
		rnsSalvarLivro.add(vDadosObrigatoriosLivro);
		rnsSalvarLivro.add(lCategoria);
		
		List<IStrategy> rnsInativarLivro = new ArrayList<IStrategy>();
		
		rnsInativarLivro.add(mInativacao);
		
		Map<String, List<IStrategy>> rnsLivro = new HashMap<String, List<IStrategy>>();
		
		rnsLivro.put("SALVAR", rnsSalvarLivro);
		rnsLivro.put("INATIVAR", rnsInativarLivro);
		
		rns.put(Livro.class.getName(), rnsLivro);
	}

	@Override
	public Resultado salvar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "SALVAR");
		
		if(msg == null) {
			IDAO dao = daos.get(nmClasse);
			try {
				dao.salvar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possível realizar o registro!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado excluir(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "EXCLUIR");
		
		if(msg == null) {
			IDAO dao = daos.get(nmClasse);
			try {
				dao.excluir(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar o registro!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado alterar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "ALTERAR");
		
		if(msg == null) {
			IDAO dao = daos.get(nmClasse);
			try {
				dao.alterar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar o registro!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado consultar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "CONSULTAR");
		
		if(msg == null) {
			IDAO dao = daos.get(nmClasse);
			try {
				dao.consultar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar o registro!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado visualizar(EntidadeDominio entidade) {
		resultado = new Resultado();
		resultado.setEntidades(new ArrayList<EntidadeDominio>(1));
		resultado.getEntidades().add(entidade);
		return resultado;
	}
	
	private String executarRegras(EntidadeDominio entidade, String operacao) {
		String nmClasse = entidade.getClass().getName();
		StringBuilder msg = new StringBuilder();
		
		Map<String, List<IStrategy>> regrasOperacao = rns.get(nmClasse);
		
		if(regrasOperacao != null) {
			List<IStrategy> regras = regrasOperacao.get(operacao);
			
			if(regras != null) {
				for(IStrategy s:regras) {
					String m = s.processar(entidade);
					
					if(m != null) {
						msg.append(m);
						msg.append("\n");
					}
				}
			}
		}
		
		if(msg.length()>0)
			return msg.toString();
		else
			return null;
	}
	
}
