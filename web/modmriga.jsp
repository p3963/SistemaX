<%-- 
    Document   : modconto
    Created on : 7 nov 2021, 16:19:30
    Author     : p39
--%>

<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="gest.movc.Mriga"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
    <link type='text/css' rel='stylesheet' href='css/fancybox.css' />
    <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
    <script type="text/javascript" src="js/jQuery.fancybox.js"></script>
    <script type="text/javascript" src="js/cbbox1.js"></script>
<!--    <script type="text/javascript" src="js/tinymce.js"></script>-->
    <link rel="stylesheet" href="css/cbbox1.css">
    <script type="text/javascript">
        $(function(){
            $("#mriga").keyup(function(e) {
                if (e.keyCode == 27) { //Escape button
                    $.fancybox.close();
                }
            });
            $("#mvmble").click(function(event){
                //event.preventDefault();
                $('#mvmble').change(function () {
                    if ($(this).prop("checked")) {
                        $("#mvmble").attr("checked","checked");
                        return;
                    }
                    $("#mvmble").removeAttr("checked");
                });
            });
        });
        
        function movble(x){
        }
        $(document).ready(function(){
            $("#umriga").on("submit", function(){
//                alert("ur");
//                $("#umriga").submit();
                parent.$.fancybox.close();
//                alert("ur1");
            });
        });
        function dareavere(z){
            $("#da").val(z);
//            alert ($("#da").val());
        }
        function opzpc(x){
            //alert(x);
            $("#pcid").val(x);    
            $("#pcidd").val(x);    
        }
    </script>
    </head>
    <body>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
        int id = Integer.parseInt(request.getParameter("id"));
        Mriga m = new Mriga(DbParameter.getDb());
        SistemaXDbMriga r= new SistemaXDbMriga(DbParameter.getDb());
        String sql="select id, idmovc, descr, imp, riga, pcid, da from mrighe where id='"+id+"';";
        ResultSet rsmr=r.query(sql);
        rsmr.next();
        //m=r.getMriga(id);
        out.println("<button id=\"close\" onclick=\"parent.$.fancybox.close();\">Close</button><br>");
        out.println("ID n. "+rsmr.getInt("id")+"<br>");
        out.println("<div id=\"mriga\">");
        out.println("<form id=\"umriga\" method=\"post\" action=\"updatemriga.jsp\">");//
        //out.println("<label>id</label><br><input disabled class=\"in\" name=\"idd\" type=\"text\" size=\"100\" value='"+id+"'><br>");//m.getId()
        out.println("<label>id movimenti</label><br><input disabled class=\"in\" name=\"idmovcd\" type=\"text\" size=\"100\" value='"+rsmr.getInt("idmovc")+"'><br>");
        out.println("<label>descrizione</label><br><input required class=\"in\" name=\"descr\" type=\"text\" size=\"100\" value='"+rsmr.getString("descr")+"'><br>");
        
        out.println("<br><select id=\"das\" onchange=\"dareavere($(this).val());\">");
        if(rsmr.getBoolean("da")){
            out.println("<option value=\"true\" selected >dare</option>");            
            out.println("<option value=\"false\">avere</option>");
        }else{
            out.println("<option value=\"true\">dare</option>");
            out.println("<option value=\"false\" selected >avere</option>");
        }
        out.println("</select>");
        out.println("<br><label>dare-avere</label><br><input id=\"da\" class=\"in\" name=\"da\" type=\"hidden\" size=\"100\" value='"+rsmr.getBoolean("da")+"'><br>");//

        out.println("<label>importo</label><br><input required class=\"in\" name=\"imp\" type=\"number\" step=\".01\" size=\"100\" value='"+rsmr.getString("imp")+"'><br>");//BigDecimal
        //----NUMBER
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
                String sql1 = "select id, descr from public.pc where id = "+x[i]+";";
                ResultSet rspc =sistpc.query(sql1);
                rspc.next();
                descriz[i] = rspc.getString("descr");
