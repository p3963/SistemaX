/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package include;

import gest.db.DbParameter;
import java.io.IOException;

/**
 *
 * @author piero.trentanove
 */
public class RestoreExec {
    public RestoreExec(){
    }
    
    public static synchronized void re0() throws IOException {
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb0.sh");
    }
    public static synchronized void re1() throws IOException {
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb1.sh");
    }
    public static synchronized void re2() throws IOException {
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb2.sh");
    }
    public static synchronized void re3() throws IOException {
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb3.sh");
    }
    public static synchronized void redb() throws IOException {
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"restore_shell.sh");
    }
}
