/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gest.pc.util;

import gest.pc.Conto;
import java.util.ArrayList;

/**
 *
 * @author p39
 */
public class Arr {
    public ArrayList al=null;
    public Arr(){
        this.al= new ArrayList();
    }
    public void ArrPush(Object o){
        al.add(o);
    }
    public Object[] getArr(Conto[] ac){
        return al.toArray(ac);
    }
    public int getSize(){
        return al.size();
    }
}
