<%-- 
    Document   : avanzi.jsp
    Created on : 27 nov 2021, 13:53:40
    Author     : p39
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <script type="text/javascript">
//            function settbl() {
//                aposid();
//                $.ajax({
//                    url: "settable.jsp",
//                    type: "post",
//                    dataType: "json",
//                    data: {
//                        aa: a,
//                        bb: b,
//                    },
//                    success: function (msg) {
//                        aposid();
//                        oo = a.toString();
//                        ii = b.toString();
//                        j = oo.substring(0, oo.length - 1);
//                        j += ",";
//                        j += ii.substring(1);
//                        piumeno(j);
//                    },
//                    error: function (e) {
//                        alert("SETTBL");
//                    },
//                });
//                return;
//            }
//            function piumeno(x) {
//                $.ajax({
//                    url: "ajsonnext.jsp",
//                    type: "post",
//                    dataType: "json",
//                    data: {
//                        ab: x,
//                    },
//                    success: function (msg) {
//                        inout(msg);
//                    },
//                    error: function (e) {
//                        alert("errore son next");
//                    },
//                });
//            }
//            function inout(m) {
//                aposid();
//                var v = null;
//                $("#b1 tr").each(function (index, e) {
//                    if ($(this).attr("id").substring(3) == a[i]) {
//                        v = e;
//                    }
//                });
//                $("#b2 tr").each(function (index, e) {
//                    if ($(this).attr("id").substring(3) == b[i]) {
//                        v = e;
//                    }
//                });
//                for (var i = 1; i < m.length; i++) {
//                    if (m[i - 1] == "s") {
//                        $(v).children("td").each(function (ii, ee) {
//                            if ($(this).attr("class") == "in")
//                                $(this).html("");
//                        });
//                    } else if (m[i - 1] == "n")
//                        $(v).children("td").each(function (ii, ee) {
//                            if ($(this).attr("class") == "out")
//                                $(this).html("");
//                        });
//                    else
//                        ;
//                }
//            }
        
//            function move(idx, inout) {
//                //aposid();
//                $.ajax({
//                    url: "indentaconto.jsp",
//                    dataType: "text",
//                    type: "post",
//                    data: {
//                        in: idx,
//                        aa: a,
//                        bb: b,
//                        io: inout,
//                    },
//                    success: function (msg) {
//                        //settbl();
//                        location.reload();
//                    },
//                    error: function (e) {
//                        alert("error move");
//                    },
//                });
//            }

    </script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
