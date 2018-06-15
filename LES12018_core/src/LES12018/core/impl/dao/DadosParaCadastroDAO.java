package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import LES12018.core.impl.dao.AbstractJdbcDAO;
import les12018.auxiliar.DadosParaCadastro;
import les12018.dominio.Autor;
import les12018.dominio.CatAtivacao;
import les12018.dominio.CatInativacao;
import les12018.dominio.Categoria;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;

public class DadosParaCadastroDAO extends AbstractJdbcDAO{
	public DadosParaCadastroDAO() {
		super("table", "idTable");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		DadosParaCadastro dadosCad = new DadosParaCadastro();
		Autor a = new Autor();
		Editora edi = new Editora();
		Categoria cat = new Categoria();
		CatInativacao cti = new CatInativacao();
		CatAtivacao cta = new CatAtivacao();
		GrupoPrecificacao gp = new GrupoPrecificacao();
		
		dadosCad.setAutores(new ArrayList<Autor>());
		dadosCad.setCategoria(new ArrayList<Categoria>());
		dadosCad.setCategoriasDeAtivacao(new ArrayList<CatAtivacao>());
		dadosCad.setCategoriasDeInativacao(new ArrayList<CatInativacao>());
		dadosCad.setEditora(new ArrayList<Editora>());
		dadosCad.setPrecificacoes(new ArrayList<GrupoPrecificacao>());
		
		try {
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM tb_autor");
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			
			while(rs.next()) {
				a = new Autor();
				a.setNome(rs.getString("AUT_NOME"));
				a.setId(rs.getInt("AUT_ID"));
				dadosCad.getAutores().add(a);
			}
			
			sql = new StringBuilder();
			sql.append("SELECT * FROM tb_editora");
			pst = connection.prepareStatement(sql.toString());
			rs = pst.executeQuery();
			
			while(rs.next()) {
				edi = new Editora();
				edi.setNome(rs.getString("EDI_NOME"));
				edi.setId(rs.getInt("EDI_ID"));
				dadosCad.getEditora().add(edi);
			}
			
			sql = new StringBuilder();
			sql.append("SELECT * FROM tb_categoria");
			pst = connection.prepareStatement(sql.toString());
			rs = pst.executeQuery();
			
			while(rs.next()) {
				cat = new Categoria();
				cat.setNome(rs.getString("CAT_NOME"));
				cat.setId(rs.getInt("CAT_ID"));
				dadosCad.getCategoria().add(cat);
			}
			
			sql = new StringBuilder();
			sql.append("SELECT * FROM tb_grupoprecificacao");
			pst = connection.prepareStatement(sql.toString());
			rs = pst.executeQuery();
			
			while(rs.next()) {
				gp = new GrupoPrecificacao();
				gp.setNome(rs.getString("GRP_NOME"));
				gp.setId(rs.getInt("GRP_ID"));
				gp.setPorcentagem(rs.getInt("GRP_PRLUCRO"));
				dadosCad.getPrecificacoes().add(gp);
			}
			
			sql = new StringBuilder();
			sql.append("SELECT * FROM tb_categoriaativacao");
			pst = connection.prepareStatement(sql.toString());
			rs = pst.executeQuery();
			
			while(rs.next()) {
				cta = new CatAtivacao();
				cta.setNome(rs.getString("CTA_NOME"));
				cta.setId(rs.getInt("CTA_ID"));
				dadosCad.getCategoriasDeAtivacao().add(cta);
			}
			
			sql = new StringBuilder();
			sql.append("SELECT * FROM tb_categoriainativacao");
			pst = connection.prepareStatement(sql.toString());
			rs = pst.executeQuery();
			
			while(rs.next()) {
				cti = new CatInativacao();
				cti.setNome(rs.getString("CTI_NOME"));
				cti.setId(rs.getInt("CTI_ID"));
				dadosCad.getCategoriasDeInativacao().add(cti);
			}
			
			ArrayList<EntidadeDominio> kk = new ArrayList<EntidadeDominio>();
			kk.add(dadosCad);
			
			return kk;	
		} catch (SQLException e) {
				e.printStackTrace();
		}	
		return null;
	}

	@Override
	public void ativar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
