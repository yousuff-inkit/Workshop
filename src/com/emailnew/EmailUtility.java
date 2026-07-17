package com.emailnew;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
 

public class EmailUtility {   
	public  String sendEmailpdf(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC,File attachfile){  
		
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");                  
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
       
        String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }      
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	} 
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }
        MimeBodyPart attachPart = new MimeBodyPart();    
		attachPart.attachFile(attachfile);     
		multipart.addBodyPart(attachPart);
		
        msg.setContent(multipart);
        Transport.send(msg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	return "fail";
        }
        return "success";        
    }
	
	public  String sendEmail(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC){  
		
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");                  
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
       
        String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }      
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	}        
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }   
        msg.setContent(multipart);
        Transport.send(msg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	return "fail";
        }
        return "success";        
    }
}