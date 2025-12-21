<%@page import="gest.db.DbParameter"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gest.pc.PiCo"%>
<%@page import="gest.pc.Conto"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONArray"%>
<%
    String posp = request.getParameter("pospp");
    String posd = request.getParameter("posdd");
    String aa = request.getParameter("aa");
    String bb = request.getParameter("bb");
    int xd = (int) Integer.parseInt(request.getParameter("xdd"));
    JSONArray a = (JSONArray) new JSONTokener(aa).nextValue();
    JSONArray b = (JSONArray) new JSONTokener(bb).nextValue();
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
    Conto contopartenzameno1 = new Conto(DbParameter.getDb());
    Conto contopartenzapiu1 = new Conto(DbParameter.getDb());
    Conto contoarrivomeno1 = new Conto(DbParameter.getDb());
    Conto contoarrivopiu1 = new Conto(DbParameter.getDb());
    Conto a2 = new Conto (DbParameter.getDb());
    Conto b2 = new Conto (DbParameter.getDb());

    int[] q = new int[999999];
    
    int k =0;
    for(k=0; k<a.length(); k++)
        q[k]=a.getInt(k);
     
    for(k=0; k<b.length(); k++)
        q[k+a.length()]=b.getInt(k);
        
    contopartenzameno1 = PiCo.pc.getConto(q[iposp - 1]);//+o
    currentprec=PiCo.pc.getConto(q[iposp]);
    contopartenzapiu1 = PiCo.pc.getConto(q[iposp + 1]);//+s

    contoarrivomeno1 = PiCo.pc.getConto(q[iposd - 1]);//++o
    current = PiCo.pc.getConto(q[iposd]);//++s+++o
    contoarrivopiu1 = PiCo.pc.getConto(q[iposd + 1]);//+++s
    
    
    a2 = PiCo.pc.getConto(a.getInt(1));
    b2 = PiCo.pc.getConto(b.getInt(1));
    
    if(iposp<iposd){
        if (contopartenzameno1.getId()!=1&&contopartenzameno1.getId()!=2){
            if(contopartenzameno1.hasSon()){
                contopartenzameno1.setSid(contopartenzapiu1.getId());
                contopartenzameno1.setNid(0);
            }else if(contopartenzameno1.hasNext()){
                contopartenzameno1.setNid(contopartenzapiu1.getId());
                contopartenzameno1.setSid(0);
            }
        }else{
            contopartenzameno1.setSid(contopartenzapiu1.getId());
            contopartenzameno1.setNid(0);
        }
    }else if(iposp>iposd){
        if(currentprec.hasSon()){
            currentprec.setSid(contopartenzapiu1.getId());
            currentprec.setNid(0);
        }else if(currentprec.hasNext()){
            currentprec.setNid(contopartenzapiu1.getId());
            currentprec.setSid(0);
        }
    }

    if (contoarrivomeno1.hasSon()) {
        contoarrivomeno1.setSid(current.getId());
        contoarrivomeno1.setNid(0);
    } else if (contoarrivomeno1.hasNext()) {
        contoarrivomeno1.setNid(current.getId());
        contoarrivomeno1.setSid(0);
    }
    if(iposp<iposd){
        if (current.hasSon()) {
            current.setSid(contoarrivopiu1.getId());
            current.setNid(0);
        }else if (current.hasNext()) {
            current.setSid(0);
            current.setNid(contoarrivopiu1.getId());
        }

    }else if(iposp>iposd){
        if (current.getId()==a2.getId()){
            if (current.hasSon()) {
                current.setSid(a2.getsid());
                current.setNid(0);
            }else if (current.hasNext()) {
                current.setSid(0);
                current.setNid(a2.getnid());
            }
        }else if (current.getId()==b2.getId()){
            if (current.hasSon()) {
                current.setSid(b2.getsid());
                current.setNid(0);
            }else if (current.hasNext()) {
                current.setSid(0);
                current.setNid(b2.getnid());
            }
        }
        if (contoarrivopiu1.getId()!=1&&contoarrivopiu1.getId()!=2){
            if (current.hasSon()) {
                current.setSid(contoarrivopiu1.getId());
                current.setNid(0);
            }else if (current.hasNext()) {
                current.setSid(0);
                current.setNid(contoarrivopiu1.getId());
            }
        }
        else{
            current.setSid(contoarrivopiu1.getId());
            current.setNid(0);
        }
    }
    PiCo.pc.update(current);
    PiCo.pc.update(contoarrivomeno1);
    PiCo.pc.update(currentprec);
    PiCo.pc.update(contopartenzameno1);
    
%>
