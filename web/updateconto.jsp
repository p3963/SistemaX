<%-- 
    Document   : updateconto
    Created on : 14 nov 2021, 10:15:08
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

        Conto c = new Conto(DbParameter.getDb());
        int id = Integer.parseInt(request.getParameter("id"));
        c=PiCo.pc.getConto(id);
//    int nid = Integer.parseInt(request.getParameter("nid"));
//    int sid = Integer.parseInt(request.getParameter("sid"));
//    int pos = Integer.parseInt(request.getParameter("pos"));
        String descr = request.getParameter("descr");
//    String livello = request.getParameter("livello");
//        String saldod = request.getParameter("saldod");
//        String saldoa = request.getParameter("saldoa");
        String movble = request.getParameter("mvmble");
//    FileWriter f = new FileWriter("/home/p39/Documenti/upconto.txt",false);
//    f.write(movble);
//    f.flush();
    boolean mvmble = false;
    if (movble.compareTo("vero")==0)
        mvmble = true;
//    f.write(String.valueOf(mvmble));
//    f.flush();
//    f.close();
        c.setId(id);
        c.setNid(c.getnid());
        c.setSid(c.getsid());
        c.setFid(c.getfid());
        c.setPid(c.getpid());
        c.setPos(c.getPos());
        c.setRc(0);
        c.setCat(c.getCat());
//    c.setNid(nid);
//    c.setSid(sid);
//    c.setPos(pos);
        c.setDescr(descr);
        c.setLevel(c.getlevel());
//    c.setLevel(livello);
        c.setSaldod(c.getSaldod().toString());
        c.setSaldoa(c.getSaldoa().toString());
        c.setMvmble(mvmble);
        PiCo.pc.update(c);
    }
%>
<script>
</script>