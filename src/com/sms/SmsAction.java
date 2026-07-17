package com.sms;

import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  
import java.io.PrintWriter;  
import java.net.HttpURLConnection;  
import java.net.MalformedURLException;
import java.net.URL;  
import java.net.URLEncoder;  
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;  
import java.util.Vector;  
import java.sql.*;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;

public class SmsAction {

	
    public  String doSendSmsBasicAuto(String phone,String clname,String msg,String docno,String dtype,String brhid,Connection conn,String compid,String userid) throws Exception {

        String uid="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";
        int cldocno=0;
        try{

            Integer loginUserId=0;

            String sid=null;
            String url=null;
            String senderid=null;
            
            if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
                return "0";
                //throw new IllegalArgumentException("SMS message should be present."); 
                
            }  
            msg = URLEncoder.encode(msg, "UTF-8");  

            Vector numbers = new Vector();  

            if (phone.indexOf(59) >= 0) {  
                String[] pharr = phone.split(";");  
                for (String t : pharr) {  
                    try {  
                        numbers.add(Long.valueOf(t));  
                    } catch (NumberFormatException ex) {  
                        throw new IllegalArgumentException("Give proper phone numbers.");  
                    }  
                }  
            } else {  
                try {  
                    numbers.add(Long.valueOf(phone));  
                } catch (NumberFormatException ex) {  
                    throw new IllegalArgumentException("Give proper phone numbers.");  
                }  
            }
            
            
            
            
            

            try
            {
                System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
            + "smssenderidparam,smsmsgparam from my_comp where comp_id='"+compid+"'");
                ResultSet rst= conn.createStatement(
                        ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
            "select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
            + "smssenderidparam,smsmsgparam from my_comp where comp_id='"+compid+"'");
                //+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
                
                if(rst.next())
                {
                    uid =rst.getString("username");
                    pwd =rst.getString("smspassword");
                    smsuseridparam =rst.getString("smsuseridparam");
                    smspasswordparam =rst.getString("smspasswordparam");
                    smsphnoparam =rst.getString("smsphnoparam");
                    smssenderidparam =rst.getString("smssenderidparam");
                    smsmsgparam =rst.getString("smsmsgparam");
                    url=rst.getString("requestUrl");
                    senderid=rst.getString("senderid");
                    
                }
                rst.close();    
            }catch(SQLException e){}

            if (numbers.size() == 0) {  
                throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
            }  
            String temp = "";  
            //progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
            //trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

            String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid+"&Optout=3001";

            System.out.println("====content====="+content);

            
            URL u = new URL(content); 
            HttpsURLConnection uc = (HttpsURLConnection) u.openConnection();
            
            
            //HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
            uc.setDoOutput(true);  
            uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
            uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
            uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
            uc.setRequestProperty("Accept", "*/*");  
            uc.setRequestProperty("Referer", url);  
            uc.setRequestMethod("POST");  
            uc.setInstanceFollowRedirects(false);  

            PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
            pw.print(content);  
            pw.flush();  
            pw.close();  
            BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

            while ((temp = br.readLine()) != null) {  
                System.out.println("==returns=="+temp);  
            }  
            
            String cookie = uc.getHeaderField("Set-Cookie");


            try {

                PreparedStatement  prest =conn.prepareStatement(
                        "Insert Into my_smsbox(sender, message, staus, msgType, userId, phone,cldocno)" +
                        " VALUES(?,?,?,?,?,?,?)");
                prest.setString(1,senderid); prest.setString(2, msg);
                prest.setInt(3,(1));prest.setInt(4,0);  
                prest.setInt(5,Integer.parseInt(userid)); 
                prest.setString(6, phone);
                prest.setInt(7, cldocno);
                prest.executeUpdate();
                
                PreparedStatement  prest1 =conn.prepareStatement(
                        "Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
                        " VALUES(?,?,now(),?,?,?,?)");
                prest1.setString(1, docno); prest1.setString(2, dtype);
                prest1.setString(3, phone); prest1.setString(4, msg);
                prest1.setString(5, brhid);
                prest1.setString(6, userid);
                prest1.executeUpdate();

            } catch (SQLException e) {e.printStackTrace(); return "fail";}


