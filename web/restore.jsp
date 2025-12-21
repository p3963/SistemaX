<%-- 
    Document   : restore
    Created on : 7 lug 2025, 11:09:12
    Author     : piero.trentanove
--%>

<%@page import="include.RestoreExec"%>
<%@page import="include.Menu"%>
<%@page import="gest.db.DbParm"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.attribute.PosixFilePermission"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.db.DbParameter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
</head>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
    
            out.println("<body>");
            out.println(Menu.getMenu());
//        out.println("<nav class=\"navbar\">");
//        out.println("<input type=\"checkbox\" id=\"menu-toggle\">");
//        out.println("<label for=\"menu-toggle\" class=\"hamburger\">☰</label>");
//        out.println("<ul class=\"menu\">");
//            out.println("<li><a href=\"menu.jsp\">Home</a></li>");
//            out.println("<li><a href=\"saldi.jsp\">Caricamento saldi</a></li>");
//            out.println("<li><a href=\"mostraconti.jsp\">Elenco conti</a></li>");
//            out.println("<li><a href=\"movimento.jsp\">Movimenti contabili</a></li>");
//            out.println("<li><a href=\"retrimov.jsp\">Ricerca movimenti</a></li>");
//            out.println("<li><a href=\"mastrino.jsp\">Mastrino</a></li>");
//            out.println("<li><a href=\"bilancio.jsp\">Movimenti-Bilancio</a></li>");
//            out.println("<li><a href=\"dump_dt.jsp\">Backup</a></li>");
//            out.println("<li><a href=\"restore_dt.jsp\">Restore</a></li>");
//            out.println("<li><a href=\"logout.jsp\">Bye</a></li>");
//        out.println("</ul>");
//        out.println("</nav>");
    out.println("</body><br><br>");
    if (request.getParameter("res")==null)
        ;
        else{
    
//        out.println("<a href=\"restore_dt.jsp\">restore</a><br>");
//        out.println("<a href=\"menu.jsp\">menu</a><br>");
//        out.println("<a href=\"logout.jsp\">bye</a><br><br>");
            String directory = DbParameter.getPath();
            File dir = new File(directory);
            if(!dir.exists()){
                dir.mkdir();
                Path file = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions = new HashSet<>();
                permissions.add(PosixFilePermission.OWNER_READ);
                permissions.add(PosixFilePermission.OWNER_WRITE);
                permissions.add(PosixFilePermission.GROUP_READ);
                permissions.add(PosixFilePermission.GROUP_WRITE);
                permissions.add(PosixFilePermission.OTHERS_READ);
                permissions.add(PosixFilePermission.OTHERS_WRITE);
                permissions.add(PosixFilePermission.OWNER_EXECUTE);
                permissions.add(PosixFilePermission.GROUP_EXECUTE);
                permissions.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file, permissions);
            }
           
            directory = DbParameter.getSXR();
            File dirr = new File(directory);
            if(!dirr.exists()){
                dirr.mkdir();
                Path file = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions = new HashSet<>();
                permissions.add(PosixFilePermission.OWNER_READ);
                permissions.add(PosixFilePermission.OWNER_WRITE);
                permissions.add(PosixFilePermission.GROUP_READ);
                permissions.add(PosixFilePermission.GROUP_WRITE);
                permissions.add(PosixFilePermission.OTHERS_READ);
                permissions.add(PosixFilePermission.OTHERS_WRITE);
                permissions.add(PosixFilePermission.OWNER_EXECUTE);
                permissions.add(PosixFilePermission.GROUP_EXECUTE);
                permissions.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file, permissions);
                
            }
