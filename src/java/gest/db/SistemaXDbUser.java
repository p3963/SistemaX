/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;
import gest.pc.util.Utenti;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;       
import java.text.ParseException;
import java.util.Arrays;

/**
 *
 * @author p39
 */
public class SistemaXDbUser {
    private SistemaXDb SistemaXUtenti;
    private String[] utentiColumns;
    private Object[] values;
    private String db="";
    public SistemaXDbUser(String db) throws Exception{
        this.SistemaXUtenti= new SistemaXDb(db);
        this.utentiColumns=SistemaXUtenti.getDbColumnsOfTable("utenti");
    }
    public int insert(Utenti utenti) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.insert("utenti", this.utentiColumns, this.values(utenti));
    }
    public int qinsert(Utenti utenti) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.insert("utenti", this.utentiColumns, this.values(utenti));
    }
    public int currvalid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.currvalid("utenti");
    }
    public int maxid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.maxid("utenti");
    }
    public Utenti getUtenti(int id) throws SQLException, IllegalArgumentException, IllegalAccessException, NoSuchFieldException, ClassNotFoundException, ParseException{
        if (id>=0){
            String columns="";
            for (int i=0; i<this.utentiColumns.length; i++)
                columns+=this.utentiColumns[i]+",";
            columns=columns.substring(0, columns.length()-1);
            String sql = "SELECT "+columns+" FROM public.utenti where id="+id+"";
            ResultSet rs=this.SistemaXUtenti.query(sql);
            //PiCo p = new PiCo();
            Utenti m = new Utenti(this.db);
            if(rs.next()){
                m.setId(rs.getInt("id"));
                m.setAmm(rs.getBoolean("amm"));
                m.setCognome(rs.getString("cognome"));
                m.setNome(rs.getString("nome"));
                m.setUsername(rs.getString("username"));
                m.setPassword(rs.getString("password"));
                m.setSSID(rs.getString("sessionid"));
            }
            return m;
        }
        else
            return null;
    }
    public Utenti getUtenti(String username) throws SQLException, IllegalArgumentException, IllegalAccessException, NoSuchFieldException, ClassNotFoundException, ParseException{
            String columns="";
            for (int i=0; i<this.utentiColumns.length; i++)
                columns+=this.utentiColumns[i]+",";
            columns=columns.substring(0, columns.length()-1);
            String sql = "SELECT "+columns+" FROM public.utenti where username='"+username+"';";
            ResultSet rs=this.SistemaXUtenti.query(sql);
            //PiCo p = new PiCo();
            Utenti m = new Utenti(this.db);
            if(rs.next()){
                m.setId(rs.getInt("id"));
                m.setAmm(rs.getBoolean("amm"));
                m.setCognome(rs.getString("cognome"));
                m.setNome(rs.getString("nome"));
                m.setUsername(rs.getString("username"));
                m.setPassword(rs.getString("password"));
                m.setSSID(rs.getString("sessionid"));
            }
            return m;
    }
    public int update(Utenti utenti) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.update("utenti", this.utentiColumns, this.values(utenti));
    }
    public int dquery(String table, Utenti utenti) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.update("utenti", this.utentiColumns, this.values(utenti));
    }

    public ResultSet query(String sql) throws SQLException {
        
        return SistemaXUtenti.query(sql);
    }
    //aggiunto dopo
    public int uquery(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXUtenti.uquery(sql);
    }
    //aggiunto dopo
    private Object[] values(Utenti utenti) throws IllegalArgumentException, IllegalAccessException{
        Field[] f=utenti.getClass().getFields();
//        TypeVariable [] tp = conto.getClass().getTypeParameters();
        String[] s = new String[this.utentiColumns.length];
        String[] st = new String[this.utentiColumns.length];
        for (int n=0; n<s.length; n++){
            s[n]=f[n].getName();
            st[n]=f[n].getType().getName();
        }
        Arrays.sort(s);
        this.values = new Object[this.utentiColumns.length];
        int n=0;
        for (String ss: s){
            this.values[n]=utenti.getValueOf(ss);
            n++;
        }
        return this.values;
    }
}
