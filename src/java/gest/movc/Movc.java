/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.movc;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author p39
 */
public class Movc {
    public int id=0;
    public Date data = null;
    public String descr = null;
    public boolean da = true;
    public BigDecimal imp = null;
    public int pcid=0;
    public int acid=0;
    public int veid=0;
    public int odid=0;
    public int riga=0;
//    private String db = null;

    public Movc(String db) throws ParseException {
//        this.db=db;
        this.id=0;
        this.data=this.setData("0000-00-00");
        this.imp= new BigDecimal("0.00");
        this.pcid=0;
        this.acid=0;
        this.veid=0;
        this.odid=0;
        this.riga=0;
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

    public void setDescr(String string) {
        this.descr=string;
    }

    public void setId(int aInt) {
        this.id=aInt;
    }

    public void setImp(String string) {
        this.imp = new BigDecimal(string);
    }
    public void setImp(BigDecimal bd) {
        this.imp = bd;
    }
    public void setImp(Long l) {
        this.imp = new BigDecimal(l);
    }

    public int getRiga() {
        return riga;
    }

    public void setRiga(int riga) {
        this.riga = riga;
    }

//    public String getDb() {
//        return db;
//    }
//
//    public void setDb(String db) {
//        this.db = db;
//    }


    public void setDa(boolean aBoolean) {
        this.da=aBoolean;
    }
    public Date setData(String string) throws ParseException {
        DateFormat df= new SimpleDateFormat ("yyyy-MM-dd");
        return this.data = df.parse(string);
    }
    public void setPcid(int aInt) {
        this.pcid=aInt;
    }
    public void setPcid(String aInt) {
        this.pcid=Integer.parseInt(aInt);
    }
    public void setAcid(int aInt) {
        this.acid=aInt;
    }
    public void setVeid(int aInt) {
        this.veid=aInt;
    }
    public void setOdid(int aInt) {
        this.odid=aInt;
    }
    public String getDescr() {
        return this.descr;
    }

    public int getId() {
        return this.id;
    }

    public BigDecimal getImp() {
        return this.imp;
    }


    public boolean getDa() {
        return this.da;
    }

    public Date getData(){
        return this.data;
    }
    public String getFormatData(){
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
        return sdf.format(this.data);
    }

    public int getPcid() {
        return this.pcid;
    }
    public int getAcid() {
        return this.acid;
    }
    public int getVeid() {
        return this.veid;
    }
    public int getOdid() {
        return this.odid;
    }
}
