<%-- 
    Document   : mostraconti
    Created on : 16-giu-2013, 14.45.23
    Author     : p39
--%>


<%@page import="include.Menu"%>
<%@page import="gest.db.DbParameter"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="gest.db.SistemaXDbMriga"%>
<%@page import="gest.db.DbMaria"%>

<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SistemaX ver.2.0</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/p39.css">
        <link type='text/css' rel='stylesheet' href='css/fancybox.css' />
        <!--        <link type='text/css' rel='stylesheet' href='css/style.css' />-->
        <style type="text/css">
            #loading {
                width: 30px;
                height: 30px;
                background-color: #c0c0c0;
                position: absolute;
                left: 50%;
                top: 50%;
                margin-top: -140px;
                margin-left: -140px;
                text-align: center;
            }
        </style>
        <script type="text/javascript" src="js/jQuery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jqtdnd1.js"></script> 
        <!--        <script type="text/javascript" src="js/jquery.tablednd.js"></script>-->
        <script type="text/javascript" src="js/core-fb1.js"></script>
<!--        <script src="js/tinymce.js" referrerpolicy="origin"></script>-->
        <!--        <script type="text/javascript" src="js/aposid.js"></script>-->
<!--        <script type="text/javascript" src="js/mostraconti.js"></script>-->
        <script type="text/javascript">
            var a;
            var b;
            var ab;
            var abc;
            function aposid() {
                ab = "[";
                a = "[";
                b = "[";
                $("#b1 tr").each(function () {
                    a += $(this).attr("id").substring(3);
                    a += ",";
                    ab += $(this).attr("id").substring(3);
                    ab += ",";
                    
                });
                $("#b2 tr").each(function () {
                    b += $(this).attr("id").substring(3);
                    b += ",";
                    ab += $(this).attr("id").substring(3);
                    ab += ",";
                });
                a = a.substring(0, a.length - 1);
                b = b.substring(0, b.length - 1);
                ab = ab.substring(0, ab.length - 1);
                a += "]";
                b += "]";
                ab += "]";
            }
            var xp;
            var xd;
            var posp;
            var posd;
            var prima;
            var dopo;
            function settable() {
                aposid();
            //alert(ab.toString());
                posizione(ab);
                //ids(ab);

                $("#row1>td").removeClass("dragHandle");
                $("#row2>td").removeClass("dragHandle");
                $("#row1 button").remove();
                $("#row2 button").remove();
                $("#row1").attr("class", "nodrag nodrop");
                $("#row2").attr("class", "nodrag nodrop");
                $("#b1 tr").each(function(){
                    if(parseInt($(this).attr("id").substring(3))==99999999){
                        $(this).attr("class", "nodrag nodrop");
                        $(this).children("td").each(function(){
                            $(this).find("button").remove();
                        });
                    }
                });
                $("#b2 tr").each(function(){
                    if(parseInt($(this).attr("id").substring(3))==999999999){
                        $(this).attr("class", "nodrag nodrop");
                        $(this).children("td").each(function(){
                            $(this).find("button").remove();
                        });
                    }
                });
                $("#th1").attr("class", "nodrag nodrop");
                $("#th2").attr("class", "nodrag nodrop");

                return;
            }
            function posizione(pos){
                $.ajax({
                    url: "posizione.jsp",
                    dataType: "text",
                    type: "post",
                    data:{
                        ab:pos,
                        //j:pos,
                    },
                    success:function(msg){
                        //zpos=msg.split(",");
                        //alert(zpos);
                    },
                    error:function(e){
                        alert("errore"+pos);
                    }
                });
            }
            function delconto(i){
                if (!confirm("Cancelli conto "+i))
                    return;
                else{
                    $.ajax({
                        url : "saldidel.jsp",
                        dataType:"text",
                        type: "post",
                        data :{id:i},
                        success: function(msg){
                            aposid();
                            if (msg==1){
                                $.ajax({
                                    url : "deletec.jsp",
                                    dataType:"text",
                                    type: "post",
                                    data :{id:i,ab:ab,a:a,b:b,},
                                    success:function(msg){
                                        alert ("conto "+i+" cancellato" + msg);
                                        location.reload();
                                    },
                                    error:function(){
                                        
                                    },
                                });
                            }
                            else
                                alert("Impossibile cancellazione: saldi non a zero o il conto contiene movimenti");
                        },
                        error:function(){
                            alert ("errore saldi")
                        }
                    });
                }
            }
            document.write("<div id=\"loading\" align=\"center\"><img src=\"images/fancybox_loading@2x.gif\" alt=\"Caricamento\" /></div>");
            $(document).ready(function () {
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //return;
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                settable();
                $("#conti").tableDnD({
                    onDragStart: function (table, row) {
                        $.Callbacks(
                                $.ajax({
                                    type: "post",
                                    dataType: "text",
                                    url: "ajmostraconti.jsp",
                                    data: {
                                        serial: $.tableDnD.serialize(),
                                    },
                                    success: function (msg) {
                                        $("#demop").html(msg);
                                        prima = msg.split(",");
                                        xp = row.id.substring(3);
                                        posp = 0;
                                        let jposp = new Array();
                                        jposp = JSON.parse($("#demop").text());
                                        let n = 0;
                                        for (i = 1; i < jposp.length; i++) {
                                            if (jposp[i] == xp) {
                                                n = i;
                                                break;
                                            }
                                        }
                                        posp = n;
                                    },
                                    error: function (e) {
                                        alert("errore di comunicazione con il server" + e);
                                    },
                                }),
                                );
                    },
                    onDrop: function (table, row) {
                        $.Callbacks(
                                $.ajax({
                                    type: "post",
                                    dataType: "text",
                                    url: "ajmostraconti.jsp",
                                    data: {
                                        serial: $.tableDnD.serialize(),
                                    },
                                    success: function (msg) {
                                        $("#demod").html(msg);
                                        dopo = msg.split(",");
                                        xd = row.id.substring(3);
                                        posd = 0;
                                        let jposd = new Array();
                                        jposd = JSON.parse($("#demod").text());
                                        let n = 0;
                                        for (i = 1; i < jposd.length; i++) {
                                            if (jposd[i] == xd) {
                                                n = i;
                                                break;
                                            }
                                        }
                                        posd = n;
                                        aposid();
                                        
                                        $.ajax({
                                            url: "ajspostamento.jsp",
                                            dataType: "text",
                                            type: "post",
                                            data: {
                                                xdd: xd,
                                                pospp: posp,
                                                posdd: posd,
                                                aa: a,
                                                bb: b,
                                            },
                                            success: function (msg) {
                                                //alert(msg);
                                                location.reload();
                                            },
                                            error: function (e) {
                                                alert("AJSPOSTAMENTO" + e);
                                            },
                                        });
                                    },
                                    error: function (e) {
                                        alert("errore di comunicazione con il server" + e);
                                    },
                                }),
                            );
                    },
                });
            });
            function popup(i) {
                $.ajax({
                    url: "iconto.jsp",
                    dataType: "json",
                    type: "post",
                    data: {i: i},
                    success: function (msg) {
                        fillfancy(msg);
                    },
                    error: function (e) {
                        alert("popup");
                    },
                });
            }
            function fillfancy(msg) {
                var line = new String();
                $("#fancy").empty();
                for (var item in msg) {
                    if (msg.hasOwnProperty(item)) {
                        line = line.concat("<a href=\"#\" >" + msg[item] + "</a>");
                    }
                }
                $("#fancy").html(line);
            }
            $(function () {
                $.extend($.fancybox.defaults, {
                    afterClose: function () {
                        location.reload();
                    },
                });
//                $(.fancybox).fancybox({
//                    afterClosed: function() {
//                        location.reload();
//                        //location.href="mostraconti.jsp";
//                    }
//                });
                document.getElementById("loading").style.display = "none";
            });

            
            

        </script>
    </head><body>       
        <%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    gest.pc.util.User usera = new gest.pc.util.User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{
            out.println(Menu.getMenu());
    out.println("</body><br><br>");

            //SistemaXDbMriga dbmrighe= new SistemaXDbMriga("gest");
//            out.println("<a href=\"menu.jsp\" style=\"text-align:right;\")>menu</a>");
//            out.println("<a href=\"logout.jsp\" style=\"text-align:right;\")>bye</a>");
            PiCo q = new PiCo(DbParameter.getDb());
            q.scorriConti(4, PiCo.pc.getConto(2));
            int j = q.alConti.getSize();
            q.aConti = new Conto[j];
            q.alConti.getArr(q.aConti);
            PiCo p = new PiCo(DbParameter.getDb());
            p.scorriConti(4, PiCo.pc.getConto(1));
            int k = 0;
            int i = p.alConti.getSize();
            p.aConti = new Conto[i];
            p.alConti.getArr(p.aConti);
            int n = 0;
            Conto r = new Conto(DbParameter.getDb());
            Conto rp = new Conto(DbParameter.getDb());
            
            out.println("<div id=\"demop\" style=\"display:none\"></div>");//
            out.println("<div id=\"demod\" style=\"display:none\"></div>");//
//            out.println("</div>");
            out.println("<h1>Piano dei conti</h1>");
            out.println("<table id=\"conti\" class=\"fancybox\" style=\"border:solid thin; tex-align:center; margin:auto;\">");
                out.println("<tr><td class=\"insert\" style=\"border-bottom:solid thin; border-top:solid thin;\"><button"
                        + " href=\"insertconto.jsp?id=1"
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"javascript:void(0);\"><img src=\"images/piu.gif\"</button></td></tr>");
            out.println("<tr id=\"th1\" style=\"border:solid thin; \"><th>id</th><th>pos</th><th>son</th><th>next</th><th>level</th>"
                    + "<th>dare</th><th>avere</th><th>descrizione</th><th>Mov.ble</th></tr>"
                    +"" );
            out.println("<tbody id=\"b1\">");
            for (n = 0; n < p.aConti.length; n++) {
                //++++++++++++++++++++++++++++++++++++++++
                r = PiCo.pc.getConto(p.aConti[n].getId());
                if (n>0)
                    rp = PiCo.pc.getConto(p.aConti[n-1].getId());
                //++++++++++++++++++++++++++++++++++++++++class=\"draghandle\" 
                out.println("<tr id=\"row" + r.getId() + "\" pos='" + r.getPos() + "'\">");
                
                out.println("<td class=\"agg\" style=\"border-bottom:solid thin; border-top:solid thin;\" \"><button"
                        + " href=\"insertnuovo.jsp" //aggconto
                        + "?id=" + r.getId()
                        + "&idp="+rp.getId()
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"popup('" + r.getId()
                        + "');\"><img src=\"images/piu.gif\"</button></td>");

                //out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" ><img src=\"images/updown2.gif\" alt=\"sposta\"></td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\">" + r.getId() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"pos\">" + r.getPos() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" id=\"s" + r.getId() + "\" class=\"son\">" + r.getsid() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" id=\"n" + r.getId() + "\"  class=\"next\">" + r.getnid() + "</td>");
                //out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"lev\" id=\"lev" + r.getId() + "\">" + "" + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"sd\" id=\"sd" + r.getId() + "\">" + r.getSaldod() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"sa\" id=\"sa" + r.getId() + "\">" + r.getSaldoa() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"mvmble\" id=\"mvmble" + r.getId() + "\">" + String.valueOf(r.getMvmble()) + "</td>");
                out.println("<td class=\"mod\" style=\"border-bottom:solid thin; border-top:solid thin;\"><button"
                        + " href=\"modconto.jsp?id="
                        + r.getId()
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"popup('" + r.getId()
                        + "');\">" + r.getdescr() + "</button></td>");
                out.println("<td class=\"del\" style=\"border-bottom:solid thin; border-top:solid thin;\"><button"
                        + " href=\"javascript:void(0)"
                        + "\""
//                        + " data-fancybox"
//                        + " data-type=\"iframe\""
//                        + " fancybox-close"
                        + " onclick=\"delconto("+r.getId()+");\"><img src=\"images/meno.gif\"</button></td>");
                out.println("</tr>");
//              }
            }
            k = n;
            out.println("</tbody>");
                out.println("<tr><td class=\"insert\" style=\"border-bottom:solid thin; border-top:solid thin;\"><button"
                        + " href=\"insertconto.jsp?id=2"
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"javascript:void(0);\"><img src=\"images/piu.gif\"></button></td></tr>");
            out.println("<tr id=\"th2\" style=\"border:solid thin; \"><th>id</th><th>pos</th><th>son</th><th>next</th><th>level</th>"
                    + "<th>dare</th><th>avere</th><th>descrizione</th><th>Mov.ble</th></tr>"
                    +"" );
            out.println("<tbody id=\"b2\">");
            for (n = 0; n < q.aConti.length; n++) {
                r = PiCo.pc.getConto(q.aConti[n].getId());
                if (n>0)
                    rp = PiCo.pc.getConto(q.aConti[n-1].getId());
                
                //++++++++++++++++++++++++++++++++++++++++
                //++++++++++++++++++++++++++++++++++++++++class=\"draghandle\"
//              if (!(r.getId()==0||r.getId()==1||r.getId()==2)){
                out.println("<tr  id=\"row" + r.getId() + "\" pos='" + r.getPos() + "'\">");
                
                out.println("<td class=\"agg\" style=\"border-bottom:solid thin; border-top:solid thin;\" \"><button"
                        + " href=\"insertnuovo.jsp" //aggconto
                        + "?id=" + r.getId()
                        + "&idp="+rp.getId()
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"popup('" + r.getId()
                        + "');\"><img src=\"images/piu.gif\"</button></td>");

                //out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" ><img src=\"images/updown2.gif\" alt=\"sposta\"></td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\">" + r.getId() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"pos\">" + r.getPos() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" id=\"s" + r.getId() + "\" class=\"son\">" + r.getsid() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" id=\"n" + r.getId() + "\" class=\"next\">" + r.getnid() + "</td>");
                //out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"lev\" id=\"lev" + r.getId() + "\">" + r.getlevel() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"sd\" id=\"sd" + r.getId() + "\">" + r.getSaldod() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"sa\" id=\"sa" + r.getId() + "\">" + r.getSaldoa() + "</td>");
                out.println("<td style=\"border-bottom:solid thin; border-top:solid thin;\" class=\"sa\" id=\"mvmble" + r.getId() + "\">" + String.valueOf(r.getMvmble()) + "</td>");
                out.println("<td class=\"mod\" style=\"border-bottom:solid thin; border-top:solid thin;\" \"><button"
                        + " href=\"modconto.jsp"
                        + "?id=" + r.getId()
                        + "\""
                        + " data-fancybox"
                        + " data-type=\"iframe\""
                        + " fancybox-close"
                        + " onclick=\"popup('" + r.getId()
                        + "');\">" + r.getdescr() + "</button></td>");
                out.println("<td class=\"del\" style=\"border-bottom:solid thin; border-top:solid thin;\"><button"
                        + " href=\"javascript:void(0)"
                        + "\""
//                        + " data-fancybox"
//                        + " data-type=\"iframe\""
//                        + " fancybox-close"
                        + " onclick=\"delconto("+r.getId()+")\"><img src=\"images/meno.gif\"></button></td>");
                out.println("</tr>");
//              }
            }
            out.println("</tbody></table>");
            out.println("<div id=\"fancy\" class=\"fancybox fancybox-close\"></div>");
            out.println("<div id=\"insert\" class=\"fancybox fancybox-close\"></div>");

            }
//            else {
//             response.sendRedirect("index.jsp");
            
        %>
    </body></html>
