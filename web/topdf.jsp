<%-- 
    Document   : topdf
    Created on : 22-giu-2013, 17.52.39
    Author     : p39
--%>

<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
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
            com.itextpdf.text.Document document =
        new com.itextpdf.text.Document( com.itextpdf.text.PageSize.A4 );
String fileNameWithPath = "/Users/p39/Desktop/" + "PDF-HtmlWorkerParsed.pdf";
FileOutputStream fos = new FileOutputStream( fileNameWithPath );
com.itextpdf.text.pdf.PdfWriter pdfWriter =
        com.itextpdf.text.pdf.PdfWriter.getInstance( document, fos );

document.open();

//**********************************************************
// if required, you can add document meta data
document.addAuthor( "Ravinder" );
//document.addCreator( creator );
document.addSubject( "HtmlWoker Parsed Pdf from iText" );
document.addCreationDate();
document.addTitle( "HtmlWoker Parsed Pdf from iText" );
//**********************************************************/
FileReader f = new FileReader("/Users/p39/Desktop/testo.html");
String s = "";
BufferedReader b;
b=new BufferedReader(f);
while (true){
    String ss = b.readLine();
    if(ss==null)
        break;
    s+=ss;
}
out.println(s);
//com.itextpdf.text.html.simpleparser.HTMLWorker htmlWorker =
//        new com.itextpdf.text.html.simpleparser.HTMLWorker( document );
//htmlWorker.parse( new StringReader( s ) );

//document.close();
//fos.close();

//out.println( "File 3: '" + fileNameWithPath + "' created." );
        %>
    </body>
</html>
