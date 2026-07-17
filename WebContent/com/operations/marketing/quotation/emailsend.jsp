<%-- 
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <%@page import="java.io.*"%>
  <%@page import="java.util.*"%>
<%@page import="com.itextpdf.text.BaseColor"%>
<%@page import=" com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Document" %>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.itextpdf.text.List"%>
<%@page import="com.itextpdf.text.ListItem" %>
<%@page import="com.itextpdf.text.Paragraph" %>

<%@page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter" %>


  <%@page import="java.io.BufferedWriter"%>
  <%@page import="java.io.File.*"%>
<%@page import="java.io.FileWriter"%>


  <%@page import="com.itextpdf.text.Font"%>
  <%@page import="com.itextpdf.text.PageSize"%>
<%@page import="com.itextpdf.text.Font.FontFamily"%>

<%@page import="com.itextpdf.text.FontFactory"%>

  <%@page import="com.itextpdf.text.Phrase"%>
  
  
  <%@page import="com.itextpdf.text.Paragraph"%>
  <%@page import="com.itextpdf.text.pdf.BaseFont"%>
  <%@page import="com.itextpdf.text.pdf.FontSelector"%>
  

<!--  
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.FontSelector;
 -->



<%

ArrayList<String> tariffarr=new ArrayList<String>();
ArrayList<String> arr=new ArrayList<String>();
 
        try {
        	
        	String aa="5";
 
              OutputStream file = new FileOutputStream(new File("C:/eclipse-jee-kepler-SR2-win32-x86_64/eclipsekepler/"+aa+".pdf"));
	          Document document = new Document();
	          PdfWriter.getInstance(document, file);
 
			//Inserting Image in PDF
			   //  Image image = Image.getInstance ("/icons/epic.jpg");
			   //  image.scaleAbsolute(120f, 60f);//image width,height	
 
			//Inserting Table in PDF
			
			String cutname="";
			   String mobno="";
			   String address="";
			   String email="";
			   String date="";
			   String type="";
			   int docnoss=0;
			
			
			
	          Connection conn = null;
	  		try {
	  				 conn = ClsConnection.getMyConnection();
	  				Statement stmtprint = conn.createStatement ();
	  	        	
	  				String resql=("select q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
	  						+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
	  						+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
	  						+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
	  						+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO=39 ");
	  				
	  			//	System.out.println("1212"+resql);
	  				
	  				ResultSet pintrs = stmtprint.executeQuery(resql);
	  				
	  			     
	  			       while(pintrs.next()){
	  			    	   // cldatails
	  			    	   
	  			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
	  			    	   
	  			    	
	  			    	  cutname=  pintrs.getString("name");
	  			    	address=  pintrs.getString("com_add1");
	  			    	  mobno=  pintrs.getString("mob");
	  			    	email=  pintrs.getString("email");
	  			    	    //upper
	  			      date= pintrs.getString("date");
	  			      type= pintrs.getString("type");
	  			      docnoss= pintrs.getInt("doc_no");
	  			     
	  			       }
	  				

	  				stmtprint.close();
	  			//	conn.close();
	  				
	  				
	  				 Statement stmtinvoice10 = conn.createStatement ();
	  				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_quotm r  "
	  				    		+ " left join my_brch b on r.BRANCH=b.doc_no left join my_locm l on l.brhid=b.doc_no "
	  				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no=5  ";


	  			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
	  				       
	  				       while(resultsetcompany.next()){
	  				    	   
	  				    	   resultsetcompany.getString("branchname");
	  				    	   resultsetcompany.getString("company");
	  				    	  
	  				    	  resultsetcompany.getString("address");
	  				    	 
	  				    	  resultsetcompany.getString("tel");
	  				    	  
	  				    	 resultsetcompany.getString("fax");
	  				    	  resultsetcompany.getString("location");
	  				    	  
	  				    	 
	  				    	   
	  				       } 
	  				       stmtinvoice10.close();
	  				 
	  						Statement stmtinvoice2 = conn.createStatement ();
	  					
	  						String strSqldetail="select eq.sr_no,eq.brdid,eq.modid,eq.spec ,eq.clrid,round(eq.unit) unit,DATE_FORMAT(frmdate,'%d-%m-%Y') AS  "
	  								+ "	fromdate,DATE_FORMAT(todate,'%d-%m-%Y') AS todate,eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
	  								+ "vc.color color,vg.gname gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
	  								+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
	  								+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid   where  eq.rdocno=39 ";
	  					
	  			
	  					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
	  					
	  					int rowcount=1;
	  			
	  					while(rsdetail.next()){
	  		
	  							String temp="";
	  							String spci="";
	  							
	  							if(rsdetail.getString("spec").equalsIgnoreCase("0"))
	  							{
	  								spci="";
	  							}
	  							else
	  							{
	  								spci=rsdetail.getString("spec");
	  							}
	  							temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("fromdate")+"::"+rsdetail.getString("todate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("gname") ;
	  		
	  							arr.add(temp);
	  							rowcount++;
	  			
	  					
	  						
	  				              }
	  					stmtinvoice2.close();  
	  					//request.setAttribute("details",arr); 
	  		/* 			ArrayList<String> tariffarr=new ArrayList<String>(); */
	  					Statement stmtinvoice3 = conn.createStatement ();
	  				
	  					String strSqldetail1="select if(vg.gname='0',' ',vg.gname) group1,if(qt.rentaltype='0',' ',qt.rentaltype) rentaltype,if(qt.tariff=0,' ',round(qt.tariff,2)) rate  "
	  							+ ",if(qt.cdw=0,' ',round(qt.cdw,2)) cdw,if(qt.pai=0,' ',round(qt.pai,2)) pai,if(qt.cdw1=0,' ',round(qt.cdw1,2)) cdw1, "
	  							+ "if(qt.pai1=0,' ',round(qt.pai1,2)) pai1,if(qt.gps=0,' ',round(qt.gps,2)) gps,"
	  							+ "if(qt.babyseater=0,' ',round(qt.babyseater,2)) babyseater,if(qt.cooler=0,' ',round(qt.cooler,2)) cooler,"
	  							+ "if(qt.kmrest=0,' ',round(qt.kmrest)) kmrest,if(qt.exkmrte=0,' ',round(qt.exkmrte,2)) exkmrte,"
	  							+ "if(qt.oinschg=0,' ',round(qt.oinschg,2)) oinschg,if(qt.exhrchg=0,' ',round(qt.exhrchg,2)) exhrchg "
	  							+ "from gl_quotd qt left join gl_vehgroup vg on vg.doc_no=qt.grpid  where qt.rdocno=39 ";
	  				
	  		
	  				ResultSet rsdetail1=stmtinvoice3.executeQuery(strSqldetail1);
	  				
	  				int rowcounts=1;
	  		
	  				while(rsdetail1.next()){
	  	
	  						String temp="";
	  					     
	  						
	  						temp=rowcounts+"::"+rsdetail1.getString("group1")+"::"+rsdetail1.getString("rentaltype")+"::"+rsdetail1.getString("rate")
	  						+"::"+rsdetail1.getString("cdw")+"::"+rsdetail1.getString("cdw1")
	  						+"::"+rsdetail1.getString("gps")+"::"+rsdetail1.getString("babyseater")+"::"+rsdetail1.getString("cooler")+"::"+rsdetail1.getString("kmrest")
	  						+"::"+rsdetail1.getString("exkmrte")+"::"+rsdetail1.getString("oinschg")+"::"+rsdetail1.getString("exhrchg");
	  	
	  						tariffarr.add(temp);
	  						rowcounts++;
	  		
	  				
	  					
	  			              }
	  				stmtinvoice3.close();  
	  			//	request.setAttribute("tariffdetails",tariffarr);  
	  				conn.close();



	  				
	  		}
	  		catch(Exception e){
	  			conn.close();
	  			e.printStackTrace();
	  		} 
		 
	  		
	  		
	  		
	  		
	  		
	  		
	 /*  		

	  		 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
	  		    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>Brand</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>Model</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>Specification</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>Color</b></td>
	  		    <td align="left"  style="border-collapse: collapse;"><b>Rent Type</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>From Date</b></td>
	  		    <td align="left"  style="border-collapse: collapse;"><b>To Date</b></td>
	  		    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
	  		        <td align="left" style="border-collapse: collapse;"><b>Group</b></td>
	  		   */
	  		
	  		   
	  	       Font f = new Font();
	  	        f.setColor(BaseColor.WHITE);
	  	       // PdfPCell cell = new PdfPCell(new Phrase( ));
	  	       // cell.setBackgroundColor(BaseColor.BLACK);
	  	       // cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	      //  cell.setColspan(7);
	  	       
	  		   
	
	  		 PdfPTable table2 = new PdfPTable(10);
	    		 PdfPTable table3 = new PdfPTable(10);
	    		  table2.setWidthPercentage(100);
	 		     table3.setWidthPercentage(100);
	 		 //   table2.addCell(cell);
	  	        // Add the second header row twice
	  	/*         table2.getDefaultCell().setBackgroundColor(BaseColor.LIGHT_GRAY); */
	  	
	  	
	  	float[] columnWidths = new float[] {10f, 25f, 25f, 50f,25f, 25f, 25f, 25f,25f,25f};
             table2.setWidths(columnWidths);
             table3.setWidths(columnWidths);
	 		     
	    		 table2.addCell("Sl");
	    		 table2.addCell("Brand");
	    		 table2.addCell("Model");
	    		 table2.addCell("Specification");
	    		 table2.addCell("Color");
	    		 table2.addCell("Rent Type");
	    		 table2.addCell("From Date");
	    		 table2.addCell("To Date");
	    		 table2.addCell("Unit");
	    		 table2.addCell("Group");
	    		
	    		   
					for(int i=0;i< arr.size();i++){
				    	
					     String[] veharray=arr.get(i).split("::");
	  		

				            table3.addCell(veharray[0]);
				            table3.addCell(veharray[1]);
				            table3.addCell(veharray[2]);
				            table3.addCell(veharray[3]);
				            table3.addCell(veharray[4]);
				            table3.addCell(veharray[5]);
				            table3.addCell(veharray[6]);
				            table3.addCell(veharray[7]);
				            table3.addCell(veharray[8]);
				            table3.addCell(veharray[9]);
				      
	  		
					}
	  		

			 PdfPTable table = new PdfPTable(13);
			 PdfPTable   table1 = new PdfPTable(13);
		     table.setWidthPercentage(100);
		     table1.setWidthPercentage(100);
		   
			   table1.addCell("Sl No");
		
			   table1.addCell("Group");
			   table1.addCell("Rental Type");
			   table1.addCell("Taiff");
			   table1.addCell("CDW");
			   table1.addCell("SCDW");
			   
			   
			   table1.addCell("Gps");
			   table1.addCell("Child Seat");
			   table1.addCell("Booster");
			   table1.addCell("KM Rest");
			   table1.addCell("Exc KM Rate");
			   table1.addCell("Ins Charge");
			   table1.addCell("Ex. Hr Charge");
			   
			   
				for(int i=0;i< tariffarr.size();i++){
			    	
				     String[] desarray=tariffarr.get(i).split("::");
				     
					 // String[] subarray=rowValues.get(i).split("::");		
			   
			
/* for(int i=1;i<=5;i++)
{ */
			// PdfPTable   table = new PdfPTable(6);
		
			
	            table.addCell(desarray[0]);
	            table.addCell(desarray[1]);
	            table.addCell(desarray[2]);
	            table.addCell(desarray[3]);
	            table.addCell(desarray[4]);
	            table.addCell(desarray[5]);
	            table.addCell(desarray[6]);
	            table.addCell(desarray[7]);
	            table.addCell(desarray[8]);
	            table.addCell(desarray[9]);
	            table.addCell(desarray[10]);
	            table.addCell(desarray[11]);
	            table.addCell(desarray[12]);
	       
	          
}
				      
//}			      
				      
				  
 /* 
			 //Text formating in PDF
	                Chunk chunk=new Chunk("Welecome To Java4s Programming Blog...");
					chunk.setUnderline(+1f,-2f);//1st co-ordinate is for line width,2nd is space between
					Chunk chunk1=new Chunk("Php4s.com");
					chunk1.setUnderline(+4f,-8f);
					chunk1.setBackground(new BaseColor (17, 46, 193));      
  */
			 //Now Insert Every Thing Into PDF Document
		         document.open();//PDF document opened........			       
		        // document.add(new Paragraph("A Hello World PDF document."));
					//document.add(image);


    
				//	document.add(Chunk.NEWLINE);   //Something like in HTML :-)
                        document.add(table1);
/*              for(int i=1;i<=5;i++)
{  */    
 				        document.add(table);
						document.add(Chunk.NEWLINE);   //Something like in HTML :-)
						document.add(table2);
						document.add(table3);
/* } */
					//document.add(table1);
				//	document.add(list);            //In the new page we are going to add list
					//document.add(list1);    
		               document.close();
 
					//document.add(chunk);
					//document.add(chunk1);
 
					//document.add(Chunk.NEWLINE);   //Something like in HTML :-)							    
 
       				//document.newPage();            //Opened new page
					//document.add(list);            //In the new page we are going to add list
					//document.add(list1);    
		        // document.close();
 
 
            System.out.println("Pdf created successfully..");
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 

 %>  --%>