/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gest.db;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author piero.trentanove
 */
public class DbParameter {
    private static String SXR = "/Users/piero.trentanove/SistemaX/restore/";
    private static String listab_out = "/Users/piero.trentanove/SistemaX/lista_backup.txt";
    private static String listab = "ls -1 /Users/piero.trentanove/SistemaX/*.sql > /Users/piero.trentanove/SistemaX/lista_backup.txt";
    private static String path = "/Users/piero.trentanove/SistemaX";
    private static String dump = "/opt/homebrew/Cellar/postgresql@13/13.21/bin/pg_dump";
            //"/opt/homebrew/Cellar/libpq/17.5/bin/pg_dump";
    private static String restore = "/opt/homebrew/Cellar/postgresql@13/13.21/bin/psql";
            //"/opt/homebrew/Cellar/libpq/17.5/bin/psql";
    private static Date date= new Date();
    private static String db = "gest7";
    private static String db1 = "gest";
    private static String user = "p39";
    private static String pass = "p39";
    private static String ac ="ac";
    private static String aziende ="aziende";
    private static String azperut ="azperut";
    private static String caumovc ="caumovc";
    private static String movc ="movc";
    private static String mrighe ="mrighe";
    private static String od ="od";
    private static String pc ="pc";
    private static String utenti ="utenti";
    private static String ve ="ve";
    private static String dropdb = "/opt/homebrew/Cellar/postgresql@13/13.21/bin/dropdb";
    private static String createdb = "/opt/homebrew/Cellar/postgresql@13/13.21/bin/createdb";
    private static String psql_restore="/opt/homebrew/Cellar/postgresql@13/13.21/bin/psql";
    //private static final String lavoro = "SistemaX";;
    
    public DbParameter() {
    }
    
    public static String getUser() {
        return user;
    }

    public static String getPass() {
        return pass;
    }
    public static String getDb() {
        return db;
    }
//    public static String getPg_dump() {
//        return pg_dump;
//    }
    public static String getDate() {
        String pattern = "dd-MM-yyyy_HH-mm-ss";
        DateFormat df = new SimpleDateFormat(pattern);
        Date today = Calendar.getInstance().getTime();
        String todayAsString = df.format(today);
        
        return todayAsString;
    }

//    public static String getPg_dump_pc() {
//        return pg_dump_pc;
//    }

    public static String getDump() {
        return dump;
    }

//    public static String getPg_dump_movc() {
//        return pg_dump_movc;
//    }
//
//    public static String getPg_dump_mrighe() {
//        return pg_dump_mrighe;
//    }

    public static String getMrighe() {
        return mrighe;
    }

    public static String getOd() {
        return od;
    }

    public static String getPc() {
        return pc;
    }

    public static String getUtenti() {
        return utenti;
    }

    public static String getVe() {
        return ve;
    }

    public static String getMovc() {
        return movc;
    }

    public static String getCaumovc() {
        return caumovc;
    }

    public static String getAzperut() {
        return azperut;
    }

    public static String getAziende() {
        return aziende;
    }

    public static String getAc() {
        return ac;
    }

    public static String getPath() {
        return path;
    }

    public static String getRestore() {
        return restore;
    }

    public static String getListab() {
        return listab;
    }

    public static String getListab_out() {
        return listab_out;
    }

    public static String getPsql_restore() {
        return psql_restore;
    }

    public static String getSXR() {
        return SXR;
    }

    public static String getDropdb() {
        return dropdb;
    }

    public static String getCreatedb() {
        return createdb;
    }

//    public static String getLavoro() {
//        return lavoro;
//    }

    public static String getDb1() {
        return db1;
    }

}
