<%-- 
    Document   : topdf
    Created on : 22-giu-2013, 17.52.39
    Author     : p39
--%>

<%@page import="org.xhtmlrenderer.resource.FSEntityResolver"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.xhtmlrenderer.pdf.ITextRenderer"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="org.xhtmlrenderer.resource.XMLResource"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.StringReader"%>
<%@page import="java.io.FileOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>To pdf</title>
    </head>
    <body>
        <%
File f = new File("/Users/p39/Desktop/testo.html");
long fs = f.length();
byte [] bf = new byte[(int)fs]; 
FileInputStream fis = new FileInputStream( "/Users/p39/Desktop/testo.html" );
fis.read(bf, 0, (int)fs);
String s = "";
for (int i=0; i<bf.length; i++){
    s+=Byte.toString(bf[i]);
}
out.println(s);
//final DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
//    documentBuilderFactory.setValidating(false);
//    DocumentBuilder builder = documentBuilderFactory.newDocumentBuilder();
//    builder.setEntityResolver(FSEntityResolver.instance());
//    org.w3c.dom.Document document = builder.parse(new ByteArrayInputStream(s.getBytes()));

//ITextRenderer renderer = new ITextRenderer();

// if you have html source in hand, use it to generate document object
//renderer.setDocument(document, null);
//renderer.setDocumentFromString( s );
//renderer.layout();

//String fileNameWithPath = "/Users/p39/Desktop/" + "PDF-FromHtmlString.pdf";
//FileOutputStream fos = new FileOutputStream( fileNameWithPath );
//renderer.createPDF( fos );
//fos.close();
//out.println( "File 2: '" + fileNameWithPath + "' created." );

        %>
    </body>
</html>
