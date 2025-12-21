<%-- 
    Document   : topdf3
    Created on : 22-giu-2013, 21.09.31
    Author     : p39
--%>

<%@page import="org.xhtmlrenderer.pdf.ITextRenderer"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String inputFile = "/Users/p39/Desktop/firstdoc.xhtml";
        String url = new File(inputFile).toURI().toURL().toString();
        String outputFile = "/Users/p39/Desktop/firstdoc.pdf";
        OutputStream os = new FileOutputStream(outputFile);
        
        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocument(url);
        renderer.layout();
        renderer.createPDF(os);
        
        os.close();

            %>
    </body>
</html>