//FASE 0
        String restore= request.getParameter("res");
        String comando="";
        out.println("File di bakup scelto: <br><b>"+restore+"</b><br><br><br>");
        String tabella=restore;
        String tab="";
        String database="";
        if(tabella.contains(DbParameter.getDb1())){
                BufferedWriter rest = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"resdb.sh"));
                
                BufferedWriter rest0 = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"resdb0.sh"));
                String restart="brew services restart postgresql@13";
                out.println("Riavvio del server postgres: <br><b>"+restart+"</b><br><br>");
                rest0.write(restart);
                rest0.newLine();
                rest0.flush();
                rest0.close();
                
            directory = DbParameter.getSXR()+"resdb0.sh";
            File re0 = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path file0 = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions0 = new HashSet<>();
                permissions0.add(PosixFilePermission.OWNER_READ);
                permissions0.add(PosixFilePermission.OWNER_WRITE);
                permissions0.add(PosixFilePermission.GROUP_READ);
                permissions0.add(PosixFilePermission.GROUP_WRITE);
                permissions0.add(PosixFilePermission.OTHERS_READ);
                permissions0.add(PosixFilePermission.OTHERS_WRITE);
                permissions0.add(PosixFilePermission.OWNER_EXECUTE);
                permissions0.add(PosixFilePermission.GROUP_EXECUTE);
                permissions0.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file0, permissions0);
                
//            }

            
                rest.write(restart);
                rest.newLine();
                rest.flush();
                //rest.close();
                
                //database = DbParameter.getDb();
//PRIMA FASE
                BufferedWriter rest1 = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"resdb1.sh"));
                String dropdb=DbParameter.getDropdb()+" -U postgres -w -f --if-exists "+DbParameter.getDb();
                out.println("Comando di drop database: <br><b>"+dropdb+"</b><br><br>");
                rest1.write(dropdb);
                rest1.newLine();
                rest1.flush();
                rest1.close();
                
            directory = DbParameter.getSXR()+"resdb1.sh";
            File re1 = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path file1 = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions1 = new HashSet<>();
                permissions1.add(PosixFilePermission.OWNER_READ);
                permissions1.add(PosixFilePermission.OWNER_WRITE);
                permissions1.add(PosixFilePermission.GROUP_READ);
                permissions1.add(PosixFilePermission.GROUP_WRITE);
                permissions1.add(PosixFilePermission.OTHERS_READ);
                permissions1.add(PosixFilePermission.OTHERS_WRITE);
                permissions1.add(PosixFilePermission.OWNER_EXECUTE);
                permissions1.add(PosixFilePermission.GROUP_EXECUTE);
                permissions1.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file1, permissions1);
                
//            }
                
                out.println("<br>");

                rest.write(dropdb);
                rest.newLine();
                rest.flush();
                //rest.close();


//SECONDA FASE            
                BufferedWriter rest2 = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"resdb2.sh"));
                String createdb =DbParameter.getCreatedb()+" -U postgres -w -O p39 -T template1 -E 'UTF8' --lc-collate='C' --lc-ctype='C' -D pg_default "+DbParameter.getDb();
                out.println("Comando di creazione del database: <br><b>"+createdb+"</b><br><br>");
                rest2.write(createdb);
                rest2.newLine();
                rest2.flush();
                rest2.close();
                
            directory = DbParameter.getSXR()+"resdb2.sh";
            File re2 = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path file2 = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions2 = new HashSet<>();
                permissions2.add(PosixFilePermission.OWNER_READ);
                permissions2.add(PosixFilePermission.OWNER_WRITE);
                permissions2.add(PosixFilePermission.GROUP_READ);
                permissions2.add(PosixFilePermission.GROUP_WRITE);
                permissions2.add(PosixFilePermission.OTHERS_READ);
                permissions2.add(PosixFilePermission.OTHERS_WRITE);
                permissions2.add(PosixFilePermission.OWNER_EXECUTE);
                permissions2.add(PosixFilePermission.GROUP_EXECUTE);
                permissions2.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file2, permissions2);
                
//            }

                out.println("<br>");
                
                rest.write(createdb);
                rest.newLine();
                rest.flush();
                //rest.close();