//            }
        }
        for (int i=0; i<k; i++){
            x[i+j] = PiCo.pc.getConto(q.aConti[i].getId()).getId();
//            if(x[i]==0 || x[i]==1 || x[i]==2 || x[i]==99999999 || x[i]==999999999)
//                continue;
//            else{
                String sql1 = "select id, descr from public.pc where id = "+x[i+j]+";";
                ResultSet rspc =sistpc.query(sql1);
                rspc.next();
                descriz[i+j] = rspc.getString("descr");
//            }
        }
        Conto current = new Conto (DbParameter.getDb());
        
        //String sqlpc="select id, descr from pc where true order by descr;";
        //SistemaXDbPc dbpc = new SistemaXDbPc(DbParameter.getDb());
        //ResultSet pc = dbpc.query(sqlpc);
        //out.println("<br><select id=\"selpc\" onchange=\"opzpc($(this).val());\">");
        String opz="";
        int idpc =0;
            //out.println("<option disabled selected value=\"0\" "+opz+" >idconto: 0  descrizione: "+"Scegliere un conto"+"</option>");
            //out.println("<option disabled selected value=\""+"0"+"\" "+opz+" >idconto: "+"0"+" descrizione: "+"Scegliere un conto"+"</option>");

        out.println("Conto attuale: ");
        int contocurrent =rsmr.getInt("pcid");
        out.println(contocurrent);
        String sql1 = "select id, descr from public.pc where id = "+contocurrent+";";
        ResultSet rspc =sistpc.query(sql1);
        rspc.next();
        String descrizione = rspc.getString("descr");
        out.println("<div type=\"hidden\" class=\"classid\">"+contocurrent+"</div>");
        out.println("<div type=\"hidden\" class=\"classdescr\">"+descrizione+"</div>");

        //out.println(" - "+descrizione+"<br>");//+rsmr.getString(\"descr\")+"<br>");
        out.println("<input class=\"con\" required onload=\"descrconto1($(this).val());\" onchange=\"descrconto($(this).val(),$(this).attr('id'));\" type=\"text\" name=\"pcid\" list=\"piano\" placeholder=\"Scegli il Conto...\" id=\"regular\" /><span class=\"conspan\" id=\"pcspan\"></span>");
        out.println("<datalist id=\"piano\">");
    
          for (int z=0; z<(j+k); z++){
                if(x[z]==rsmr.getInt("pcid"))
                    opz=" selected";
                else
                    opz="";

                if(x[z]==0){
                    ;
                }
                else if(x[z]==1){
                    out.println("<option disabled value=\"1\">Stato patrimoniale</option>");
                }else if(x[z]==2){
                    out.println("<option disabled value=\"2\">Conto economico</option>");
                }else if(x[z]==99999999){
                    out.println("<option disabled value=\"99999999\">Coda sp</option>");
                }else if(x[z]==999999999){
                    out.println("<option disabled value=\"999999999\">Coda ce</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+"
                    out.println("<option "+opz+" id=\"opt\""+x[z]+" value='"+x[z]+" || "+descriz[z]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
//                    out.println("<span id=\"spanpc"+x[z]+"\"></span>");
                }
//                out.println("<span id=\"descrizioneconto\"></span>");

          }
          out.println("</datalist>");
//        while(pc.next()){
//            idpc=pc.getInt("id");
//            String descrpc=pc.getString("descr");
//            if(idpc==rsmr.getInt("pcid"))
//                opz=" selected";
//            else
//                opz="";
//            if(idpc==0){
//                    ;
//            }
//            else if(idpc==1){
//                ;//out.println("<option disabled value=\"1\">Stato patrimoniale</option>");
//            }else if(idpc==2){
//                ;//out.println("<option disabled value=\"2\">Conto economico</option>");
//            }else if(idpc==99999999){
//                ;//out.println("<option disabled value=\"99999999\">Coda sp</option>");
//            }else if(idpc==999999999){
//                ;//out.println("<option disabled value=\"999999999\">Coda ce</option>");
//            }else{
////                out.println("<option value=\""+idpc+"\" "+opz+" >idconto: "+idpc+" descrizione: "+descrpc+"</option>");
//                    out.println("<option "+opz+" id=\"opt\""+idpc+" value='"+idpc+" || "+descrpc+"'> id: "+idpc+" descr: "+descrpc+"</option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
//            }
//        }
//        out.println("</select><br>");
        //----
        out.println("<br><label>pcid</label><br><input id=\"pcidd\" disabled class=\"in\" name=\"pcidd\" type=\"text\" size=\"100\" value='"+rsmr.getInt("pcid")+"'><br>");
        //out.println("<label>riga</label><br><input disabled class=\"in\" name=\"rigad\" type=\"text\" size=\"100\" value='"+rsmr.getInt("riga")+"'><br>");
        out.println("<input name=\"id\" type=\"hidden\" value='"+id+"'><br>");//m.getId()
        out.println("<input name=\"idmovc\" type=\"hidden\" value='"+rsmr.getInt("idmovc")+"'><br>");
        out.println("<input id=\"pcid\" name=\"pcid\" type=\"hidden\" value='"+rsmr.getInt("pcid")+"'><br>");
        out.println("<input name=\"riga\" type=\"hidden\" value='0'><br>");
        out.println("<br><button id=\"salva\"  type=\"submit\" class=\"fancybox-close\"  style=\"margin:auto;text-align:center; color:white; background-color:blue;\">Salva</button>");
        out.println("</form>");
        out.println("<div>");//onclick=\"ur();\"   onclick=\"parent.$.fancybox.close();\"
    }
%>
    </body>
    <script>
        $(document).ready(function(){
            $("#regular").val($(".classid").text());
            $("#pcspan").text($(".classdescr").text());
        });
        function descrconto1(f){
//            $("#regular"+g).val(f);
            i=f.substring(0,f.indexOf(" || "));
//            alert(f);//regular
//            j=g.substring(7);
//            alert(g);
            $("#regular"+j).val(i);
//            $("#pcspan"+j).text(f);
        }
        function descrconto(f,g){
//            $("#regular"+g).val(f);
            i=f.substring(0,f.indexOf(" || "));
//            alert(f);//regular
            j=g.substring(7);
//            alert(g);
            $("#regular"+j).val(i);
            $("#pcspan"+j).text(f);
        }
    
</script>

</html>