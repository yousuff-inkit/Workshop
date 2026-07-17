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


<%


 
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
	  						+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO=5 ");
	  				
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
	  				
	  				
	  				/* 
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
	  				       ArrayList<String> arr=new ArrayList<String>();
	  						Statement stmtinvoice2 = conn.createStatement ();
	  					
	  						String strSqldetail="select eq.sr_no,eq.brdid,eq.modid,eq.spec ,eq.clrid,round(eq.unit) unit,DATE_FORMAT(frmdate,'%d-%m-%Y') AS  "
	  								+ "	fromdate,DATE_FORMAT(todate,'%d-%m-%Y') AS todate,eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
	  								+ "vc.color color,vg.gname gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
	  								+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
	  								+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid   where  eq.rdocno=5 ";
	  					
	  			
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
	  					request.setAttribute("details",arr); 
	  					ArrayList<String> tariffarr=new ArrayList<String>();
	  					Statement stmtinvoice3 = conn.createStatement ();
	  				
	  					String strSqldetail1="select if(vg.gname='0',' ',vg.gname) group1,if(qt.rentaltype='0',' ',qt.rentaltype) rentaltype,if(qt.tariff=0,' ',round(qt.tariff,2)) rate  "
	  							+ ",if(qt.cdw=0,' ',round(qt.cdw,2)) cdw,if(qt.pai=0,' ',round(qt.pai,2)) pai,if(qt.cdw1=0,' ',round(qt.cdw1,2)) cdw1, "
	  							+ "if(qt.pai1=0,' ',round(qt.pai1,2)) pai1,if(qt.gps=0,' ',round(qt.gps,2)) gps,"
	  							+ "if(qt.babyseater=0,' ',round(qt.babyseater,2)) babyseater,if(qt.cooler=0,' ',round(qt.cooler,2)) cooler,"
	  							+ "if(qt.kmrest=0,' ',round(qt.kmrest)) kmrest,if(qt.exkmrte=0,' ',round(qt.exkmrte,2)) exkmrte,"
	  							+ "if(qt.oinschg=0,' ',round(qt.oinschg,2)) oinschg,if(qt.exhrchg=0,' ',round(qt.exhrchg,2)) exhrchg "
	  							+ "from gl_quotd qt left join gl_vehgroup vg on vg.doc_no=qt.grpid  where qt.rdocno=5 ";
	  				
	  		
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
	  				request.setAttribute("tariffdetails",tariffarr);  
	  				conn.close();*/



	  				
	  		}
	  		catch(Exception e){
	  			conn.close();
	  			e.printStackTrace();
	  		} 
	  
		
	       /*  PdfPTable table = new PdfPTable(3); // 3 columns.
	        table.setWidthPercentage(100); //Width 100%
	        table.setSpacingBefore(10f); //Space before table
	        table.setSpacingAfter(10f); //Space after table
	 
	        //Set Column widths
	        float[] columnWidths = {1f, 1f, 1f};
	        table.setWidths(columnWidths);
	 
	        PdfPCell cell1 = new PdfPCell(new Paragraph("Cell 1"));
	        cell1.setBorderColor(BaseColor.BLUE);
	        cell1.setPaddingLeft(1);
	        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 
	        PdfPCell cell2 = new PdfPCell(new Paragraph("Cell 2"));
	        cell2.setBorderColor(BaseColor.GREEN);
	        cell2.setPaddingLeft(10);
	        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
	        cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 
	        PdfPCell cell3 = new PdfPCell(new Paragraph("Cell 3"));
	        cell3.setBorderColor(BaseColor.RED);
	        cell3.setPaddingLeft(10);
	        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
	        cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 
	        //To avoid having the cell border and the content overlap, if you are having thick cell borders
	        //cell1.setUserBorderPadding(true);
	        //cell2.setUserBorderPadding(true);
	        //cell3.setUserBorderPadding(true);
	 
	        table.addCell(cell1);
	        table.addCell(cell2);
	        table.addCell(cell3);
	     
			 */
			
			      PdfPTable table=new PdfPTable(10);
			
	                     PdfPCell cell = new PdfPCell (new Paragraph ("Quotation"));
	                     
	                     
	          
	                     
 
				      cell.setColspan (10);
				    //  cell.setHorizontalAlignment (Element.ALIGN_LEFT);
				      cell.setPadding (1.0f);
				     // //cell.setBackgroundColor (new BaseColor (140, 221, 8));					               
 
				      table.addCell(cell);						               
 
				      table.addCell("Name");
				      table.addCell("Address");
				      table.addCell("Email");
                      table.addCell("Java4s");
				      table.addCell("NC");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.addCell("United States");
				      table.setSpacingBefore(1.0f);       // Space Before table starts, like margin-top in CSS
				      table.setSpacingAfter(1.0f);  
				      // Space After table starts, like margin-Bottom in CSS	
				       PdfPTable table1=new PdfPTable(10);
				      PdfPCell cell2 = new PdfPCell ();
				      cell2.setColspan (10);
				      cell2.setHorizontalAlignment (Element.ALIGN_CENTER);
				      cell2.setPadding (0);
				      //cell2.setBackgroundColor (new BaseColor (140, 221, 8));	
				      table1.addCell(cell2);						               
				      
				      table1.addCell("Name");
				      table1.addCell("Address");
				      table1.addCell("Email");
                      table1.addCell("Java4s");
				      table1.addCell("NC");
				      table1.addCell("United States");
				       
				      
				      
				      
				      List list1=new List(true,30);
			          list1.add(new ListItem("Java4s"+" "+"asdddddddddddd"));
				      list1.add(new ListItem("Php4s"));
				      list1.add(new ListItem("Some Thing..."));
				       
			 //Inserting List in PDF
				      List list=new List(true,30);
			          list.add(new ListItem("Java4s"+"asddssssssssssssssssssdddddddddd"));
				      list.add(new ListItem("Php4s"));
				      list.add(new ListItem("Some Thing..."));		
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
		         document.add(new Paragraph("A Hello World PDF document."));
					//document.add(image);
        Paragraph paragraph = new Paragraph("This is right aligned text");
            paragraph.setAlignment(Element.ALIGN_RIGHT);
      document.add(paragraph);
      // Centered
      paragraph = new Paragraph("This is centered text");
      paragraph.setAlignment(Element.ALIGN_CENTER);
      document.add(paragraph);
      // Left
      paragraph = new Paragraph("This is left aligned text");
      paragraph.setAlignment(Element.ALIGN_LEFT);
      document.add(paragraph);
				//	document.add(Chunk.NEWLINE);   //Something like in HTML :-)
 
                    document.add(new Paragraph("                                                                        Quotation                                          "));
 				   document.add(table);
					//document.add(table1);
					document.add(list);            //In the new page we are going to add list
					document.add(list1);    
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
 

 %> --%>