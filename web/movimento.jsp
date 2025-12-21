<%-- 
    Document   : movimento
    Created on : 25 dic 2021, 09:27:12
    Author     : p39
--%>

<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="gest.pc.util.User"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.pc.PiCo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <html>
        <head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/p39.css">
<link rel="stylesheet" href="css/cbbox1.css">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jqtdnd1.js"></script>
        <script type="text/javascript" src="js/cbbox1.js"></script>
        <script type="text/javascript">
            var bool = true;
            var indice=0;
            var ntogli=0;
            function dataoggi(){
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!
                var yyyy = today.getFullYear();

                if (dd < 10) {
                    dd = '0' + dd;
                }

                if (mm < 10) {
                    mm = '0' + mm;
                }

                today = yyyy + '-' + mm + '-' + dd;
                $("#data").val(today);
            }

            function togli(x){
                indice-=1;
                $(x).parent("div").remove();
                let itogli=0;
                $("#riga .descr").each(function(){
                    itogli+=1;
                    $(this).attr("name","desout"+itogli);
                    $(this).attr("id","descri"+itogli);
                });
                itogli=0;
                $("#riga .imp").each(function(){
                    itogli+=1;
                    $(this).attr("name","impout"+itogli);
                    $(this).attr("id","importo"+itogli);
                });
                itogli=0;
                $("#riga .da").each(function(){
                    itogli+=1;
                    $(this).attr("name","daout"+itogli);
                    $(this).attr("id","dareavere"+itogli);
                });
                itogli=0;
                $("#riga .con").each(function(){
                    itogli+=1;
                    $(this).attr("name","pcout"+itogli);
                    $(this).attr("id","regular"+itogli);
                });
                itogli=0;
                $("#riga .conspan").each(function(){
                    itogli+=1;
                    $(this).attr("id","pcspan"+itogli);
                });
                if(itogli<1)
                    $("#sav").attr("disabled",true);
            }
            var pi = true;
            function controllo(e){
//                alert("quo");
//                $("#riga input").each(function(){
//                    if ($(this).val()==="" || $(this).val()===null){
////                        e.preventDefault();
//                        pi=false;
//                        return pi;
//                    }
//                });
//                    return true;
                
                //return true;
            }
            function salva(x){
// Add an event listener
                document.addEventListener("submit", function(e) {
                    console.log(e.detail); // Prints "Example of an event"
                });

// Create the event
                var event = new CustomEvent("submit", { "detail": "Example of an event" });

// Dispatch/Trigger/Fire the event
                document.dispatchEvent(event);
                
                lanciaEvento(event);
            }
            function lanciaEvento (event) {
                if (event.type === "submit") {
                //$("#movim").submit(function(event){
                let i=0;
                $(".indice").each(function(){
                    i++;
                });
                    //alert(i);
                $("#tot").val(i);

                var aval = new Array();
                var bid = new Array();
                
                $(".control").each(function(){
                    aval.push($(this).val());
                    bid.push($(this).attr("id"));
                });
                p=0;
                n=0;
                m=bid.length;
            loop: while(n<bid.length){
                    p=n+1;
                    while(p<bid.length){
                        if (bid[p]===bid[n]){
                            aval.splice(p,1);// bid[q+1];
                            bid.splice(p,1);
                            break loop;
                        }
                        p++;
                    }
                    n++;
                }

                var bool = true; 
                for (var t=0; t<bid.length; t++){
                    if (aval[t]===null || aval[t]===""){
//                        if(ciclo){
//                            ciclo = false;
                            event.preventDefault();
                            alert("Campi non valorizzati ("+bid[t]+")");
                            bool = false;
                            return false;
//                        }
                    }
                }
                if(bool)
                    $("#movim").submit();
                
                } else {
                    alert ("Un altro evento");
                }
            }
            function aggiungi (){
                if(indice<100){
                    indice+=1;
                    $("#rigapiu .descr").each(function(){
                        $(this).attr("name","desout"+indice);
                        $(this).attr("id","descri"+indice);
                        $(this).attr("required", "required");
                    });
                    $("#rigapiu .imp").each(function(){
                        $(this).attr("name","impout"+indice);
                        $(this).attr("id","importo"+indice);
                        $(this).attr("required", "required");
                    });
                    $("#rigapiu .da").each(function(){
                        $(this).attr("name","daout"+indice);
                        $(this).attr("id","dareavere"+indice);
                    });
                    $("#rigapiu .con").each(function(){
                        $(this).attr("name","pcout"+indice);
                        //////
                        $(this).attr("id","regular"+indice);
                        $(this).attr("required", "required");
                        //////
                    });
                    $("#rigapiu .conspan").each(function(){
                        $(this).attr("id","pcspan"+indice);
                    });
                    //$("#rigapiu input").removeClass("control");
                    $("#riga").append($("#rigapiu").html());
                    $("#riga input").addClass("control");
//                    $("#riga > .imp").addClass("control");
//                    $("#riga > .con").addClass("control");
                if(indice>=1)
                    $("#sav").attr("disabled",false);

                    //$("#riga .indice").addClass("good").removeClass("indice");
                }                
            }
            function pausecomp(millis){
                var date = new Date();
                var curDate = null;
                do { curDate = new Date(); }
                while(curDate-date < millis);
            }
            function me(x){
                let t = parseFloat($("#totale").text());
                let a = parseFloat($(x).val());
                let c = t-a;
                $("#totale").text(c);
            }
            function le(x){
                let t = parseFloat($("#totale").text());
                let a = parseFloat($(x).val());
                let c = t+a;
                $("#totale").text(c);
            }
            function saldo(){
                $("#totale").text("0.00");
                $("#riga .control.imp").each(function(){
                    let x = $(this).parent(".indice");
                    let s = $(x).children(".da").val();
                    var strimp = $(this).val();
//                    alert($(this).val());
                    
//                    alert(Number.parseFloat($(this).val()).toFixed(2));
//                    $("#totale").text(Number.parseFloat($(this).val()).toFixed(2));
//                    alert(Number.parseFloat($("#totale").text()).toFixed(2));
//                    saldo+=Conto.round(Double.parseDouble(rss.getString("imp")),2);

                    if (s==="1")
                        $("#totale").text(
                           Number(
                           (Number.parseFloat($("#totale").text())+Number.parseFloat($(this).val()))
                           .toFixed(2))
                           );
                    else
                        $("#totale").text(
                            Number(
                            (Number.parseFloat($("#totale").text())-Number.parseFloat($(this).val()))
                            .toFixed(2))
                            );
                       
                });
            }
            $(document).ready(function(){
                dataoggi();
                $("#sav").attr("disabled",true);
            });
