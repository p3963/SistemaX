/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package invioemail;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

//@WebServlet(name = "InvioEmail", urlPatterns = {"/mail.jsp"})
//@MultipartConfig(maxFileSize = 10*1024*1024,maxRequestSize = 20*1024*1024,fileSizeThreshold = 5*1024*1024)
public class EmailSender {
  private String user;
  private String password;
  private String host;
  private String mittente;
  private String destinatario;
  private String cc;
  private String bcc;
  private String oggetto;
  private String contenuto;
  private ArrayList allegato;

  /**
  * Costruttore completo, richiede i parametri
  * di connessione al server di posta
  * @param user
  * @param password
  * @param host
  * @param mittente
  * @param destinatario
  * @param cc
  * @param bcc
  * @param oggetto
  * @param contenuto
  * @param allegato
  */
  public EmailSender(String user, String password, String host, 
                     String mittente, String destinatario, String cc, String bcc,
                     String oggetto, String contenuto, ArrayList allegato){

    this.user = user;
    this.password = password;
    this.host = host;
    this.mittente = mittente;
    this.destinatario = destinatario;
    this.cc = cc;
    this.bcc = bcc;
    this.oggetto = oggetto;
    this.contenuto=contenuto;
    this.allegato = allegato;
  }
  public EmailSender(String mittente, String destinatario, String cc, String bcc, String oggetto, String contenuto, ArrayList allegato){

    this.user = "piero-39@libero.it";
//    this.user = "smtp@p39.eu";
    this.password = "P4ssw4rd$";
//    this.password = "SmtpP@ssword";
    this.host = "smtp.libero.it";
//    this.host = "authsmtp.securemail.pro";
    this.mittente = mittente;
    this.destinatario = destinatario;
    this.cc = cc;
    this.bcc = bcc;
    this.oggetto = oggetto;
    this.contenuto = contenuto;
    this.allegato = allegato;
  }

  // Metodo che si occupa dell'invio effettivo della mail
  public void inviaEmail() throws IOException {
    int port = 25; //porta 25 per non usare SSL
    //int port = 587; //porta 25 per non usare SSL

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.user", user);
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);

    // commentare la riga seguente per non usare SSL 
//    props.put("mail.smtp.starttls.enable","true");
    props.put("mail.smtp.socketFactory.port", port);

    // commentare la riga seguente per non usare SSL 
//    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.socketFactory.fallback", "false");

    Session session = Session.getInstance(props, null);
    session.setDebug(true);

    // Creazione delle BodyParts del messaggio
    MimeBodyPart messageBodyPart1 = new MimeBodyPart();

    try{
      // COSTRUZIONE DEL MESSAGGIO
      Multipart multipart = new MimeMultipart();
      MimeMessage msg = new MimeMessage(session);

      // header del messaggio
      msg.setSubject(oggetto);
      msg.setSentDate(new Date());
      msg.setFrom(new InternetAddress(mittente));//mittente

      // destinatario
      msg.setRecipients(Message.RecipientType.TO,destinatario);
      msg.setRecipients(Message.RecipientType.CC, cc);
      msg.setRecipients(Message.RecipientType.BCC,bcc);

      // corpo del messaggio
      messageBodyPart1.setContent(contenuto, "text/html; charset=utf-8");
      //messageBodyPart1.setText("Saluti dal Blog di Lancill! Vieni a trovarmi su http://lancill.blogspot.it");
      multipart.addBodyPart(messageBodyPart1);

      // allegato al messaggio
    for (int i=0; i<allegato.size(); i++){
        MimeBodyPart messageBodyPart2 = new MimeBodyPart();
        String alle = (String) allegato.get(i);
        if (alle.compareTo("c:\\temp\\null")==0)
            continue;
        DataSource source = new FileDataSource(alle);
        messageBodyPart2.setDataHandler(new DataHandler(source));
        String barraw = "\\";
        String barral = "/";
        String filename = "";
        int trovaw = alle.lastIndexOf(barraw);
        int troval = alle.lastIndexOf(barral);
        if (trovaw>=0)
            filename = alle.substring(trovaw+1);
        else
            filename = alle.substring(troval+1);
        messageBodyPart2.setFileName(filename);
        multipart.addBodyPart(messageBodyPart2);
    }
    // inserimento delle parti nel messaggio
    msg.setContent(multipart);

    Transport transport = session.getTransport("smtp"); //("smtp") per non usare SSL
    transport.connect(host, user, password);
    transport.sendMessage(msg, msg.getAllRecipients());
    transport.close();
    for (int i=0; i<allegato.size(); i++){
        String alle = (String) allegato.get(i);
        File f = new File(alle);
        f.delete();
    }

    System.out.println("Invio dell'email Terminato");
    }catch(AddressException ae) {
      ae.printStackTrace();
    }catch(NoSuchProviderException nspe){
      nspe.printStackTrace();
    }catch(MessagingException me){
      me.printStackTrace();
    }
  }
}