//TERZA FASE
                BufferedWriter rest3 = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"resdb3.sh"));
                String dbase=DbParameter.getRestore()+" -U p39 -w -d "+DbParameter.getDb()+"  < "+tabella+""; 
                comando = dbase;
                out.println("Script di restore database: <br><b>"+comando+"</b><br><br>");
                rest3.write(comando);
                rest3.newLine();
                rest3.flush();
                rest3.close();
                
            directory = DbParameter.getSXR()+"resdb3.sh";
            File re3 = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path file3 = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions3 = new HashSet<>();
                permissions3.add(PosixFilePermission.OWNER_READ);
                permissions3.add(PosixFilePermission.OWNER_WRITE);
                permissions3.add(PosixFilePermission.GROUP_READ);
                permissions3.add(PosixFilePermission.GROUP_WRITE);
                permissions3.add(PosixFilePermission.OTHERS_READ);
                permissions3.add(PosixFilePermission.OTHERS_WRITE);
                permissions3.add(PosixFilePermission.OWNER_EXECUTE);
                permissions3.add(PosixFilePermission.GROUP_EXECUTE);
                permissions3.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file3, permissions3);
                
//            }

                
                rest.write(comando);
                rest.newLine();
                rest.flush();
                
                rest.close();
            directory = DbParameter.getSXR()+"resdb.sh";
            File resdb = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path file = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions = new HashSet<>();
                permissions.add(PosixFilePermission.OWNER_READ);
                permissions.add(PosixFilePermission.OWNER_WRITE);
                permissions.add(PosixFilePermission.GROUP_READ);
                permissions.add(PosixFilePermission.GROUP_WRITE);
                permissions.add(PosixFilePermission.OTHERS_READ);
                permissions.add(PosixFilePermission.OTHERS_WRITE);
                permissions.add(PosixFilePermission.OWNER_EXECUTE);
                permissions.add(PosixFilePermission.GROUP_EXECUTE);
                permissions.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file, permissions);
                
//            }
                
                out.println("<br>");
                BufferedWriter restoreshell = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"restore_shell.sh"));
//                restoreshell.write("sh "+DbParameter.getSXR()+"resdb0.sh");
//                restoreshell.newLine();
//                restoreshell.flush();
//                restoreshell.write("sleep 4");
//                restoreshell.newLine();
//                restoreshell.flush();
                restoreshell.write("sh "+DbParameter.getSXR()+"resdb1.sh");
                restoreshell.newLine();
                restoreshell.flush();
                restoreshell.write("sleep 4");
                restoreshell.newLine();
                restoreshell.flush();
                restoreshell.write("sh "+DbParameter.getSXR()+"resdb2.sh");
                restoreshell.newLine();
                restoreshell.flush();
                restoreshell.write("sleep 4");
                restoreshell.newLine();
                restoreshell.flush();
                restoreshell.write("sh "+DbParameter.getSXR()+"resdb3.sh");
                restoreshell.newLine();
                restoreshell.flush();
                //Runtime.getRuntime().exec("sh resdb3.sh");
                //restoreshell.write("sh "+DbParameter.getSXR()+"resdb3.sh");
                //restoreshell.newLine();
                //restoreshell.write("sleep 4");
                //restoreshell.flush();
                restoreshell.close();
            directory = DbParameter.getSXR()+"restore_shell.sh";
            File restore_shell = new File(directory);
//            if(!dirr.exists()){
//                dirr.mkdir();
                Path filers = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissionsrs = new HashSet<>();
                permissionsrs.add(PosixFilePermission.OWNER_READ);
                permissionsrs.add(PosixFilePermission.OWNER_WRITE);
                permissionsrs.add(PosixFilePermission.GROUP_READ);
                permissionsrs.add(PosixFilePermission.GROUP_WRITE);
                permissionsrs.add(PosixFilePermission.OTHERS_READ);
                permissionsrs.add(PosixFilePermission.OTHERS_WRITE);
                permissionsrs.add(PosixFilePermission.OWNER_EXECUTE);
                permissionsrs.add(PosixFilePermission.GROUP_EXECUTE);
                permissionsrs.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(filers, permissionsrs);
                
