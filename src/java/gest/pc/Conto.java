/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc;

import gest.pc.util.Livello;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;

/**
 *
 * @author p39
 */
    public class Conto {
        public int id=0;
        public int fid=0;
        public int nid=0;
        public int pid=0;
        public int sid=0;
        public String descr= "";
        public int rc=0;
        public boolean mvmble=true;
        public int cat=0;
        public BigDecimal saldoa=null;
        public BigDecimal saldod=null;
        public int pos=0;
        public String level="0";
        private String db="";
        public Conto (String db,String descr,Conto fid) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, Exception {
            this.db=db;
            this.descr=descr;
            this.fid=PiCo.pc.getConto(fid.id).id;
            this.sid=0;
            this.nid=0;
            this.id=0;
            this.mvmble=true;
            this.cat=0;
            this.saldoa = new BigDecimal("0.00");
            this.saldod = new BigDecimal("0.00");
            this.pos=0;
            //%%%%%%%%%%%%%%%%%
            this.level="0";
//            if (this.lastChild(fid)==-1)
//                this.level=fid.level+".1";
//            else
//                this.level= new Livello(PiCo.pc.getConto(this.lastChild(fid)).level).compLivello(1,PiCo.pc.getConto(this.lastChild(fid)).level);
            //%%%%%%%%%%%%%%%%%
        }
        public Conto (String db) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException{
            this.db=db;
            this.descr="";
            this.fid=0;
            this.sid=0;
            this.nid=0;
            this.pid=0;
            this.id=0;
            this.mvmble=true;
            this.cat=0;
            this.saldoa = new BigDecimal("0.00");
            this.saldod = new BigDecimal("0.00");
            this.pos=0;
            this.level="0";
        }
        public Conto (Conto c, String db) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException{
            Conto cc= new Conto (this.db);
//            if(c.getId()!=0){
                cc=PiCo.pc.getConto(c.getId());
                this.db=db;
                this.descr=cc.getdescr();
                this.fid=cc.getfid();
                this.sid=cc.getsid();
                this.nid=cc.getnid();
                this.pid=cc.getpid();
                this.id=cc.getId();
                this.mvmble=cc.getMvmble();
                this.cat=cc.getCat();
                this.pos=cc.getPos();
                this.level=cc.getlevel();
        }
        public int getsid(){
            return this.sid;
        }
        public int getfid(){
            return this.fid;
        }
        public int getnid(){
            return this.nid;
        }
        public int getpid(){
            return this.pid;
        }
        public String getlevel(){
            return this.level;
        }
        public String getdescr(){
            return this.descr;
        }
        public int getId(){
            return this.id;
        }
        public int getCat(){
            return this.cat;
        }
        public boolean getMvmble(){
            return this.mvmble;
        }
        public BigDecimal getSaldoa(){
            return this.saldoa;
        }
        public BigDecimal getSaldod(){
            return this.saldod;
        }
        public int getPos(){
            return this.pos;
        }
        public boolean hasSon(){
            if(this.getsid()>0)
                return true;//this.getsid();
            else
                return false;                
        }
        public boolean hasNext(){
            if(this.getnid()>0)
                return true;//this.getnid();
            else
                return false;                
        }
        public void setId(int id){
            this.id=id;
        }
        public void setFid(int id){
            this.fid=id;
        }
        public void setNid(int id){
            this.nid=id;
        }
        public void setPid(int id){
            this.pid=id;
        }
        public void setSid(int id){
            this.sid=id;
        }
        public void setLevel(String l) throws FileNotFoundException, IOException{
            this.level=l;
        }
        public void setDescr(String d){
            this.descr=d;
        }
        public void setRc(int id){
            this.rc=id;
        }
        public void setCat(int cat){
            this.cat=cat;
        }
        public void setMvmble(boolean b){
            this.mvmble=b;
        }
        public void setSaldoa(String val){
            this.saldoa = new BigDecimal(val);
        }
        public void setSaldod(String val){
            this.saldod = new BigDecimal(val);
        }
        public void setPos(int pos){
            this.pos = pos;
        }
        public Conto getConto (int id) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException{            
            if (id>=0)
                return PiCo.pc.getConto(id);
            else
                return null;
        }

        public int lastChild(Conto c) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException{
            if (c.getsid()==0)
                return -1;
            Conto current = this.getConto(c.getsid());
            if (current.id==0)
                return -1;
            Conto lc=current;
            while(current.id!=0){
                lc=current;
                current=this.getConto(current.nid);
            }
            return lc.id;
        }
        public Object getValueOf(String field) throws IllegalArgumentException, IllegalAccessException{
            Field[] f=this.getClass().getDeclaredFields();
            Object result=null;
            for (Field ff: f){
                if (ff.getName().equals(field)){
                    ff.setAccessible(true);
                    result=ff.get(this);
                    break;
                }
            }
            return result;
        }
        public static double round(double value, int places) {
            if (places < 0) throw new IllegalArgumentException();

            BigDecimal bd = BigDecimal.valueOf(value);
            bd = bd.setScale(places, RoundingMode.HALF_UP);
            return bd.doubleValue();
        }

    }