</script>
<script type="text/javascript">
    function descrconto(f,g){
//        alert(f);
//        alert(g);
        i=f.substring(0,f.indexOf(" || "));
//        alert(i);
        j=g.substring(7);
//        alert (j);
        $("#regular"+j).val(i);
        $("#pcspan"+j).text(f);
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

          out.println(Menu.getMenu());
          out.println("<br><br>");
    //out.println("<body>");
//        out.println("<nav class=\"navbar\">");
//        out.println("<input type=\"checkbox\" id=\"menu-toggle\">");
//        out.println("<label for=\"menu-toggle\" class=\"hamburger\">☰</label>");
//        out.println("<ul class=\"menu\">");
//            out.println("<li><a href=\"menu.jsp\">Home</a></li>");
//            out.println("<li><a href=\"saldi.jsp\">Caricamento saldi</a></li>");
//            out.println("<li><a href=\"mostraconti.jsp\">Elenco conti</a></li>");
//            out.println("<li><a href=\"movimento.jsp\">Movimenti contabili</a></li>");
//            out.println("<li><a href=\"retrimov.jsp\">Ricerca movimenti</a></li>");
//            out.println("<li><a href=\"mastrino.jsp\">Mastrino</a></li>");
//            out.println("<li><a href=\"bilancio.jsp\">Movimenti-Bilancio</a></li>");
//            out.println("<li><a href=\"dump_dt.jsp\">Backup</a></li>");
//            out.println("<li><a href=\"restore_dt.jsp\">Restore</a></li>");
//            out.println("<li><a href=\"logout.jsp\">Bye</a></li>");
//        out.println("</ul>");
//        out.println("</nav><br><br>");
//    out.println("</body><br><br>");
//    out.println("<a href=\"menu.jsp\" style=\"text-align:right\">menu</a>");
//    out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>"+"<br>");
        
        PiCo p = new PiCo(DbParameter.getDb());
        p.scorriConti(4, PiCo.pc.getConto(6));
        int j = p.alConti.getSize();
        p.aConti = new Conto[j];
        p.alConti.getArr(p.aConti);
        PiCo q = new PiCo(DbParameter.getDb());
        q.scorriConti(4, PiCo.pc.getConto(50000));
        int k = q.alConti.getSize();
        q.aConti = new Conto[k];
        q.alConti.getArr(q.aConti);
        PiCo t = new PiCo(DbParameter.getDb());
        t.scorriConti(4, PiCo.pc.getConto(100000));
        int l = t.alConti.getSize();
        t.aConti = new Conto[l];
        t.alConti.getArr(t.aConti);
        PiCo m = new PiCo(DbParameter.getDb());
        m.scorriConti(4, PiCo.pc.getConto(150000));
        int s = m.alConti.getSize();
        m.aConti = new Conto[s];
        m.alConti.getArr(m.aConti);
        int[] x = new int[j+k+l+s];
        String[] descriz = new String[j+k+l+s];
        SistemaXDbPc sistpc = new SistemaXDbPc(DbParameter.getDb());
//        for (int i=0; i<j+k+l+s; i++){
//                x[i] = PiCo.pc.getConto(p.aConti[i].getId()).getId();
//                String sql = "select id, descr from public.pc where id = "+x[i]+";";
//                ResultSet rspc =sistpc.query(sql);
//                rspc.next();
//                descriz[i] = rspc.getString("descr");
//        }
        for (int i=0; i<j; i++){
                x[i] = PiCo.pc.getConto(p.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i] = rspc.getString("descr");
        }
        for (int i=0; i<k; i++){
                x[i+j] = PiCo.pc.getConto(q.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j] = rspc.getString("descr");
        }
        for (int i=0; i<l; i++){
                x[i+j+k] = PiCo.pc.getConto(t.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j+k]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j+k] = rspc.getString("descr");
        }
        for (int i=0; i<s; i++){
                x[i+j+k+l] = PiCo.pc.getConto(m.aConti[i].getId()).getId();
                String sql = "select id, descr from public.pc where id = "+x[i+j+k+l]+";";
                ResultSet rspc =sistpc.query(sql);
                rspc.next();
                descriz[i+j+k+l] = rspc.getString("descr");
        }
        Conto current = new Conto (DbParameter.getDb());
        
        out.println("<div>");
        out.println("<form id=\"movim\" method=\"post\" action=\"regmov.jsp\">");
        out.println("<input type=\"hidden\" id=\"tot\" name=\"tot\" value=\"100\">");
        out.println("<input required id=\"data\" type=\"date\" name=\"data\">");
        out.println("<select id=\"tipo\" name=\"tipo\">");
        out.println("<option value=\"1\">vendite</option>");
        out.println("<option value=\"2\">acquisti</option>");
        out.println("<option value=\"3\" selected>generico movimento</option>");
        out.println("</select>");
        out.println("<br><br>");
        out.println("<div id=\"riga\">");
        out.println("</div>");
        
  ////////////////////////////////////////////////////////controllo();       
        out.println("<br>");
        out.println("<button  type=\"button\"  onclick=\"aggiungi();\"><img src=\"images/piu.gif\"></button>");
        out.println("<br><br><button onclick=\"salva(this); return false;\"  type=\"submit\" name=\"save\" id=\"sav\">Salva</button>");
        out.println("</form>");
        out.println("<div id=\"rigapiu\" style=\"display: none\">");
        out.println("<div class=\"indice\">");
        out.println("<br>");
        out.println("<input required=\"required\" class=\"descr\"  type=\"text\" size=\"50\" placeholder=\"Descrizione\" name=\"des\" >");
        out.println("<br><br>");
        out.println("<input required=\"required\" class=\"imp\" placeholder=\"Importo\" type=\"number\" name=\"imp\" onkeyup=\"saldo();\">");
        out.println("<select  class=\"da\" name=\"da\" onchange=\"saldo();\">");
        out.println("<option  value=\"1\">Dare</option>");
        out.println("<option  value=\"0\">Avere</option>");
        out.println("</select>");
        
    
        out.println("<br><br>");
        out.println("<input required=\"required\" class=\"con\" onchange=\"descrconto($(this).val(),$(this).attr('id')); return false;\" type=\"text\" name=\"pc\" list=\"piano\" placeholder=\"Scegli il Conto...\" id=\"regular\" /><span class=\"conspan\" id=\"pcspan\"></span>");
        out.println("<datalist id=\"piano\">");
    
