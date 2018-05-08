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
import java.util.concurrent.ExecutorCompletionService;

import LES12018.core.impl.negocio.CategoriaAtivacao;
import les12018.dominio.Ativacao;
import les12018.dominio.Autor;
import les12018.dominio.CatAtivacao;
import les12018.dominio.CatInativacao;
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
			
			sql = new StringBuilder();
            sql.append("SELECT max(LIV_ID) as LiV_iD from tb_livros");
            pst = connection.prepareStatement(sql.toString());
            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                livro.setId(rs.getInt("LIV_ID"));
            }
            
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
		System.out.println(livro.getId());
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE tb_livros SET LIV_TITULO=?, LIV_ANO=?, LIV_EDICAO=?, LIV_ISBN=?, LIV_CODBARRAS=?,");
			sql.append("LIV_NUMPAG=?, LIV_SINOPSE=?, LIV_ALTURA=?, LIV_LARGURA=?, LIV_PESO=?, ");
			sql.append("LIV_PROFUNDIDADE=?, LIV_AUT_ID=?, ");
			sql.append("LIV_EDI_ID=?, LIV_GRP_ID=? ");
			sql.append("WHERE LIV_ID=?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, livro.getTitulo());
			pst.setString(2, livro.getAnoPub());
			pst.setString(3, livro.getEdicao());
			pst.setString(4, livro.getISBN());
			pst.setString(5, livro.getCodBarras());
			pst.setString(6, livro.getNumPaginas());
			pst.setString(7, livro.getSinopse());
			pst.setDouble(8, livro.getAltura());
			pst.setDouble(9, livro.getLargura());
			pst.setDouble(10, livro.getPeso());
			pst.setDouble(11, livro.getProfundidade());
			pst.setInt(12, livro.getAutor().getId());
			pst.setInt(13, livro.getEditora().getId());
			pst.setInt(14, livro.getGP().getId());
			pst.setInt(15, livro.getId());
			
			System.out.println(pst.toString());
			
			pst.executeUpdate();
			
			connection.commit();
			
			if(livro.getCategorias() != null) {
				sql = new StringBuilder();
				sql.append("DELETE FROM tb_contem WHERE CON_LIV_ID=?");
				pst = connection.prepareStatement(sql.toString());
				
				pst.setInt(1, livro.getId());
				
				pst.executeUpdate();
				connection.commit();
				
				for(Categoria categoria:livro.getCategorias()) {
					try {
					sql = new StringBuilder();
					sql.append("INSERT INTO tb_contem(CON_LIV_ID, CON_CAT_ID) ");
					sql.append("VALUES (?,?)");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, livro.getId());
					pst.setInt(2, categoria.getId());
					
					pst.executeUpdate();
					
					connection.commit();
					}catch(Exception e) {
						
					}
				}
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
			sql.append("DELETE FROM tb_inativacao WHERE INA_LIV_ID =?");
			pst = connection.prepareStatement(sql.toString());
			
			pst.setInt(1, livro.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("INSERT INTO tb_inativacao(INA_JUSTIFICATIVA, INA_CTI_ID, INA_LIV_ID )");
			sql.append(" VALUES(?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, livro.getInativacao().getMotivo());
			pst.setInt(2, livro.getInativacao().getCategoria().getId());
			pst.setInt(3, livro.getId());
			
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
	
	public void ativar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE tb_livros SET LIV_ISATIVO=? ");
			sql.append("WHERE LIV_ID=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setBoolean(1, true);
			pst.setInt(2, livro.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("DELETE FROM tb_ativacao WHERE ATI_LIV_ID =?");
			pst = connection.prepareStatement(sql.toString());
			
			pst.setInt(1, livro.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("INSERT INTO tb_ativacao(ATI_JUSTIFICATIVA, ATI_CTA_ID, ATI_LIV_ID )");
			sql.append(" VALUES(?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, livro.getAtivacao().getMotivo());
			pst.setInt(2, livro.getAtivacao().getCategoria().getId());
			pst.setInt(3, livro.getId());
			
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
		PreparedStatement pst2 = null;
		int atual = 0;
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
		sql.append("LEFT JOIN tb_livros_estoque as estoque");
		sql.append(" ON(estoque.LVE_LIV_ID = livro.LIV_ID)");
		/*sql.append("LEFT JOIN tb_contem AS contem");
		sql.append(" ON(livro.LIV_ID = contem.CON_LIV_ID) ");
		sql.append("LEFT JOIN tb_categoria AS categoria");
		sql.append(" ON(categoria.CAT_ID = contem.CON_CAT_ID) ");
		sql.append("LEFT JOIN tb_livros_estoque as estoque");
		sql.append(" ON(estoque.LVE_LIV_ID = livro.LIV_ID)");
		sql.append("LEFT JOIN tb_inativacao as Inativacao");
		sql.append(" ON(Inativacao.INA_LIV_ID = livro.LIV_ID)");
		sql.append("LEFT JOIN tb_categoriainativacao as catinativ");
		sql.append(" ON(catinativ.CTI_ID = Inativacao.INA_CTI_ID");
		sql.append("LEFT JOIN tb_ativacao as Ativacao");
		sql.append(" ON(Ativacao.ATI_LIV_ID = livro.LIV_ID)");
		sql.append("LEFT JOIN tb_categoriaativacao as catativ");
		sql.append(" ON(catativ.CTA_ID = Ativacao.ATI_CTA_ID");*/
		sql.append("WHERE 1=1 ");
		
		if(livro.getTitulo() != null && livro.getTitulo().length() >0) 
			sql.append(" AND LIV_TITULO LIKE '" + livro.getTitulo()+"%'");
		
		if(livro.getAnoPub() != null && livro.getAnoPub().length() > 0) 
			sql.append(" AND LIV_ANO= '" + livro.getAnoPub() + "'");
		
		if(livro.getEditora().getId() != null && livro.getEditora().getId() > 0) 
			sql.append(" AND LIV_EDI_ID= '" + livro.getEditora().getId() + "'");
		
		if(livro.getAutor().getId() != null && livro.getAutor().getId() > 0) 
			sql.append(" AND LIV_AUT_ID= '" + livro.getAutor().getId() + "'");
		
		if(livro.getCodBarras() != null && livro.getCodBarras().length() > 0) 
			sql.append(" AND LIV_CODBARRAS= '" + livro.getCodBarras() + "'");
		
		try {
			if(livro.getCategorias().get(0).getId() != null && livro.getCategorias().get(0).getId() > 0)
				sql.append("AND CAT_ID= '" + livro.getCategorias().get(0).getId() + "'");
			}catch (Exception e) {
				// TODO: handle exception
			}

		if(livro.getISBN() != null && livro.getISBN().length() >0) 
			sql.append(" AND LIV_ISBN= '" + livro.getISBN() + "'");
		
		if(livro.getQtdEstoque() == 1) 
			sql.append(" AND LVE_QTD > 0 ");
		
		try {
			System.out.println(livro.isAtivo());
			if(livro.isAtivo()) {
				sql.append(" and LIV_ISATIVO= " + livro.isAtivo());
			} else if(!livro.isAtivo()) {
				sql.append(" and LIV_ISATIVO= " + livro.isAtivo());
			}
		} catch (Exception e) {
			
		}
		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			System.out.println(pst.toString());
			ResultSet rs = pst.executeQuery();
			ResultSet rs2;
			while(rs.next()) {
				Livro li = new Livro();
				li.setAutor(new Autor());
				li.setEditora(new Editora());
				li.setGP(new GrupoPrecificacao());
				li.setCategorias(new ArrayList<Categoria>());
				li.setAtivacao(new Ativacao());
				li.setInativacao(new Inativacao());
				li.getAtivacao().setCategoria(new CatAtivacao());
				li.getInativacao().setCategoria(new CatInativacao());
				li.setId(rs.getInt("LIV_ID"));
				li.getAutor().setId(rs.getInt("LIV_AUT_ID"));
				li.setTitulo(rs.getString("LIV_TITULO"));
				li.setAnoPub(rs.getString("LIV_ANO"));
				li.setEdicao(rs.getString("LIV_EDICAO"));
				li.setCodBarras(rs.getString("LIV_CODBARRAS"));
				li.setISBN(rs.getString("LIV_ISBN"));
				li.setNumPaginas(rs.getString("LIV_NUMPAG"));
				li.setAltura(rs.getInt("LIV_ALTURA"));
				li.setPeso(rs.getDouble("LIV_PESO"));
				li.setLargura(rs.getDouble("LIV_LARGURA"));
				li.setProfundidade(rs.getDouble("LIV_PROFUNDIDADE"));
				li.setSinopse(rs.getString("LIV_SINOPSE"));
				li.getGP().setId(rs.getInt("LIV_GRP_ID"));
				li.getGP().setNome(rs.getString("GRP_NOME"));
				li.getGP().setPorcentagem(rs.getInt("GRP_PRLUCRO"));
				li.getAutor().setNome(rs.getString("AUT_NOME"));
				li.getAutor().setId(rs.getInt("AUT_ID"));
				li.getEditora().setNome(rs.getString("EDI_NOME"));
				li.getEditora().setId(rs.getInt("LIV_EDI_ID"));
				//li.setDtCadastro(rs.getDate("LIV_DATACADASTRO"));
				li.setAtivo(rs.getBoolean("LIV_ISATIVO"));
				li.setQtdEstoque(rs.getInt("LVE_QTD"));
				li.setPrecoUnit(rs.getDouble("LVE_PRECO_UNIT"));
				System.out.println(li.getTitulo());
				sql = new StringBuilder();
				sql.append("SELECT * FROM (SELECT * FROM tb_contem as CON ");
				sql.append("LEFT JOIN tb_livros as Livro ");
				sql.append("ON Livro.LIV_ID = CON.CON_LIV_ID ");
				sql.append("WHERE LIV_ID = ?) as pupu "); 
				sql.append("LEFT JOIN tb_categoria as CAT ");
				sql.append("on CAT.CAT_ID = pupu.CON_CAT_ID;");
				
				pst2 = connection.prepareStatement(sql.toString());
				
				pst2.setInt(1, li.getId());
				rs2 = pst2.executeQuery();
				
				for(int i=0;rs2.next(); i++) {
					if(li.getId() == rs2.getInt("LIV_ID")) {
						li.getCategorias().add(new Categoria());
						li.getCategorias().get(i).setNome(rs2.getString("CAT_NOME"));
						li.getCategorias().get(i).setId(rs2.getInt("CAT_ID"));
					}
					else {
						break;
					}
				}
				
				/*if(li.getId() != null) {
					sql = new StringBuilder();
					sql.append("CALL Buscar_Ati(?)");
					pst2 = connection.prepareStatement(sql.toString());
					pst2.setInt(1, li.getId());
					System.out.println(pst2);
					rs2 = pst2.executeQuery();
					try {
						System.out.println("ID ATIVACAO" + rs2.getInt("ATI_ID"));
						li.getAtivacao().setId(rs2.getInt("ATI_ID"));
						li.getAtivacao().setMotivo(rs2.getString("ATI_JUSTIFICATIVA"));
						li.getAtivacao().getCategoria().setId(rs2.getInt("CTA_ID"));
						li.getAtivacao().getCategoria().setNome(rs2.getString("CTA_NOME"));
					}catch (Exception e) {
						// TODO: handle exception
					}
					System.out.println(li.getAtivacao().getMotivo());
					sql = new StringBuilder();
					sql.append("CALL Buscar_ina(?)");
					pst2 = connection.prepareStatement(sql.toString());
					pst2.setInt(1, li.getId());
					rs2 = pst2.executeQuery();
					try {
						li.getInativacao().setId(rs2.getInt("LIV_INA_ID"));
						li.getInativacao().setMotivo(rs2.getString("INA_JUSTIFICATIVA"));
						li.getInativacao().getCategoria().setId(rs2.getInt("CTI_ID"));
						li.getInativacao().getCategoria().setNome(rs2.getString("CTI_NOME"));
					}catch (Exception e) {
						// TODO: handle exception
					}
				}*/
				System.out.println("Chega aqui ?");
				if(li.getId() != atual)
					livros.add(li);
				atual = rs.getInt("LIV_ID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(livros.get(0).getId());
		return livros;
	}
}
