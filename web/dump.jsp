<%-- 
    Document   : dump
    Created on : 2 lug 2025, 16:46:47
    Author     : piero.trentanove
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParm"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.nio.file.attribute.PosixFilePermission"%>
<%@page import="java.util.Set"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
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
    
//            out.println("<a href=\"menu.jsp\">menu</a><br>");
//            out.println("<a href=\"logout.jsp\">bye</a><br><br>");
            String comando = "";
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
          FileWriter file = new FileWriter(DbParameter.getListab_out(),true);
          BufferedWriter bw = new BufferedWriter(file);
          //out.println(request.getParameter(DbParameter.getAc()));
            if(request.getParameter(DbParameter.getAc())!=null){
                if (request.getParameter(DbParameter.getAc()).compareTo("SI")==0){
                    comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAc()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getAc()+" "+DbParameter.getDb()+"";
                    Runtime.getRuntime().exec(comando);
                    bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAc()+"_"+DbParameter.getDate()+".sql");
                    bw.write("\n");
                    bw.flush();
                    out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAc()+"_"+DbParameter.getDate()+".sql<br>");
                } 
            }
            if(request.getParameter(DbParameter.getAziende())!=null){
          if (request.getParameter(DbParameter.getAziende()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAziende()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getAziende()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAziende()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAziende()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getAzperut())!=null){
          if (request.getParameter(DbParameter.getAzperut()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAzperut()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getAzperut()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAzperut()+"_"+DbParameter.getDate()+".sql");
            bw.newLine();
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getAzperut()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getCaumovc())!=null){
          if (request.getParameter(DbParameter.getCaumovc()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getCaumovc()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getCaumovc()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getCaumovc()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getCaumovc()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getMovc())!=null){
          if (request.getParameter(DbParameter.getMovc()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMovc()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getMovc()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMovc()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMovc()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getMrighe())!=null){
         if (request.getParameter(DbParameter.getMrighe()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMrighe()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getMrighe()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMrighe()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getMrighe()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getOd())!=null){
         if (request.getParameter(DbParameter.getOd()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getOd()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getOd()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getOd()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getOd()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getPc())!=null){
         if (request.getParameter(DbParameter.getPc()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getPc()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getPc()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getPc()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getPc()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getUtenti())!=null){
         if (request.getParameter(DbParameter.getUtenti()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getUtenti()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getUtenti()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getUtenti()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getUtenti()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getVe())!=null){
         if (request.getParameter(DbParameter.getVe()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getVe()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w  -t "+DbParameter.getVe()+" "+DbParameter.getDb()+"";
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getVe()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/"+DbParm.getLavoro()+"_"+DbParameter.getVe()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          if(request.getParameter(DbParameter.getDb())!=null){
         if (request.getParameter(DbParameter.getDb()).compareTo("SI")==0){
            comando=DbParameter.getDump()+" --inserts -f "+DbParameter.getPath()+"/SistemaXDB_"+DbParameter.getDb()+"_"+DbParameter.getDate()+".sql -F plain -U p39 -w "+DbParameter.getDb()+""; //-t "+DbParameter.getDb()+"
            Runtime.getRuntime().exec(comando);
            bw.write(DbParameter.getPath()+"/SistemaXDB_"+DbParameter.getDb()+"_"+DbParameter.getDate()+".sql");
            bw.write("\n");
            bw.flush();
            out.println(DbParameter.getPath()+"/SistemaXDB_"+DbParameter.getDb()+"_"+DbParameter.getDate()+".sql<br>");
          } }
          bw.close();
    }
//        String comando= DbParameter.getPg_dump();
//        String comando_pc= DbParameter.getPg_dump_pc();
//        String comando_movc= DbParameter.getPg_dump_movc();
//        String comando_mrighe= DbParameter.getPg_dump_mrighe();
//        out.println(comando);
//        Runtime.getRuntime().exec(comando);
//        out.println(comando_pc);
//        Runtime.getRuntime().exec(comando_pc);
//        out.println(comando_movc);
//        Runtime.getRuntime().exec(comando_movc);
//        out.println(comando_mrighe);
//        Runtime.getRuntime().exec(comando_mrighe);
//    }
%>