//        for (int i=0; i<j; i++){
        for (int z=0; z<j; z++){
                if(x[z]==0){
                    ;
                }
                else if(x[z]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z]+" value='"+x[z]+" || "+descriz[z]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<k; z++){
                if(x[z+j]==0){
                    ;
                }
                 else if(x[z+j]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j]+" value='"+x[z+j]+" || "+descriz[z+j]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<l; z++){
                if(x[z+j+k]==0){
                    ;
                }
                 else if(x[z+j+k]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j+k]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j+k]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j+k]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j+k]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j+k]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j+k]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j+k]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j+k]+" value='"+x[z+j+k]+" || "+descriz[z+j+k]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
        for (int z=0; z<s; z++){
                if(x[z+j+k+l]==0){
                    ;
                }
                 else if(x[z+j+k+l]==6){
                    out.println("<option readonly value=\"6\">ATTIVITA'</option>");
                }else if(x[z+j+k+l]==49999){
                    out.println("<option readonly value=\"49999\">coda ATTIVITA'</option>");
                }else if(x[z+j+k+l]==50000){
                    out.println("<option readonly value=\"50000\">PASSIVITA'</option>");
                }else if(x[z+j+k+l]==99999){
                    out.println("<option readonly value=\"99999\">coda PASSIVITA'</option>");
                }else if(x[z+j+k+l]==100000){
                    out.println("<option readonly value=\"100000\">COSTI</option>");
                }else if(x[z+j+k+l]==149999){
                    out.println("<option readonly value=\"149999\">coda COSTI</option>");
                }else if(x[z+j+k+l]==150000){
                    out.println("<option readonly value=\"150000\">RICAVI</option>");
                }else if(x[z+j+k+l]==199999){
                    out.println("<option readonly value=\"199999\">coda RICAVI</option>");
                }else{// id: "+x[z]+" descr: "+descriz[z]+""+descriz[z]+"
                    out.println("<option id=\"opt\""+x[z+j+k+l]+" value='"+x[z+j+k+l]+" || "+descriz[z+j+k+l]+"'></option>");//<span id=\"descrizioneconto"+x[z]+"\"></span>");
                }

        }
          out.println("</datalist>");

/////////        
//        out.println("</select>");
        
//        out.println("<button  type=\"button\"  onclick=\"aggiungi();\"><img src=\"images/piu.gif\"></button>");
        out.println("<br><br>");
        out.println("<button  type=\"button\"  onclick=\"togli(this);\"><img src=\"images/meno.gif\"></button>");

        out.println("</div>");
        out.println("</div>");
        out.println("<br>");
        out.println("<div id=\"totale\">0.00</div>");
        out.println("</div>");
        }
        //out.println("</body></html>");
    %>
    </body>
    </html>
    


