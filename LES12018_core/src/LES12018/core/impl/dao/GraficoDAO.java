package LES12018.core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import les12018.auxiliar.ItemsGrafico;
import les12018.dominio.DadosParaGrafico;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Pedido;

public class GraficoDAO extends AbstractJdbcDAO{
	public GraficoDAO() {
		super("tb_livro", "id_livro");
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
	public void ativar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		openConnection();                                       // abre a conexão com o Banco
		ArrayList<ItemsGrafico> dados = new ArrayList<ItemsGrafico>();
        PreparedStatement pst = null;
        DadosParaGrafico dadosParaGrafico = (DadosParaGrafico) entidade;
    	List<EntidadeDominio> graficos = new ArrayList<EntidadeDominio>();
        StringBuilder sql = new StringBuilder();
        
        if(dadosParaGrafico != null) {
        	sql.append("SELECT CAT_ID, CAT_NOME as categoria, SUM(quantidade) as total, mês FROM ");
        	sql.append("(SELECT ITP_LIV_ID, CON_CAT_ID, quantidade, mês FROM ");
			sql.append("(SELECT DISTINCT ITP_LIV_ID, sum(ITP_QTD) as quantidade, month(PED_DATA) as mês FROM (SELECT PED_ID, PED_DATA FROM tb_pedidos ");
			sql.append("WHERE month(PED_DATA) >= month(?) AND month(PED_DATA) <= month(?) AND year(PED_DATA) = year(sysdate())) as data_comparacao JOIN ");
			sql.append("tb_item_pedido as itempedido WHERE data_comparacao.PED_ID = itempedido.ITP_PED_ID ");
			sql.append("group by ITP_LIV_ID, month(PED_DATA)) as livropedido JOIN tb_contem as contemcat ");
			sql.append("WHERE contemcat.CON_LIV_ID = livropedido.ITP_LIV_ID) as liv_cat_qtd JOIN tb_categoria as cat ");
			sql.append("WHERE liv_cat_qtd.CON_CAT_ID = cat.CAT_ID ");
			sql.append("GROUP BY CAT_ID, mês ");
			sql.append("ORDER BY categoria ASC ");
			
			try {
	    		openConnection();
	    		pst = connection.prepareStatement(sql.toString());
	    		
	    		pst.setDate(1, dadosParaGrafico.getDataInicial());
	    		pst.setDate(2, dadosParaGrafico.getDataFinal());
	    		
	    		System.out.println(pst.toString());
	    		ResultSet rs = pst.executeQuery();
	    		
	    		while(rs.next()) {
	    			ItemsGrafico grafico = new ItemsGrafico();
	    			grafico.setIdCategoria(rs.getInt("CAT_ID"));
	    			grafico.setNomeCategoria(rs.getString("categoria"));
	    			grafico.setQtdTotal(rs.getInt("total"));
	    			grafico.setMes(rs.getInt("mês"));
	    			
	    			dados.add(grafico);
	    		}
	    		sql = new StringBuilder();
	    		sql.append("SELECT count(CAT_ID) as total from tb_categoria");
	    		
	    		pst = connection.prepareStatement(sql.toString());
	    		rs = pst.executeQuery();
	    		
	    		while(rs.next()) {
	    			dadosParaGrafico.setTotalCat(rs.getInt("total"));
	    		}
	    		
	    		dadosParaGrafico.setItems(dados);
	    	}catch (Exception e) {
				e.printStackTrace();
			}
			
        }
        
        graficos.add(dadosParaGrafico);
		return graficos;
	}

}
