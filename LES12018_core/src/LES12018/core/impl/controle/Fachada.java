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
		
		Map<String, List<IStrategy>> rnsLivro = new HashMap<String, List<IStrategy>>();
		
		rnsLivro.put("SALVAR", rnsSalvarLivro);
		
		rns.put(Livro.class.getName(), rnsLivro);
	}

	@Override
	public Resultado salvar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Resultado excluir(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Resultado alterar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Resultado consultar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Resultado visualizar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
