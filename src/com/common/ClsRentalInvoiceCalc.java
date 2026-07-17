package com.common;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.connection.ClsConnection;

public class ClsRentalInvoiceCalc {
	ClsConnection ClsConnection=new ClsConnection();

public  ArrayList<Double> getInvoiceCalc(String rano,String cldocno,Date fromdate,Date todate,String rentaltype,String invtype) throws SQLException{
	ArrayList<Double> invoicearray=new ArrayList<Double>();
Connection conn=null;
try {
	//System.out.println("Conn Created getInvoiceCalc");
	conn=ClsConnection.getMyConnection();
	Statement stmt=conn.createStatement();
	int monthcal=0;
	if(rentaltype.equalsIgnoreCase("daily")){
		monthcal=1;
	}
	if(rentaltype.equalsIgnoreCase("weekly")){
		monthcal=7;
	}
	if(rentaltype.equalsIgnoreCase("fortnightly")){
		monthcal=14;
	}
//	System.out.println("==========="+rentaltype);
	String strfrom="";
	if(rentaltype.equalsIgnoreCase("monthly")){
		if(invtype.equalsIgnoreCase("1")){
		strfrom="select if((select method from gl_config where field_nme='monthlycal')=1,(select (DAY(LAST_DAY('"+todate+"')))) ,"+
				"(select value from gl_config where field_nme='monthlycal')) monthcal";
//		System.out.println("================"+stmt);
		
		}
		if(invtype.equalsIgnoreCase("2")){
			//Monthcal Calculation for Period
			//select lastday of fromdate if monthend of both months are same else select lastday of todate//Extra Block for updating agmt invtodate in case of agreement started in monthend
			/*
			Statement stmtdelcal=conn.createStatement();
			int delcal=0;
			//Deciding outddate or deliverydate
			String strdelcal="select method from gl_config where field_nme='delcal'";
			ResultSet rsdelcal=stmtdelcal.executeQuery(strdelcal);
			
			while(rsdelcal.next()){
				delcal=rsdelcal.getInt("method");
			}
			String strcheckdate="";
			java.sql.Date temptodate=null;
			//when delivery date must be considered
			if(delcal==0){
				
					strcheckdate="select if(delivery=1 and delstatus=1,(select din from gl_vmove where rdocno="+rano+" and rdtype='RAG' and "+
				" trancode='DL' and repno=0),odate) temptodate from gl_ragmt where doc_no="+rano;	
				
				
			}
			//When Outdate is considered
			else{
				
					strcheckdate="select odate temptodate from gl_ragmt where doc_no="+rano;
				
			}
			System.out.println("Check Date Query: "+strcheckdate);
			ResultSet rstemptodate=stmtdelcal.executeQuery(strcheckdate);
			while(rstemptodate.next()){
				temptodate=rstemptodate.getDate("temptodate");
			}
			*/
			
			
					
			strfrom="select if((select method from gl_config where field_nme='monthlycal')=1,"+
					" datediff('"+todate+"','"+fromdate+"'),(select value from gl_config where field_nme='monthlycal')) monthcal";
			
					}
		ResultSet rs=stmt.executeQuery(strfrom);
		while(rs.next()){
			monthcal=rs.getInt("monthcal");
		}
	}
	
	
	String strtarifsum="select if((select method from gl_config where field_nme='monthlycal')=1,(select (DAY(LAST_DAY('"+todate+"')))) ,"+
			"(select value from gl_config where field_nme='monthlycal')) monthcal,"+
			" DATEDIFF('"+todate+"','"+fromdate+"') datediff,"+
			" round(((select datediff)/(select "+monthcal+"))*rate,0) ratesum,round(((select datediff)/(select "+monthcal+"))*cdw,0) cdwsum,"+
			" round(((select datediff)/(select "+monthcal+"))*pai,0) paisum,round(((select datediff)/(select "+monthcal+"))*cdw1,0) cdw1sum,"+
			" round(((select datediff)/(select "+monthcal+"))*pai1,0) pai1sum,round(((select datediff)/(select "+monthcal+"))*gps,0) gpssum,"+
			" round(((select datediff)/(select "+monthcal+"))*babyseater,0) babyseatersum,round(((select datediff)/(select "+monthcal+"))*cooler,0)"+
			" coolersum ,((select ratesum)+(select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) rentalsum,"+
			" ((select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) inschgsum,"+
			" ((select gpssum)+(select babyseatersum)+(select coolersum)) accsum from gl_rtarif where rdocno="+rano+" and rstatus=7";
	
//	System.out.println("Invoiccalc"+strtarifsum);
//	System.out.println("Date Difference :"+datediff);
	ResultSet rstarifsum=stmt.executeQuery(strtarifsum);
	/*monthcal=0.0,*/
	double rentalsum=0.0,datediff=0.0,accsum=0.0,inschgsum=0.0;
	while(rstarifsum.next()){
		rentalsum=rstarifsum.getDouble("ratesum");
		datediff=rstarifsum.getDouble("datediff");
		accsum=rstarifsum.getDouble("accsum");
		//monthcal=rstarifsum.getDouble("monthcal");
		inschgsum=rstarifsum.getDouble("inschgsum");
	}
	invoicearray.add(rentalsum);
	invoicearray.add(accsum);
	invoicearray.add(inschgsum);
	//System.out.println("Closed Conn getInvoice Calc");
	conn.close();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
return invoicearray;
}

}