            u = null;  
            uc = null;  
            return "success";
        }
        catch(Exception e){
            e.printStackTrace();
            return "fail";
        }

    }
	public  String doSendSmsBasic(String phone,String clname,String msg,String docno,String dtype,String brhid,Connection conn) throws Exception {
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String uid="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";
		int cldocno=0;
		try{

			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;
			
			if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
				return "0";
				//throw new IllegalArgumentException("SMS message should be present."); 
				
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			
			
			

			try
			{
				System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid+"&Optout=3001";

			System.out.println("====content====="+content);

			
			URL u = new URL(content);  
			HttpsURLConnection uc = (HttpsURLConnection) u.openConnection();
            
			//HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone,cldocno)" +
						" VALUES(?,?,?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1));prest.setInt(4,0);	
				prest.setInt(5,Integer.parseInt(session.getAttribute("USERID").toString().trim())); 
				prest.setString(6, phone);
				prest.setInt(7, cldocno);
				prest.executeUpdate();
				
				PreparedStatement  prest1 =conn.prepareStatement(
						"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
						" VALUES(?,?,now(),?,?,?,?)");
				prest1.setString(1, docno); prest1.setString(2, dtype);
				prest1.setString(3, phone);	prest1.setString(4, msg);
				prest1.setString(5, session.getAttribute("BRANCHID").toString().trim());
				prest1.setString(6, session.getAttribute("USERID").toString().trim());
				prest1.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}
	public  String doSendSms() throws Exception {
		ClsConnection ClsConnection=new ClsConnection();


		Connection conn = ClsConnection.getMyConnection();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();


		String phone="",msg="",uid="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="";
		int cldocno=0;
		try{

			phone=request.getParameter("recipient").toString().trim();

			msg=request.getParameter("message").toString().trim();


			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;

			System.out.println("inside ----------------------------------------- smsm ");
			////        if ((uid == null) || (uid.length() == 0)) {  
			////            throw new IllegalArgumentException("User ID should be present.");  
			////        }  
			////  
			////        uid = URLEncoder.encode(uid, "UTF-8");  
			////  
			////        if ((pwd == null) || (pwd.length() == 0)) {  
			////            throw new IllegalArgumentException("Password should be present.");  
			////        }  
			////        pwd = URLEncoder.encode(pwd, "UTF-8");  
			////  
			////        if ((phone == null) || (phone.length() == 0)) {  
			////            throw new IllegalArgumentException("At least one phone number should be present.");  
			////        }  
			if ((msg == null) || (msg.length() == 0)) {  
				//throw new IllegalArgumentException("SMS message should be present.");  
				return "0";
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			/*try
			{
				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select  msg  from my_msgsettings where dtype='INT' and  brhid in(0)");
		
				if(rs.next())
				{
					msg =rs.getString("msg").trim().replaceAll("ref_name", "Krishnanunni").replaceAll("inv_amount","2000").replaceAll("voc_no", "10552").replaceAll("inv_date", "03-04-2016").replaceAll(" ", "%20");
					
					
				}
				rs.close();	
			}catch(SQLException e){}*/
			

			try
			{
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;

			System.out.println("====content====="+content);

			URL u = new URL(content);  
			HttpsURLConnection uc = (HttpsURLConnection) u.openConnection(); 
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream(), Charset.forName("UTF-8")));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId,phone)" +
						" VALUES(?,?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1)); prest.setInt(4,0);	
				prest.setInt(5,loginUserId); prest.setString(6, phone);
				prest.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}


	public  String doSendSms(String phone,String clname,String invamount,String invno,String invdate,String dtype,String brhid) throws Exception {

		ClsConnection ClsConnection=new ClsConnection();

		
		Connection conn = ClsConnection.getMyConnection();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();


		String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";
		int cldocno=0;
		try{

			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;

			////        if ((uid == null) || (uid.length() == 0)) {  
			////            throw new IllegalArgumentException("User ID should be present.");  
			////        }  
			////  
			////        uid = URLEncoder.encode(uid, "UTF-8");  
			////  
			////        if ((pwd == null) || (pwd.length() == 0)) {  
			////            throw new IllegalArgumentException("Password should be present.");  
			////        }  
			////        pwd = URLEncoder.encode(pwd, "UTF-8");  
			////  
			////        if ((phone == null) || (phone.length() == 0)) {  
			////            throw new IllegalArgumentException("At least one phone number should be present.");  
			////        }  
			
			
			try
			{
				String sqlmessage="";		
				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
		
				if(rs.next())
				{
					//msg =rs.getString("msg").replaceAll("ref_name", clname).replaceAll("inv_amount",invamount).replaceAll("voc_no", invno).replaceAll("inv_date", invdate).replaceAll(" ", "%20");
					
					
										
					    sqlmessage = rs.getString("msg").replaceAll("branch", brhid).replaceAll("documentno", invno).replaceAll("documenttype", dtype);
					
					    /*ResultSet rs1= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(sqlmessage);
					    */
					    
					
				}
				rs.close();	
				if(!(sqlmessage.trim().equalsIgnoreCase(""))){
						Statement stmtsmsmsg=conn.createStatement();
					    ResultSet rs1=stmtsmsmsg.executeQuery(sqlmessage);
					    System.out.println("SMS Message: "+sqlmessage);
					    while(rs1.next()) {
					    	// System.out.println(rs1.getString("msg"));
						   msg =rs1.getString("msg");
						   cldocno=rs1.getInt("cldocno");
					    }
					    System.out.println("Check Msg: "+msg);
				}
			}catch(SQLException e){e.printStackTrace();}
			
			
			
			if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
				return "0";
				//throw new IllegalArgumentException("SMS message should be present."); 
				
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			
			
			

			try
			{
				System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;

			System.out.println("====content====="+content);

			
			URL u = new URL(content);  
			HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone,cldocno)" +
						" VALUES(?,?,?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1));prest.setInt(4,0);	
				prest.setInt(5,Integer.parseInt(session.getAttribute("USERID").toString().trim())); 
				prest.setString(6, phone);
				prest.setInt(7, cldocno);
				
				prest.executeUpdate();
				
				PreparedStatement  prest1 =conn.prepareStatement(
						"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
						" VALUES(?,?,now(),?,?,?,?)");
				prest1.setString(1, invno); prest1.setString(2, dtype);
				prest1.setString(3, phone);	prest1.setString(4, msg);
				prest1.setString(5, session.getAttribute("BRANCHID").toString().trim());
				prest1.setString(6, session.getAttribute("USERID").toString().trim());
				prest1.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}

	public  String doSendSms(String phone,String clname,String invamount,String invno,String invdate,String dtype,String brhid,Connection conn) throws Exception {

		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();


		String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";
		int cldocno=0;
		try{

			Integer loginUserId=0;

			String sid=null;
			String url=null;
			String senderid=null;

			////        if ((uid == null) || (uid.length() == 0)) {  
			////            throw new IllegalArgumentException("User ID should be present.");  
			////        }  
			////  
			////        uid = URLEncoder.encode(uid, "UTF-8");  
			////  
			////        if ((pwd == null) || (pwd.length() == 0)) {  
			////            throw new IllegalArgumentException("Password should be present.");  
			////        }  
			////        pwd = URLEncoder.encode(pwd, "UTF-8");  
			////  
			////        if ((phone == null) || (phone.length() == 0)) {  
			////            throw new IllegalArgumentException("At least one phone number should be present.");  
			////        }  
			
			
			try
			{
				String sqlmessage="";		
				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
		
				if(rs.next())
				{
					//msg =rs.getString("msg").replaceAll("ref_name", clname).replaceAll("inv_amount",invamount).replaceAll("voc_no", invno).replaceAll("inv_date", invdate).replaceAll(" ", "%20");
					
					
										
					    sqlmessage = rs.getString("msg").replaceAll("branch", brhid).replaceAll("documentno", invno).replaceAll("documenttype", dtype);
					
					    /*ResultSet rs1= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(sqlmessage);
					    */
					    
					
				}
				rs.close();	
				if(!(sqlmessage.trim().equalsIgnoreCase(""))){
						Statement stmtsmsmsg=conn.createStatement();
					    ResultSet rs1=stmtsmsmsg.executeQuery(sqlmessage);
					    System.out.println("SMS Message: "+sqlmessage);
					    while(rs1.next()) {
					    	System.out.println(rs1.getString("msg"));
						   msg =rs1.getString("msg");	
						   cldocno=rs1.getInt("cldocno");
					    }
				}
			    System.out.println("Check Msg: "+msg);
			    
			}catch(SQLException e){e.printStackTrace();}
			
			
			
			if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
				return "0";
				//throw new IllegalArgumentException("SMS message should be present."); 
				
			}  
			msg = URLEncoder.encode(msg, "UTF-8");  

			Vector numbers = new Vector();  

			if (phone.indexOf(59) >= 0) {  
				String[] pharr = phone.split(";");  
				for (String t : pharr) {  
					try {  
						numbers.add(Long.valueOf(t));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}  
			} else {  
				try {  
					numbers.add(Long.valueOf(phone));  
				} catch (NumberFormatException ex) {  
					throw new IllegalArgumentException("Give proper phone numbers.");  
				}  
			}
			
			
			
			
			

			try
			{
				System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				ResultSet rst= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
			"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
			+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
				//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
				
				if(rst.next())
				{
					uid =rst.getString("username");
					pwd =rst.getString("smspassword");
					smsuseridparam =rst.getString("smsuseridparam");
					smspasswordparam =rst.getString("smspasswordparam");
					smsphnoparam =rst.getString("smsphnoparam");
					smssenderidparam =rst.getString("smssenderidparam");
					smsmsgparam =rst.getString("smsmsgparam");
					url=rst.getString("requestUrl");
					senderid=rst.getString("senderid");
					
				}
				rst.close();	
			}catch(SQLException e){}

			if (numbers.size() == 0) {  
				throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
			}  
			String temp = "";  
			//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
			//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

			String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid+"&Optout=3001";

//			System.out.println("====content====="+content);

			
			URL u = new URL(content);  
			HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
			uc.setDoOutput(true);  
			uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
			uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
			uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
			uc.setRequestProperty("Accept", "*/*");  
			uc.setRequestProperty("Referer", url);  
			uc.setRequestMethod("POST");  
			uc.setInstanceFollowRedirects(false);  

			PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
			pw.print(content);  
			pw.flush();  
			pw.close();  
			BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

			while ((temp = br.readLine()) != null) {  
				System.out.println("==returns=="+temp);  
			}  

			String cookie = uc.getHeaderField("Set-Cookie");


			try {

				PreparedStatement  prest =conn.prepareStatement(
						"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone,cldocno)" +
						" VALUES(?,?,?,?,?,?,?)");
				prest.setString(1,senderid); prest.setString(2, msg);
				prest.setInt(3,(1));prest.setInt(4,0);	
				prest.setInt(5,Integer.parseInt(session.getAttribute("USERID").toString().trim())); 
				prest.setString(6, phone);
				prest.setInt(7, cldocno);
				prest.executeUpdate();
				
				PreparedStatement  prest1 =conn.prepareStatement(
						"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
						" VALUES(?,?,now(),?,?,?,?)");
				prest1.setString(1, invno); prest1.setString(2, dtype);
				prest1.setString(3, phone);	prest1.setString(4, msg);
				prest1.setString(5, session.getAttribute("BRANCHID").toString().trim());
				prest1.setString(6, session.getAttribute("USERID").toString().trim());
				prest1.executeUpdate();

			} catch (SQLException e) {e.printStackTrace();}


			u = null;  
			uc = null;  
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

	}

	public  String doSendSmsApp(String phone,String clname,String invno,String dtype,String brhid,Connection conn) throws Exception 
	{
			String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";

			System.out.println("phone==="+phone+"==cl==="+clname);
			System.out.println("inv:"+invno);
			try{

				Integer loginUserId=0;

				String sid=null;
				String url=null;
				String senderid=null;
				try
				{
					String sqlmessage="";		
					ResultSet rs= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
			
					if(rs.next())
					{
						    sqlmessage = rs.getString("msg").replaceAll("branch", brhid).replaceAll("documentno", invno).replaceAll("documenttype", dtype);
						    System.out.println("sqlmessage"+sqlmessage);
					}
					rs.close();	
					if(!(sqlmessage.trim().equalsIgnoreCase(""))){
							Statement stmtsmsmsg=conn.createStatement();
						    ResultSet rs1=stmtsmsmsg.executeQuery("select '"+sqlmessage+"' msg");
						    System.out.println("SMS Message: "+sqlmessage);
						    while(rs1.next()) {
						    	System.out.println(rs1.getString("msg"));
							   msg =rs1.getString("msg");	
						    }
					}
				    System.out.println("Check Msg: "+msg);
				    
				}catch(SQLException e){e.printStackTrace();}
				
				
				
				if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
					return "0";
					//throw new IllegalArgumentException("SMS message should be present."); 
					
				}  
				msg = URLEncoder.encode(msg, "UTF-8");  

				Vector numbers = new Vector();  

				if (phone.indexOf(59) >= 0) {  
					String[] pharr = phone.split(";");  
					for (String t : pharr) {  
						try {  
							numbers.add(Long.valueOf(t));  
						} catch (NumberFormatException ex) {  
							throw new IllegalArgumentException("Give proper phone numbers.");  
						}  
					}  
				} else {  
					try {  
						numbers.add(Long.valueOf(phone));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}
				
				try
				{
					System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
				+ "smssenderidparam,smsmsgparam from my_comp where comp_id=1");
					ResultSet rst= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
				+ "smssenderidparam,smsmsgparam from my_comp where comp_id=1");
					//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
					
					if(rst.next())
					{
						uid =rst.getString("username");
						pwd =rst.getString("smspassword");
						smsuseridparam =rst.getString("smsuseridparam");
						smspasswordparam =rst.getString("smspasswordparam");
						smsphnoparam =rst.getString("smsphnoparam");
						smssenderidparam =rst.getString("smssenderidparam");
						smsmsgparam =rst.getString("smsmsgparam");
						url=rst.getString("requestUrl");
						senderid=rst.getString("senderid");
						
					}

					rst.close();	
				}catch(SQLException e){
					e.printStackTrace();
				}
				catch(Exception e){
					e.printStackTrace();
				}
				if (numbers.size() == 0) {  
					throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
				}  
				String temp = "";  
				//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
				//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

				//String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;
				String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;
				System.out.println("====content====="+content);

				
				URL u = new URL(content);  
				HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
				uc.setDoOutput(true);  
				uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
				uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
				uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
				uc.setRequestProperty("Accept", "*/*");  
				uc.setRequestProperty("Referer", url);  
				uc.setRequestMethod("POST");  
				uc.setInstanceFollowRedirects(false);  

				PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
				pw.print(content);  
				pw.flush();  
				pw.close();  
				BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

				while ((temp = br.readLine()) != null) {  
					System.out.println("==returns=="+temp);  
				}  

				String cookie = uc.getHeaderField("Set-Cookie");


				try {

					PreparedStatement  prest =conn.prepareStatement(
							"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone)" +
							" VALUES(?,?,?,?,?,?)");
					prest.setString(1,senderid);
					prest.setString(2, msg);
					prest.setInt(3,(1));
					prest.setInt(4,0);	
					prest.setInt(5,loginUserId); 
					prest.setString(6, phone);
					prest.executeUpdate();
					
					PreparedStatement  prest1 =conn.prepareStatement(
							"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
							" VALUES(?,?,now(),?,?,?,?)");
					prest1.setString(1, invno);
					prest1.setString(2, dtype);
					prest1.setString(3, phone);	
					prest1.setString(4, msg);
					prest1.setString(5, "1");
					prest1.setString(6, invno);
					prest1.executeUpdate();

				} catch (SQLException e) {e.printStackTrace();}


				u = null;  
				uc = null;  
				return "success";
			}
			catch(Exception e){
				e.printStackTrace();
				return "fail";
			}

		}

		public  String doSendSmsOtp(String phone,String clname,String invno,String dtype,String brhid,String otp,Connection conn) throws Exception 
	{
			String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";

			System.out.println("phone==="+phone+"==cl==="+clname);
			System.out.println("inv:"+invno);
			try{

				Integer loginUserId=0;

				String sid=null;
				String url=null;
				String senderid=null;
				try
				{
					String sqlmessage="";		
					ResultSet rs= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
			
					if(rs.next())
					{
						    sqlmessage = rs.getString("msg")+" "+otp.replaceAll("branch", brhid).replaceAll("documentno", invno).replaceAll("documenttype", dtype);
						    System.out.println("sqlmessage"+sqlmessage);
					}
					rs.close();	
					if(!(sqlmessage.trim().equalsIgnoreCase(""))){
							Statement stmtsmsmsg=conn.createStatement();
						    ResultSet rs1=stmtsmsmsg.executeQuery("select '"+sqlmessage+"' msg");
						    System.out.println("SMS Message: "+sqlmessage);
						    while(rs1.next()) {
						    	System.out.println(rs1.getString("msg"));
							   msg =rs1.getString("msg");	
						    }
					}
				    System.out.println("Check Msg: "+msg);
				    
				}catch(SQLException e){e.printStackTrace();}
				
				
				
				if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
					return "0";
					//throw new IllegalArgumentException("SMS message should be present."); 
					
				}  
				msg = URLEncoder.encode(msg, "UTF-8");  

				Vector numbers = new Vector();  

				if (phone.indexOf(59) >= 0) {  
					String[] pharr = phone.split(";");  
					for (String t : pharr) {  
						try {  
							numbers.add(Long.valueOf(t));  
						} catch (NumberFormatException ex) {  
							throw new IllegalArgumentException("Give proper phone numbers.");  
						}  
					}  
				} else {  
					try {  
						numbers.add(Long.valueOf(phone));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}
				
				try
				{
					System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
				+ "smssenderidparam,smsmsgparam from my_comp where comp_id=1");
					ResultSet rst= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
				+ "smssenderidparam,smsmsgparam from my_comp where comp_id=1");
					//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
					
					if(rst.next())
					{
						uid =rst.getString("username");
						pwd =rst.getString("smspassword");
						smsuseridparam =rst.getString("smsuseridparam");
						smspasswordparam =rst.getString("smspasswordparam");
						smsphnoparam =rst.getString("smsphnoparam");
						smssenderidparam =rst.getString("smssenderidparam");
						smsmsgparam =rst.getString("smsmsgparam");
						url=rst.getString("requestUrl");
						senderid=rst.getString("senderid");
						
					}
					
					rst.close();	
				}catch(SQLException e){
					e.printStackTrace();
				}
				catch(Exception e){
					e.printStackTrace();
				}
				if (numbers.size() == 0) {  
					throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
				}  
				String temp = "";  
				//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
				//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

				//String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;
				String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;
				System.out.println("====content====="+content);

				
				URL u = new URL(content);  
				HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
				uc.setDoOutput(true);  
				uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
				uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
				uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
				uc.setRequestProperty("Accept", "*/*");  
				uc.setRequestProperty("Referer", url);  
				uc.setRequestMethod("POST");  
				uc.setInstanceFollowRedirects(false);  

				PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
				pw.print(content);  
				pw.flush();  
				pw.close();  
				BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

				while ((temp = br.readLine()) != null) {  
					System.out.println("==returns=="+temp);  
				}  

				String cookie = uc.getHeaderField("Set-Cookie");


				try {

					PreparedStatement  prest =conn.prepareStatement(
							"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone)" +
							" VALUES(?,?,?,?,?,?)");
					prest.setString(1,senderid);
					prest.setString(2, msg);
					prest.setInt(3,(1));
					prest.setInt(4,0);	
					prest.setInt(5,loginUserId); 
					prest.setString(6, phone);
					prest.executeUpdate();
					
					PreparedStatement  prest1 =conn.prepareStatement(
							"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
							" VALUES(?,?,now(),?,?,?,?)");
					prest1.setString(1, invno);
					prest1.setString(2, dtype);
					prest1.setString(3, phone);	
					prest1.setString(4, msg);
					prest1.setString(5, "1");
					prest1.setString(6, invno);
					prest1.executeUpdate();

				} catch (SQLException e) {e.printStackTrace();}


				u = null;  
				uc = null;  
				return "success";
			}
			catch(Exception e){
				e.printStackTrace();
				return "fail";
			}

		}	

		public  String doSendSmsMain() throws Exception {
			//System.out.println("Main sms");
			ClsConnection ClsConnection=new ClsConnection();
			Connection conn = ClsConnection.getMyConnection();
			HttpServletRequest request=ServletActionContext.getRequest();
			//HttpSession session=request.getSession();
			


			String phone="",cmpid="",msg="",uid="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="";

			try{
				System.out.println("inside ----------------------------------------- "+request);
				phone=request.getParameter("recipient").toString().trim();

				msg=request.getParameter("message").toString().trim();

				cmpid=request.getParameter("cmpid").toString().trim();

				Integer loginUserId=0;

				String sid=null;
				String url=null;
				String senderid=null;

				System.out.println("inside ----------------------------------------- "+phone);
				////        if ((uid == null) || (uid.length() == 0)) {  
				////            throw new IllegalArgumentException("User ID should be present.");  
				////        }  
				////  
				////        uid = URLEncoder.encode(uid, "UTF-8");  
				////  
				////        if ((pwd == null) || (pwd.length() == 0)) {  
				////            throw new IllegalArgumentException("Password should be present.");  
				////        }  
				////        pwd = URLEncoder.encode(pwd, "UTF-8");  
				////  
				////        if ((phone == null) || (phone.length() == 0)) {  
				////            throw new IllegalArgumentException("At least one phone number should be present.");  
				////        }  
				if ((msg == null) || (msg.length() == 0)) {  
					//throw new IllegalArgumentException("SMS message should be present.");  
					return "0";
				}  
				msg = URLEncoder.encode(msg, "UTF-8");  

				Vector numbers = new Vector();  

				if (phone.indexOf(59) >= 0) {  
					String[] pharr = phone.split(";");  
					for (String t : pharr) {  
						try {  
							numbers.add(Long.valueOf(t));  
						} catch (NumberFormatException ex) {  
							throw new IllegalArgumentException("Give proper phone numbers.");  
						}  
					}  
				} else {  
					try {  
						numbers.add(Long.valueOf(phone));  
					} catch (NumberFormatException ex) {  
						throw new IllegalArgumentException("Give proper phone numbers.");  
					}  
				}
				
				
				/*try
				{
					ResultSet rs= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select  msg  from my_msgsettings where dtype='INT' and  brhid in(0)");
			
					if(rs.next())
					{
						msg =rs.getString("msg").trim().replaceAll("ref_name", "Krishnanunni").replaceAll("inv_amount","2000").replaceAll("voc_no", "10552").replaceAll("inv_date", "03-04-2016").replaceAll(" ", "%20");
						
						
					}
					rs.close();	
				}catch(SQLException e){}*/
				

				try
				{
					System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,smssenderidparam,smsmsgparam from my_comp where comp_id='"+01+"'");
					ResultSet rst= conn.createStatement(
					ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
				"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
				+ "smssenderidparam,smsmsgparam from my_comp where doc_no='1'");
					//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
					if(rst.next())
					{
						uid =rst.getString("username");
						pwd =rst.getString("smspassword");
						smsuseridparam =rst.getString("smsuseridparam");
						smspasswordparam =rst.getString("smspasswordparam");
						smsphnoparam =rst.getString("smsphnoparam");
						smssenderidparam =rst.getString("smssenderidparam");
						smsmsgparam =rst.getString("smsmsgparam");
						url=rst.getString("requestUrl");
						senderid=rst.getString("senderid");
						
					}
					rst.close();	
				}catch(SQLException e){}

				if (numbers.size() == 0) {  
					throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
				}  
				String temp = "";  
				//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
				//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

				String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid;

				System.out.println("====content====="+content);

				URL u = new URL(content);  
				HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
				uc.setDoOutput(true);  
				uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
				uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
				uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
				uc.setRequestProperty("Accept", "*/*");  
				uc.setRequestProperty("Referer", url);  
				uc.setRequestMethod("POST");  
				uc.setInstanceFollowRedirects(false);  

				PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
				pw.print(content);  
				pw.flush();  
				pw.close();  
				BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream(), Charset.forName("UTF-8")));  

				while ((temp = br.readLine()) != null) {  
					System.out.println("==returns=="+temp);  
				}  

				String cookie = uc.getHeaderField("Set-Cookie");


				try {

					PreparedStatement  prest =conn.prepareStatement(
							"Insert Into my_smsbox(sender, message, staus, msgType, userId,phone)" +
							" VALUES(?,?,?,?,?,?)");
					prest.setString(1,senderid); prest.setString(2, msg);
					prest.setInt(3,(1)); prest.setInt(4,0);	
					prest.setInt(5,loginUserId); prest.setString(6, phone);
					prest.executeUpdate();

				} catch (SQLException e) {e.printStackTrace();}


				u = null;  
				uc = null;  
				return "success";
			}
			catch(Exception e){
				e.printStackTrace();
				return "fail";
			}

		}

		public  String doSendSms(HttpSession session,String phone,String clname,String cldoc,String invamount,String invno,String invdate,String dtype,String brhid,Connection conn) throws Exception {
			System.out.println("in do......cldoc"+cldoc);     
			System.out.println("in do......dtype"+dtype);   
			/*	HttpServletRequest request=ServletActionContext.getRequest();  
				HttpSession session=request.getSession();*/
			    

				String uid="",msg="",pwd="",smsuseridparam="",smspasswordparam="",smsphnoparam="",smssenderidparam="",smsmsgparam="",ret="";

				try{

					Integer loginUserId=0;    
					String sid=null;
					String url=null;
					String senderid=null;    
					
					try
					{
						String sqlmessage="";		
						ResultSet rs= conn.createStatement(
								ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select  msg  from my_msgsettings where dtype='"+dtype+"' and  brhid in("+brhid+",0) and status=3");
				                    
						if(rs.next())       
						{
												
							    sqlmessage = rs.getString("msg").replaceAll("documentno", invno).replaceAll("documenttype", dtype).replaceAll("cldocno1", cldoc);
							
						}
						rs.close();	
						if(!(sqlmessage.trim().equalsIgnoreCase(""))){
								Statement stmtsmsmsg=conn.createStatement();
							    ResultSet rs1=stmtsmsmsg.executeQuery(sqlmessage);
							    System.out.println("SMS Message: "+sqlmessage);
							    while(rs1.next()) {
							    	System.out.println(rs1.getString("msg"));
								   msg =rs1.getString("msg");	
							    }
						}
					    System.out.println("Check Msg: "+msg);
					    
					}catch(SQLException e)
					{e.printStackTrace();
					}
					
					
					
					if ((msg == null) || (msg.equalsIgnoreCase("")) || (msg.length() == 0)) {  
						return "0";
						//throw new IllegalArgumentException("SMS message should be present."); 
						
					}  
					msg = URLEncoder.encode(msg, "UTF-8");  

					Vector numbers = new Vector();  

					if (phone.indexOf(59) >= 0) {  
						String[] pharr = phone.split(";");  
						for (String t : pharr) {  
							try {  
								numbers.add(Long.valueOf(t));  
							} catch (NumberFormatException ex) {  
								throw new IllegalArgumentException("Give proper phone numbers.");  
							}  
						}  
					} else {  
						try {  
							numbers.add(Long.valueOf(phone));  
						} catch (NumberFormatException ex) {  
							throw new IllegalArgumentException("Give proper phone numbers.");  
						}  
					}
					
					
					
					
					

					try
					{
						System.out.println("select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
					+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
						ResultSet rst= conn.createStatement(
								ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select smscno, username, smspassword, requestUrl,senderid,smsuseridparam,smspasswordparam,smsphnoparam,"
					+ "smssenderidparam,smsmsgparam from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'");
						//+" where doc_no='"+MyApp.xuser.getCmpId()+"'");
						
						if(rst.next())
						{
							uid =rst.getString("username");
							pwd =rst.getString("smspassword");
							smsuseridparam =rst.getString("smsuseridparam");
							smspasswordparam =rst.getString("smspasswordparam");
							smsphnoparam =rst.getString("smsphnoparam");
							smssenderidparam =rst.getString("smssenderidparam");
							smsmsgparam =rst.getString("smsmsgparam");
							url=rst.getString("requestUrl");
							senderid=rst.getString("senderid");
							
						}
						rst.close();	
					}catch(SQLException e){}

					if (numbers.size() == 0) {  
						throw new IllegalArgumentException("At least one proper phone number should be present to send SMS.");  
					}  
					String temp = "";  
					//progress--->>>http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=progresscars&passwd=23850743&mobilenumber=971561189339&message=testing&sid=ProgressCar&mtype=N&DR=Y
					//trust-->>>http://mshastra.com/sendurlcomma.aspx?user=20077207&pwd=nz2xbu&senderid=TrustRent&mobileno=971561189339&msgtext=Hello%20Optout%203001&smstype=0/4/3

					String content =url+smsuseridparam+"="+uid+"&"+smspasswordparam+"="+pwd+"&"+smsphnoparam+"="+phone+"&"+smsmsgparam+"="+msg+"&"+smssenderidparam+"="+senderid+"&Optout=3001";

					System.out.println("====content====="+content);

					
					URL u = new URL(content);  
					HttpURLConnection uc = (HttpURLConnection) u.openConnection();  
					uc.setDoOutput(true);  
					uc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
					uc.setRequestProperty("Content-Length", String.valueOf(content.length()));  
					uc.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");  
					uc.setRequestProperty("Accept", "*/*");  
					uc.setRequestProperty("Referer", url);  
					uc.setRequestMethod("POST");  
					uc.setInstanceFollowRedirects(false);  

					PrintWriter pw = new PrintWriter(new OutputStreamWriter(uc.getOutputStream()), true);  
					pw.print(content);  
					pw.flush();  
					pw.close();  
					BufferedReader br = new BufferedReader(new InputStreamReader(uc.getInputStream()));  

					while ((temp = br.readLine()) != null) {  
						System.out.println("==returns=="+temp);  
					}  

					String cookie = uc.getHeaderField("Set-Cookie");


					try {

						PreparedStatement  prest =conn.prepareStatement(
								"Insert Into my_smsbox(sender, message, staus, msgType, userId, phone,cldocno)" +
								" VALUES(?,?,?,?,?,?,?)");
						prest.setString(1,senderid); prest.setString(2, msg);
						prest.setInt(3,(1));prest.setInt(4,0);	
						prest.setInt(5,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
						prest.setString(6, phone);
						prest.setString(7, cldoc);
						prest.executeUpdate();
						
						PreparedStatement  prest1 =conn.prepareStatement(
								"Insert Into smslog(doc_no, dtype, edate, mobileNo, message, brhId, userId)" +
								" VALUES(?,?,now(),?,?,?,?)");
						prest1.setString(1, invno); prest1.setString(2, dtype);
						prest1.setString(3, phone);	prest1.setString(4, msg);
						prest1.setString(5, session.getAttribute("BRANCHID").toString().trim());
						prest1.setString(6, session.getAttribute("USERID").toString().trim());
						prest1.executeUpdate();

					} catch (SQLException e) {e.printStackTrace();}


					u = null;  
					uc = null;  
					return "success";
				}
				catch(Exception e){
					e.printStackTrace();
					return "fail";
				}

			}

}
