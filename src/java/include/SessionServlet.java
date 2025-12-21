/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package include;

/**
 *
 * @author piero.trentanove
 */
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class SessionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(); // Ottiene o crea una sessione
        String sessionId = session.getId();

        out.println("<html><body>");
        out.println("<h1>ID di Sessione: " + sessionId + "</h1>");

        // Invalida la sessione
        // session.invalidate();
        // sessionId = session.getId(); // Questo sarà un nuovo ID
        // out.println("<h1>Nuovo ID di Sessione dopo invalidazione: " + sessionId + "</h1>");

        out.println("</body></html>");
    }
}