/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.db;

import gest.pc.Conto;
import java.sql.*;

/**
 *
 * @author p39
 */
public class SistemaXDb{
    private Db gest;
    protected String[] tables=null;
    protected String[] columns=null;
    public SistemaXDb(String db) throws Exception{
        this.gest = new Db(DbParameter.getDb(),DbParameter.getUser(),DbParameter.getPass());
        this.tables=null;
        this.columns=null;
    }
    public SistemaXDb(String db,String user, String password) throws Exception{
        this.gest = new Db(db,user,password);
        this.tables=null;
        this.columns=null;
    }
    public String[] getDbTables() throws SQLException{
        String sql="SELECT table_name as t FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema = 'public' ORDER BY table_name;";
        ResultSet rs=this.gest.query(sql);
        int i=0;
        while(rs.next()){
            String x = rs.getString("t");
            i++;
        }
        this.tables = new String[i];
        rs.close();
        sql="SELECT table_name as t FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema = 'public' ORDER BY table_name;";
        rs=this.gest.query(sql);
        int n=0;
        while(rs.next()){
            this.tables[n]=rs.getString("t");
            n++;////////////???????????
        }
        rs.close();
        return this.tables;
    }
    protected String[] getDbColumnsOfTable(String table) throws SQLException{
        //List<String> tl = Arrays.asList(this.getDbTables());
        //if(tl.contains(table)){
            String sql="SELECT column_name as c FROM information_schema.columns WHERE table_name ='"+table+"' order by column_name;";
            ResultSet rs = this.gest.query(sql);
            int i=0;
            while(rs.next()){
                i++;
            }
            this.columns = new String[i];
            rs.close();
            sql="SELECT column_name as c FROM information_schema.columns WHERE table_name ='"+table+"' order by column_name;";
            rs = this.gest.query(sql);
            int n=0;
            while(rs.next()){
                this.columns[n]=rs.getString("c");
                n++;
            }
            rs.close();
        //}
        return this.columns;
    }
    protected int insert(String table, String[] columns, Object[] values) throws SQLException{
        String tableColumns = "";
        String valueOfColumns ="";
        int posOfId=0;
        for(int n=0; n<columns.length; n++){
            if (columns[n].compareTo("id")==0){
                posOfId=n;
            }
            else
                tableColumns+=columns[n]+",";
        }
        tableColumns=tableColumns.substring(0, tableColumns.length()-1);
        for (int i=0; i<values.length; i++){
            String s="";
            if (i==posOfId)
                continue;
            if (values[i]==null)
                s=null;
            else
                s=values[i].toString();
            valueOfColumns+="'"+s+"',";
        }
        valueOfColumns=valueOfColumns.substring(0, valueOfColumns.length()-1);
        String sql="INSERT into public."+table+" ("+tableColumns+") values ("+valueOfColumns+");";
        int r = this.gest.uquery(sql);
        //this.gest.stclose();
        return r;
    }
    protected int qinsert(String table, String[] columns, Object[] values) throws SQLException{
        String tableColumns = "";
        String valueOfColumns ="";
        int posOfId=0;
        for(int n=0; n<columns.length; n++){
            if (columns[n].compareTo("id")==0){
                posOfId=n;
            }
            else
                tableColumns+=columns[n]+",";
        }
        tableColumns=tableColumns.substring(0, tableColumns.length()-1);
        for (int i=0; i<values.length; i++){
            String s="";
            if (i==posOfId)
                continue;
            if (values[i]==null)
                s=null;
            else
                s=values[i].toString();
            valueOfColumns+="'"+s+"',";
        }
        valueOfColumns=valueOfColumns.substring(0, valueOfColumns.length()-1);
        String sql="INSERT into public."+table+" ("+tableColumns+") values ("+valueOfColumns+") RETURNING id;";
        ResultSet rs = this.gest.query(sql);
        if(rs.next())
            return rs.getInt("id");
        else
            return -1;
    }
    protected int insert(String table, int id,String[] columns, Object[] values) throws SQLException{
        String tableColumns = "";
        String valueOfColumns ="";
        int posOfId=0;
        for(int n=0; n<columns.length; n++){
            if (columns[n].compareTo("id")==0){
                posOfId=n;
            }
            else
                tableColumns+=columns[n]+",";
        }
        tableColumns=tableColumns.substring(0, tableColumns.length()-1)+",id";
        for (int i=0; i<values.length; i++){
            String s="";
            if (i==posOfId){
                //values[i]=id;
                continue;
            }
            if (values[i]==null)
                s=null;
            else
                s=values[i].toString();
            valueOfColumns+="'"+s+"',";
        }//INSERT INTO persons (lastname,firstname) VALUES ('Smith', 'John') RETURNING id;

        valueOfColumns=valueOfColumns.substring(0, valueOfColumns.length()-1)+","+id;
        String sql="INSERT into public."+table+" ("+tableColumns+") values ("+valueOfColumns+");";
        int r = this.gest.uquery(sql);
        //this.gest.stclose();
        return r;
    }
    protected int update(String table, String[] columns, Object[] values) throws SQLException{
        String updateColumn = "";
        int n=0;
        String id="";
        for(String s: columns){
            if (s.compareTo("id")==0){
                id=values[n].toString();
                n++;
                continue;
            }
            updateColumn+=s+"='"+values[n].toString()+"',";
            n++;
        }
        updateColumn=updateColumn.substring(0, updateColumn.length()-1);
        String sql="UPDATE public."+table+" set "+updateColumn+" where id='"+id+"';";
        int r = this.gest.uquery(sql);
        //this.gest.stclose();
        return r;
    }
    public ResultSet query(String sql) throws SQLException{
        ResultSet rs = this.gest.query(sql);
        return rs;
    }
    protected int dquery(String table, Conto conto) throws SQLException{
        String sql="DELETE FROM public."+table+" where id='"+conto.getId()+"';";
        int r = this.gest.uquery(sql);
        return r;
    }
    protected int uquery(String sql) throws SQLException{
        int r = this.gest.uquery(sql);
        return r;
    }
    protected int currvalid(String table) throws SQLException{
        String sql = "SELECT CURRVAL(pg_get_serial_sequence('"+table+"','id'));";
        ResultSet rs = this.gest.query(sql);
        if (rs.next()){
            return rs.getInt("CURRVAL");
        }
        else{
            return -1;
        }
    }
    protected int maxid(String table) throws SQLException{
        String sql = "SELECT max(id) as m from public."+table+";";
        ResultSet rs = this.gest.query(sql);
        if (rs.next()){
            return rs.getInt("m");
        }
        else{
            return -1;
        }
    }
}

