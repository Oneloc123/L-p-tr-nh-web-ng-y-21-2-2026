package code.salecar.mail;


import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class Mail {
    private static final String email = "";
    private static final String appPassword = "";
    public static void send(String sendTo, String subject, String content){
        Properties pro = new Properties();
        pro.put("mail.smtp.host","smtp.gmail.com");
        pro.put("mail.smtp.port","587");
        pro.put("mail.smtp.auth","true");
        pro.put("mail.smtp.starttls.enable","true");
        Session session = Session.getInstance(pro, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return  new PasswordAuthentication(email,appPassword);
            }
        });
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email,"CarX Support"));
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(sendTo));
            message.setSubject(subject);
            message.setContent(content,"text/html; charset=UTF-8");
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }
}
