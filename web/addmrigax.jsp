<%-- 
    Document   : addmrigax
    Created on : 26 nov 2024, 14:02:53
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileWriter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sa = request.getSession();
    String username = (String) sa.getAttribute("username");
    User usera = new User();
    if (sa.getId().compareTo(usera.getSessionId(username)) != 0) {
        response.sendRedirect("index.jsp");
    } else {
        int idmovc = Integer.parseInt(request.getParameter("idmovc"));
        String descr = request.getParameter("descr");
        String da = request.getParameter("da").toString();//Boolean.getBoolean(
        int riga = Integer.parseInt(request.getParameter("riga"));
        int pcid = Integer.parseInt(request.getParameter("pcid"));
        String imp = request.getParameter("imp");
        SistemaXDbMriga mr = new SistemaXDbMriga(DbParameter.getDb());
        String sql = "insert into mrighe (idmovc, descr, da, riga, pcid, imp) values ('"+idmovc+"', '"+descr+"', '"+da+"', '"+riga+"', '"+pcid+"', '"+imp+"');";
        if (pcid == 0){
//            out.println("Conto non valido");
        %>
            <script>
                alert ("Conto non valorizzato!");
            </script>
        <%
        }else{
            int k=mr.uquery(sql);
        }
//        
//        try {
//            FileWriter myWriter = new FileWriter("addmrigax.txt");
//            myWriter.write(sql+" |mr:"+k);
//            myWriter.close();
//            System.out.println("Successfully wrote to the file.");
//        } catch (IOException e) {
//            System.out.println("An error occurred.");
//            e.printStackTrace();
//        }
    }
%>