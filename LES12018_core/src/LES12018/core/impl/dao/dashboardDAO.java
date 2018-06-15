package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import les12018.auxiliar.DadosParaGrafico;
import les12018.dominio.Ativacao;
import les12018.dominio.Autor;
import les12018.dominio.Cartao;
import les12018.dominio.CatAtivacao;
import les12018.dominio.CatInativacao;
import les12018.dominio.Categoria;
import les12018.dominio.Cliente;
import les12018.dominio.CupomPromocional;
import les12018.dominio.CupomTroca;
import les12018.dominio.Editora;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;
import les12018.dominio.Inativacao;
import les12018.dominio.Livro;
import les12018.dominio.Pedido;
import les12018.dominio.Produto;

public class dashboardDAO extends AbstractJdbcDAO {

	public dashboardDAO() {
		super("table", "idTable");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		
		
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		
		
	}

	@Override
	public void ativar(EntidadeDominio entidade) throws SQLException {
		
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		
		openConnection();
		PreparedStatement pst = null;
		PreparedStatement pst2 = null;
		int atual = 0;
		
		ArrayList<EntidadeDominio> listEnt = new ArrayList<EntidadeDominio>();
		Cliente cli = new Cliente();
		Autor aut = new Autor();
		Editora edit = new Editora();
		Livro liv = new Livro();
		Produto prod = new Produto();
		Pedido  ped = new Pedido();
		Endereco end = new Endereco();
		CupomTroca cupTroca = new CupomTroca();
		CupomPromocional cupPromo = new CupomPromocional();
		Categoria cat = new Categoria();
		
		if (entidade instanceof Cliente) {
			
			String coluna = " ";
			// query de clientes
			try {
				
				StringBuilder sql = new StringBuilder();
				
				if (!((Cliente) entidade).getsNome().equals("todos")) {
					
					sql.append("SELECT dayname(CLI_DATA_CAD) as MES, (COUNT(CLI_DATA_CAD)) AS QTD_CAD FROM (");
					sql.append("SELECT CLI_DATA_CAD, CLI_ID FROM topbooks.tb_clientes  ");
					sql.append(") AS TAB ");
					sql.append("group by MES");
					
					coluna = "MES";
				}	
				else if (((Cliente) entidade).getsNome().equals("hoje")) {
					sql.append("SELECT date(CLI_DATA_CAD) as DIA, (COUNT(CLI_DATA_CAD)) AS QTD_CAD FROM (");
					sql.append("SELECT CLI_DATA_CAD, CLI_ID FROM topbooks.tb_clientes  ");
					sql.append("WHERE (day(sysdate()) = day(CLI_DATA_CAD)) ");
					sql.append(") AS TAB ");
					sql.append("group by DIA");
					
					coluna = "DIA";
				}
				else if (((Cliente) entidade).getsNome().equals("semana")) {
					sql.append("SELECT dayname(CLI_DATA_CAD) as DIA_SEMANA, (COUNT(CLI_DATA_CAD)) AS QTD_CAD FROM (");
					sql.append("SELECT CLI_DATA_CAD, CLI_ID FROM topbooks.tb_clientes  ");
					sql.append("WHERE (week(sysdate()) = week(CLI_DATA_CAD)) ");
					sql.append(") AS TAB ");
					sql.append("group by DIA_SEMANA");
					
					coluna = "DIA_SEMANA";
				}
					
				else if (((Cliente) entidade).getsNome().equals("mes")) {
					sql.append("SELECT date(CLI_DATA_CAD) as DIA, (COUNT(CLI_DATA_CAD)) AS QTD_CAD FROM (");
					sql.append("SELECT CLI_DATA_CAD, CLI_ID FROM topbooks.tb_clientes  ");
					sql.append("WHERE (month(sysdate()) = month(CLI_DATA_CAD)) ");
					sql.append(") AS TAB ");
					sql.append("group by DIA");
					
					coluna = "DIA";
				}
					
				else if (((Cliente) entidade).getsNome().equals("ano")) {
					sql.append("SELECT monthname(CLI_DATA_CAD) as MES, (COUNT(CLI_DATA_CAD)) AS QTD_CAD FROM (");
					sql.append("SELECT CLI_DATA_CAD, CLI_ID FROM topbooks.tb_clientes  ");
					sql.append("WHERE (year(sysdate()) = year(CLI_DATA_CAD)) ");
					sql.append(") AS TAB ");
					sql.append("group by MES");
					
					coluna = "MES";
				}
				
				try {
					
					openConnection();
					pst = connection.prepareStatement(sql.toString());
					ResultSet rs = pst.executeQuery();
					ResultSet rs2 = null;
					
					while(rs.next()) {  
						
						cli = new Cliente();
						cli.setsNome(rs.getString(coluna));
						cli.setnRanking(rs.getInt("QTD_CAD"));
						
		    			listEnt.add(cli);
		    			
					}
					
					return listEnt;
					
				}catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pst.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		if (entidade instanceof Pedido) {
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM tb_pedidos AS pedido");
	    	sql.append(" LEFT JOIN tb_cartoes AS cartao ");
	    	sql.append("ON cartao.CAR_NUM_CARTAO = pedido.PED_CAR_NUM_CARTAO");
	    	sql.append(" LEFT JOIN tb_enderecos as endereco ");
	    	sql.append("ON endereco.END_CEP = pedido.PED_END_CEP AND endereco.END_NUM_LOGRADOURO = pedido.PED_END_NUM_LOGRADOURO");
	    	sql.append(" LEFT JOIN tb_clientes as cliente ");
	    	sql.append("ON cliente.CLI_ID = pedido.PED_CLI_ID");
	    	sql.append(" LEFT JOIN tb_item_pedido as item ");
	    	sql.append("ON item.ITP_PED_ID = pedido.PED_ID ");
	    	sql.append(" WHERE 1=1");
			
			if (!((Pedido) entidade).getStatus().equals("todos")) {
				
				if (!((Pedido) entidade).getStatus().equals("hoje"))
					sql.append(" AND PED_DATA = SYSDATE");
				
				if (!((Pedido) entidade).getStatus().equals("semana")) {
					sql.append(" AND DAYOFWEEK(PED_DATA) = DAYOFWEEK(SYSDATE)");
					sql.append(" AND YEAR(PED_DATA) = YEAR(SYSDATE)");
				}
				
				if (((Pedido) entidade).getStatus().equals("mes")) {
					sql.append(" AND MONTH(PED_DATA) = MONTH(SYSDATE)");
					sql.append(" AND YEAR(PED_DATA) = YEAR(SYSDATE)");
				}
				
				if (((Pedido) entidade).getStatus().equals("mes"))
					sql.append(" AND YEAR(PED_DATA) = YEAR(SYSDATE)");
			}
			
			sql.append("GROUP BY PED_ID");
			
			try {
	    		openConnection();
	    		pst = connection.prepareStatement(sql.toString());
	    		ResultSet rs = pst.executeQuery();
	    		ResultSet rs2;
	    		
	    		while(rs.next()) {
	    			Pedido pedido = new Pedido();
	    			pedido.setId(rs.getInt("PED_ID"));
	    			pedido.setValorTotal(rs.getDouble("PED_VALORTOTAL"));
	    			pedido.setStatus(rs.getString("PED_STATUS"));
	    			pedido.setFrete(rs.getDouble("PED_FRETE"));
	    			pedido.setFormaDePagamento(rs.getString("PED_METODOPAG"));
	    			pedido.setDtCadastro(rs.getDate("PED_DATA"));
	    			pedido.setCartao(new Cartao());
	    			pedido.getCartao().setsNumCartao(rs.getString("PED_CAR_NUM_CARTAO"));
	    			pedido.getCartao().setsNomeTitular(rs.getString("CAR_NOME_TITULAR"));
	    			pedido.getCartao().setsCodSeguranca(rs.getString("CAR_CVV"));
	    			pedido.getCartao().setsBandeira(rs.getString("CAR_BANDEIRA"));
	    			pedido.getCartao().setDtDataVal(rs.getString("CAR_DT_VALIDADE"));
	    			pedido.setEndEntrega(new Endereco());
	    			pedido.getEndEntrega().setCEP(rs.getString("PED_END_CEP"));
	    			pedido.getEndEntrega().setNumerologradouro(rs.getString("PED_END_NUM_LOGRADOURO"));
	    			pedido.getEndEntrega().setTipoResidencia(rs.getString("END_TIPO_RESIDENCIA"));
	    			pedido.getEndEntrega().setTipoLogradouro(rs.getString("END_TIPO_LOGRADOURO"));
	    			pedido.getEndEntrega().setPais(rs.getString("END_PAIS"));
	    			pedido.getEndEntrega().setNome(rs.getString("END_NOME"));
	    			pedido.getEndEntrega().setLogradouro(rs.getString("END_LOGRADOURO"));
	    			pedido.getEndEntrega().setFlgCobranca(rs.getBoolean("END_FLG_COBRANCA"));
	    			pedido.getEndEntrega().setEstado(rs.getString("END_ESTADO"));
	    			pedido.getEndEntrega().setComp(rs.getString("END_COMP"));
	    			pedido.getEndEntrega().setCidade(rs.getString("END_CIDADE"));
	    			pedido.getEndEntrega().setBairro(rs.getString("END_BAIRRO"));
	    			pedido.getCliente().setId(rs.getInt("PED_CLI_ID"));
	    			pedido.getCliente().setsNome(rs.getString("CLI_NOME"));
	    			pedido.setProdutos(new ArrayList<Produto>());
	    			
	    			sql = new StringBuilder();
	    			sql.append("SELECT * FROM tb_item_pedido AS ped ");
	    			sql.append("LEFT JOIN tb_livros AS livro ");
	    			sql.append("ON livro.LIV_ID = ped.ITP_LIV_ID ");
	    			sql.append("LEFT JOIN tb_livros_estoque AS estoque "); 
	    			sql.append("ON estoque.LVE_LIV_ID = ped.ITP_LIV_ID ");
	    			sql.append("WHERE ITP_PED_ID=?");
	    			
	    			pst2 = connection.prepareStatement(sql.toString());
	    			pst2.setInt(1, pedido.getId());
	    			System.out.println(pst2.toString());
	    			rs2 = pst2.executeQuery();
	    			
	    			int i = 0;
	    			
	    			for(i = 0; rs2.next(); i++) {
	    				if(pedido.getId() == rs2.getInt("ITP_PED_ID")) {
	    					pedido.getProdutos().add(new Produto());
	    					pedido.getProdutos().get(i).setSubtotal(rs2.getDouble("ITP_SUBTOTAL"));
	    					pedido.getProdutos().get(i).setQuantidade(rs2.getInt("ITP_QTD"));
	    					pedido.getProdutos().get(i).getLivro().setId(rs2.getInt("ITP_LIV_ID"));
	    					pedido.getProdutos().get(i).getLivro().setTitulo(rs2.getString("LIV_TITULO"));
	    					pedido.getProdutos().get(i).getLivro().setQtdEstoque(rs2.getInt("LVE_PRECO_UNIT"));
	    				}
	    			}
	    			listEnt.add(pedido);
	    		}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pst.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return listEnt;
		}
		
		if (entidade instanceof Livro) {
			
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
			sql.append("WHERE 1=1");
			
			if (!((Livro) entidade).getTitulo().equals("todos")) {
				
				if (!((Livro) entidade).getTitulo().equals("semana"))
					sql.append(" AND LIV_DATACADASTRO = SYSDATE");
				
				if (!((Livro) entidade).getTitulo().equals("semana")) {
					sql.append(" AND DAYOFWEEK(LIV_DATACADASTRO) = DAYOFWEEK(SYSDATE)");
					sql.append(" AND YEAR(LIV_DATACADASTRO) = YEAR(SYSDATE)");
				}
				
				if (!((Livro) entidade).getTitulo().equals("mes")) {
					sql.append(" AND MONTH(LIV_DATACADASTRO) = MONTH(SYSDATE)");
					sql.append(" AND YEAR(LIV_DATACADASTRO) = YEAR(SYSDATE)");
				}
				
				if (!((Livro) entidade).getTitulo().equals("ano")) 
					sql.append(" AND YEAR(LIV_DATACADASTRO) = YEAR(SYSDATE)");
			}
			
			sql.append(" GROUP BY(LIV_ID)");
			
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
					
					listEnt.add(li);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pst.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return listEnt;
	}
}
