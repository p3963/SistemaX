<%@page import="gest.db.DbParameter"%>
<%@page import="gest.pc.util.User"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONArray"%>
<%
    HttpSession sa=request.getSession();
    String username=(String)sa.getAttribute("username");
    User usera = new User();
    if(sa.getId().compareTo(usera.getSessionId(username))!=0)
        response.sendRedirect("index.jsp");
    else{

    String posp = request.getParameter("pospp");
    String posd = request.getParameter("posdd");
    String aa = request.getParameter("aa");
    String bb = request.getParameter("bb");
    String cc = request.getParameter("cc");
    String dd = request.getParameter("dd");
    int xd = (int) Integer.parseInt(request.getParameter("xdd"));
    JSONArray a = (JSONArray) new JSONTokener(aa).nextValue();
    JSONArray b = (JSONArray) new JSONTokener(bb).nextValue();
    JSONArray c = (JSONArray) new JSONTokener(cc).nextValue();
    JSONArray d = (JSONArray) new JSONTokener(dd).nextValue();
    int iposp = Integer.parseInt(posp);
    int iposd = Integer.parseInt(posd);
    Conto current = new Conto(DbParameter.getDb());
    Conto currentprec = new Conto(DbParameter.getDb());
//    int i = 0;
//    for (i = 1; i < a.length(); i++) {
//        current = PiCo.pc.getConto(a.getInt(i));
//        current.setPos(i);
//        PiCo.pc.update(current);
//    }
//    for (int j = 1; j < b.length(); j++) {
//        current = PiCo.pc.getConto(b.getInt(j));
//        current.setPos(j + i);
//        PiCo.pc.update(current);
//    }

//////////////////////////////////////////////////////////////////////////////////////////////    
    Conto ciposd = new Conto(DbParameter.getDb());
    Conto ciposdmeno1 = new Conto(DbParameter.getDb());
    Conto ciposdpiu1 = new Conto(DbParameter.getDb());
    Conto ciposdpiu2 = new Conto(DbParameter.getDb());
    Conto ciposp = new Conto(DbParameter.getDb());
    Conto cipospmeno1 = new Conto(DbParameter.getDb());
    Conto ciposppiu1 = new Conto(DbParameter.getDb());
    Conto a2 = new Conto (DbParameter.getDb());
    Conto b2 = new Conto (DbParameter.getDb());
    Conto c2 = new Conto (DbParameter.getDb());
    Conto d2 = new Conto (DbParameter.getDb());

    int[] q = new int[199999];
    
    int k =0;
    for(k=0; k<a.length(); k++)
        q[k]=a.getInt(k);
     
    for(k=0; k<b.length(); k++)
        q[k+a.length()]=b.getInt(k);

    for(k=0; k<c.length(); k++)
        q[k+b.length()]=c.getInt(k);
        
    for(k=0; k<d.length(); k++)
        q[k+c.length()]=d.getInt(k);
        
        
    ciposp=PiCo.pc.getConto(q[iposp]);
    ciposd = PiCo.pc.getConto(q[iposd]);//++s+++o
    cipospmeno1 = PiCo.pc.getConto(q[iposp - 1]);//+o
    ciposppiu1 = PiCo.pc.getConto(q[iposp + 1]);//+s
    ciposdmeno1 = PiCo.pc.getConto(q[iposd - 1]);//++o
    ciposdpiu1 = PiCo.pc.getConto(q[iposd + 1]);//+++s
    
    
//    a2 = PiCo.pc.getConto(a.getInt(1));
//    b2 = PiCo.pc.getConto(b.getInt(1));
//    c2 = PiCo.pc.getConto(c.getInt(1));
//    d2 = PiCo.pc.getConto(d.getInt(1));
        if (cipospmeno1.hasSon()){
            cipospmeno1.setSid(ciposp.getId());
            cipospmeno1.setNid(0);
        }
        else{
            cipospmeno1.setNid(ciposp.getId());
            cipospmeno1.setSid(0);
        }
        if (ciposd.hasSon()){
            ciposd.setSid(ciposdpiu1.getId());
            ciposd.setNid(0);
        }
        else{
            ciposd.setSid(0);
            ciposd.setNid(ciposdpiu1.getId());
        }
        if (ciposdmeno1.hasSon()){
            ciposdmeno1.setSid(ciposd.getId());
            ciposdmeno1.setNid(0);
        }
        else{
            ciposdmeno1.setSid(0);
            ciposdmeno1.setNid(ciposd.getId());
        }
        if(iposp>iposd){
            if(ciposp.hasSon()){
                ciposp.setSid(ciposppiu1.getId());
                ciposp.setNid(0);
            }else{
                ciposp.setNid(ciposppiu1.getId());
                ciposp.setSid(0);
            }
        }   
        
    PiCo.pc.update(ciposd);
    PiCo.pc.update(ciposp);
    PiCo.pc.update(ciposdmeno1);
    PiCo.pc.update(cipospmeno1);
    }
    
%>
