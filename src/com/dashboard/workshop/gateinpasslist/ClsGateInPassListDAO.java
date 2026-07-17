package com.dashboard.workshop.gateinpasslist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsGateInPassListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	
	public  JSONArray masterdetails(String fromdate,String todate,String check,String load,String client) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";String sqltest1="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
       // System.out.println("client---------------"+client);
       
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
    	if(!(client.equalsIgnoreCase("0") || client.equalsIgnoreCase("") || client.equalsIgnoreCase("undefined"))){
			sqltest1+="and ws.cldocno="+client+"";
        }
    	//System.out.println("load1------------------"+load);
        if(!(load.equalsIgnoreCase("undefined") || load.equalsIgnoreCase("") || load.equalsIgnoreCase("null") || load.equalsIgnoreCase("0")))
     	{
        	//System.out.println("load2------------------"+load);
        	if(load.equalsIgnoreCase("open")){
     		sqltest+="and ws.processstatus<8";
        	}else if(load.equalsIgnoreCase("close")){
        	sqltest+="and ws.processstatus=8";	
        	}
     	}
     		
     	
     	 
     	
		try {
				 conn = objconn.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				  System.out.println("-----code------");
			
			String sql="select  df.name srvpkg,dy.sal_name rfrby,ds.sal_name inssrvor,es.sal_name srvadvsr,ms.sal_name estimator,bc.refname insurcmpny,ws.doc_no doc_no,ws.voc_no voc_no,ws.doc_no gateinpassdoc,ws.date,ws.estdeltime time,gr.name reptype, ws.regno, ws.pltid pcode,vb.brand_name brand,vm.vtype model,datediff( CURRENT_TIMESTAMP, ws.DATE) gipdate,"
					+ "  ws.estdeldate expdelivery, ws.estdeltime dtime,ws.desc1 description,ws.username,ws.mobile, "
					+ " ur.user_name estimtdby,uw.user_name gipuser,e.date estdate,e.doc_no estimationno,e.voc_no estimationvocno,j.doc_no jobno,j.voc_no jobvocno,j.date jdate,us.user_name user,ac.refname customer, "
					+ "  ws.processstatus,if(((ep.rdocno is null) and (el.rdocno is null)) ,'approved','notapproved') approval,if(j.complete=1,'Completed','Not Completed') jstatus from ws_gateinpass ws"
					+ " left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid "
					+ " left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no "
					+ " left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP')) "
					+ " left join my_user ur on ur.doc_no=e.userid"
					+ " left join my_user us on us.doc_no=j.userid"
					+ " left join my_user uw on uw.doc_no=ws.userid"
					+ " left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='CRM' "
					+ " left join my_acbook bc on bc.cldocno=ws.insurcldocno and bc.dtype='CRM' "
					+ " left join my_salesman ms on ms.doc_no=ws.marketingperson and ms.sal_type='WMP'"
					+ " left join my_salesman es on es.doc_no=ws.serviceadvisor and es.sal_type='WSA'"
					+ " left join my_salesman ds on ds.doc_no=ws.insurancesurvivor and ds.sal_type='WIS'"
					+ " left join my_salesman dy on dy.doc_no=ws.referencedby and dy.sal_type='WRB'"
					+ " left join ws_servicepackage df on df.doc_no=ws.servicepackage and df.status=3"
					+ " left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on e.doc_no=ep.rdocno"
					+ " left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el on e.doc_no=el.rdocno where ws.date>='"+sqlfromdate+"' and ws.date<='"+sqltodate+"' "+sqltest1+" "+sqltest+"";
			System.out.println("-----gatelist----detail--"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
     	
		//System.out.println(RESULTDATA);
        return RESULTDATA;
     	
    }
	
	 public JSONArray clientdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = objconn.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' and pcase=0 ";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=objcommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        finally{
	        	conn.close();
	        }
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	 public  JSONArray getdet(String fromdate,String todate,String check,String datetype,String client,String txttype,String load,String cmbcategory) throws SQLException {
		 JSONArray data=new JSONArray();
		 
	     if(!(check.equalsIgnoreCase("1"))){
	    	 return data;
	     }
	     Connection conn = null;
	     try {
	    	 conn = objconn.getMyConnection();
	    	 Statement stmt = conn.createStatement();
	    	 java.sql.Date sqlfromdate=null,sqltodate=null;
	    	 String sqltest1="",sqltest="",sqltest2="";
	    	 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	    		 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	      	 }
	         if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	      	{
	      		sqltodate=objcommon.changeStringtoSqlDate(todate);
	      		
	      	}
	     	if(!(client.equalsIgnoreCase("0") || client.equalsIgnoreCase("") || client.equalsIgnoreCase("undefined"))){
	 			sqltest1+="and gate.cldocno="+client+"";
	 		
	         }
	     	 if(!(cmbcategory.equalsIgnoreCase("0") || cmbcategory.equalsIgnoreCase("") || cmbcategory.equalsIgnoreCase("undefined"))){
	                sqltest2+="and ac.catid="+cmbcategory+"";
	             }
	     	 if(!(datetype.equalsIgnoreCase("undefined") || datetype.equalsIgnoreCase("") || datetype.equalsIgnoreCase("null") || datetype.equalsIgnoreCase("0")))
	         {
	        
	     	if(datetype.equalsIgnoreCase("GIP")) {
	     	    sqltest+=" and gate.date>='"+sqlfromdate+"' and gate.date<='"+sqltodate+"'";
	     	}
	     	else if(datetype.equalsIgnoreCase("EST")) {
	     	   sqltest+=" and est.date>='"+sqlfromdate+"' and est.date<='"+sqltodate+"'";
	             
            }
	     	else if(datetype.equalsIgnoreCase("JC")) {
	     	   sqltest+=" and job.date>='"+sqlfromdate+"' and job.date<='"+sqltodate+"'";
	              
            }
	     	else if(datetype.equalsIgnoreCase("JCC")) {
	               sqltest+=" and jcc.date>='"+sqlfromdate+"' and jcc.date<='"+sqltodate+"'";
	                  
	            }
	     	else if(datetype.equalsIgnoreCase("INV")) {
	     	   sqltest+=" and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"'";
	              
            }
	     }
            
	     	//System.out.println("load1------------------"+load);
          
	     	 
             if(!(load.equalsIgnoreCase("undefined") || load.equalsIgnoreCase("") ||
              load.equalsIgnoreCase("null") || load.equalsIgnoreCase("0")))
              {
             //System.out.println("load2------------------"+load);
             if(load.equalsIgnoreCase("open")){
             sqltest+="and gate.processstatus<8";
             } else if(load.equalsIgnoreCase("close")){
              sqltest+="and gate.processstatus=8";
              }
              }
           
	             
	         String strsql="select a.*,@i:=@i+1 srno from(select concat(coalesce(est.claimno,''),' , ',coalesce(estadd.claimno,'')) estclaimno,date(jcc.date) jobcompletedate,invsum.mininvdate,gate.outdate,gate.outtime,invsum.invall invvocnoall,invsum.invtaxtotal,delbaymov.indate delindate,"+
			" flr.extdate, job.promdate promisedate,coalesce(spare.sparetotal,0.0) sparetotal,coalesce(labour.labourtotal,0.0) labourtotal,"+
    		 " coalesce(spare.sparetotal,0.0)+coalesce(labour.labourtotal,0.0) esttotal,convert(if(estadd.estaddition is not null,"+
    		 " concat(est.voc_no,'-', estadd.estaddition),est.voc_no),char(25)) estall,est.date estdate,"+
    		 " convert(coalesce(yom.yom,''),char(10)) yom,coalesce(clr.color,'') color,df.name srvpkg, dy.sal_name rfrby,ds.sal_name inssrvor,"+
    		 " es.sal_name srvadvsr,ms.sal_name estimator,bc.refname insurcmpny,cl.category clcat, gate.doc_no doc_no,gate.voc_no voc_no,gate.doc_no gateinpassdoc,"+
    		 " gate.date,date_format(datalog.edate,'%H:%i') time,repair.name reptype, gate.regno,  gate.pltid pcode,brd.brand_name brand,model.vtype model,"+
    		 " datediff( CURRENT_TIMESTAMP, gate.DATE) gipdate,gate.estdeldate expdelivery,  gate.estdeltime dtime,gate.desc1 description,"+
    		 " gate.username,gate.mobile,  ur.user_name estimtdby,uw.user_name gipuser,est.doc_no estimationno,est.voc_no"+
    		 " estimationvocno,job.doc_no jobno,job.voc_no jobvocno,job.date jdate,us.user_name user, coalesce(ac.refname,gate.clientname) customer,gate.processstatus,"+
    		 " if(((ep.rdocno is null) and (el.rdocno is null)) ,'approved','notapproved') approval,"+
    		 " if(job.complete=1,'Completed','Not Completed') jstatus from ws_gateinpass gate left join ws_gartype repair on"+
    		 " repair.row_no=gate.repairtype left join gl_vehbrand brd on brd.doc_no=gate.brdid left join gl_vehmodel model on"+
    		 " model.doc_no=gate.modid left join ws_estm est on est.gipno=gate.doc_no  left join ws_jobcard job on (est.doc_no=job.refno and"+
    		 " reftype='EST') left join ws_invm inv on (inv.refno=job.doc_no and inv.reftype='JC') left join my_user ur on ur.doc_no=est.userid left join my_user us"+
    		 " on us.doc_no=job.userid left join my_user uw on uw.doc_no=gate.userid left join my_acbook ac on ac.cldocno=gate.cldocno and"+
    		 " ac.dtype='CRM'  left join my_acbook bc on bc.cldocno=gate.insurcldocno and bc.dtype='CRM' left join my_clcatm cl on cl.doc_no=ac.catid\r\n"
    		 + "  left join my_salesman ms on"+
    		 " ms.doc_no=gate.marketingperson and ms.sal_type='WMP' left join my_salesman es on es.doc_no=gate.serviceadvisor and"+
    		 " es.sal_type='WSA' left join my_salesman ds on ds.doc_no=gate.insurancesurvivor and ds.sal_type='WIS' left join my_salesman dy"+
    		 " on dy.doc_no=gate.referencedby and dy.sal_type='WRB' left join ws_servicepackage df on df.doc_no=gate.servicepackage and"+
    		 " df.status=3 left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on"+
    		 " est.doc_no=ep.rdocno left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el"+
    		 " on est.doc_no=el.rdocno left join my_color clr on gate.colorid=clr.doc_no left join gl_yom yom on gate.yom=yom.doc_no left"+
    		 " join (select convert(group_concat(addition,'-'),char(25)) estaddition,jobcarddocno jobdocno,group_concat(distinct coalesce(claimno,''),',') claimno from ws_estmadd where status=3"+
    		 " group by jobcarddocno,addition) estadd on job.doc_no=estadd.jobdocno left join (select sum(approvedvalue) sparetotal,rdocno"+
    		 " from  ws_estspare where confirmed=1 and approved=1 group by rdocno) spare on (est.doc_no=spare.rdocno) left join"+
    		 " (select sum(total)  labourtotal,rdocno from  ws_estlabour  where confirmed=1 and approved=1 group by rdocno) labour on"+
    		 " (est.doc_no=labour.rdocno) left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno left join (select jobcarddocno jobdocno,"+
    		 " indate from ws_baymove where  bayid=12 group by jobcarddocno) delbaymov on flr.jobdocno=delbaymov.jobdocno left join"+
    		 " (select min(date) mininvdate,convert(group_concat(voc_no,'-'), char(25)) invall,sum(taxtotal) invtaxtotal,refno,reftype from"+
    		 " ws_invm where status=3 and reftype='JC' group by refno)  invsum on job.doc_no=invsum.refno left join ws_jobcardcomp jcc on"+
    		 " job.doc_no=jcc.jobcardno  left join datalog datalog on (gate.doc_no=datalog.doc_no and datalog.dtype='GIP' and datalog.entry='A') where 1=1 "+sqltest1+" "+sqltest+" "+sqltest2+" group by gate.doc_no)a,(select @i:=0)c";
			System.out.println("load1=========="+strsql);
	         ResultSet rs=stmt.executeQuery(strsql);
	         data=objcommon.convertToJSON(rs);
	     }
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
	        return data;
	     	
	    }
	 
	 
	 public  JSONArray getsum(String fromdate,String todate,String check,String datetype,String client,String txttype,String load,String cmbcategory) throws SQLException {
         JSONArray data=new JSONArray();
         
         if(!(check.equalsIgnoreCase("1"))){
             return data;
         }
         Connection conn = null;
         try {
             conn = objconn.getMyConnection();
             Statement stmt = conn.createStatement();
             java.sql.Date sqlfromdate=null,sqltodate=null;
              String sqltest1="",sqltest="",sqltest2="";
             if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
                 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
             }
             if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
            {
                sqltodate=objcommon.changeStringtoSqlDate(todate);
                
            }
            if(!(client.equalsIgnoreCase("0") || client.equalsIgnoreCase("") || client.equalsIgnoreCase("undefined"))){
                sqltest1+="and gate.cldocno="+client+"";
             }
            if(!(cmbcategory.equalsIgnoreCase("0") || cmbcategory.equalsIgnoreCase("") || cmbcategory.equalsIgnoreCase("undefined"))){
                sqltest2+="and ac.catid="+cmbcategory+"";
             }
            if(!(datetype.equalsIgnoreCase("undefined") || datetype.equalsIgnoreCase("") || datetype.equalsIgnoreCase("null") || datetype.equalsIgnoreCase("0")))
            {
           
           if(datetype.equalsIgnoreCase("GIP")) {
               sqltest+=" and gate.date>='"+sqlfromdate+"' and gate.date<='"+sqltodate+"'";
           }
           else if(datetype.equalsIgnoreCase("EST")) {
              sqltest+=" and est.date>='"+sqlfromdate+"' and est.date<='"+sqltodate+"'";
                
           }
           else if(datetype.equalsIgnoreCase("JC")) {
              sqltest+=" and job.date>='"+sqlfromdate+"' and job.date<='"+sqltodate+"'";
                 
           }
           else if(datetype.equalsIgnoreCase("JCC")) {
                  sqltest+=" and jcc.date>='"+sqlfromdate+"' and jcc.date<='"+sqltodate+"'";
                     
               }
           else if(datetype.equalsIgnoreCase("INV")) {
              sqltest+=" and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"'";
                 
           }
        }
        
           
           System.out.println("load1------------------"+load);
             if(!(load.equalsIgnoreCase("undefined") || load.equalsIgnoreCase("") || load.equalsIgnoreCase("null") || load.equalsIgnoreCase("0")))
             {
                //System.out.println("load2------------------"+load);
                if(load.equalsIgnoreCase("open")){
                sqltest+="and gate.processstatus<8";
                } else if(load.equalsIgnoreCase("close")){
                     sqltest+="and gate.processstatus=8";    
                }
             }
             sqltest+=" and gate.date>='"+sqlfromdate+"' and gate.date<='"+sqltodate+"'";
            
             
             String strsql="select a.*,@i:=@i+1 srno from(SELECT  gate.cldocno docno, est.doc_no estimation,ac.refname client,COALESCE(ep.amt,0.0)+COALESCE(el.amt,0.0) estamt,COALESCE(inv.taxtotal,0.0) invamt FROM ws_gateinpass gate\r\n"
                     + "LEFT JOIN my_acbook ac ON ac.cldocno=gate.cldocno AND ac.dtype='CRM' left join my_clcatm cl on cl.doc_no=ac.catid \r\n"
                     + "LEFT JOIN ws_estm est ON est.gipno=gate.doc_no\r\n"
                     + "LEFT JOIN (SELECT ep.rdocno,SUM(ep.spnetamount) amt FROM  ws_estspare ep WHERE ep.approved=1 GROUP BY ep.rdocno) ep \r\n"
                     + "ON est.doc_no=ep.rdocno \r\n"
                     + "LEFT JOIN (SELECT ep.rdocno,SUM(ep.jobnetamount) amt FROM  ws_estlabour ep WHERE ep.approved=1 GROUP BY ep.rdocno) el\r\n"
                     + "ON est.doc_no=el.rdocno \r\n"
                     + "LEFT JOIN ws_jobcard job ON est.doc_no=job.refno AND job.reftype='EST' left join ws_jobcardcomp jcc on jcc.jobcardno=job.doc_no \r\n"
                     + "LEFT JOIN ws_invm inv ON job.doc_no=inv.refno AND inv.reftype='JC' where gate.status=3 "+sqltest+" "+sqltest1+" "+sqltest2+" GROUP BY ac.cldocno)a,(select @i:=0)c \r\n"
                     + "\r\n"
                     + "";
            System.out.println("load2========="+strsql);
             ResultSet rs=stmt.executeQuery(strsql);
             data=objcommon.convertToJSON(rs);
         }
            catch(Exception e){
                e.printStackTrace();
                conn.close();
            }
            finally{
                conn.close();
            }
            return data;
            
        }
    
	 
	 
	 public  JSONArray getDataForFancyExcel(String fromdate,String todate,String check,String load,String client,String datetype,String cmbcategory) throws SQLException {
		 JSONArray data=new JSONArray();
	     if(!(check.equalsIgnoreCase("1"))){
	    	 return data;
	     }
	     Connection conn = null;
	     try {
	    	 conn = objconn.getMyConnection();
	    	 Statement stmt = conn.createStatement();
	    	 java.sql.Date sqlfromdate=null,sqltodate=null;
	    	 String sqltest1="",sqltest="",sqltest2="";
	    	 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	    		 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	      	 }
	         if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	      	{
	      		sqltodate=objcommon.changeStringtoSqlDate(todate);
	      		
	      	}
	         if(!(client.equalsIgnoreCase("0") || client.equalsIgnoreCase("") || client.equalsIgnoreCase("undefined"))){
	                sqltest1+="and gate.cldocno="+client+"";
	             }
	         if(!(cmbcategory.equalsIgnoreCase("0") || cmbcategory.equalsIgnoreCase("") || cmbcategory.equalsIgnoreCase("undefined"))){
	                sqltest2+="and ac.catid="+cmbcategory+"";
	             }//System.out.println("load1------------------"+load);
	        
	         if(!(datetype.equalsIgnoreCase("undefined") || datetype.equalsIgnoreCase("") || datetype.equalsIgnoreCase("null") || datetype.equalsIgnoreCase("0")))
             {
            
            if(datetype.equalsIgnoreCase("GIP")) {
                sqltest+=" and gate.date>='"+sqlfromdate+"' and gate.date<='"+sqltodate+"'";
            }
            else if(datetype.equalsIgnoreCase("EST")) {
               sqltest+=" and est.date>='"+sqlfromdate+"' and est.date<='"+sqltodate+"'";
                 
            }
            else if(datetype.equalsIgnoreCase("JC")) {
               sqltest+=" and job.date>='"+sqlfromdate+"' and job.date<='"+sqltodate+"'";
                  
            }
            else if(datetype.equalsIgnoreCase("JCC")) {
                   sqltest+=" and jcc.date>='"+sqlfromdate+"' and jcc.date<='"+sqltodate+"'";
                      
                }
            else if(datetype.equalsIgnoreCase("INV")) {
               sqltest+=" and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"'";
                  
            }
         }
         
	     	
	     	if(!(load.equalsIgnoreCase("undefined") || load.equalsIgnoreCase("") || load.equalsIgnoreCase("null") || load.equalsIgnoreCase("0")))
	      	 {
	         	//System.out.println("load2------------------"+load);
	         	if(load.equalsIgnoreCase("open")){
	      		sqltest+="and gate.processstatus<8";
	         	}else{
	         	sqltest+="and gate.processstatus>8";	
	         	}
	      	 }
	    	 
	         String strsql="select gate.voc_no 'Doc No',date_format(gate.date,'%d.%m.%Y') 'Date',date_format(datalog.edate,'%H:%i') 'Time',repair.name 'Repair Type',"+
	         " ac.refname 'Customer Name',coalesce(bc.refname,'') 'Insurance Company',gate.regno 'Reg No',gate.pltid 'Plate Code',brd.brand_name 'Brand',"+
	         " model.vtype 'Model',coalesce(clr.color,'') 'Color',convert(coalesce(yom.yom,''),char(10)) 'YoM',date_format(est.date,'%d.%m.%Y') 'Est.Date',"+
	         " convert(if(estadd.estaddition is not null,concat(est.voc_no,',', estadd.estaddition),est.voc_no),char(25)) 'Est.Doc No (Additions)',"+
	         " round(coalesce(spare.sparetotal,0.0)+coalesce(labour.labourtotal,0.0),2) 'Est.Total',round(coalesce(spare.sparetotal,0.0),2) 'Est Spare Total',"+
	         " coalesce(date_format(job.date,'%d.%m.%Y'),'') 'Job Date',convert(coalesce(job.voc_no,''),char(10)) 'Job No',coalesce(date_format(job.promdate,'%d.%m.%Y'),'') 'Promise Date',"+
	         " coalesce(date_format(flr.extdate,'%d.%m.%Y'),'') 'Ext.Date',coalesce(date_format(delbaymov.indate,'%d.%m.%Y'),'') 'Ready for Del.',"+
	         " if(job.complete=1,'Completed','Not Completed') 'Job Complete',coalesce(date_format(date(jcc.date),'%d.%m.%Y'),'') "+
			 " 'Job Complete Date',invsum.invall 'Inv Doc No',date_format(invsum.mininvdate,'%d.%m.%Y') 'Inv Date',"+
	         " round(coalesce(invsum.invtaxtotal,0.0),2) 'Inv Amount',coalesce(date_format(gate.outdate,'%d.%m.%Y'),'') 'GOP Date',coalesce(gate.outtime,'') 'GOP Time',"+
	         " datediff( CURRENT_TIMESTAMP, gate.DATE) 'Days-GIP Date',date_format(gate.estdeldate,'%d.%m.%Y') 'Exp.Del.Date',gate.estdeltime 'Exp.Del.Time',"+
	         " coalesce(gate.desc1,'') 'Description',coalesce(gate.username,'') 'Vehicle User',concat('.',coalesce(gate.mobile,''),'.') 'Mobile',coalesce(uw.user_name,'') 'GIP User',"+
	         " coalesce(ur.user_name,'') 'Estimated By',coalesce(ms.sal_name,'') 'Estimator',coalesce(es.sal_name,'') 'Service Advisor',"+
	         " coalesce(ds.sal_name,'') 'Insur.Surveyer',coalesce(dy.sal_name,'') 'Referred By',coalesce(df.name,'') 'Service Package' from ws_gateinpass gate left join ws_gartype repair on"+
    		 " repair.row_no=gate.repairtype left join gl_vehbrand brd on brd.doc_no=gate.brdid left join gl_vehmodel model on"+
    		 " model.doc_no=gate.modid left join ws_estm est on est.gipno=gate.doc_no  left join ws_jobcard job on ((est.doc_no=job.refno and"+
    		 " reftype='EST') or (gate.doc_no=job.refno and reftype='GIP'))  left join my_user ur on ur.doc_no=est.userid left join my_user us"+
    		 " on us.doc_no=job.userid left join my_user uw on uw.doc_no=gate.userid left join my_acbook ac on ac.cldocno=gate.cldocno and"+
    		 " ac.dtype='CRM'  left join my_acbook bc on bc.cldocno=gate.insurcldocno and bc.dtype='CRM'  left join my_salesman ms on"+
    		 " ms.doc_no=gate.marketingperson and ms.sal_type='WMP' left join my_salesman es on es.doc_no=gate.serviceadvisor and"+
    		 " es.sal_type='WSA' left join my_salesman ds on ds.doc_no=gate.insurancesurvivor and ds.sal_type='WIS' left join my_salesman dy"+
    		 " on dy.doc_no=gate.referencedby and dy.sal_type='WRB' left join ws_servicepackage df on df.doc_no=gate.servicepackage and"+
    		 " df.status=3 left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on"+
    		 " est.doc_no=ep.rdocno left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el"+
    		 " on est.doc_no=el.rdocno left join my_color clr on gate.colorid=clr.doc_no left join gl_yom yom on gate.yom=yom.doc_no left"+
    		 " join (select convert(group_concat(addition,','),char(25)) estaddition,jobcarddocno jobdocno from ws_estmadd where status=3"+
    		 " group by jobcarddocno,addition) estadd on job.doc_no=estadd.jobdocno left join (select sum(approvedvalue) sparetotal,rdocno"+
    		 " from  ws_estspare where confirmed=1 and approved=1 group by rdocno) spare on (est.doc_no=spare.rdocno) left join"+
    		 " (select sum(total)  labourtotal,rdocno from  ws_estlabour  where confirmed=1 and approved=1 group by rdocno) labour on"+
    		 " (est.doc_no=labour.rdocno) left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno left join (select jobcarddocno jobdocno,"+
    		 " indate from ws_baymove where  bayid=12 group by jobcarddocno) delbaymov on flr.jobdocno=delbaymov.jobdocno left join"+
    		 " (select min(date) mininvdate,convert(group_concat(voc_no,','), char(25)) invall,sum(taxtotal) invtaxtotal,refno,reftype from"+
    		 " ws_invm where status=3 and reftype='JC' group by refno)  invsum on job.doc_no=invsum.refno left join ws_jobcardcomp jcc on"+
    		 " job.doc_no=jcc.jobcardno  left join datalog datalog on (gate.doc_no=datalog.doc_no and datalog.dtype='GIP' and datalog.entry='A') where gate.date>='"+sqlfromdate+"' and gate.date<='"+sqltodate+"' "+sqltest1+" "+sqltest+"  "+sqltest2+"  group by gate.doc_no";
			System.out.println(strsql);
	         ResultSet rs=stmt.executeQuery(strsql);
	         data=objcommon.convertToEXCEL(rs);
	     }
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
	        return data;
	     	
	    }
}
