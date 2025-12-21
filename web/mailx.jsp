<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
    <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
    <script src="./tinymce/js/tinymce/tinymce.min.js"></script>
<script>
function validateEmail(email) {
    var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return re.test(email);
}
function emailIsValid(email) {
  var regex_email_valida = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return regex_email_valida.test(email);
}
function mailvalidation(emailList){
    var emails = emailList.replace(/\s/g,'').split(",");
    var valid = true;
    var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    for (var i = 0; i < emails.length; i++) {
        if( emails[i] === "" || ! regex.test(emails[i])){
            valid = false;
        }
    }
    return valid;
}
function mailvalidation1(emailList){
    var emails1 = emailList.replace(/\s/g,'').split(",");
    var valid1 = true;
    var regex1 = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    for (var i = 0; i < emails1.length; i++) {
        if( ! regex1.test(emails1[i])){//emails[i] === "" || 
            valid1 = false;
        }
    }
    return valid1;
}
$(document).ready(function(){
    $("#mail").on("submit",function(event){
        //$("#contenuto").val(htmlentities($("#contenuto").val()));
        //alert ($("#contenuto").val());
        var s="";
        if(!mailvalidation($("#mittente").val()))
            s+="Indizzo mittente non valido\n";
        //if(!emailIsValid($("#destinatario").val()))
        if(!mailvalidation($("#destinatario").val()))
            s+="Indizzo destinatario non valido\n";
        if ($("#cc").val()==="")
            ;
        else if(!mailvalidation1($("#cc").val()))
            s+="Indizzo cc non valido\n";
        if ($("#bcc").val()==="")
            ;
        else if(!mailvalidation1($("#bcc").val()))
            s+="Indizzo bcc non valido\n";
	if(s!==""){
            event.preventDefault();
            alert(s);
	}
    });
});
function htmlentities(rawStr){
    var encodedStr = rawStr.replace(/[\u00A0-\u9999<>\&]/g, function(i) {
        return '&#'+i.charCodeAt(0)+';';
    });
    return encodedStr;
}
</script>
<script>
  tinymce.init({
    selector: '#contenuto',//inserttemplate addtemplate | 
    license_key: 'gpl',
	plugins: 'export anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage advtemplate ai mentions tinycomments tableofcontents footnotes mergetags autocorrect typography inlinecss markdown code',// save 
    toolbar: 'undo redo | code export | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
    tinycomments_mode: 'embedded',
    tinycomments_author: 'Author name',
    mergetags_list: [
      { value: 'First.Name', title: 'First Name' },
      { value: 'Email', title: 'Email' },
    ],
	ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),
    //ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),
});
</script>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
out.println("<form id=\"mail\" action=\"mail.jsp\" method=\"post\" enctype=\"multipart/form-data\">");//

out.println("<table cellspacing=\"5\" border=\"0\">");
    out.println("<tr>");
    out.println("<td align=\"right\">Indirizzo Mittente:</td>");
    out.println("<td><input required id=\"mittente\" type=\"text\" name=\"mittente\" /></td>");
    out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Indirizzo Destinatario:</td>");
out.println("<td><input required id=\"destinatario\" type=\"text\" name=\"destinatario\" /></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Indirizzo CC:</td>");
out.println("<td><input id=\"cc\" type=\"text\" name=\"cc\" /></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Indirizzo BCC:</td>");
out.println("<td><input id=\"bcc\" type=\"text\" name=\"bcc\" /></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Oggetto:</td>");
out.println("<td><input required id=\"oggetto\" type=\"text\" name=\"oggetto\" /></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Allegati:</td>");
out.println("<td><input multiple id=\"alle\" type=\"file\" name=\"alle\" /></td>");//
out.println("</tr>");
out.println("<tr>");
out.println("<td align=\"right\">Testo:</td>");
//out.println("<td><div contenteditable=\"true\" id=\"contenuto\" name=\"contenuto\"></div></td>");
out.println("<td><textarea id=\"contenuto\" name=\"contenuto\"></textarea></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td></td>");
out.println("<td><input type=\"submit\" value=\"Invia\" /></td>");
out.println("</tr>");
out.println("</table>");
out.println("</form>");
          %>
</body>
</html>
</html>
