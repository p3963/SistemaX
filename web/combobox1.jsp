<%-- 
    Document   : combobox
    Created on : 12 ago 2025, 15:06:17
    Author     : piero.trentanove
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.db.DbParameter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<meta charset="UTF-8">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="css/cbbox.css">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/cbbox.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        PiCo p = new PiCo(DbParameter.getDb());
        p.scorriConti(4, PiCo.pc.getConto(1));
        int j = p.alConti.getSize();
        p.aConti = new Conto[j];
        p.alConti.getArr(p.aConti);
        PiCo q = new PiCo(DbParameter.getDb());
        q.scorriConti(4, PiCo.pc.getConto(2));
        int k = q.alConti.getSize();
        q.aConti = new Conto[k];
        q.alConti.getArr(q.aConti);
        int[] x = new int[j+k];
        String[] descriz = new String[j+k];
        SistemaXDbPc sistpc = new SistemaXDbPc(DbParameter.getDb());
        for (int i=0; i<j; i++){
            x[i] = PiCo.pc.getConto(p.aConti[i].getId()).getId();
//            if(x[i]==0 || x[i]==1 || x[i]==2 || x[i]==99999999 || x[i]==999999999)
//                continue;
//            else{
                String sql = "select id, descr from public.pc where id = "+x[i]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i] = rspc.getString("descr");
//            }
        }
        for (int i=0; i<k; i++){
            x[i+j] = PiCo.pc.getConto(q.aConti[i].getId()).getId();
//            if(x[i]==0 || x[i]==1 || x[i]==2 || x[i]==99999999 || x[i]==999999999)
//                continue;
//            else{
                String sql = "select id, descr from public.pc where id = "+x[i]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j] = rspc.getString("descr");
//            }
        }
            %>
<label for="cb1-input">Conto</label>
<div class="combobox combobox-list">
  <div class="group">
    <input id="cb1-input" class="cb_edit" type="text" role="combobox" aria-autocomplete="list" aria-expanded="false" aria-controls="cb1-listbox">
    <button id="cb1-button" tabindex="-1" aria-label="States" aria-expanded="false" aria-controls="cb1-listbox">
      <svg width="18" height="16" aria-hidden="true" focusable="false" style="forced-color-adjust: auto">
        <polygon class="arrow" stroke-width="0" fill-opacity="0.75" fill="currentcolor" points="3,6 15,6 9,14"></polygon>
      </svg>
    </button>
  </div>
  <ul id="cb1-listbox" role="listbox" aria-label="States">
      <%
          for (int z=0; z<(j+k); z++){
                if(x[z]==0){
                    ;
                }
                else if(x[z]==1){
//                    out.println("<option disabled value=\"1\">Stato patrimoniale</option>");
                }else if(x[z]==2){
//                    out.println("<option disabled value=\"2\">Conto economico</option>");
                }else if(x[z]==99999999){
//                    out.println("<option disabled value=\"99999999\">Coda sp</option>");
                }else if(x[z]==999999999){
//                    out.println("<option disabled value=\"999999999\">Coda ce</option>");
                }else{
    out.println("<li id=\"idpc"+x[z]+"\" role=\"option\">"+descriz[z]+"</li>");
//                    out.println("<option value='"+x[z]+"'> id: "+x[z]+" descr: "+descriz[z]+"</option>");
                }
          }
          %>
<!--    <li id="lb1-al" role="option">Alabama</li>-->
  </ul>
</div>
        
    </body>
</html>
