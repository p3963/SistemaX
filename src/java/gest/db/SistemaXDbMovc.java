/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;
import gest.movc.Movc;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Arrays;

/**
 *
 * @author p39
 */
public class SistemaXDbMovc {
    private SistemaXDb SistemaXMovc;
    private String[] movcColumns;
    private Object[] values;
    private String db="";
    public SistemaXDbMovc(String db) throws Exception{
        this.SistemaXMovc= new SistemaXDb(db);
        this.movcColumns=SistemaXMovc.getDbColumnsOfTable("movc");
    }
    public int insert(Movc movc) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.insert("movc", this.movcColumns, this.values(movc));
    }
    public int qinsert(Movc movc) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.insert("movc", this.movcColumns, this.values(movc));
    }
    public ResultSet query(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.query(sql);
    }
    public int currvalid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.currvalid("movc");
    }
    public int maxid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.maxid("movc");
    }
    public int uquery(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.uquery(sql);
    }
    public Movc getMovc(int id) throws SQLException, IllegalArgumentException, IllegalAccessException, NoSuchFieldException, ClassNotFoundException, ParseException{
        if (id>=0){
            String columns="";
            for (int i=0; i<this.movcColumns.length; i++)
                columns+=this.movcColumns[i]+",";
            columns=columns.substring(0, columns.length()-1);
            String sql = "SELECT "+columns+" FROM public.movc where id="+id+"";
            ResultSet rs=this.SistemaXMovc.query(sql);
            //PiCo p = new PiCo();
            Movc m = new Movc(this.db);
            if(rs.next()){
                m.setDescr(rs.getString("descr"));
                m.setId(rs.getInt("id"));
                m.setImp(rs.getString("imp"));
                m.setPcid(rs.getInt("pcid"));
                m.setAcid(rs.getInt("acid"));
                m.setVeid(rs.getInt("veid"));
                m.setOdid(rs.getInt("odid"));
                m.setDa(rs.getBoolean("da"));
                m.setData(rs.getString("data"));
                m.setRiga(rs.getInt("riga"));
            }
            return m;
        }
        else
            return null;
    }
    public int update(Movc movc) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.update("movc", this.movcColumns, this.values(movc));
    }
    public int dquery(String table, Movc movc) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMovc.update("movc", this.movcColumns, this.values(movc));
    }
    private Object[] values(Movc movc) throws IllegalArgumentException, IllegalAccessException{
        Field[] f=movc.getClass().getFields();
//        TypeVariable [] tp = conto.getClass().getTypeParameters();
        String[] s = new String[this.movcColumns.length];
        String[] st = new String[this.movcColumns.length];
        for (int n=0; n<s.length; n++){
            s[n]=f[n].getName();
            st[n]=f[n].getType().getName();
        }
        Arrays.sort(s);
        this.values = new Object[this.movcColumns.length];
        int n=0;
        for (String ss: s){
            this.values[n]=movc.getValueOf(ss);
            n++;
        }
        return this.values;
    }
}
