package com.sms;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.TimerTask;
import java.util.logging.Logger;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.workshop.autoJobClockIn.autoJobClockInAction;

public class ClsAutoSMSAction extends TimerTask {

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
		SmsAction smsaction=new SmsAction();
		try{
		    System.out.println("Inside Auto SMS");
			Statement stmt = conn.createStatement();
			String gatedocno="",brhid="",clientname="",mobile="",cmpid="";
			String strgetclient="SELECT cmp.doc_no cmpid,gate.doc_no gatedocno,gate.brhid,COALESCE(ac.refname,gate.username) clientname,COALESCE(IF(ac.per_mob='',gate.mobile,ac.per_mob),gate.mobile) mobile FROM ws_gateinpass gate LEFT JOIN my_Acbook ac ON gate.cldocno=ac.cldocno AND ac.dtype='CRM' left join my_brch br on gate.brhid=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no WHERE gate.outdate IS NOT NULL AND DATE_ADD(gate.outdate,INTERVAL 7 DAY)=CURDATE() AND gate.feedbacksms=0";
			// String strgetclient="SELECT cmp.doc_no cmpid,gate.doc_no gatedocno,gate.brhid,COALESCE(ac.refname,gate.username) clientname,COALESCE(IF(ac.per_mob='',gate.mobile,ac.per_mob),gate.mobile) mobile FROM ws_gateinpass gate LEFT JOIN my_Acbook ac ON gate.cldocno=ac.cldocno AND ac.dtype='CRM' left join my_brch br on gate.brhid=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no WHERE gate.outdate IS NOT NULL AND DATE_ADD(gate.outdate,INTERVAL 10 DAY)=CURDATE() AND gate.feedbacksms=0 limit 1";
			System.out.println(strgetclient);
			ResultSet rsgetclient=stmt.executeQuery(strgetclient);
			JSONArray clientarray=new JSONArray();
			while(rsgetclient.next()) {
			    JSONObject objdata=new JSONObject();
				gatedocno=rsgetclient.getString("gatedocno");
				brhid=rsgetclient.getString("brhid");
				clientname=rsgetclient.getString("clientname");
				mobile=rsgetclient.getString("mobile");
				cmpid=rsgetclient.getString("cmpid");
				objdata.put("gatedocno",gatedocno);
				objdata.put("brhid",brhid);
				objdata.put("clientname",clientname);
				objdata.put("mobile",mobile);
				objdata.put("cmpid",cmpid);
				clientarray.add(objdata);
			}
			conn.close();	
		
			for(int i=0;i<clientarray.size();i++){
			    JSONObject objdata=clientarray.getJSONObject(i);
			    conn=connobj.getMyConnection();
			    conn.setAutoCommit(false);
			    int errorstatus=0;
	            String strgetmsg="select msg from my_msgsettings where dtype='GOP' and status=3 and brhid="+objdata.getString("brhid");
                System.out.println(strgetmsg);
                ResultSet rsmsg=conn.createStatement().executeQuery(strgetmsg);
                String msg="";
                while(rsmsg.next()) {
                    msg=rsmsg.getString("msg");
                }
                msg=msg.replace("documentno",objdata.getString("gatedocno"));
                
                ResultSet rsmessage=conn.createStatement().executeQuery(msg);
                String message="";
                while(rsmessage.next()) {
                    message=rsmessage.getString("msg");
                }
                
                String smsstatus=smsaction.doSendSmsBasicAuto(objdata.getString("mobile"), objdata.getString("clientname"), message, objdata.getString("gatedocno"), "GOP", objdata.getString("brhid"), conn,objdata.getString("cmpid"),"-1");
                if(smsstatus.equalsIgnoreCase("success")) {
                    String strupdate="update ws_gateinpass set feedbacksms=1 where doc_no="+objdata.getString("gatedocno");
                    int update=stmt.executeUpdate(strupdate);
                    if(update<=0) {
                    	errorstatus=1;
                    }
                }
                if(smsstatus.equalsIgnoreCase("success") && errorstatus==0) {
                	conn.commit();
                }
                
                conn.close();
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
