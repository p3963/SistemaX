<%-- 
    Document   : dump_dt
    Created on : 3 lug 2025, 13:27:39
    Author     : piero.trentanove
--%>

<%@page import="include.Menu"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.attribute.PosixFilePermission"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDb"%>
<%@page import="gest.pc.util.User"%>
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
    
            DbParameter DBP= new DbParameter();
    
//            out.println("<a href=\"menu.jsp\">menu</a><br>");
//            out.println("<a href=\"logout.jsp\">bye</a><br><br>");
            
            
            //FileReader f = new FileReader("/Users/piero.trentanove/SistemaX/lista_backup.txt");
            FileReader file = new FileReader(DbParameter.getListab_out());
//                Path filer = Path.of(DbParameter.getListab_out()); // Sostituisci con il percorso del tuo file
//                Set<PosixFilePermission> permissions = new HashSet<>();
//                permissions.add(PosixFilePermission.OWNER_READ);
//                permissions.add(PosixFilePermission.OWNER_WRITE);
//                permissions.add(PosixFilePermission.GROUP_READ);
//                permissions.add(PosixFilePermission.GROUP_WRITE);
//                permissions.add(PosixFilePermission.OTHERS_READ);
//                permissions.add(PosixFilePermission.OTHERS_WRITE);
//                permissions.add(PosixFilePermission.OWNER_EXECUTE);
//                permissions.add(PosixFilePermission.GROUP_EXECUTE);
//                permissions.add(PosixFilePermission.OTHERS_EXECUTE);
//
//                Files.setPosixFilePermissions(filer, permissions);
                
            BufferedReader in = new BufferedReader(file);
            String ab="";
            ArrayList ord=new ArrayList();
            while (( ab=in.readLine())!=null){
                ord.add(ab);
            }
            ord.sort(null);
            //out.println(in);
            String bk="kkkk";
//            for(int i =0; i< ord.size(); i++){
//                bk = (String)ord.get(i);
//            }
            out.println("<form id=\"restore\" action=\"restore.jsp\" method=\"post\">");
            //in.reset();
            
//            out.println("<select id=\"sr\" name=\"sr\">");
            out.println("<option value=\"\" type=\"radio\"></option>");
            for(int i =0; i< ord.size(); i++){
                bk = (String)ord.get(i);
                out.println("<hr>");
                    if (bk.contains(DbParameter.getDb1())) {//
                    
                            out.println("<b>Restore database "+DbParameter.getDb()+"</b>");
                            out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\"><b>"+bk+"</b>");
                    }else
                if (bk.contains(DbParameter.getAc())) {
                        
                        out.println("Restore tabella "+DbParameter.getAc());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getAziende())) {
                        
                        out.println("Restore tabella "+DbParameter.getAziende());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getAzperut())) {
                        
                        out.println("Restore tabella "+DbParameter.getAzperut());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getCaumovc())) {
                        
                        out.println("Restore tabella "+DbParameter.getCaumovc());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getMovc())) {
                        
                        out.println("Restore tabella "+DbParameter.getMovc());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getMrighe())) {
                        
                        out.println("Restore tabella "+DbParameter.getMrighe());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getOd())) {
                        
                        out.println("Restore tabella "+DbParameter.getOd());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                if (bk.contains(DbParameter.getPc())) {
                        
                        out.println("Restore tabella "+DbParameter.getPc());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                
                if (bk.contains(DbParameter.getUtenti())) {
                        
                        out.println("Restore tabella "+DbParameter.getUtenti());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                
                if (bk.contains(DbParameter.getVe())) {
                        
                        out.println("Restore tabella "+DbParameter.getVe());
                        out.println("<input name=\"res\" value=\""+bk+"\" type=\"radio\">"+bk);
                }else
                    continue;
            }
                out.println("<hr>");
//            out.println("</select>");
            out.println("<br><br><button type=\"submit\">Invia</button>");
            out.println("</form");
            //file.close();
            in.close();


    }    
%>