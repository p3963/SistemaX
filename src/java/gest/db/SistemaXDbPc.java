/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;
import gest.pc.PiCo;
import gest.pc.Conto;
import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import org.json.JSONArray;

/**
 *
 * @author p39
 */
public class SistemaXDbPc {

    private SistemaXDb SistemaXPc;
    private String[] pcColumns;
    private Object[] values;
    private String db="";
    public SistemaXDbPc(String db) throws Exception{
        this.SistemaXPc= new SistemaXDb(db);
        this.pcColumns=SistemaXPc.getDbColumnsOfTable("pc");
    }
    public int insert(Conto conto) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.insert("pc", this.pcColumns, this.values(conto));
    }
    public int insert(Conto conto,int id) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.insert("pc", id,this.pcColumns, this.values(conto));
    }
    public int update(Conto conto) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.update("pc", this.pcColumns, this.values(conto));
    }
    public int dquery(Conto conto) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.dquery("pc", conto);
    }
    public ResultSet query(String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.query(sql);
    }
    public int currvalid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.currvalid("pc");
    }
    public int maxid() throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.maxid("pc");
    }
    public int qinsert(Conto conto) throws SQLException, IllegalArgumentException, IllegalAccessException{
        return SistemaXPc.qinsert("pc", this.pcColumns, this.values(conto));
    }
    public int uquery(String sql) throws SQLException{
        int r = SistemaXPc.uquery(sql);
        return r;
    }
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//    public int uquery(Conto conto, String sql) throws SQLException, IllegalArgumentException, IllegalAccessException{
//        return SistemaXPc.executeUpdate("pc", this.pcColumns, this.values(conto));
//    }
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    public Conto getConto(int id) throws SQLException, IllegalArgumentException, IllegalAccessException, NoSuchFieldException, ClassNotFoundException, IOException{
        if (id>=0){
            String columns="";
            for (int i=0; i<this.pcColumns.length; i++)
                columns+=this.pcColumns[i]+",";
            columns=columns.substring(0, columns.length()-1);
            String sql = "SELECT "+columns+" FROM public.pc where id='"+id+"';";
            ResultSet rs=this.SistemaXPc.query(sql);
            Conto c = new Conto(this.db);
            if(rs.next()){
                c.setDescr(rs.getString("descr"));
                c.setFid(rs.getInt("fid"));
                c.setLevel("0");//%%%%%%%%%%% rs.getString("level") %%%%%%%%%%%
                c.setMvmble(rs.getBoolean("mvmble"));
                c.setNid(rs.getInt("nid"));
                c.setPid(rs.getInt("pid"));
                c.setRc(rs.getInt("rc"));
                c.setSid(rs.getInt("sid"));
                c.setId(rs.getInt("id"));
                c.setCat(rs.getInt("cat"));
                c.setSaldoa(rs.getString("saldoa"));
                c.setSaldod(rs.getString("saldod"));
                c.setPos(rs.getInt("pos"));
            }
            return c;
        }
        else
            return null;
    }
    public Conto getContoByPos (int pos, JSONArray s) throws Exception{
        return PiCo.pc.getConto(s.getInt(pos));
    }
    private Object[] values(Conto conto) throws IllegalArgumentException, IllegalAccessException{
        Field[] f=conto.getClass().getFields();
//        TypeVariable [] tp = conto.getClass().getTypeParameters();
        String[] s = new String[this.pcColumns.length];
        String[] st = new String[this.pcColumns.length];
        for (int n=0; n<s.length; n++){
            s[n]=f[n].getName();
            st[n]=f[n].getType().getName();
        }
        Arrays.sort(s);
        this.values = new Object[this.pcColumns.length];
        int n=0;
        for (String ss: s){
            this.values[n]=conto.getValueOf(ss);
            n++;
        }
        return this.values;
    }
}
