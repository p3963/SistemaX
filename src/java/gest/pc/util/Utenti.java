/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gest.pc.util;

import gest.db.Db;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author p39
 */
public class Utenti {
    public int id;
    public String username;
    public String password;
    public String nome;
    public String cognome;
    public boolean amm;
    public String sessionid;
    private String db = null;
    public Utenti(){
        this.amm = false;

    }
    public Utenti (String db) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException{
        this.db=db;
    }
    public Utenti (String db, String username) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException{
        this.db=db;
        this.username=username;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getSSID() {
        return sessionid;
    }

    public void setSSID(String sessionid) {
        this.sessionid = sessionid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public boolean isAmm() {
        return amm;
    }

    public void setAmm(boolean amm) {
        this.amm = amm;
    }
            public Object getValueOf(String field) throws IllegalArgumentException, IllegalAccessException{
            Field[] f=this.getClass().getDeclaredFields();
            Object result=null;
            for (Field ff: f){
                if (ff.getName()==field){
                    ff.setAccessible(true);
                    result=ff.get(this);
                    break;
                }
            }
            return result;
        }
    public String getSessionId(String username) throws SQLException {
        String sql= "select sessionid from utenti where username='"+username+"';";
        Connection p = PgsqlConnector.db;
        Statement st = p.createStatement();
        ResultSet sessionids= st.executeQuery(sql);
        while(sessionids.next()){
            this.sessionid=sessionids.getString("sessionid");
        }
        return sessionid;
    }

}
