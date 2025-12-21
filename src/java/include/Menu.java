/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package include;

/**
 *
 * @author piero.trentanove
 */
public class Menu {
    private static final String menu="<nav class=\"navbar\">"+
        "<input type=\"checkbox\" id=\"menu-toggle\">"+
        "<label for=\"menu-toggle\" class=\"hamburger\">☰</label>"+
        "<ul class=\"menu\">"+
            "<li><a href=\"menu.jsp\">Home</a></li>"+
            "<li><a href=\"saldi.jsp\">Caricamento<br>saldi</a></li>"+
            "<li><a href=\"mostraconti.jsp\">Elenco<br>conti</a></li>"+
            "<li><a href=\"movimento.jsp\">Movimenti<br>contabili</a></li>"+
            "<li><a href=\"retrimov.jsp\">Ricerca<br>movimenti</a></li>"+
            "<li><a href=\"mastrino.jsp\">Mastrino</a></li>"+
            "<li><a href=\"bilancio.jsp\">Movimenti<br>Bilancio</a></li>"+
            "<li><a href=\"dump_dt.jsp\">Backup</a></li>"+
            "<li><a href=\"restore_dt.jsp\">Restore</a></li>"+
            "<li><a href=\"parametri.jsp\"><em>Parametri</em></a></li>"+
            "<li><a href=\"delute.jsp\"><em>Cancellazione<br>utenza</em></a></li>"+
            "<li><a href=\"cpform.jsp\"><em>Cambio<br>password</em></a></li>"+
            "<li><a href=\"logout.jsp\">Bye</a></li>"+
        "</ul>"+
        "</nav>";

    public Menu() {
    }

    public static String getMenu() {
        return menu;
    }

            
}
