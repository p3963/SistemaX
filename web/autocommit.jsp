<%-- 
    Document   : autocommit
    Created on : 13 lug 2025, 10:52:35
    Author     : piero.trentanove
--%>

<%@page import="gest.db.DbParameter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
<%
    //String ac="/opt/homebrew/Cellar/libpq/17.5/bin/psql -U p39 -w -d postgres -c 'set autocommit=on;'";
    String dropdb=DbParameter.getDropdb()+" -U postgres -w --if-exists "+DbParameter.getDb();
    out.println(dropdb);
    Runtime.getRuntime().exec(dropdb);
    String createdb =DbParameter.getCreatedb()+" -U postgres -w -O p39 -T template1 -E 'UTF8' --lc-collate='C' --lc-ctype='C' -D pg_default "+DbParameter.getDb();
    out.println("<br><br>"+createdb);
    Runtime.getRuntime().exec(createdb);
    String rest = DbParameter.getRestore()+" -U p39 -w -d gest1 < /Users/piero.trentanove/SistemaX/SistemaXDB_gest1_11-07-2025_13-18-12.sql";
    out.println(rest);
    Runtime.getRuntime().exec(rest);
    %>