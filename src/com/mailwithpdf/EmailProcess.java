

package com.mailwithpdf;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
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
 

public class EmailProcess {

	
	public  void sendEmailwithpdf(String host, String port,
            final String userName, final String password,
            String recipient,String subject, String message, File attachFile,String docnos)
                    throws AddressException, MessagingException {
        // sets SMTP server properties
		
	//	System.out.println("==recipient==="+recipient+"=CC=="+CC);
		
	System.out.println("-------------Email Process-----------------");
	System.out.println("host=="+host+"==port=="+port+"==userName=="+userName+"==password=="+password+"==recipient=="+recipient);
		Session session=null;
		Properties properties = new Properties();
	if(port.equalsIgnoreCase("465")){	
       
        properties.setProperty("mail.smtp.protocol", "smtps");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", port);
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
       
	}
	if(port.equalsIgnoreCase("587")){	
	//	properties.put("mail.smtp.auth", "true");
	//	properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
	}
	else //port 25
	{
		 properties.put("mail.smtp.host", host);    // SMTP Host
		 properties.put("mail.smtp.port", port);                             // SMTP Port
		 properties.put("mail.smtp.auth", "true");                         // SMTP Authentication Enabled
	                
	      
	}
	System.out.println(properties);
	 Authenticator auth = new Authenticator() {
         public PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication(userName, password);
         }
     };
     session = Session.getInstance(properties, auth);
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        		//System.out.println("====recipient======"+recipient);
        		//System.out.println("====CC======"+CC);
        		//System.out.println("====BCC======"+BCC);
        		//System.out.println("==userName===="+userName);
        		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        
        
   
        
        
      /*  String[] cc = null;
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
        }*/
        
        
        if(!(subject.equals(""))){
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
 
        // creates message part
        Multipart multipart = new MimeMultipart();
        docnos=docnos==null?"":docnos;
        //nou
        /*if(!(docnos.equalsIgnoreCase("")))
        {*/
                
        MimeBodyPart myattach = new MimeBodyPart();
        
        //System.out.println("-------------myattach--------------"+myattach);
        
        //String filename = "QOT"+docnos+".pdf";
     	/*		
     	 * String path= System.getProperty("user.home")+File.separator+"Downloads";*/
        
       DataSource source = new FileDataSource(attachFile);
       // System.out.println("-------------source--------------"+source);
       // DataSource source = new FileDataSource(attachFile+filename);
        myattach.setDataHandler(new DataHandler(source));
        //myattach.setFileName(filename);
        //multipart.addBodyPart(myattach);
	/*}*/
        
        //krish
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
       
        multipart.addBodyPart(messageBodyPart);
       // multipart.addBodyPart(messageBodyPart);
 
        // adds attachments
       if (attachFile != null) {
            MimeBodyPart attachPart = new MimeBodyPart();
 
            try {
                attachPart.attachFile(attachFile);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
 
            multipart.addBodyPart(attachPart);
        }
        // sets the multi-part as e-mail's content*/
        msg.setContent(multipart);
 
        // sends the e-mail
       // System.out.println("=====dfghjkjhgfdfghjkl======="+msg);
        Transport.send(msg);
        
    }

	public  void sendEmailwithpdfNoAuth(String host, String port,
            final String userName,
            String recipient,String subject, String message, File attachFile,String docnos)
                    throws AddressException, MessagingException {
      
		 Properties properties = System.getProperties();
		 
	        properties.put("mail.smtp.host", host);
	        properties.put("mail.smtp.port", port);
	        Session session = Session.getDefaultInstance(properties, null);
     
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
            
        if(!(subject.equals(""))){
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
     
        Multipart multipart = new MimeMultipart();
        docnos=docnos==null?"":docnos;
                
        MimeBodyPart myattach = new MimeBodyPart();
        
       DataSource source = new FileDataSource(attachFile);
        myattach.setDataHandler(new DataHandler(source));
    
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
       
        multipart.addBodyPart(messageBodyPart);
       if (attachFile != null) {
            MimeBodyPart attachPart = new MimeBodyPart();
 
            try {
                attachPart.attachFile(attachFile);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
 
            multipart.addBodyPart(attachPart);
        }
    
        msg.setContent(multipart);
   Transport.send(msg);
   System.out.println("===Message Success====");
    }
	
	public  void sendEmailwithpdfBCC(String host, String port,
            final String userName, final String password,
            String rto,String rcc,String rbcc,String subject, String message, File attachFile,String docnos)
                    throws AddressException, MessagingException {
        // sets SMTP server properties
		
	//	System.out.println("==recipient==="+recipient+"=CC=="+CC);
		
	System.out.println("-------------Email Process-----------------"+message);
	System.out.println("host=="+host+"==port=="+port+"==userName=="+userName+"==password=="+password+"== TO=="+rto+"== CC=="+rcc+"== BCC=="+rbcc);
		Session session=null;
		Properties properties = new Properties();
	if(port.equalsIgnoreCase("465")){	
       
        properties.setProperty("mail.smtp.protocol", "smtps");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", port);
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        
        
        
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
       
	}
	if(port.equalsIgnoreCase("587")){	
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", port);
	}
	else //port 25
	{
		 properties.put("mail.smtp.host", host);    // SMTP Host
		 properties.put("mail.smtp.port", port);                             // SMTP Port
		 properties.put("mail.smtp.auth", "true");                         // SMTP Authentication Enabled
	                
	      
	}
		/*
		 * for PAL 
		 *
		   properties.put("mail.smtp.host", host);    // SMTP Host
		 properties.put("mail.smtp.port", port);                             // SMTP Port
		 properties.put("mail.smtp.auth", "false");
		  */
	//	 properties.put("mail.smtp.starttls.enable", "true");// SMTP Authentication Enabled
	                
	 Authenticator auth = new Authenticator() {
         public PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication(userName, password);
         }
     };
     session = Session.getInstance(properties, auth);
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        		//System.out.println("====recipient======"+recipient);
        		//System.out.println("====CC======"+CC);
        		//System.out.println("====BCC======"+BCC);
        		System.out.println("==userName===="+userName);
        		
        msg.setFrom(new InternetAddress(userName));
        
        if(!(rto.equalsIgnoreCase(""))){
        	String[] rtoarr=rto.split(",");
        	InternetAddress[] toAddresses =  new InternetAddress[rtoarr.length] ;
        	for(int i=0; i<rtoarr.length; i++){
        		 toAddresses[i] = new InternetAddress(rtoarr[i]) ;
               
        	}
        	 msg.setRecipients(Message.RecipientType.TO, toAddresses);
        }
        if(!(rcc.equalsIgnoreCase(""))){
        	
        	String[] rccarr=rcc.split(",");
        	InternetAddress[] toAddresses =  new InternetAddress[rccarr.length] ;
        	for(int i=0; i<rccarr.length; i++){
        		 toAddresses[i] = new InternetAddress(rccarr[i]) ;
               
        	}
        	 msg.setRecipients(Message.RecipientType.CC, toAddresses);
        }
        if(!(rbcc.equalsIgnoreCase(""))){
        	
        	String[] rbccarr=rbcc.split(",");
        	InternetAddress[] toAddresses =  new InternetAddress[rbccarr.length] ;
        	for(int i=0; i<rbccarr.length; i++){
        		 toAddresses[i] = new InternetAddress(rbccarr[i]) ;
        	}
        	 msg.setRecipients(Message.RecipientType.BCC, toAddresses);
        }
        
      /*  String[] cc = null;
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
        }*/
        
        
        if(!(subject.equals(""))){
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
 
        // creates message part
        Multipart multipart = new MimeMultipart();
        docnos=docnos==null?"":docnos;
        //nou
        /*if(!(docnos.equalsIgnoreCase("")))
        {*/
                
        MimeBodyPart myattach = new MimeBodyPart();
        
        //System.out.println("-------------myattach--------------"+myattach);
        
        //String filename = "QOT"+docnos+".pdf";
     	/*		
     	 * String path= System.getProperty("user.home")+File.separator+"Downloads";*/
        
       DataSource source = new FileDataSource(attachFile);
       // System.out.println("-------------source--------------"+source);
       // DataSource source = new FileDataSource(attachFile+filename);
        myattach.setDataHandler(new DataHandler(source));
        //myattach.setFileName(filename);
        //multipart.addBodyPart(myattach);
	/*}*/
        
        //krish
        MimeBodyPart messageBodyPart = new MimeBodyPart();
     //   messageBodyPart.setText(message, "ISO-8859-1");  // first
        messageBodyPart.setContent(message, "text/html");
      // messageBodyPart.setHeader("content-Type", "text/html;charset=\"ISO-8859-1\""); // first

        multipart.addBodyPart(messageBodyPart);
       // multipart.addBodyPart(messageBodyPart);
 
        // adds attachments
       if (attachFile != null) {
            MimeBodyPart attachPart = new MimeBodyPart();
 
            try {
                attachPart.attachFile(attachFile);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
 
            multipart.addBodyPart(attachPart);
        }
        // sets the multi-part as e-mail's content*/
        msg.setContent(multipart);
 
        // sends the e-mail
       // System.out.println("=====dfghjkjhgfdfghjkl======="+msg);
        Transport.send(msg);
        
    }
}


