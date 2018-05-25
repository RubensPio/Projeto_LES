package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;

import les12018.dominio.Cartao;
import les12018.dominio.Cliente;
import les12018.dominio.CupomPromocional;
import les12018.dominio.CupomTroca;
import les12018.dominio.Endereco;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Pedido;
import les12018.dominio.Produto;

public class PedidoDAO extends AbstractJdbcDAO{
	
	public PedidoDAO(){
        super("tb_pedidos", "id_pedido");
    }
	
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = null;
		Pedido objPedido = (Pedido) entidade;
		Pedido ped = new Pedido();
		CupomPromocional cpP = new CupomPromocional();
		ArrayList<CupomTroca> cpT = new ArrayList<CupomTroca>();
		CupomTroca cp;
		ResultSet rs;
		StringBuilder sql;
		 if(objPedido != null) {
			 if(!objPedido.isFlgTroca()) {
				 try {
					 if(objPedido.getCupomPromocional() != null) {
						 connection.setAutoCommit(false);
			             sql = new StringBuilder();
			             
			             sql.append("SELECT * FROM tb_cupom_desconto WHERE CPD_ID=?");
			             
			             pst = connection.prepareStatement(sql.toString());
			             
			             pst.setInt(1, objPedido.getCupomPromocional().getId());
			             
			             rs = pst.executeQuery();
			             
			             while(rs.next()) {
			            	cpP.setId(rs.getInt("CPD_ID")); 
			            	cpP.setValor(rs.getDouble("CPD_VALOR"));
			             }
					 }else if(objPedido.getCuponsTroca() != null) {
						 connection.setAutoCommit(false);
			             sql = new StringBuilder();
			             
			             sql.append("SELECT * FROM tb_cupom_troca WHERE CPT_CLI_ID=?");
			             
			             pst = connection.prepareStatement(sql.toString());
			             
			             pst.setInt(1, objPedido.getCliente().getId());
			             
			             rs = pst.executeQuery();
			             
			             while(rs.next()) {
			            	cp = new CupomTroca();
			            	cp.setId(rs.getInt("CPT_ID"));
			            	cp.setValor(rs.getDouble("CPT_VALOR"));
			            	cpT.add(cp);
			             }
					 }
					 
					 if(cpP.getId() != null) {
						 double ValorDesconto = objPedido.getValorTotal() * (1-(cpP.getValor()/100));
						 objPedido.setValorTotal(ValorDesconto);
					 }
					 
					 connection.setAutoCommit(false);
		             sql = new StringBuilder();
		             
		             sql.append("INSERT into tb_pedidos(PED_VALORTOTAL, PED_CLI_ID, PED_METODOPAG, PED_FRETE, PED_DATA, PED_CAR_NUM_CARTAO, PED_END_CEP, PED_END_NUM_LOGRADOURO, PED_STATUS) ");
		             sql.append("VALUES(?,?,?,?,sysdate(),?,?,?,?)");
		             
		             pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
		             
		             pst.setDouble(1, objPedido.getValorTotal());
		             pst.setInt(2, objPedido.getCliente().getId());
		             pst.setString(3, objPedido.getFormaDePagamento());
		             pst.setDouble(4, objPedido.getFrete());
		             pst.setString(5, objPedido.getCartao().getsNumCartao());
		             pst.setString(6, objPedido.getEndEntrega().getCEP());
		             pst.setString(7, objPedido.getEndEntrega().getNumerologradouro());
		             pst.setString(8, objPedido.getStatus());
		             
		             pst.executeUpdate();
		             
		             rs = pst.getGeneratedKeys();
		                int num=0;
		                if(rs.next())
		    			{
		    				num = rs.getInt(1);
		    				objPedido.setId(num);
		    			}
		    			
		    		connection.commit();
		    		
		    		for(Produto prod:objPedido.getProdutos()) {
		    			connection.setAutoCommit(false);
		    			
		    			sql = new StringBuilder();
						sql.append("INSERT INTO tb_item_pedido(ITP_LIV_ID, ITP_PED_ID, ITP_SUBTOTAL, ITP_QTD)");
						sql.append("VALUES(?,?,?,?)");
						
						pst = connection.prepareStatement(sql.toString());
						
						pst.setInt(1, prod.getLivro().getId());
						pst.setInt(2, objPedido.getId());
						pst.setDouble(3, prod.getSubtotal());
						pst.setInt(4, prod.getQuantidade());
						
						pst.executeUpdate();
						connection.commit();
		    		}
				 }catch (SQLException e) {
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
				 
			 }else {
				 try {
					 connection.setAutoCommit(false);
					 
					 sql = new StringBuilder();
					 
					 sql.append("SELECT PED_VALORTOTAL FROM tb_pedidos WHERE PED_ID=?");
					 
					 pst = connection.prepareStatement(sql.toString());
					 
					 pst.setInt(1, objPedido.getId());
					 
					 rs = pst.executeQuery();
					 
					 double pedvalor = 0;
					 
					 if(rs.next()){
						 pedvalor = rs.getDouble("PED_VALORTOTAL");
		    		}
					 System.out.println(objPedido.getValorTotal());
					 System.out.println(pedvalor);
					 
					 //Remove os produtos a serem trocados no pedido
					 if(pedvalor != objPedido.getValorTotal()) {
						 
						 for(Produto prod:objPedido.getProdutos()) {
							 sql = new StringBuilder();
							 if(prod.isFlgRemover() && prod.getQuantidade() == prod.getQuantidadeAnterior()) {
								connection.setAutoCommit(false);
							 	sql.append("DELETE FROM tb_item_pedido WHERE ITP_LIV_ID=? AND ITP_PED_ID=?");
							 	
							 	pst = connection.prepareStatement(sql.toString());
							 	
							 	pst.setInt(1, prod.getLivro().getId());
							 	pst.setInt(2, objPedido.getId());
							 	
							 	pst.executeUpdate();
							 	connection.commit();
							 }else if(prod.isFlgRemover()){
								connection.setAutoCommit(false);
							 	sql.append("UPDATE tb_item_pedido SET ITP_QTD=?,ITP_SUBTOTAL=? WHERE ITP_LIV_ID=? AND ITP_PED_ID=?");
							 	
							 	pst = connection.prepareStatement(sql.toString());
							 	
							 	int qtd = prod.getQuantidadeAnterior()-prod.getQuantidade();
							 	
							 	pst.setInt(1, qtd);
							 	pst.setDouble(2, prod.getSubtotal());
							 	pst.setInt(3, prod.getLivro().getId());
							 	pst.setInt(4, objPedido.getId());
							 	
							 	System.out.println(pst.toString());
							 	pst.executeUpdate();
							 	connection.commit(); 
							 }
						 }
						 
						 sql = new StringBuilder();
						 connection.setAutoCommit(false);
						 
						 sql.append("UPDATE tb_pedidos SET PED_VALORTOTAL=? ");
						 sql.append("WHERE PED_ID=?");
						 
						 pst = connection.prepareStatement(sql.toString());
						 
						 double total = pedvalor-objPedido.getValorTotal();
						 
						 pst.setDouble(1, total);
						 pst.setInt(2, objPedido.getId());
						 
						 System.out.println(pst.toString());
						 pst.executeUpdate();
						 connection.commit();
						 
						 //Insere um novo pedido de troca
						 connection.setAutoCommit(false);
						 sql = new StringBuilder();
						 
						 sql.append("INSERT into tb_pedidos(PED_VALORTOTAL, PED_CLI_ID, PED_METODOPAG, PED_FRETE, PED_DATA, PED_CAR_NUM_CARTAO, PED_END_CEP, PED_END_NUM_LOGRADOURO, PED_STATUS, PED_ID_TROCA) ");
			             sql.append("VALUES(?,?,?,?,sysdate(),?,?,?,?,?)");
			             
			             pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
			             
			             pst.setDouble(1, objPedido.getValorTotal());
			             pst.setInt(2, objPedido.getCliente().getId());
			             pst.setString(3, objPedido.getFormaDePagamento());
			             pst.setDouble(4, objPedido.getFrete());
			             pst.setString(5, objPedido.getCartao().getsNumCartao());
			             pst.setString(6, objPedido.getEndEntrega().getCEP());
			             pst.setString(7, objPedido.getEndEntrega().getNumerologradouro());
			             pst.setString(8, "Em troca");
			             pst.setInt(9, objPedido.getId());
			             
			             System.out.println(pst.toString());
			             pst.executeUpdate();
			             
			             rs = pst.getGeneratedKeys();
			                int num=0;
			                if(rs.next())
			    			{
			    				num = rs.getInt(1);
			    				objPedido.setId(num);
			    			}
			    			
			    		connection.commit();
			    		
			    		for(Produto pro:objPedido.getProdutos()) {
			    			if(pro.isFlgRemover()) {
				    			connection.setAutoCommit(false);
				    			
				    			sql = new StringBuilder();
								sql.append("INSERT INTO tb_item_pedido(ITP_LIV_ID, ITP_PED_ID, ITP_SUBTOTAL, ITP_QTD)");
								sql.append("VALUES(?,?,?,?)");
								
								pst = connection.prepareStatement(sql.toString());
								
								pst.setInt(1, pro.getLivro().getId());
								pst.setInt(2, objPedido.getId());
								pst.setDouble(3, pro.getSubtotal());
								pst.setInt(4, pro.getQuantidade());
								
								System.out.println(pst.toString());
								pst.executeUpdate();
								connection.commit();
			    			}
			    		}
					 }else {
						 try {
			        			connection.setAutoCommit(false);
			        			sql.append("UPDATE tb_pedidos set PED_STATUS=? ");
			        			sql.append("WHERE PED_ID=?");
			        			
			        			pst = connection.prepareStatement(sql.toString());
			        			
			        			pst.setString(1, "Em troca");
			        			pst.setInt(2, objPedido.getId());
			        			
			        			pst.executeUpdate();
			        			connection.commit();
			        			
			        		}catch (SQLException e) {
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
					 
				 }catch (SQLException e) {
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
		 }
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = connection.prepareStatement("");
        Pedido objPedido = (Pedido) entidade;
        StringBuilder sql = new StringBuilder();
        if(objPedido != null) {
        	if(objPedido.getStatus() != null) {
        		try {
        			connection.setAutoCommit(false);
        			sql.append("UPDATE tb_pedidos set PED_STATUS=? ");
        			sql.append("WHERE PED_ID=?");
        			
        			pst = connection.prepareStatement(sql.toString());
        			
        			pst.setString(1, objPedido.getStatus());
        			pst.setInt(2, objPedido.getId());
        			
        			pst.executeUpdate();
        			connection.commit();
        			
        		}catch (SQLException e) {
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
        	}else {
	        		try {
		        		for(Produto prod:objPedido.getProdutos()) {
		        				if(prod.isFlgRemover()) {
				        			connection.setAutoCommit(false);
				        			
				        			sql = new StringBuilder();
				        			sql.append("SELECT LVE_QTD FROM tb_livros_estoque");
				        			sql.append(" WHERE LVE_LIV_ID=?");
				        			
				        			pst = connection.prepareStatement(sql.toString());
				        			
				        			pst.setInt(1, prod.getLivro().getId());
				        			
				        			ResultSet rs = pst.executeQuery();
				        			int qtd = 0;
				        			while(rs.next()){
				                        qtd = rs.getInt("LVE_QTD");
				                    }
				        			
				        			connection.setAutoCommit(false);
		        					
		        					sql = new StringBuilder();
		        					sql.append("UPDATE tb_livros_estoque set LVE_QTD=? ");
				        			sql.append("WHERE LVE_LIV_ID=?");
				        			
				        			pst = connection.prepareStatement(sql.toString());
				        			
				        			int qtdt = qtd+prod.getQuantidadeAnterior();
				        			
				        			pst.setInt(1, qtdt);
				        			pst.setInt(2, prod.getLivro().getId());
				        			
				        			System.out.println(pst.toString());
				        			pst.executeUpdate();
				        			connection.commit();
				        			
				        			connection.setAutoCommit(false);
				        			sql = new StringBuilder();
				        			
				        			sql.append("UPDATE tb_livros_estoque set LVE_QTD=? ");
				        			sql.append("WHERE LVE_LIV_ID=?");
				        			
				        			pst = connection.prepareStatement(sql.toString());
				        			
				        			qtd = qtdt-prod.getQuantidade();
				        			
				        			pst.setInt(1, qtd);
				        			pst.setInt(2, prod.getLivro().getId());
				        			
				        			pst.executeUpdate();
				        			connection.commit();
		        				}
			        		}
	        	}catch (SQLException e) {
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
        }
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = null;
        Pedido objPedido = (Pedido) entidade;
        StringBuilder sql = new StringBuilder();
        if(objPedido != null) {
        	if(objPedido.getStatus() != null) {
        		try {
        			connection.setAutoCommit(false);
        			sql.append("UPDATE tb_pedidos set PED_STATUS=? ");
        			sql.append("WHERE PED_ID=?");
        			
        			pst = connection.prepareStatement(sql.toString());
        			
        			pst.setString(1, objPedido.getStatus());
        			pst.setInt(2, objPedido.getId());
        			
        			pst.executeUpdate();
        			connection.commit();
        			
        		}catch (SQLException e) {
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
        	}else {
        		try {
        			for(Produto prod:objPedido.getProdutos()) {
        				if(prod.isFlgRemover()) {
		        			connection.setAutoCommit(false);
		        			
		        			sql = new StringBuilder();
		        			sql.append("SELECT LVE_QTD FROM tb_livros_estoque");
		        			sql.append(" WHERE LVE_LIV_ID=?");
		        			
		        			pst = connection.prepareStatement(sql.toString());
		        			
		        			pst.setInt(1, prod.getLivro().getId());
		        			ResultSet rs = pst.executeQuery();
		        			int qtd = 0;
		        			while(rs.next()){
		                        qtd = rs.getInt("LVE_QTD");
		                    }
		        			
		        			connection.setAutoCommit(false);
		        			sql = new StringBuilder();
		        			
		        			sql.append("UPDATE tb_livros_estoque set LVE_QTD=? ");
		        			sql.append("WHERE LVE_LIV_ID=?");
		        			
		        			pst = connection.prepareStatement(sql.toString());
		        			
		        			int qtdt = qtd+prod.getQuantidade();
		        			
		        			pst.setInt(1, qtdt);
		        			pst.setInt(2, prod.getLivro().getId());
		        			
		        			pst.executeUpdate();
		        			connection.commit();
        				}
        			}
        		}catch (SQLException e) {
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
        }
	}

	@Override
	public void ativar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
    	PreparedStatement pst2 = null;
    	
    	int atual = 0;
    	Pedido ped = (Pedido) entidade;
    	List<EntidadeDominio> pedidos = new ArrayList<EntidadeDominio>();
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
    	sql.append(" WHERE 1=1 ");
    	
    	if(ped.getValorTotal() > 0) {
    		sql.append(" AND PED_VALORTOTAL='" + ped.getValorTotal()+"'");
    	}
    	
    	if(ped.getStatus() != null && ped.getStatus().length() > 0) {
    		sql.append(" AND PED_STATUS='" + ped.getStatus()+"'");
    	}
    	
    	if(ped.getFormaDePagamento() != null && ped.getFormaDePagamento().length() > 0) {
    		sql.append(" AND PED_METODOPAG='" + ped.getFormaDePagamento()+"'");
    	}
    	
    	if(ped.getCartao().getsNumCartao() != null && ped.getCartao().getsNumCartao().length() > 0) {
    		sql.append(" AND PED_CAR_NUM_CARTAO LIKE '" + ped.getCartao().getsNumCartao() +"%'");
    	}
    	
    	if(ped.getEndEntrega().getCEP() != null && ped.getEndEntrega().getCEP().length() > 0) {
    		sql.append(" AND PED_END_CEP LIKE '" + ped.getEndEntrega().getCEP() + "%'");
    	}
    	
    	if(ped.getEndEntrega().getNumerologradouro() != null && ped.getEndEntrega().getNumerologradouro().length() > 0) {
    		sql.append(" AND PED_END_NUM_LOGRADOURO='" + ped.getEndEntrega().getNumerologradouro()+"'");
    	}
    	
    	if(ped.getDtCadastro() != null) {
    		sql.append(" AND PED_DATA=" + ped.getDtCadastro());
    	}
    	
    	if(ped.getCliente().getId() != null && ped.getCliente().getId() < 0) {
    		sql.append(" AND PED_CLI_ID='"+ ped.getCliente().getId() +"'");
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
    			System.out.println(pedido.getId());
    			pedidos.add(pedido);
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	System.out.println(pedidos.size());
		return pedidos;
	}
	
}
