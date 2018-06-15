package LES12018.core.impl.controle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.java.swing.plaf.motif.MotifBorders;
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

import LES12018.core.IFachada;
import LES12018.core.IDAO;
import LES12018.core.IStrategy;
import LES12018.core.aplicacao.Resultado;
import LES12018.core.impl.dao.ClienteDAO;
import LES12018.core.impl.dao.DadosParaCadastroDAO;
import LES12018.core.impl.dao.GraficoDAO;
import LES12018.core.impl.dao.LivroDAO;
import LES12018.core.impl.dao.PedidoDAO;
import LES12018.core.impl.negocio.AlterarEndCobranca;
import LES12018.core.impl.negocio.CategoriaAtivacao;
import LES12018.core.impl.negocio.CategoriaInativacao;
import LES12018.core.impl.negocio.EnderecoCobrUnico;
import LES12018.core.impl.negocio.LivroCategoria;
import LES12018.core.impl.negocio.MotivoAtivacao;
import LES12018.core.impl.negocio.MotivoInativacao;
import LES12018.core.impl.negocio.MudarSenha;
import LES12018.core.impl.negocio.RegraCompraCupom;
import LES12018.core.impl.negocio.ValidarDadosObrigatoriosCartao;
import LES12018.core.impl.negocio.ValidarDadosObrigatoriosCliente;
import LES12018.core.impl.negocio.ValidarDadosObrigatoriosEndereco;
import LES12018.core.impl.negocio.ValidarDadosObrigatoriosLivro;
import LES12018.core.impl.negocio.ValidarLogin;
import les12018.dominio.Livro;
import les12018.dominio.Pedido;
import les12018.dominio.Produto;
import les12018.auxiliar.DadosParaCadastro;
import les12018.dominio.Autor;
import les12018.dominio.CatAtivacao;
import les12018.dominio.Cliente;
import les12018.dominio.DadosParaGrafico;
import les12018.dominio.EntidadeDominio;

public class Fachada implements IFachada{
	private Map<String, IDAO> daos;
	private Map<String, Map<String, List<IStrategy>>> rns;
	private Resultado resultado;
	
	public Fachada() {
		daos = new HashMap<String, IDAO>();
		rns = new HashMap<String, Map<String, List<IStrategy>>>();
		
		LivroDAO livroDAO = new LivroDAO();
		DadosParaCadastroDAO dadosParaCadastroDAO = new DadosParaCadastroDAO();
		ClienteDAO clienteDAO = new ClienteDAO();
		PedidoDAO pedidoDAO = new PedidoDAO();
		GraficoDAO graficoDAO = new GraficoDAO();
		
		daos.put(Livro.class.getName(), livroDAO);
		daos.put(DadosParaCadastro.class.getName(), dadosParaCadastroDAO);
		daos.put(Cliente.class.getName(), clienteDAO);
		daos.put(Pedido.class.getName(), pedidoDAO);
		daos.put(DadosParaGrafico.class.getName(), graficoDAO);
		
		ValidarDadosObrigatoriosLivro vDadosObrigatoriosLivro = new ValidarDadosObrigatoriosLivro();
		MotivoInativacao mInativacao = new MotivoInativacao();
		LivroCategoria lCategoria = new LivroCategoria();
		MotivoAtivacao mAtivacao = new MotivoAtivacao();
		CategoriaAtivacao CatAtiv = new CategoriaAtivacao();
		CategoriaInativacao CatIna = new CategoriaInativacao();
		ValidarLogin VaLogin = new ValidarLogin();
		ValidarDadosObrigatoriosCartao VaCartao = new ValidarDadosObrigatoriosCartao();
		ValidarDadosObrigatoriosEndereco VaEndereco = new ValidarDadosObrigatoriosEndereco();
		ValidarDadosObrigatoriosCliente VaCliente = new ValidarDadosObrigatoriosCliente();
		EnderecoCobrUnico EndCobUnico = new EnderecoCobrUnico();
		AlterarEndCobranca AltEndCob = new AlterarEndCobranca();
		MudarSenha MudarSenha = new MudarSenha();
		RegraCompraCupom CompraCupDis = new RegraCompraCupom();
		
		List<IStrategy> rnsSalvarLivro = new ArrayList<IStrategy>();
		
		rnsSalvarLivro.add(vDadosObrigatoriosLivro);
		rnsSalvarLivro.add(lCategoria);
		
		List<IStrategy> rnsInativarLivro = new ArrayList<IStrategy>();
		
		rnsInativarLivro.add(mInativacao);
		rnsInativarLivro.add(CatIna);
		
		List<IStrategy> rnsAtivacaoLivro = new ArrayList<IStrategy>();
		
		rnsAtivacaoLivro.add(mAtivacao);
		rnsAtivacaoLivro.add(CatAtiv);
		
		List<IStrategy> Login = new ArrayList<IStrategy>();
		
		Login.add(VaLogin);
		
		List<IStrategy> rnsCadastro = new ArrayList<IStrategy>();
		
		rnsCadastro.add(VaCliente);
		rnsCadastro.add(VaCartao);
		rnsCadastro.add(VaEndereco);
		rnsCadastro.add(EndCobUnico);
		
		List<IStrategy> rnsAlterar = new ArrayList<IStrategy>();
		
		rnsAlterar.add(AltEndCob);
		rnsAlterar.add(MudarSenha);
		
		List<IStrategy> rnsCompra = new ArrayList<IStrategy>();
		
		rnsCompra.add(CompraCupDis);
		
		Map<String, List<IStrategy>> rnsLivro = new HashMap<String, List<IStrategy>>();
		Map<String, List<IStrategy>> rnsCliente = new HashMap<String, List<IStrategy>>();
		Map<String, List<IStrategy>> rnsPedido = new HashMap<String, List<IStrategy>>();
		
		rnsLivro.put("SALVAR", rnsSalvarLivro);
		rnsLivro.put("EXCLUIR", rnsInativarLivro);
		rnsLivro.put("ATIVAR", rnsAtivacaoLivro);
		
		rnsCliente.put("LOGAR", Login);
		rnsCliente.put("SALVAR", rnsCadastro);
		rnsCliente.put("ALTERAR", rnsAlterar);
		
		rnsPedido.put("SALVAR", rnsCompra);
		
		rns.put(Livro.class.getName(), rnsLivro);
		rns.put(Cliente.class.getName(), rnsCliente);
		rns.put(Produto.class.getName(), rnsPedido);
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
				System.out.println(entidades.get(0).getClass().getName());
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
	public Resultado ativar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "ATIVAR");
		if(msg == null) {
			IDAO dao = daos.get(nmClasse);
			try {
				dao.ativar(entidade);
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
				resultado.setEntidades(dao.consultar(entidade));
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
	@Override
	public Resultado logar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String msg = executarRegras(entidade, "LOGAR");
		if(msg == null) {
			List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
			entidades.add(entidade);
			resultado.setEntidades(entidades);
		} else {
			resultado.setMsg(msg);
		}
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
