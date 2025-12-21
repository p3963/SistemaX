
<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.DisLivello"%>
<%@page import="gest.pc.util.Livello"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Array"%>
<%@page import="gest.db.SistemaXDbPc"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JSONArray a = new JSONArray();
    JSONArray b = new JSONArray();
    String a1 =request.getParameter("aa");
    String b2 =request.getParameter("bb");
    a = (JSONArray) new JSONTokener(a1).nextValue();
    b = (JSONArray) new JSONTokener(b2).nextValue();
    

        int i=0;
        int j=Integer.parseInt(request.getParameter("j"));
        int k=Integer.parseInt(request.getParameter("k"));
        ArrayList z = new ArrayList();
        Conto [] x = new Conto[999999999];
        for (i=0; i<999999999; i++){
            if (i==x[i].getId())
                z.add(PiCo.pc.getConto(i).getId());
        }
        
        Conto prec = new Conto (DbParameter.getDb());
        
        Conto current = new Conto (DbParameter.getDb());
        
        String sl="";
        
        for(i=k; i<z.size(); i++){
            current = PiCo.pc.getConto((int)z.get(i));
            
            if (prec.getId()==0)
                current.setLevel("1");
            else if (prec.getId()==1)
                current.setLevel("2");
            else if(prec.hasNext()){
                String slp=current.getlevel();
                int lp = Integer.parseInt(slp.substring(slp.lastIndexOf(".")+1));
                lp++;
                String lpp=slp.substring(0, slp.lastIndexOf("."))+"."+String.valueOf(lp);
                current.setLevel(lpp);
            }
            else if(prec.hasSon()){
                String slp=current.getlevel();
                slp += ".1";
                current.setLevel(slp);
            }
            else ;
            current.setPos(i+j);
            PiCo.pc.update(current);                 
        }
    
//    int j=0;
//    j=DisLivello.DisLivello(0,1,a);
//    j=DisLivello.DisLivello(j,1,b);
//    out.println(j);
%>
