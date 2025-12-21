/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author p39
 */
public class Userold {
    private int id=0;
    private String username="";
    private String password="";
    private String nome="";
    private String cognome="";
    private String sessionId="";
    private static PgsqlConnector connector=null;
    private ArrayList<Userold> alusers=null;

    public Userold() {
        this.id = 0;
        this.username = "";
        this.password = "";
        this.nome = "";
        this.cognome = "";
        this.sessionId = "";
        this.connector=new PgsqlConnector();
        this.alusers=new ArrayList<Userold>();
    }
    public Userold(int id, String username, String password, String nome, String cognome, String sessionId) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.nome = nome;
        this.cognome = cognome;
        this.sessionId = sessionId;
        this.connector=new PgsqlConnector();
        this.alusers=new ArrayList<Userold>();
    }
    
    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public String getSessionId() {
        return sessionId;
    }
    
    public String getSessionId(String username) throws SQLException {
        String sql= "select sessionid from users where username='"+username+"';";
        ResultSet sessionids= connector.rs(sql);
        while(sessionids.next()){
            this.sessionId=sessionids.getString("sessionid");
        }
        return sessionId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
    public ArrayList<Userold> getUsers() throws SQLException{
        try {
            String sql="select * from users";
            ResultSet users= connector.rs(sql);
            while(users.next()){
                Userold user = new Userold();
                user.id=users.getInt("id");
                user.username=users.getString("username");
                user.password=users.getString("password");
                user.nome=users.getString("nome");
                user.cognome=users.getString("cognome");
                user.sessionId=users.getString("sessionid");
                alusers.add(user);
            }
        }
        catch(SQLException e){
              throw new SQLException(e);
        }
        return alusers;
    }
    public static String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
         
        return sb.toString();
    }
    public int updateSessionIdUser(String username, String sessionId) throws SQLException{
        String sql = "update users set sessionid='"+sessionId+"' where username='"+username+"';";
        int result=connector.rsu(sql);
        return result;
    }
    public boolean setUser(String username) throws SQLException{
        String sql="select * from users where username='"+username+"';";
        ResultSet users= connector.rs(sql);
        boolean result=false;
        while(users.next()){
            this.id=users.getInt("id");
            this.username=users.getString("username");
            this.password=users.getString("password");
            this.nome=users.getString("nome");
            this.cognome=users.getString("cognome");
            this.sessionId=users.getString("sessionid");
            this.alusers.add(this);
            result = true;
        }
        return result;
    }
}

