package gest.pc.util;

import gest.db.DbParameter;
import gest.pc.Conto;
import gest.pc.PiCo;
import java.io.IOException;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author p39
 */
public class DisLivello {
    public void DisLivello(){}
    public static int DisLivello(int j, int k, JSONArray a) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, SQLException, ClassNotFoundException, IOException, Exception{
        int i=0;
        String sl="";
        for(i=k; i<a.length(); i++){
            Conto ii = new Conto (DbParameter.getDb());
            ii=PiCo.pc.getConto(a.getInt(i));
            if (ii.getId()==1)
                sl = "1";
            else if (ii.getId()==2)
                sl = "2";
            else if (ii.getId()==3)
                sl = "3";
            else if (ii.getId()==4)
                sl = "4";
            else if (ii.getId()==5)
                sl = "5";
            else if (ii.getId()==6)
                sl = "6";
            else{
                Livello l = new Livello ("");
                Conto jj=PiCo.pc.getConto(a.getInt(i-1));
                sl=jj.getlevel();
                if(jj.hasSon())
                    sl=sl+".1";
                else if(jj.hasNext())
                    sl=l.compLivello(1,sl);
                else
                    ;
            }
            ii.setLevel(sl);
            ii.setPos(i+j-1);
            PiCo.pc.update(ii);
        }
        return i;
    }
}
