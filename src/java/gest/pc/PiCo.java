/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc;
import gest.db.SistemaXDbPc;
import gest.pc.util.Arr;
import gest.pc.util.ScorriConti;
import java.io.IOException;
import java.sql.SQLException;
/**
 *
 * @author piero
 */
public class PiCo {
    private Conto testa=null;
    public static SistemaXDbPc pc = null;
    private String db="";
    public Conto [] aConti=null;
    public static Arr alConti=null;
     public boolean isEmpty(){
        if (this.testa==null)
            return true;
        return false;
    }
    public PiCo (String db) throws Exception, NoSuchFieldException, IllegalArgumentException, IllegalAccessException, ClassNotFoundException{
        this.testa = new Conto(this.db);
        this.db=db;
        pc = new SistemaXDbPc(this.db);
        alConti = new Arr();
    }
    public Conto getTesta(){
        return this.testa;
    }
    public SistemaXDbPc getPc(){
        return pc;
    }
    public void scorriConti(int liv, Conto start) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException {
        ScorriConti sc = new ScorriConti();
        sc.fScorriConti(0, start);//%%%%%%%%%%%%%% liv %%%%%%%%%%%%%
    }
    /**
 * escape()
 *
 * Escape a give String to make it safe to be printed or stored.
 *
 * @param s The input String.
 * @return The output String.
 **/
    public static String escape(String s){
        return s.replace("\\", "\\\\")
          .replace("\t", "\\t")
          .replace("\b", "\\b")
          .replace("\n", "\\n")
          .replace("\r", "\\r")
          .replace("\f", "\\f")
          .replace("\'", "\\'")
          .replace("\"", "\\\"");
    }

}