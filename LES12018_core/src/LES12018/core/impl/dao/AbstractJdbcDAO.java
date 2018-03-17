package LES12018.core.impl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;

import LES12018.core.IDAO;
import LES12018.core.util.Conexao;

public abstract class AbstractJdbcDAO implements IDAO{
	protected Connection connection;
	protected String table;
	protected String idTable;
	protected boolean ctrlTransaction = true;
	
	public AbstractJdbcDAO(Connection connection, String table, String idTable) {
		this.table = table;
		this.idTable = idTable;
		this.connection = connection;
	}
	
	protected AbstractJdbcDAO( String table, String idTable) {
		this.table = table;
		this.idTable = idTable;
	}
	
	protected void openConnection() {
		try {
			if(connection == null || connection.isClosed())
				connection = Conexao.getConnection();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
