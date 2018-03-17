package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import les12018.dominio.EntidadeDominio;
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
					+ " LIV_ISATIVO, LIV_AUT_ID, LIV_EDI_ID, LIV_GRP_ID)");
			sql.append(" VAUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString(), 
					Statement.RETURN_GENERATED_KEYS);
			
			pst.setString(1, livro.getTitulo());
			pst.setString(2, livro.getAnoPub());
			pst.setString(3, livro.getEdicao());
			pst.setString(4, livro.getISBN());
			pst.setInt(5, livro.getNumPaginas());
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
			pst.executeUpdate();
			
			ResultSet rs = pst.getGeneratedKeys();
			int id=0;
			if(rs.next())
				id = rs.getInt(1);
			livro.setId(id);
			
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
			pst.setInt(5, livro.getNumPaginas());
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
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
	
	@Override
	public void excluir(EntidadeDominio entidade) {
		
	}
	
	@Override
	public List<EntidadeDominio> consultar (EntidadeDominio entidade){
		return
	}
}
