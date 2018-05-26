package LES12018.core.impl.dao;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;
import com.sun.corba.se.spi.orb.ParserData;

import les12018.dominio.*;

public class ClienteDAO extends AbstractJdbcDAO {

    public ClienteDAO(){
        super("tb_clientes", "id_cliente");
    }

    // função que adiciona todos os dados de cliente na tabela de clientes
    @Override
    public void salvar(EntidadeDominio entidade){
        openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = null;
        Cliente obCliente = (Cliente) entidade;
        System.out.println("kkk entra no salvar");
        System.out.println(obCliente.getCartoes().get(0).getsNumCartao());
        StringBuilder sql;
        if (obCliente.getId() == null){                        // se o ID de cliente for nulo, quer dizer que não está cadastrado, entao é uma chamada de cadastro de novo cliente 
        	System.out.println("Cadastrar Cliente");
            try {
                connection.setAutoCommit(false);

                // Concatena em uma String a Query que insere na tabela de cliente
                sql = new StringBuilder();
                sql.append("INSERT INTO tb_clientes(CLI_NOME, CLI_GENERO, CLI_DATA_NASC, CLI_CPF, CLI_EMAIL, CLI_SENHA, CLI_TELEFONE"
    					+ ", CLI_isADMIN, CLI_ATIVO, CLI_DATA_CAD)");
    			sql.append("VALUES (?,?,?,?,?,?,?,?,?,sysdate())");
    			
    			pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
    			
    			pst.setString(1, obCliente.getsNome());
    			pst.setString(2, obCliente.getsGenero());
    			pst.setDate(3, (Date)obCliente.getDtDataNasc());
    			pst.setString(4, obCliente.getsCPF());
    			pst.setString(5, obCliente.getsEmail());
    			//pst.setString(6, obCliente.getsRanking());
    			pst.setString(6, obCliente.getsSenha());
    			pst.setString(7, obCliente.getsTelefone());
    			pst.setBoolean(8, obCliente.getIsAdmin());
    			pst.setBoolean(9, obCliente.getFlgAtivo());
    			
    			pst.executeUpdate();
    			
    			ResultSet rs = pst.getGeneratedKeys();
                int id=0;
                if(rs.next())
    			{
    				id = rs.getInt(1);
    				obCliente.setId(id);
    			}
    			
    			connection.commit();
    			
    			connection.setAutoCommit(false);
    
                sql = new StringBuilder();
                sql.append("INSERT INTO tb_enderecos(END_NOME,END_TIPO_RESIDENCIA, END_TIPO_LOGRADOURO, END_LOGRADOURO,"
                    + " END_BAIRRO, END_NUM_LOGRADOURO, END_CEP, END_CIDADE, END_PAIS,"
                    + " END_FLG_COBRANCA, END_ESTADO, END_CLI_ID)");
                sql.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
    
                pst = connection.prepareStatement(sql.toString());
    
                pst.setString(1, obCliente.getEnderecos().get(0).getNome());
                pst.setString(2, obCliente.getEnderecos().get(0).getTipoResidencia());
                pst.setString(3, obCliente.getEnderecos().get(0).getTipoLogradouro());
                pst.setString(4, obCliente.getEnderecos().get(0).getLogradouro());
                pst.setString(5, obCliente.getEnderecos().get(0).getBairro());
                pst.setString(6, obCliente.getEnderecos().get(0).getNumerologradouro());
                pst.setString(7, obCliente.getEnderecos().get(0).getCEP());
                pst.setString(8, obCliente.getEnderecos().get(0).getCidade());
                pst.setString(9, obCliente.getEnderecos().get(0).getPais());
                pst.setBoolean(10, true);
                pst.setString(11, obCliente.getEnderecos().get(0).getEstado());
                pst.setInt(12, obCliente.getId());
    
                pst.executeUpdate();
                    
                connection.commit();
    
            } catch (SQLException e) {
                try {
                    connection.rollback();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
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

        if (obCliente.getId() != null && obCliente.getCartoes().get(0).getsNumCartao() != null) {                     // indica que o cliente já existe e deseja adicionar um novo cartão

            try {
                connection.setAutoCommit(false);
    
                for (Cartao cartao : obCliente.getCartoes()) {
                    
                    sql = new StringBuilder();
                    sql.append("INSERT INTO tb_cartoes(CAR_NUM_CARTAO, CAR_CVV, CAR_NOME_TITULAR," 
                        + " CAR_DT_VALIDADE, CAR_BANDEIRA, CAR_CLI_ID)");
                    sql.append(" VALUES (?,?,?,?,?,?)");
    
                    pst = connection.prepareStatement(sql.toString());
    
                    pst.setString(1, cartao.getsNumCartao());
                    pst.setString(2, cartao.getsCodSeguranca());
                    pst.setString(3, cartao.getsNomeTitular());
                    pst.setDate(4, Date.valueOf(cartao.getDtDataVal()));
                    pst.setString(5, cartao.getsBandeira());
                    pst.setInt(6, obCliente.getId());
    
                    System.out.println(pst.toString());
                    pst.executeUpdate();
                    connection.commit();
                }
            } catch (SQLException e) {
                try {
                    connection.rollback();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
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

        if (obCliente.getId() != null && obCliente.getEnderecos().get(0).getCEP() != null) {                               //indica que a operação desejada é de cadastrar um endereço novo

            try {
                connection.setAutoCommit(false);
    
                for (Endereco endereco : obCliente.getEnderecos()) {
    
                    sql = new StringBuilder();
                    sql.append("INSERT INTO tb_enderecos(END_NOME,END_TIPO_RESIDENCIA, END_TIPO_LOGRADOURO, END_LOGRADOURO,"
                        + " END_BAIRRO, END_NUM_LOGRADOURO, END_CEP, END_CIDADE, END_PAIS,"
                        + " END_FLG_COBRANCA, END_ESTADO, END_CLI_ID)");
                    sql.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
    
                    pst = connection.prepareStatement(sql.toString());
    
                    pst.setString(1, endereco.getNome());
                    pst.setString(2, endereco.getTipoResidencia());
                    pst.setString(3, endereco.getTipoLogradouro());
                    pst.setString(4, endereco.getLogradouro());
                    pst.setString(5, endereco.getBairro());
                    pst.setString(6, endereco.getNumerologradouro());
                    pst.setString(7, endereco.getCEP());
                    pst.setString(8, endereco.getCidade());
                    pst.setString(9, endereco.getPais());
                    pst.setBoolean(10, endereco.getFlgCobranca());
                    pst.setString(11, endereco.getEstado());
                    pst.setInt(12, obCliente.getId());
    
                    System.out.println(pst.toString());
                    pst.executeUpdate();
                    connection.commit();
                }    
            } catch (SQLException e) {
                try {
                    connection.rollback();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
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
    }

    
    @Override
    public void alterar(EntidadeDominio entidade) {

        openConnection();
        PreparedStatement pst = null;
        Cliente obCliente = (Cliente) entidade;
        StringBuilder sql = new StringBuilder();
        if(obCliente.getId() != null && obCliente.getEnderecos().get(0).getCEP() == null && obCliente.getCartoes().get(0).getsNumCartao() == null && obCliente.getsNome() == null) {
        	try {
	        	connection.setAutoCommit(false);
	
	            sql = new StringBuilder();
	            sql.append("UPDATE tb_clientes SET CLI_SENHA=? ");
	            sql.append("WHERE CLI_ID=?");
	
	            pst = connection.prepareStatement(sql.toString());
	
	            pst.setString(1, obCliente.getsSenha());
	            pst.setInt(2, obCliente.getId());
	            
	            pst.executeUpdate();
	            connection.commit();
        	}catch (SQLException e) {
	            try {
	                connection.rollback();
	            } catch (Exception e1) {
	                e1.printStackTrace();
	            }
	            e.printStackTrace();
	        } finally {
	            try {
	                pst.close();
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
        }else if(obCliente.getId() != null && obCliente.getEnderecos().get(0).getCEP() == null && obCliente.getCartoes().get(0).getsNumCartao() == null) {
        try {
            connection.setAutoCommit(false);

            sql = new StringBuilder();
            sql.append("UPDATE tb_clientes SET CLI_NOME=?, CLI_GENERO=?, CLI_DATA_NASC=?, CLI_CPF=?, "
            + "CLI_EMAIL=?, CLI_SENHA=?, CLI_TELEFONE=?");
            sql.append("WHERE CLI_ID=?");

            pst = connection.prepareStatement(sql.toString());

            pst.setString(1, obCliente.getsNome());
            pst.setString(2, String.valueOf(obCliente.getsGenero()));
            pst.setDate(3, (Date) obCliente.getDtDataNasc());
            pst.setString(4, obCliente.getsCPF());
            pst.setString(5, obCliente.getsEmail());
            pst.setString(6, obCliente.getsSenha());
            pst.setString(7, obCliente.getsTelefone());
            pst.setInt(8, obCliente.getId());

            System.out.println(pst.toString());
            pst.executeUpdate();
            connection.commit();
        	}catch (SQLException e) {
	            try {
	                connection.rollback();
	            } catch (Exception e1) {
	                e1.printStackTrace();
	            }
	            e.printStackTrace();
	        } finally {
	            try {
	                pst.close();
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
        }else if(obCliente.getId() != null && obCliente.getCartoes().get(0).getsNumCartao() != null) {
        	try {
        		connection.setAutoCommit(false);
	            for (Cartao cartao : obCliente.getCartoes()) {
	                    
	                sql = new StringBuilder();
	                sql.append("UPDATE tb_cartoes SET CAR_NUM_CARTAO=?, CAR_CVV=?, CAR_NOME_TITULAR=?," 
	                    + " CAR_DT_VALIDADE=?, CAR_BANDEIRA=? ");
	                sql.append("WHERE CAR_CLI_ID=? AND CAR_NUM_CARTAO=?");
	
	                pst = connection.prepareStatement(sql.toString());
	
	                pst.setString(1, cartao.getsNumCartao());
	                pst.setString(2, cartao.getsCodSeguranca());
	                pst.setString(3, cartao.getsNomeTitular());
	                pst.setDate(4, Date.valueOf(cartao.getDtDataVal()));
	                pst.setString(5, cartao.getsBandeira());
	                pst.setInt(6, obCliente.getId());
	                pst.setString(7, cartao.getsNumCartao());
	                
	                pst.executeUpdate();
	                connection.commit();
	            }
        	}catch (SQLException e) {
	            try {
	                connection.rollback();
	            } catch (Exception e1) {
	                e1.printStackTrace();
	            }
	            e.printStackTrace();
	        } finally {
	            try {
	                pst.close();
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
        }else if(obCliente.getId() != null && obCliente.getEnderecos().get(0).getCEP() != null) {
        	try {
        		connection.setAutoCommit(false);
	            for (Endereco endereco : obCliente.getEnderecos()) {
	
	                sql = new StringBuilder();
	                sql.append("UPDATE tb_enderecos SET END_NOME=? ,END_TIPO_RESIDENCIA=?, END_TIPO_LOGRADOURO=?, END_LOGRADOURO=?,"
	                    + " END_BAIRRO=?, END_NUM_LOGRADOURO=?, END_CEP=?, END_CIDADE=?, END_PAIS=?,"
	                    + " END_FLG_COBRANCA=?, END_ESTADO=? ");
	                sql.append("WHERE END_CLI_ID=? AND END_CEP=? AND END_NUM_LOGRADOURO=?");
	
	                pst = connection.prepareStatement(sql.toString());
	                
	                
	                pst.setString(1, endereco.getNome());
                    pst.setString(2, endereco.getTipoResidencia());
                    pst.setString(3, endereco.getTipoLogradouro());
                    pst.setString(4, endereco.getLogradouro());
                    pst.setString(5, endereco.getBairro());
                    pst.setString(6, endereco.getNumerologradouro());
                    pst.setString(7, endereco.getCEP());
                    pst.setString(8, endereco.getCidade());
                    pst.setString(9, endereco.getPais());
                    pst.setBoolean(10, endereco.getFlgCobranca());
                    pst.setString(11, endereco.getEstado());
                    pst.setInt(12, obCliente.getId());
                    pst.setString(13, endereco.getCEP());
                    pst.setString(14, endereco.getNumerologradouro());
                    
	                System.out.println(pst.toString());
	                pst.executeUpdate();
	                connection.commit();
	            }    
	
	        } catch (SQLException e) {
	            try {
	                connection.rollback();
	            } catch (Exception e1) {
	                e1.printStackTrace();
	            }
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
    }

    @Override
	public void excluir(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		StringBuilder sql;
		Cliente cliente = (Cliente) entidade;
		System.out.println(cliente.getEnderecos().get(0).getCEP());
		System.out.println(cliente.getCartoes().get(0).getsNumCartao());
		if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() == null && cliente.getCartoes().get(0).getsNumCartao() == null) {
			try {
				connection.setAutoCommit(false);
				
				sql = new StringBuilder();
				sql.append("UPDATE tb_clientes SET CLI_ATIVO=? ");
				sql.append("WHERE CLI_ID=?");
				
				pst = connection.prepareStatement(sql.toString());
				
				pst.setBoolean(1, false);
				pst.setInt(2, cliente.getId());
				
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
		}else if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() != null && cliente.getCartoes().get(0).getsNumCartao() == null){
			System.out.println("entra no excluir");
			try {
			
				for (Endereco endereco : cliente.getEnderecos()) {
									
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("DELETE FROM tb_enderecos ");
					sql.append("WHERE END_CLI_ID=? AND END_CEP=? AND END_NUM_LOGRADOURO=?");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, cliente.getId());
					pst.setString(2, endereco.getCEP()); 
					pst.setString(3, endereco.getNumerologradouro());
					
					System.out.println(pst.toString());
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
		}else if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() == null && cliente.getCartoes().get(0).getsNumCartao() != null){
		
			try {
				
				for (Cartao cartao : cliente.getCartoes()) {
					
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("DELETE FROM tb_cartoes ");
					sql.append("WHERE CAR_CLI_ID=? AND CAR_NUM_CARTAO=?");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, cliente.getId());
					pst.setString(2, cartao.getsNumCartao());
					
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
	}

    @Override
    public List<EntidadeDominio> consultar (EntidadeDominio entidade) {
		
    	PreparedStatement pst = null;
    	PreparedStatement pst2 = null;
    	
    	Cliente cliente = (Cliente) entidade;
    	List<EntidadeDominio> clientes = new ArrayList<EntidadeDominio>();
    	StringBuilder sql = new StringBuilder();
    	
    	sql.append("SELECT * FROM tb_clientes AS cliente");
    	sql.append(" LEFT JOIN tb_cartoes AS cartao");
    	sql.append(" ON(cliente.CLI_ID = cartao.CAR_CLI_ID)");
    	sql.append(" LEFT JOIN tb_enderecos AS endereco");
    	sql.append(" ON(cliente.CLI_ID = endereco.END_CLI_ID)");
    	sql.append(" LEFT JOIN tb_cupom_troca AS troca");
    	sql.append(" ON(cliente.CLI_ID = troca.CPT_CLI_ID)");
    	sql.append(" WHERE 1=1");
    	
    	if(cliente.getsNome() != null && cliente.getsNome().length() > 0)
    		sql.append(" AND CLI_NOME LIKE'" + cliente.getsNome() + "%'");
    	
    	if(cliente.getId() != null && cliente.getId() > 0)
    		sql.append(" AND CLI_ID='" + cliente.getId() + "'");
    	
    	if(cliente.getsGenero() != null && cliente.getsGenero().length() > 0)
    		sql.append(" AND CLI_GENERO= '" + cliente.getsGenero() +"'");
    	
    	if(cliente.getDtDataNasc() != null)
    		sql.append(" AND CLI_DATA_NASC= '" + cliente.getDtDataNasc() + "'");
    	
    	if(cliente.getsCPF() != null && cliente.getsCPF().length() > 0)
    		sql.append(" AND CLI_CPF= '" + cliente.getsCPF() + "'");
    	
    	if(cliente.getsEmail() != null && cliente.getsEmail().length() > 0)
    		sql.append(" AND CLI_EMAIL= '" + cliente.getsEmail()  + "'");
    	
    	if(cliente.getnRanking() > 0)
    		sql.append(" AND CLI_RANKING= '" + cliente.getnRanking()  + "'");
    	
    	/*if(cliente.getsSenha() != null && cliente.getsSenha().length() > 0)
    		sql.append(" AND CLI_SENHA= '" + cliente.getsSenha()  + "'");*/
    	
    	if(cliente.getsTelefone() != null && cliente.getsTelefone().length() > 0)
    		sql.append(" AND CLI_TELEFONE= '" + cliente.getsTelefone()  + "'");
    	
    	/*try {
    		
	    	if(cliente.getIsAdmin())
	    		sql.append(" AND CLI_isADMIN= '" + cliente.getIsAdmin()  + "'");
	    	else if(!cliente.getIsAdmin())
	    		sql.append(" AND CLI_isADMIN= '" + cliente.getIsAdmin()  + "'");
    	}catch (Exception e) {
			
		}
    	
    	try {
    		
	    	if(cliente.getFlgAtivo())
	    		sql.append(" AND CLI_ATIVO= '" + cliente.getFlgAtivo() + "'");
	    	else if(!cliente.getFlgAtivo())
	    		sql.append(" AND CLI_ATIVO = '" + cliente.getFlgAtivo() + "'");
    	} catch (Exception e) {
			
		}*/
    	
    	try {
    	    sql.append(" AND CLI_isADMIN= '" + (cliente.getIsAdmin() ? 1 : 0) + "'");
    	}catch (Exception e) {
    	    // erro
    	}
    	
    	try {
    	    sql.append(" AND CLI_ATIVO= '" + (cliente.getFlgAtivo() ? 1 : 0) + "'");
    	} catch (Exception e) {
    	    //erro
    	}
    	
    	sql.append(" GROUP BY CLI_ID");
    	
    	try {
			
    		openConnection();
    		pst = connection.prepareStatement(sql.toString());
    		System.out.println(sql.toString());
    		ResultSet rs = pst.executeQuery();
    		ResultSet rs2;
    		
    		while(rs.next()) {
    			
    			Cliente cli = new Cliente();
    			cli.setId(rs.getInt("CLI_ID"));
    			cli.setsNome(rs.getString("CLI_NOME"));
    			cli.setsGenero(rs.getString("CLI_GENERO"));
    			cli.setDtDataNasc(rs.getDate("CLI_DATA_NASC"));
    			cli.setsCPF(rs.getString("CLI_CPF"));
    			cli.setsEmail(rs.getString("CLI_EMAIL"));
    			cli.setnRanking(rs.getInt("CLI_RANKING"));
    			cli.setsSenha(rs.getString("CLI_SENHA"));
    			cli.setsTelefone(rs.getString("CLI_TELEFONE"));
    			cli.setCartoes(new ArrayList<Cartao>());
    			cli.setEnderecos(new ArrayList<Endereco>());
    			cli.setIsAdmin(rs.getBoolean("CLI_isADMIN"));
    			cli.setFlgAtivo(rs.getBoolean("CLI_ATIVO"));
    		
    			if(!cli.getIsAdmin()) {
	    			sql = new StringBuilder();
	    			sql.append("SELECT * FROM tb_enderecos WHERE END_CLI_ID = ?");
	    			
	    			pst2 = connection.prepareStatement(sql.toString());
	    			pst2.setInt(1, cli.getId());
	    			rs2 = pst2.executeQuery();
	    			
	    			int i = 0;
	    			
	    			for(i = 0; rs2.next(); i++) {
	    				if(cli.getId() == rs2.getInt("END_CLI_ID")) {
	    					
	    					cli.getEnderecos().add(new Endereco());
	    					cli.getEnderecos().get(i).setNome(rs2.getString("END_NOME"));
	    					cli.getEnderecos().get(i).setBairro(rs2.getString("END_BAIRRO"));
	    					cli.getEnderecos().get(i).setCEP(rs2.getString("END_CEP"));
	    					cli.getEnderecos().get(i).setCidade(rs2.getString("END_CIDADE"));
	    					cli.getEnderecos().get(i).setEstado(rs2.getString("END_ESTADO"));
	    					cli.getEnderecos().get(i).setFlgCobranca(rs2.getBoolean("END_FLG_COBRANCA"));
	    					cli.getEnderecos().get(i).setLogradouro(rs2.getString("END_LOGRADOURO"));
	    					cli.getEnderecos().get(i).setNumerologradouro(rs2.getString("END_NUM_LOGRADOURO"));
	    					cli.getEnderecos().get(i).setPais(rs2.getString("END_PAIS"));
	    					cli.getEnderecos().get(i).setTipoLogradouro(rs2.getString("END_TIPO_LOGRADOURO"));
	    					cli.getEnderecos().get(i).setTipoResidencia(rs2.getString("END_TIPO_RESIDENCIA"));
	    					
	      				}
	    				else
	    					break;
	    			}
	    			
	    			sql = new StringBuilder();
	    			sql.append("SELECT * FROM tb_cartoes WHERE CAR_CLI_ID = ?");
	    			
	    			pst2 = connection.prepareStatement(sql.toString());
	    			pst2.setInt(1, cli.getId());
	    			rs2 = pst2.executeQuery();
	    			
	    			for(i = 0; rs2.next(); i++) {
	    				
	    				if(cli.getId() == rs2.getInt("CAR_CLI_ID")) {
	    					
	    					cli.getCartoes().add(new Cartao());
	    					cli.getCartoes().get(i).setDtDataVal(rs2.getString("CAR_DT_VALIDADE"));
	    					cli.getCartoes().get(i).setsBandeira(rs2.getString("CAR_BANDEIRA"));
	    					cli.getCartoes().get(i).setsCodSeguranca(rs2.getString("CAR_CVV"));
	    					cli.getCartoes().get(i).setsNomeTitular(rs2.getString("CAR_NOME_TITULAR"));
	    					cli.getCartoes().get(i).setsNumCartao(rs2.getString("CAR_NUM_CARTAO"));
	    				}
	    				else
	    					break;
	    			}
	    			
	    			sql = new StringBuilder();
	    			sql.append("SELECT * FROM tb_cupom_troca WHERE CPT_CLI_ID = ?");
	    			
	    			pst2 = connection.prepareStatement(sql.toString());
	    			pst2.setInt(1, cli.getId());
	    			System.out.println(pst2.toString());
	    			rs2 = pst2.executeQuery();
	    			
	    			for(i = 0; rs2.next(); i++) {
	    				
	    				if(cli.getId() == rs2.getInt("CPT_CLI_ID")) {
	    					
	    					cli.getCupons().add(new CupomTroca());
	    					cli.getCupons().get(i).setId(rs2.getInt("CPT_ID"));
	    					cli.getCupons().get(i).setValor(rs2.getDouble("CPT_VALOR"));
	    					System.out.println(cli.getCupons().get(i).getValor());
	    				}
	    				else
	    					break;
	    			}
	    		}
    			clientes.add(cli);
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return clientes;
    }

	@Override
	public void ativar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		StringBuilder sql;
		
		Cliente cliente = (Cliente) entidade;
		
		try {
			
			connection.setAutoCommit(false);
			
			sql = new StringBuilder();
			sql.append("UPDATE tb_clientes SET CLI_ATIVO=? ");
			sql.append("WHERE CLI_ID=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setBoolean(1, true);
			pst.setInt(2, cliente.getId());
			
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
}