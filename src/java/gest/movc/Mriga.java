/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.movc;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.ParseException;

/**
 *
 * @author p39
 */
public class Mriga {
    public int id=0;
    public int idmovc=0;
    public String descr = null;
    public boolean da = true;
    public BigDecimal imp = null;
    public int pcid=0;
    public int riga=0;
    private String db = null;

    public Mriga(String db) throws ParseException {
        this.db=db;
        this.id=0;
        this.idmovc=0;
        this.riga=0;
        this.imp= new BigDecimal("0.00");
        this.pcid=0;
        this.da=true;
        this.descr="";
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

    public int getIdmovc() {
        return idmovc;
    }

    public void setIdmovc(int idmovc) {
        this.idmovc = idmovc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public boolean isDa() {
        return da;
    }

    public void setDa(boolean da) {
        this.da = da;
    }

    public BigDecimal getImp() {
        return imp;
    }

    public void setImp(String imp) {
        this.imp = new BigDecimal(imp);
    }

    public int getPcid() {
        return pcid;
    }

    public void setPcid(int pcid) {
        this.pcid = pcid;
    }

//    public String getDb() {
//        return db;
//    }
//
//    public void setDb(String db) {
//        this.db = db;
//    }

    public int getRiga() {
        return riga;
    }

    public void setRiga(int riga) {
        this.riga = riga;
    }

    public String getDb() {
        return db;
    }

}
