/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;
import gest.movc.Mriga;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Arrays;

/**
 *
 * @author p39
 */
public class SistemaXDbMriga {
    private SistemaXDb SistemaXMriga;
    private String[] mrigaColumns;
    private Object[] values;
    private String db="";
    public SistemaXDbMriga(String db) throws Exception{
        this.SistemaXMriga= new SistemaXDb(db);
        this.mrigaColumns=SistemaXMriga.getDbColumnsOfTable("mrighe");
    }
    public int insert(Mriga mriga) throws SQLException, IllegalArgumentException, IllegalAccessException, IOException{
        return SistemaXMriga.insert("mrighe", this.mrigaColumns, this.values(mriga));
    }
    public int qinsert(Mriga mriga) throws SQLException, IllegalArgumentException, IllegalAccessException, IOException{
        return SistemaXMriga.qinsert("mrighe", this.mrigaColumns, this.values(mriga));
    }
    public ResultSet query(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMriga.query(sql);
    }
    public int uquery(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMriga.uquery(sql);
    }
    public int currvalid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMriga.currvalid("mrighe");
    }
    public int maxid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXMriga.maxid("mrighe");
    }
    public Mriga getMriga(int id) throws SQLException, IllegalArgumentException, IllegalAccessException, NoSuchFieldException, ClassNotFoundException, ParseException{
        if (id>=0){
            String columns="";
            for (int i=0; i<this.mrigaColumns.length; i++)
                columns+=this.mrigaColumns[i]+",";
            columns=columns.substring(0, columns.length()-1);
            //System.out.println(columns);
            String sql = "SELECT "+columns+" FROM public.mrighe where id="+id+"";
            ResultSet rs=this.SistemaXMriga.query(sql);
            //PiCo p = new PiCo();
            Mriga m = new Mriga(this.db);
            if(rs.next()){
                m.setId(rs.getInt("id"));
                m.setId(rs.getInt("riga"));
                m.setIdmovc(rs.getInt("idmovc"));
                m.setDescr(rs.getString("descr"));
                m.setImp(rs.getString("imp"));
                m.setPcid(rs.getInt("pcid"));
                m.setDa(rs.getBoolean("da"));
            }
            return m;
        }
        else
            return null;
    }
    public int update(Mriga mriga) throws SQLException, IllegalArgumentException, IllegalAccessException, IOException{
        return SistemaXMriga.update("mrighe", this.mrigaColumns, this.values(mriga));
    }
    private Object[] values(Mriga mriga) throws IllegalArgumentException, IllegalAccessException, IOException{
        Field[] f=mriga.getClass().getFields();
//        TypeVariable [] tp = conto.getClass().getTypeParameters();
        String[] s = new String[this.mrigaColumns.length];
        String[] st = new String[this.mrigaColumns.length];
        for (int n=0; n<f.length; n++){
            s[n]=f[n].getName();
            st[n]=f[n].getType().getName();
        }
        Arrays.sort(s);
        this.values = new Object[this.mrigaColumns.length];
        int n=0;
        for (String ss: s){
            this.values[n]=mriga.getValueOf(ss);
            n++;
        }
        return this.values;
    }
}
