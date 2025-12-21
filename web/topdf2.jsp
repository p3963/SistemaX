<%-- 
    Document   : topdf2
    Created on : 22-giu-2013, 18.51.17
    Author     : p39
--%>

<%@page import="org.xhtmlrenderer.pdf.ToPDF"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.FileOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>To pdf 2</title>
    </head>
    <body>
        <%
            ToPDF.createPDF("/Users/p39/Desktop/testo1.html", "/Users/p39/Desktop/testo1.pdf");
/*FileReader f = new FileReader("/Users/p39/Desktop/testo.html");
String s = "";
BufferedReader b;
b=new BufferedReader(f);
while (true){
    String ss = b.readLine();
    if(ss==null)
        break;
    s+=ss;
}
            ITextRenderer renderer = new ITextRenderer();
*/
// if you have html source in hand, use it to generate document object
/*renderer.setDocumentFromString( s.toString() );
renderer.layout();

String fileNameWithPath = "/Users/p39/Desktop/" + "PDF-FromHtmlString.pdf";
FileOutputStream fos = new FileOutputStream( fileNameWithPath );
renderer.createPDF( fos );
fos.close();

out.println( "File 2: '" + fileNameWithPath + "' created." );
*/
        %>
    </body>
</html>
