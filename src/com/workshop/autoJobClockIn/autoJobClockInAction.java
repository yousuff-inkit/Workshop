package com.workshop.autoJobClockIn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.TimerTask;
import java.util.logging.Logger;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class autoJobClockInAction extends TimerTask {

	private static final Logger log = Logger.getLogger( autoJobClockInAction.class.getName() );

	private static final String JAVASCRIPT_SRC = 
			" var impl = { " +
					"     run: function() { " +
					"         println ('Hello, World!'); " +
					"     } " +
					" }; ";
	
	ClsConnection connobj=new  ClsConnection();
	ClsCommon com= new ClsCommon();
	
	@Override
	public void run() {
		
		Connection conn = connobj.getMyConnection();
		String result="";
			
		try{
			Statement stmt = conn.createStatement();
			conn.setAutoCommit(false);
			String autoclosetime="";
			String strgetautoclockintime="select method ,description from gl_config where field_nme='autoJobClockInTime'";
			ResultSet rsgetautoclockintime=stmt.executeQuery(strgetautoclockintime);
			while(rsgetautoclockintime.next()){
				autoclosetime=rsgetautoclockintime.getString("description");
			}
			String strupdate="update ws_clockin set closedate=CURDATE(),closetime='"+autoclosetime+"' where closedate is null";
			int update=stmt.executeUpdate(strupdate);
			if(update>0){
				conn.commit();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result="fail";
			}
		}
		result="success";
		
	}
}
