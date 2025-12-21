/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gest.pc.util;

import gest.db.DbParameter;
import gest.pc.Conto;
import gest.pc.PiCo;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author p39
 */
public class Wtd{
    Conto m;
    int n =0;
    FileWriter f=null;
    
    public Wtd() throws IOException{
    FileWriter f = new FileWriter("/home/p39/Documenti/newconto1.txt", true);
        
    }
    public int Wtd (int id) throws Exception{
    f.write(String.valueOf(id)+"\n");
        this.m=new Conto (DbParameter.getDb());
        this.m=PiCo.pc.getConto(m.getsid());
        while(m.getId()>=0){
            Wtd wtd = new Wtd ();
            wtd.Wtd(m.getId());
            m=PiCo.pc.getConto(m.getnid());
        }
        f.flush();
        f.close();
        return this.m.getId();
    }
    
}
