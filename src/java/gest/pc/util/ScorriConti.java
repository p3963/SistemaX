/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc.util;

import gest.pc.Conto;
import gest.pc.PiCo;
import java.io.IOException;
import java.sql.SQLException;
/**
 *
 * @author p39
 */
public class ScorriConti {
    private String db="";
    public ScorriConti(){
    }
    public void fScorriConti(int liv, Conto start) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException{
        liv=0;
        Conto current = new Conto (start,this.db);
        if (current.getId()!=0){
//            
//            String l=current.getlevel();
//            int n=0,idx=0;
//            while((idx=l.indexOf("."))>=0){
//                l = l.substring(idx+1);
//                n++;
//            }
//            Livello l = new Livello(current.getlevel());
//            if (liv>=l.getNlevel())
                PiCo.alConti.ArrPush(current);
        }
        current=current.getConto(current.getsid());
	while(current.getId() != 0){
            this.fScorriConti(liv, current);
            current=current.getConto(current.getnid());
	}
        //return current.getId();
    }

}
