/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc.util;

/**
 *
 * @author piero
 */
public class Livello {
    private String livello=null;
    private int nlevel=0;
    public Livello (String l){
        this.livello=l;
        if (this.livello.equals(null))
            this.livello="0";
        String s = this.livello;
        this.nlevel=0;
        while(s.length()>0){
            this.nlevel+=1;
            if (s.indexOf(".")>0)
                s=s.substring(0, s.indexOf("."));
            else
                s="";
        }
    }
    public String getLivello(){
        return this.livello;
    }
    public String[] splitLivello(String l){
        return l.split(".");
    }
    public String compLivello(int liv, String l) throws Exception{
        String lx="";
        if(l.lastIndexOf(".")>0)
            lx=l.substring(l.lastIndexOf(".")+1);
        else
            lx=l;
        int i = (int)Integer.parseInt(lx)+liv;
        lx=String.valueOf(i);
        if(l.lastIndexOf(".")>0)
            this.livello=l.substring(0,l.lastIndexOf("."))+"."+lx;
        else
            this.livello=lx;
        return this.livello;
    }

    public int getNlevel() {
        return nlevel;
    }

    public void setNlevel(int nlevel) {
        this.nlevel = nlevel;
    }
}
