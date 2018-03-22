package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import les12018.dominio.Ativacao;
import les12018.dominio.Autor;
import les12018.dominio.Categoria;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;
import les12018.dominio.Inativacao;
import les12018.dominio.Livro;

public class LivroDAO extends AbstractJdbcDAO {
	public LivroDAO() {
		super("tb_livro", "id_livro");
	}
	@Override
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;		
		
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO tb_livros(LIV_TITULO, LIV_ANO,"
					+ " LIV_EDICAO, LIV_ISBN, LIV_NUMPAG, LIV_SINOPSE, LIV_ALTURA,"
					+ " LIV_LARGURA, LIV_PESO, LIV_PROFUNDIDADE, LIV_CODBARRAS,"
					+ " LIV_ISATIVO, LIV_AUT_ID, LIV_EDI_ID, LIV_GRP_ID, LIV_DATACADASTRO)");
			sql.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, livro.getTitulo());
			pst.setString(2, livro.getAnoPub());
			pst.setString(3, livro.getEdicao());
			pst.setString(4, livro.getISBN());
			pst.setString(5, livro.getNumPaginas());
			pst.setString(6, livro.getSinopse());
			pst.setDouble(7, livro.getAltura());
			pst.setDouble(8, livro.getLargura());
			pst.setDouble(9, livro.getPeso());
			pst.setDouble(10, livro.getProfundidade());
			pst.setString(11, livro.getCodBarras());
			pst.setBoolean(12, livro.isAtivo());
			pst.setInt(13, livro.getAutor().getId());
			pst.setInt(14, livro.getEditora().getId());
			pst.setInt(15, livro.getGP().getId());
			pst.setDate(16, (Date) livro.getDtCadastro());
			
			pst.executeUpdate();
			
			connection.commit();
			
			for(Categoria categoria:livro.getCategorias()) {
				sql = new StringBuilder();
				sql.append("INSERT INTO tb_contem(CON_LIV_ID, CON_CAT_ID) ");
				sql.append("VALUES (?,?)");
				
				pst = connection.prepareStatement(sql.toString());
				
				pst.setInt(1, livro.getId());
				pst.setInt(2, categoria.getId());
				
				pst.executeUpdate();
				
				connection.commit();
			}
			
		} catch (SQLException e) {
			try {
				connection.rollback();
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}  finally {
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public void alterar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE tb_livros SET LIV_TITULO=?, LIV_ANO=?,LIV_EDICAO=?, LIV_ISBN=?,"
					+ " LIV_NUMPAG=?, LIV_SINOPSE=?, LIV_ALTURA=?, LIV_LARGURA=?, LIV_PESO=?, "
					+ " LIV_PROFUNDIDADE=?, LIV_CODBARRAS=?,LIV_ISATIVO=?, LIV_AUT_ID=?, "
					+ " LIV_EDI_ID=?, LIV_GRP_ID=?");
			sql.append("WHERE LIV_ID=?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, livro.getTitulo());
			pst.setString(2, livro.getAnoPub());
			pst.setString(3, livro.getEdicao());
			pst.setString(4, livro.getISBN());
			pst.setString(5, livro.getNumPaginas());
			pst.setString(6, livro.getSinopse());
			pst.setDouble(7, livro.getAltura());
			pst.setDouble(8, livro.getLargura());
			pst.setDouble(9, livro.getPeso());
			pst.setDouble(10, livro.getProfundidade());
			pst.setString(11, livro.getCodBarras());
			pst.setBoolean(12, livro.isAtivo());
			pst.setInt(13, livro.getAutor().getId());
			pst.setInt(14, livro.getEditora().getId());
			pst.setInt(15, livro.getGP().getId());
			pst.setInt(16, livro.getId());				
			
			pst.executeUpdate();
			
			connection.commit();
			
			sql = new StringBuilder();
            sql.append(" SELECT max(ID_Livro) from livros;");
            pst = connection.prepareStatement(sql.toString());
            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                livro.setId(rs.getInt("ID_Livro"));
            }
			
			for(Categoria categoria:livro.getCategorias()) {
				sql = new StringBuilder();
				sql.append("UPDATE tb_contem SET CON_LIV_ID=?, CON_CAT_ID=? ");
				sql.append("WHERE LIV_ID=?");
				
				pst = connection.prepareStatement(sql.toString());
				
				pst.setInt(1, livro.getId());
				pst.setInt(2, categoria.getId());
				pst.setInt(3, livro.getId());
				
				pst.executeUpdate();
				
				connection.commit();
			}
			
		} catch (SQLException e) {
			try {
				connection.rollback();
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}  finally {
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public void excluir(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE tb_livros SET LIV_ISATIVO=? ");
			sql.append("WHERE LIV_ID=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setBoolean(1, false);
			pst.setInt(2, livro.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("INSERT INTO tb_inativacao(INA_JUSTIFICATIVA, INA_CTI_ID )");
			sql.append(" VALUES(?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, livro.getInativacao().getMotivo());
			pst.setInt(2, livro.getInativacao().getCategoria().getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
			} catch (SQLException e) {
				try {
					connection.rollback();
				}catch (SQLException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			}  finally {
				try {
					pst.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	}
	
	@Override
	public List<EntidadeDominio> consultar (EntidadeDominio entidade){
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		List<EntidadeDominio> livros = new ArrayList<EntidadeDominio>();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM tb_livros AS livro ");
		sql.append("LEFT JOIN tb_autor AS autor");
		sql.append(" ON(livro.LIV_AUT_ID = autor.AUT_ID) ");
		sql.append("LEFT JOIN tb_editora AS editora");
		sql.append(" ON(livro.LIV_EDI_ID = editora.EDI_ID) ");
		sql.append("LEFT JOIN tb_grupoprecificacao AS grupop");
		sql.append(" ON(livro.LIV_GRP_ID = grupop.GRP_ID) ");
		sql.append("LEFT JOIN tb_contem AS contem");
		sql.append(" ON(livro.LIV_ID = contem.CON_LIV_ID) ");
		sql.append("LEFT JOIN tb_categoria AS categoria");
		sql.append(" ON(categoria.CAT_ID = contem.CON_CAT_ID AND");
		sql.append(" livro.LIV_ID = contem.CON_LIV_ID) ");
		sql.append("LEFT JOIN tb_inativacao AS inativacao");
		sql.append(" ON(livro.LIV_ID = inativacao.INA_LIV_ID");
		sql.append("LEFT JOIN tb_ativacao AS ativacao");
		sql.append(" ON(livro.LIV_ID = ativacao.ATI_LIV_ID");
		sql.append("LEFT JOIN tb_categoriaativacao AS catativacao");
		sql.append(" ON(ativacao.ATI_CTA_ID = catativacao.CTA_ID");
		sql.append("LEFT JOIN tb_categoriainativacao AS catinativacao");
		sql.append(" ON(inativacao.INA_CTI_ID = catinativacao.CTI_ID");
		sql.append("WHERE 1=1\\n");
		if(livro.getTitulo() != null && livro.getTitulo().length() >0) {
			sql.append(" AND LIV_TITULO = '" + livro.getTitulo()+"'");
		}
		if(livro.getAnoPub() != null && livro.getAnoPub().length() >0) {
			sql.append(" AND LIV_ANO= '" + livro.getAnoPub() + "'");
		}
		if(livro.getEditora().getNome() != null && livro.getEditora().getNome().length() > 0) {
			sql.append(" AND LIV_EDI_ID= '" + livro.getEditora().getId() + "'");
		}
		if(livro.getAutor().getNome() != null && livro.getAutor().getNome().length() > 0) {
			sql.append(" AND LIV_AUT_ID= '" + livro.getAutor().getNome() + "'");
		}
		if(livro.getCategorias().get(0).getNome() != null && livro.getCategorias().get(0).getNome().length() > 0) {
			sql.append(" AND LIV_CAT_ID= '" + livro.getCategorias().get(0).getId());
		}
		if(livro.getISBN() != null && livro.getISBN().length() >0) {
			sql.append(" AND LIV_ISBN= '" + livro.getISBN() + "'");
		}
		if(livro.getEstoque() == 1) {
			sql.append(" AND LIV_QTDESTOQUE > 0");
		}
		try {
			if(livro.isAtivo()) {
				sql.append(" and LIV_ISATIVO= '" + livro.isAtivo());
			} else if(!livro.isAtivo()) {
				sql.append(" and LIV_ISATIVO= '" + livro.isAtivo());
			}
		} catch (NullPointerException e) {
			//TODO: handle exception
		}
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				Livro li = new Livro();
				Autor aut = new Autor();
				Editora edi = new Editora();
				GrupoPrecificacao gp = new GrupoPrecificacao();
				Inativacao ina = new Inativacao();
				Ativacao ati = new Ativacao();
				
				li.setAutor(aut);
				li.setEditora(edi);
				li.setGP(gp);
				li.setInativacao(ina);
				li.setAtivacao(ati);
				
				li.setId(rs.getInt("LIV_ID"));
				li.getAutor().setId(rs.getInt("LIV_AUT_ID"));
				li.setTitulo(rs.getString("LIV_TITULO"));
				li.setAnoPub(rs.getString("LIV_ANO"));
				li.setEdicao(rs.getString("LIV_EDICAO"));
				li.setCodBarras(rs.getString("LIV_ISBN"));
				li.setISBN(rs.getString("LIV_ISBN"));
				li.setAltura(rs.getInt("LIV_ALTURA"));
				li.setPeso(rs.getDouble("LIV_PESO"));
				li.setLargura(rs.getDouble("LIV_LARGURA"));
				li.setProfundidade(rs.getDouble("LIV_PROFUNDIDADE"));
				li.getGP().setId(rs.getInt("LIV_GRP_ID"));
				li.getGP().setNome(rs.getString("GRP_NOME"));
				li.getGP().setPorcentagem(rs.getInt("GRP_PRLUCRO")/100);
				li.getAutor().setNome(rs.getString("AUT_NOME"));
				li.getAutor().setId(rs.getInt("AUT_ID"));
				li.getEditora().setNome(rs.getString("EDI_NOME"));
				li.getEditora().setId(rs.getInt("LIV_EDI_ID"));
				li.setDtCadastro(rs.getDate("LIV_DATACADASTRO"));
				li.setAtivo(rs.getBoolean("LIV_ISATIVO"));
				li.getAtivacao().setId(rs.getInt("ATI_ID"));
				li.getAtivacao().setMotivo(rs.getString("ATI_JUSTIFICATIVA"));
				li.getAtivacao().getCategoria().setId(rs.getInt("CTA_ID"));
				li.getAtivacao().getCategoria().setNome(rs.getString("CTA_NOME"));
				li.getInativacao().setId(rs.getInt("LIV_INA_ID"));
				li.getInativacao().setMotivo(rs.getString("INA_JUSTIFICATIVA"));
				li.getInativacao().getCategoria().setId(rs.getInt("CTI_ID"));
				li.getInativacao().getCategoria().setNome(rs.getString("CTI_NOME"));
				
				for(int i=0;rs.next(); i++) {
					li.getCategorias().add(null);
					li.getCategorias().get(i).setNome(rs.getString("CAT_NOME"));
					li.getCategorias().get(i).setId(rs.getInt("CAT_ID"));
				}
				
				livros.add(li);
			}
		} catch (SQLException e) {
			try {
				connection.rollback();
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}  finally {
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return livros;
	}
}
