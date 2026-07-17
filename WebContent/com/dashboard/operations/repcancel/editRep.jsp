<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	String repno=request.getParameter("repno")==null?"":request.getParameter("repno");
	String canceldate=request.getParameter("canceldate")==null?"":request.getParameter("canceldate");
	String canceltime=request.getParameter("canceltime")==null?"":request.getParameter("canceltime");
	String cancelkm=request.getParameter("cancelkm")==null?"":request.getParameter("cancelkm");
	String cancelfuel=request.getParameter("cancelfuel")==null?"":request.getParameter("cancelfuel");
	String fleetno=request.getParameter("fleet_no")==null?"":request.getParameter("fleet_no");
 	
	Connection conn = null;
 	try{
 		java.sql.Date sqlcanceldate=null;
 		java.sql.Date lastdate=null;
 		String lasttime="";
 		int status=0;
 		double lastkm=0.0,lastfuel=0.0;
 		if(!canceldate.equalsIgnoreCase("")){
 			sqlcanceldate=ClsCommon.changeStringtoSqlDate(canceldate);
 		}
 		
 		conn=ClsConnection.getMyConnection();
 		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		
		ResultSet rslast=stmt.executeQuery("select dout,tout,kmout,fout from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")");
		while(rslast.next()){
			lastdate=rslast.getDate("dout");
			lasttime=rslast.getString("tout");
			lastkm=rslast.getDouble("kmout");
			lastfuel=rslast.getDouble("fout");
		}
		if(!canceldate.equalsIgnoreCase("")){
			if(sqlcanceldate.compareTo(lastdate)<0){
				status=1;
			}	
		}
		if(!canceltime.equalsIgnoreCase("") && !canceldate.equalsIgnoreCase("")){
			if(sqlcanceldate.compareTo(lastdate)==0){
				String canceltimearray[]=canceltime.split(":");
				int cancelhour=Integer.parseInt(canceltimearray[0]);
				int cancelminute=Integer.parseInt(canceltimearray[1]);
				String lasttimearray[]=lasttime.split(":");
				int lasthour=Integer.parseInt(lasttimearray[0]);
				int lastminute=Integer.parseInt(lasttimearray[1]);
				
				if(cancelhour<lasthour){
					status=2;
				}
				else if(cancelhour==lasthour){
					if(cancelminute<lastminute){
						status=2;	
					}
				}
			}
			
		}
		if(!cancelkm.equalsIgnoreCase("")){
			if(Double.parseDouble(cancelkm)<lastkm){
				status=3;
			}
			
		}
		String sqltest="";
		if(status==0){
			if(!canceldate.equalsIgnoreCase("")){
				sqltest+=" odate='"+sqlcanceldate+"'";
			}
			if(!canceltime.equalsIgnoreCase("")){
				if(!sqltest.equalsIgnoreCase("")){
					sqltest+=" ,otime='"+canceltime+"'";
				}
				else{
					sqltest+=" otime='"+canceltime+"'";
				}
			}
			if(!cancelkm.equalsIgnoreCase("")){
				if(!sqltest.equalsIgnoreCase("")){
					sqltest+=" ,okm="+cancelkm+"";
				}
				else{
					sqltest+=" okm="+cancelkm+"";
				}
			}
			if(!cancelfuel.equalsIgnoreCase("")){
				if(!sqltest.equalsIgnoreCase("")){
					sqltest+=" ,ofuel="+cancelfuel+"";
				}
				else{
					sqltest+=" ofuel="+cancelfuel+"";
				}
			}
			
			if(!sqltest.equalsIgnoreCase("")){
				String strsql="update gl_vehreplace set "+sqltest+" where doc_no="+repno;
				System.out.println(strsql);
				int val=stmt.executeUpdate(strsql);
				if(val>0){
					conn.commit();
					status=5;
				}
				else{
					status=-1;
				}	
			}
			
		}
		else{
			stmt.close();		
		}

		response.getWriter().print(status);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
	%>
