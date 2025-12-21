/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;

/**
 *
 * @author p39
 */
import java.sql.*;
public class DbMaria extends org.postgresql.Driver{
    private Connection conn;
    protected Statement st;
    public DbMaria (){
    
    }
    public DbMaria(String db,String user,String pass) {
      try {  
       // Class.forName("org.postgresql.Driver");
       this.conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+db,user,pass);
//       this.conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/"+db,user,pass);
       this.conn.setAutoCommit(true);
       this.st = conn.createStatement();
      }catch (Exception e){
          e.printStackTrace();
      }
    }
    public ResultSet query(String q) throws SQLException{
        return this.st.executeQuery(q);
    }
    public int uquery(String q) throws SQLException{
        int i=this.st.executeUpdate(q);
        this.st.getConnection().commit();
        return i;
    }
    protected void stclose() throws SQLException{
        this.st.close();
    }
    protected void connclose() throws SQLException{
       this.conn.close();            
    }
}
