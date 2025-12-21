/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package gest.pc.util;

import gest.db.Db;
import gest.db.DbParameter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author p39
 */
public class PgsqlConnector extends Db {
    public static Connection db;
    public PgsqlConnector(){
        Db db = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
        this.db=db.getConn();            //this.db=new PgsqlServlet().getDb();

    }
    public Connection getDb() {
        return this.db;
    }
    public ResultSet rs(String sql) throws SQLException{
        return db.createStatement().executeQuery(sql);
    }
    public synchronized int rsu(String sql) throws SQLException{
        return db.createStatement().executeUpdate(sql);
    }
    public synchronized int rsadd(String sql) throws SQLException{
        int result=0;
        Statement st=db.createStatement();
        if(st.executeUpdate(sql)!=0){
            ResultSet rsid=st.executeQuery("SELECT LAST_INSERT_ID() AS ID;");
            while(rsid.next()){
                result=rsid.getInt("ID");
            }
        }
        return result;
    }
}   
