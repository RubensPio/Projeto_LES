package LES12018.core.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
	public static Connection getConnection()
		throws ClassNotFoundException, 
		SQLException{
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost/";
		String user = "root";
		String paswd = "4721";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, user, paswd);
		
		return conn;
	}
}
