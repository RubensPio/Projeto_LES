package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.mysql.jdbc.Statement;

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
		Pedido objPedido = new Pedido();
		
		 StringBuilder sql;
		 if(objPedido != null) {
			 try {
				 connection.setAutoCommit(false);
	             sql = new StringBuilder();
	             
	             sql.append("INSERT into tb_pedidos(PED_VALORTOTAL, PED_CLI_ID, PED_METODOPAG, PED_FRETE) ");
	             sql.append("VALUES(?,?,?,?)");
	             
	             pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
	             
	             pst.setDouble(1, objPedido.getValorTotal());
	             pst.setInt(2, objPedido.getCliente().getId());
	             pst.setString(3, objPedido.getFormaDePagamento());
	             pst.setDouble(4, objPedido.getFrete());
	             
	             pst.executeUpdate();
	             
	             ResultSet rs = pst.getGeneratedKeys();
	                int num=0;
	                if(rs.next())
	    			{
	    				num = rs.getInt(1);
	    				objPedido.setId(num);
	    			}
	    			
	    		connection.commit();
	    			
	    		connection.setAutoCommit(false);
	    		for(Produto prod:objPedido.getProdutos()) {
	    			sql = new StringBuilder();
					sql.append("INSERT INTO tb_item_pedido(ITP_LIV_ID, ITP_PED_ID, ITP_SUBTOTAL, ITP_QTD)");
					sql.append("VALUES(?,?,?,?)");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, prod.getId());
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
		 }
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
	public void ativar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
}
