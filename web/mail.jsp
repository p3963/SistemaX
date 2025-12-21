<%-- 
    Document   : mail
    Created on : 22 gen 2025, 11:31:13
    Author     : ptren
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="invioemail.EmailSender"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mittente = "piero-39@hotmail.com";
    //String mittente = "piero-39@libero.it";
    mittente=request.getParameter("mittente");
    String destinatario = request.getParameter("destinatario");
    String cc = request.getParameter("cc");
    String bcc = request.getParameter("bcc");
    String oggetto = request.getParameter("oggetto");
    String contenuto = request.getParameter("contenuto");
    Enumeration e = request.getParameterNames();
    Collection<Part> ps = request.getParts();
    Iterator i = ps.iterator();
    int k = 0;
    ArrayList<String> filenames = new ArrayList<String>();
    while(i.hasNext()){
        out.println(k);
        Part p=(Part)(i.next());
        if(p.getSubmittedFileName()==null)
            continue;
//        out.println(p.toString()+"<br>");
//        out.println(p.getContentType()+"<br>");
//        out.println(p.getInputStream().toString()+"<br>");
//        out.println(p.getName()+"<br>");
//        out.println(p.getSubmittedFileName()+"<br>");
        filenames.add("/opt/temp/"+p.getSubmittedFileName());
        //p.write(p.getSubmittedFileName());
        
    try{    
        InputStream is = p.getInputStream();
        File file = new File("/opt/temp/"+p.getSubmittedFileName());
//        FileWriter fw = new FileWriter(file);
//        BufferedWriter bw = new BufferedWriter(fw);
        OutputStream outst = new FileOutputStream(file);
        outst.write(is.readAllBytes());
        outst.flush();
        outst.close();
//        fw.close();
//        bw.close();
        
//        bw..write(str);
//        f.write(is.toString());
//        f.close();
    }catch(Exception ex){
        out.println(ex);
    }
        k++;
    }
    
    out.println(mittente+"<br>");
    out.println(destinatario+"<br>");
    out.println(cc+"<br>");
    out.println(bcc+"<br>");
    out.println(oggetto+"<br>");
    out.println(contenuto+"<br>");
    while (e.hasMoreElements()){
        String en =(String)(e.nextElement());
        out.println(en+"<br>");
    }
    
    EmailSender es = new EmailSender(mittente,destinatario,cc,bcc,oggetto,contenuto,filenames);
    es.inviaEmail();
    
%>