//            }
                
//                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb0.sh");
//                Runtime.getRuntime().exec("sleep 4");
//                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb1.sh");
//                Runtime.getRuntime().exec("sleep 4");
//                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb2.sh");
//                Runtime.getRuntime().exec("sleep 4");
//                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"resdb3.sh");
//                RestoreExec.re0();
//                RestoreExec.re1();
//                RestoreExec.re2();
//                RestoreExec.re3();
                //RestoreExec.redb();
                Runtime.getRuntime().exec("sh "+DbParameter.getSXR()+"restore_shell.sh");

                String ccc="sh "+DbParameter.getSXR()+"restore_shell.sh";// > "+DbParameter.getSXR()+"shellres_outdb.txt";
                out.println("<p>Restore database <b>(automatico)</b>: <br><b>"+ccc+"</b><br><br></p>");                
        }else{
//TABELLE        
            if(tabella.contains(DbParameter.getAc())){
                tab = DbParameter.getAc();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getAziende())){
                tab = DbParameter.getAziende();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getAzperut())){
                tab = DbParameter.getAzperut();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getCaumovc())){
                tab = DbParameter.getCaumovc();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getMovc())){
                tab = DbParameter.getMovc();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getMrighe())){
                tab = DbParameter.getMrighe();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getOd())){
                tab = DbParameter.getOd();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getPc())){
                tab = DbParameter.getPc();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getUtenti())){
                tab = DbParameter.getUtenti();
                comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }else
            if(tabella.contains(DbParameter.getVe())){
                tab = DbParameter.getVe();
             comando =DbParameter.getPsql_restore()+" -U p39 -w -d "+DbParameter.getDb()+" -c 'drop table if exists "+DbParameter.getDb()+".public."+tab+";' -f "+tabella+" > "+DbParameter.getSXR()+DbParm.getLavoro()+"_restore_"+tab+"_"+DbParameter.getDate()+".txt";
            }
            try{                
                out.println("Script di restore tabella: <br><b>"+comando+"</b>");
                BufferedWriter buff = new BufferedWriter(new FileWriter(DbParameter.getSXR()+"shellres.sh"));
                buff.write(comando);
                buff.flush();
                buff.close();
            directory = DbParameter.getSXR()+"shellres.sh";
            File tabe = new File(directory);
            if(!dirr.exists()){
                dirr.mkdir();
                Path file = Path.of(directory); // Sostituisci con il percorso del tuo file
                Set<PosixFilePermission> permissions = new HashSet<>();
                permissions.add(PosixFilePermission.OWNER_READ);
                permissions.add(PosixFilePermission.OWNER_WRITE);
                permissions.add(PosixFilePermission.GROUP_READ);
                permissions.add(PosixFilePermission.GROUP_WRITE);
                permissions.add(PosixFilePermission.OTHERS_READ);
                permissions.add(PosixFilePermission.OTHERS_WRITE);
                permissions.add(PosixFilePermission.OWNER_EXECUTE);
                permissions.add(PosixFilePermission.GROUP_EXECUTE);
                permissions.add(PosixFilePermission.OTHERS_EXECUTE);

                Files.setPosixFilePermissions(file, permissions);
                
            }
                out.println("<br>");
                String c="sh "+DbParameter.getSXR()+"shellres.sh > "+DbParameter.getSXR()+"shellres_out.txt";
                out.println("<br><br>Comando di restore tabella (automatico): <br><b>"+c+"</b>");
                Runtime.getRuntime().exec(c);
            }catch(Exception e){
                out.println(e);
            }
        }
    }
    }
%>