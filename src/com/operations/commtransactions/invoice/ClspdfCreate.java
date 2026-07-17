package com.operations.commtransactions.invoice;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.mailwithpdf.*;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDPixelMap;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDXObjectImage;
import org.apache.struts2.ServletActionContext;

import com.sun.jna.platform.win32.WinBase.SYSTEM_INFO;
import com.sun.jna.platform.win32.WinDef.LPARAM;

public class ClspdfCreate {

	//pdfcreate.pdfCreate(getLblcompname(),getLblcompaddress(),getLblcompfax(),getLblcomptel(),
	//	getLblbranch(),getLblclient(),getLblaccount(),getLblphone(),getLblmobile(),getLblfax(),
	//			getLbldriven(),getLblcontractstart(),getLblmrano(),getLblinvno(),getLbldate(),getLblrano(),
	//			getLblinvfrom(),getLblinvto(),getLblcontractvehicle(),getLblratype(),getLbltotal(),getLblnetamount(),
	//			getLblamountwords(),gsetLblcheckedby(),getLblfinaldate(),getLbllocation(),getLbllpono(),
	//			getLblbranchcode(),getLbldateyear());



	public  void pdfCreate (String filename,String path1,String compname,String compadd,String compfax,String tele,String branch,String client,
			String account,String add,String add1,String phone,String mob,String fax,String driven,String contractstart,String mrano,
			String invno,String date,String rano,String invfrm,String invto,String contractveh,String ratype,String total,String netamnt,
			String amntwrds,String chkby,String finaldate,String loc,String billpono,String brnchcode,String dateyear,HashMap printdetin,
			ArrayList printfleet,String processby,String formcode, String recep) throws Exception {
		String outputFileName = filename;

		try{

			//System.out.println();       

			// System.out.println("=outputFileName===="+outputFileName);

			// Create a document and add a page to it


			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			java.util.Date dates = new java.util.Date();
			//System.out.println(dateFormat.format(dates)); //2014/08/06 15:59:48


			//String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

			String currdate=dateFormat.format(dates);

			PDDocument document = new PDDocument();
			PDPage page1 = new PDPage(PDPage.PAGE_SIZE_A4);
			// PDPage.PAGE_SIZE_LETTER is also possible
			PDRectangle rect = page1.getMediaBox();
			// rect can be used to get the page width and height
			document.addPage(page1);

			// Create a new font object selecting one of the PDF base fonts
			PDFont fontPlain = PDType1Font.HELVETICA;
			PDFont fontBold = PDType1Font.HELVETICA_BOLD;
			PDFont fontItalic = PDType1Font.HELVETICA_OBLIQUE;
			PDFont fontMono = PDType1Font.COURIER;

			// Start a new content stream which will "hold" the to be created content
			PDPageContentStream cos = new PDPageContentStream(document, page1);

			int line = 0;


			BufferedImage awtImage = ImageIO.read(new File(path1+"/icons/comlogo.jpg"));
			PDXObjectImage ximage = new PDPixelMap(document, awtImage);
			float scale = 0.5f; // alter this value to set the image size
			cos.drawXObject(ximage, 80, 730, ximage.getWidth()*scale, ximage.getHeight()*scale);


			// these three lines are new
			/*cos.setStrokingColor(Color.red);
        cos.addRect(100-3, 400-3, ximage.getWidth()*scale+6, ximage.getHeight()*scale+6);
        cos.closeAndStroke();*/

			cos.setLineWidth(1);
			//cos.setLineCapStyle(0);
			cos.addLine(50, 720, 560, 720);
			cos.closeAndStroke();




			cos.beginText();
			cos.setFont(fontBold, 10);
			//cos.setNonStrokingColor(Color.RED);
			//cos.moveTextPositionByAmount(300, rect.getHeight() - 50*(++line));
			cos.moveTextPositionByAmount(300, 740);
			cos.drawString("Invoice");
			cos.endText();


			//System.out.println("what is dis"+rect.getHeight());
			// Define a text content stream using the selected font, move the cursor and draw some text
			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 20*(++line));
			cos.moveTextPositionByAmount(450, 775);
			cos.drawString(compname);
			cos.endText();

			/* System.out.println("what is dis===="+rect.getHeight() - 50*(++line));*/

			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
			cos.moveTextPositionByAmount(450, 765);
			cos.drawString(compadd);
			cos.endText();

			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
			cos.moveTextPositionByAmount(450, 755);
			cos.drawString("TELE:"+tele);
			cos.endText();

			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
			cos.moveTextPositionByAmount(450, 745);
			cos.drawString("FAX: "+compfax);
			cos.endText();


			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
			cos.moveTextPositionByAmount(450, 735);
			cos.drawString("BRANCH : "+branch);
			cos.endText();

			cos.beginText();
			cos.setFont(fontPlain, 6);
			//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
			cos.moveTextPositionByAmount(450, 725);
			cos.drawString("LOCATION : "+loc);
			cos.endText();


			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 705);
			cos.drawString("Customer Name :  "+client);
			cos.endText();


			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 695);
			cos.drawString("Customer Code :  "+account);
			cos.endText();



			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 685);
			cos.drawString("Address :  "+add+","+add1);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 675);
			cos.drawString("Mobile :  "+mob);
			cos.endText();


			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 665);
			cos.drawString("Phone :  "+phone);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
			cos.moveTextPositionByAmount(80, 655);
			cos.drawString("Driven :  "+driven);
			cos.endText();




			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 705);
			cos.drawString("INV No : "+invno);
			cos.endText();


			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 695);
			cos.drawString("Date : "+date);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 685);
			cos.drawString("RA No : "+rano);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 675);
			cos.drawString("LPO No : "+billpono);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 665);
			cos.drawString("MRA No : "+mrano);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 655);
			cos.drawString("Type : "+ratype);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 645);
			cos.drawString("Contract Start : "+contractstart);
			cos.endText();

			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(450, 635);
			cos.drawString("INV From : "+invfrm +"   To   "+invto);
			cos.endText();


			cos.beginText();
			cos.setFont(fontBold, 6);
			cos.moveTextPositionByAmount(100, 605);
			cos.drawString("Contract Vehicle  :"+contractveh);
			cos.endText();

			cos.setLineWidth((float) .5);
			//cos.setLineCapStyle(0);
			cos.addLine(50, 620, 560, 620);
			cos.closeAndStroke();


			cos.setLineWidth((float) .5);
			//cos.setLineCapStyle(0);
			cos.addLine(50, 600, 560, 600);
			cos.closeAndStroke();

			cos.setLineWidth((float) .5);
			//cos.setLineCapStyle(0);
			cos.addLine(50, 600, 50, 620);
			cos.closeAndStroke();

			cos.setLineWidth((float) .5);
			//cos.setLineCapStyle(0);
			cos.addLine(560, 600, 560, 620);
			cos.closeAndStroke();





			detailTable(page1,cos,600,50,printdetin,total,netamnt,amntwrds,printfleet,chkby,processby,currdate);


			// Make sure that the content stream is closed:
			cos.close();



			// Save the results and ensure that the document is properly closed:
			document.save(outputFileName);
			document.close();

			Thread.sleep(1000);
			File saveFile=new File(outputFileName);
			SendEmailAction sendmail= new SendEmailAction();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			
			//sendmail.SendTomail(saveFile,formcode,recep);
			sendmail.SendTomail( saveFile,formcode,recep,account,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),client);
		}
		catch(Exception e){
			e.printStackTrace();
		}

	}



	public   void pdfCreateLocal (String filename,String path1,String compname,String compadd,String compfax,String tele,String branch,String client,
			String account,String add,String add1,String phone,String mob,String fax,String driven,String contractstart,String mrano,
			String invno,String date,String rano,String invfrm,String invto,String contractveh,String ratype,String total,String netamnt,
			String amntwrds,String chkby,String finaldate,String loc,String billpono,String brnchcode,String dateyear,HashMap printdetin,
			ArrayList printfleet,String processby,String formcode, String recep,HttpSession session,String invoicebranch,String tinno,String servtax,String cstno) throws Exception {
		String outputFileName = filename;

		//System.out.println();       



		// Create a document and add a page to it
		String invbranch=session.getAttribute("BRANCHID").toString();

		//System.out.println("=branch id===="+session.getAttribute("BRANCHID").toString());
		//System.out.println("=date===="+date);

		String invyear=date.substring(date.lastIndexOf("/")+1, date.length());
		//System.out.println("=invyear===="+invyear);
		/*DateFormat invdateFormat = new SimpleDateFormat("yyyy");
		//System.out.println(invdateFormat.format(date));
		String invyear=invdateFormat.format(invdateFormat);

		 //System.out.println("=branch id===="+session.getAttribute("BRANCHID").toString());
		 //System.out.println("=invyear===="+invyear);
		 */
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		java.util.Date dates = new java.util.Date();
		//System.out.println(dateFormat.format(dates)); //2014/08/06 15:59:48


		//String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

		String currdate=dateFormat.format(dates);

		PDDocument document = new PDDocument();
		PDPage page1 = new PDPage(PDPage.PAGE_SIZE_A4);
		// PDPage.PAGE_SIZE_LETTER is also possible
		PDRectangle rect = page1.getMediaBox();
		// rect can be used to get the page width and height
		document.addPage(page1);

		// Create a new font object selecting one of the PDF base fonts
		PDFont fontPlain = PDType1Font.HELVETICA;
		PDFont fontBold = PDType1Font.HELVETICA_BOLD;
		PDFont fontItalic = PDType1Font.HELVETICA_OBLIQUE;
		PDFont fontMono = PDType1Font.COURIER;

		// Start a new content stream which will "hold" the to be created content
		PDPageContentStream cos = new PDPageContentStream(document, page1);

		int line = 0;


		BufferedImage awtImage = ImageIO.read(new File(path1+"/icons/comlogo.jpg"));
		PDXObjectImage ximage = new PDPixelMap(document, awtImage);
		float scale = 0.5f; // alter this value to set the image size
		cos.drawXObject(ximage, 80, 760, ximage.getWidth()*scale, ximage.getHeight()*scale);


		// these three lines are new
		/*cos.setStrokingColor(Color.red);
        cos.addRect(100-3, 400-3, ximage.getWidth()*scale+6, ximage.getHeight()*scale+6);
        cos.closeAndStroke();*/

		cos.setLineWidth(1);
		//cos.setLineCapStyle(0);
		cos.addLine(50, 720, 560, 720);
		cos.closeAndStroke();




		cos.beginText();
		cos.setFont(fontBold, 10);
		//cos.setNonStrokingColor(Color.RED);
		//cos.moveTextPositionByAmount(300, rect.getHeight() - 50*(++line));
		cos.moveTextPositionByAmount(300, 750);
		cos.drawString("INVOICE");
		cos.endText();


		//System.out.println("what is dis"+rect.getHeight());
		// Define a text content stream using the selected font, move the cursor and draw some text
		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 20*(++line));
		cos.moveTextPositionByAmount(450, 805);
		cos.drawString(compname);
		cos.endText();

		/* System.out.println("what is dis===="+rect.getHeight() - 50*(++line));*/

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 795);
		cos.drawString(compadd);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 785);
		cos.drawString("TELE:"+tele);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 775);
		cos.drawString("FAX: "+compfax);
		cos.endText();


		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 765);
		cos.drawString("BRANCH : "+branch);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 755);
		cos.drawString("LOCATION : "+loc);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 745);
		cos.drawString("Service Tax : "+servtax);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 735);
		cos.drawString("TIN No : "+tinno);
		cos.endText();

		cos.beginText();
		cos.setFont(fontPlain, 6);
		//cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
		cos.moveTextPositionByAmount(450, 725);
		cos.drawString("CST No : "+cstno);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 705);
		cos.drawString("Customer Name :  "+client);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 695);
		cos.drawString("Customer Code :  "+account);
		cos.endText();



		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 685);
		cos.drawString("Address :  "+add+","+add1);
		cos.endText();

		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 675);
		cos.drawString("Mobile :  "+mob);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 665);
		cos.drawString("Phone :  "+phone);
		cos.endText();

		cos.beginText();
		cos.setFont(fontBold, 6);
		//cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
		cos.moveTextPositionByAmount(80, 655);
		cos.drawString("Driven :  "+driven);
		cos.endText();




		/* cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(450, 705);
        cos.drawString("INV No : "+invoicebranch+"/"+invyear+"/"+invno);
        cos.endText();*/


		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 705);
		cos.drawString("INV No : "+invno);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 695);
		cos.drawString("Date : "+date);
		cos.endText();

		/* cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(450, 685);
        cos.drawString("Branch : "+branch);
        cos.endText();*/

		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 685);
		cos.drawString("RA No : "+rano);
		cos.endText();

		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 675);
		cos.drawString("LPO No : "+billpono);
		cos.endText();

		/*cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(450, 655);
        cos.drawString("MRA No : "+mrano);
        cos.endText();*/

		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 665);
		cos.drawString("Branch : "+branch);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 655);
		cos.drawString("Type : "+ratype);
		cos.endText();

		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 645);
		cos.drawString("Contract Start : "+contractstart);
		cos.endText();

		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(450, 635);
		cos.drawString("INV From : "+invfrm +"   To   "+invto);
		cos.endText();


		cos.beginText();
		cos.setFont(fontBold, 6);
		cos.moveTextPositionByAmount(100, 605);
		cos.drawString("Contract Vehicle  :"+contractveh);
		cos.endText();

		cos.setLineWidth((float) .5);
		//cos.setLineCapStyle(0);
		cos.addLine(50, 620, 560, 620);
		cos.closeAndStroke();


		cos.setLineWidth((float) .5);
		//cos.setLineCapStyle(0);
		cos.addLine(50, 600, 560, 600);
		cos.closeAndStroke();

		cos.setLineWidth((float) .5);
		//cos.setLineCapStyle(0);
		cos.addLine(50, 600, 50, 620);
		cos.closeAndStroke();

		cos.setLineWidth((float) .5);
		//cos.setLineCapStyle(0);
		cos.addLine(560, 600, 560, 620);
		cos.closeAndStroke();





		detailTable(page1,cos,600,50,printdetin,total,netamnt,amntwrds,printfleet,chkby,processby,currdate);


		// Make sure that the content stream is closed:
		cos.close();



		// Save the results and ensure that the document is properly closed:
		document.save(outputFileName);
		document.close();

		Thread.sleep(1000);
		File saveFile=new File(outputFileName);
		SendEmailAction sendmail= new SendEmailAction();

		//sendmail.SendTomail(saveFile,formcode,recep);
		sendmail.SendTomail( saveFile,formcode,recep,account,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),client);
	}





	public   void detailTable(PDPage page, PDPageContentStream contentStream,
			float y, float margin,HashMap gridmap,String total,String netamt,String amtinwrds,ArrayList printfleet,String chkby,String processby,String currdate) throws IOException {
		final int rows = gridmap.size()+1;
		final int cols =5;
		final float firstRowHeight = 25f;
		final float rowHeight = 10f;
		final float colWidth = 45.6f; //tableWidth/(float)cols;
		final float tableWidth = colWidth * cols; //page.findMediaBox().getWidth()-(2*margin);
		//final float tableWidth =590;
		final float tableHeight = rowHeight * rows + firstRowHeight - rowHeight; 

		//System.out.println("===tableHeight===="+tableHeight);

		final float cellMargin= 1f;
		String  headingArray[]={"SLNO","CHARGE DISCRIPTION","UNITS","RATE","TOTAL"};
		try{

			//draw the rows
			float nexty = y ;

			//contentStream.drawLine(margin+50,nexty,margin+250+tableWidth,nexty);
			//contentStream.drawLine(margin+50,y-tableHeight,margin+250+tableWidth,y-tableHeight);
			//contentStream.drawLine(y,nexty,y-tableHeight,nexty);

			for (int i = 0; i <= rows; i++) {
				//contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
				if (i<=0) {
					nexty-= firstRowHeight;
				} else {
					nexty-= rowHeight;
				}
			}
			//25+60+90+70+30+40+60+50+40+40+55;
			//draw the columns
			float nextx = margin;
			//contentStream.drawLine(margin+50,y,margin+50,y-tableHeight);
			//contentStream.drawLine(margin+250+tableWidth,y,margin+250+tableWidth,y-tableHeight);
			for (int i = 0; i <= cols; i++) {

				if(i==0){
					nextx=nextx;
				}
				else if(i==1){
					nextx=nextx+25;
				}
				else if(i==2){
					nextx=nextx+220;
				}
				else if(i==3){
					nextx=nextx+60;
				}
				else if(i==4){
					nextx=nextx+60;
				}
				else if(i==5){
					nextx=nextx+60;
				}


				//contentStream.drawLine(nextx,y,nextx,y-tableHeight);
				//nextx += colWidth;

				//System.out.println("===nextx==inside loop"+nextx);

			}

			//now add the text

			contentStream.setLineWidth((float) .5);
			float textx = margin+cellMargin+50;



			float texty = y-15;
			//int o = content.length;
			int clno=0;
			for(int i = 0; i <rows; i++){

				for(int j = 0 ; j <cols; j++){


					if(j==0){
						textx=textx;
					}
					else if(j==1){
						textx=textx+25;
					}
					else if(j==2){
						textx=textx+220;
					}
					else if(j==3){
						textx=textx+60;
					}
					else if(j==4){
						textx=textx+60;
					}
					else if(j==5){
						textx=textx+60;
					}


					clno=j;
					String text = "";
					contentStream.beginText();
					if (i<=0) {
						contentStream.setNonStrokingColor(Color.RED);
						contentStream.setFont(PDType1Font.HELVETICA_BOLD,6);
						text = headingArray[j];
						//System.out.println("==textx=headingArray==="+text);
						contentStream.moveTextPositionByAmount(textx,texty-6);
						//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-6);
					}


					else {
						contentStream.setFont(PDType1Font.HELVETICA,6);
						contentStream.setNonStrokingColor(Color.BLACK);
						//System.out.println("= gridmap.get("+i+")======"+ gridmap.get(i));
						//System.out.println("===jjjjjjjjjj======"+j);
						ArrayList testExtracted = (ArrayList) gridmap.get(i);
						//System.out. println("teeeexxxxttttt"+testExtracted.get(j).toString());
						text =testExtracted.get(j).toString();
						contentStream.moveTextPositionByAmount(textx,texty);
						//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-3); 
					}
					contentStream.drawString(text);
					contentStream.endText();
					//textx += colWidth;
				}
				if (i<=0) {
					texty-=firstRowHeight;
				}


				else {
					texty-=rowHeight;
				}
				//System.out.println("===clnoclnoclnoclnoclnoclno====="+clno);
				if(i==2){
					textx = margin+cellMargin+50;
				}
				else{
					textx = margin+cellMargin+50;
				}
			}


			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 8);
			contentStream.moveTextPositionByAmount(50, 555-tableHeight);
			contentStream.drawString("Total  :");
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 7);
			contentStream.moveTextPositionByAmount(465, 555-tableHeight);
			contentStream.drawString(total);
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 7);
			contentStream.moveTextPositionByAmount(50, 545-tableHeight);
			contentStream.drawString("Net Total  :");
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 7);
			contentStream.moveTextPositionByAmount(465, 545-tableHeight);
			contentStream.drawString(netamt);
			contentStream.endText();


			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 7);
			contentStream.moveTextPositionByAmount(50, 535-tableHeight);
			contentStream.drawString("Amount In Words  :");
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 7);
			contentStream.moveTextPositionByAmount(300, 535-tableHeight);
			contentStream.drawString(amtinwrds);
			contentStream.endText();


			if(printfleet.size()>0){


				contentStream.setLineWidth((float) .5);
				contentStream.addLine(50, 525-tableHeight, 560, 525-tableHeight);
				contentStream.closeAndStroke();

				int j=1;
				for (int i = 0; i < printfleet.size(); i++) {

					//System.out.println("printfleet.size()"+printfleet.size());

					//System.out.println("jkjnhjjnhjnjkjnjjnj"+printfleet.get(i));


					contentStream.beginText();
					contentStream.setFont(PDType1Font.HELVETICA, 7);
					contentStream.moveTextPositionByAmount(50, 500-tableHeight-j);
					contentStream.drawString("OTHER FLEETS  :"+printfleet.get(i).toString());
					contentStream.endText();

					j=j+15;
				}
				contentStream.setLineWidth((float) .5);
				contentStream.addLine(50, 500-tableHeight-j, 560, 500-tableHeight-j);
				contentStream.closeAndStroke();


				contentStream.setLineWidth(1);
				contentStream.addLine(50, 500-tableHeight-j, 560, 500-tableHeight-j);
				contentStream.closeAndStroke();

				contentStream.setLineWidth((float) .5);
				contentStream.addLine(50, 500-tableHeight-j, 560, 500-tableHeight-j);
				contentStream.closeAndStroke();

				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(50, 493-tableHeight-j);
				contentStream.drawString("Processed By  :"+processby);
				contentStream.endText();


				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(250, 493-tableHeight-j);
				contentStream.drawString("Received By  :");
				contentStream.endText();

				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(450, 493-tableHeight-j);
				contentStream.drawString("Date  :"+currdate);
				contentStream.endText();


			}
			else{
				contentStream.setLineWidth((float) .5);
				contentStream.addLine(50, 575-tableHeight, 560, 575-tableHeight);
				contentStream.closeAndStroke();


				contentStream.setLineWidth(1);
				contentStream.addLine(50, 515-tableHeight, 560, 515-tableHeight);
				contentStream.closeAndStroke();

				contentStream.setLineWidth((float) .5);
				contentStream.addLine(50, 505-tableHeight, 560, 505-tableHeight);
				contentStream.closeAndStroke();

				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(50, 495-tableHeight);
				contentStream.drawString("Processed By  :"+processby);
				contentStream.endText();

				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(250, 495-tableHeight);
				contentStream.drawString("Received By  :");
				contentStream.endText();

				contentStream.beginText();
				contentStream.setFont(PDType1Font.HELVETICA, 7);
				contentStream.moveTextPositionByAmount(450, 495-tableHeight);
				contentStream.drawString("Date  :"+currdate);
				contentStream.endText();

			}

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 6);
			contentStream.moveTextPositionByAmount(200, 305);
			contentStream.drawString("System Generated Document,Stamp & Signature Not required.");
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 6);
			contentStream.moveTextPositionByAmount(50, 290);
			contentStream.drawString("Printed By  :"+chkby);
			contentStream.endText();

			contentStream.setLineWidth((float) .5);
			//contentStream.setLineCapStyle(0);
			contentStream.addLine(50, 320, 560, 320);
			contentStream.closeAndStroke();


			contentStream.setLineWidth((float) .5);
			//contentStream.setLineCapStyle(0);
			contentStream.addLine(50, 300, 560, 300);
			contentStream.closeAndStroke();

			contentStream.setLineWidth((float) .5);
			//contentStream.setLineCapStyle(0);
			contentStream.addLine(50, 300, 50, 320);
			contentStream.closeAndStroke();

			contentStream.setLineWidth((float) .5);
			//contentStream.setLineCapStyle(0);
			contentStream.addLine(560, 300, 560, 320);
			contentStream.closeAndStroke();


			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 8);
			contentStream.moveTextPositionByAmount(270, 45);
			contentStream.drawString("PoweredBy GateWayERP");
			contentStream.endText();
		}
		catch(Exception e){
			e.printStackTrace();
		}

	}


}


/*    public   void drawTable(PDPage page, PDPageContentStream contentStream,
            float y, float margin,HashMap gridmap,String ginst,String genterms,ArrayList descarray,String inst) throws IOException {
final int rows = gridmap.size()+1;
final int cols =11;
final float firstRowHeight = 30f;
final float rowHeight = 20f;
final float colWidth = 45.6f; //tableWidth/(float)cols;
final float tableWidth = colWidth * cols; //page.findMediaBox().getWidth()-(2*margin);
//final float tableWidth =590;
final float tableHeight = rowHeight * rows + firstRowHeight - rowHeight; 

//System.out.println("===tableHeight===="+tableHeight);

final float cellMargin= 1f;
PDRectangle rectangle = new PDRectangle();
rectangle.setLowerLeftX(10);
rectangle.setLowerLeftY(10);
rectangle.setUpperRightX(10);
rectangle.setUpperRightY(10);
page.setMediaBox(rectangle);
page.setCropBox(rectangle);
String  headingArray[]={"SLNO","BRAND","MODEL","SPECIFICATION","YOM","COLOUR","RENTALTYPE","TARIFF","UNIT","DAYS","GROUP"};

//draw the rows
float nexty = y ;
for (int i = 0; i <= rows; i++) {
contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
if (i<=0) {
nexty-= firstRowHeight;
} else {
nexty-= rowHeight;
}
}
//25+60+90+70+30+40+60+50+40+40+55;
//draw the columns
float nextx = margin;
for (int i = 0; i <= cols; i++) {

	if(i==0){
		nextx=nextx+25;
	}
	else if(i==1){
		nextx=nextx+25;
	}
	else if(i==2){
		nextx=nextx+60;
	}
	else if(i==3){
		nextx=nextx+90;
	}
	else if(i==4){
		nextx=nextx+70;
	}
	else if(i==5){
		nextx=nextx+30;
	}
	else if(i==6){
		nextx=nextx+40;
	}
	else if(i==7){
		nextx=nextx+45;
	}
	else if(i==8){
		nextx=nextx+40;
	}
	else if(i==9){
		nextx=nextx+30;
	}
	else if(i==10){
		nextx=nextx+30;
	}

	else if(i==11){
		nextx=nextx+42;
	}


contentStream.drawLine(nextx,y,nextx,y-tableHeight);
//nextx += colWidth;

//System.out.println("===nextx==inside loop"+nextx);

}

//now add the text

contentStream.setLineWidth(1);
float textx = margin+cellMargin;



float texty = y-15;
//int o = content.length;
int clno=0;
for(int i = 0; i <rows; i++){

for(int j = 0 ; j <cols; j++){


	if(j==0){
		textx=textx+25;
	}
	else if(j==1){
		textx=textx+25;
	}
	else if(j==2){
		textx=textx+60;
	}
	else if(j==3){
		textx=textx+90;
	}
	else if(j==4){
		textx=textx+70;
	}
	else if(j==5){
		textx=textx+30;
	}
	else if(j==6){
		textx=textx+40;
	}
	else if(j==7){
		textx=textx+45;
	}
	else if(j==8){
		textx=textx+40;
	}
	else if(j==9){
		textx=textx+30;
	}
	else if(j==10){
		textx=textx+30;
	}
	else if(j==11){
		textx=textx+42;
	}

	clno=j;
String text = "";
contentStream.beginText();
if (i<=0) {
	contentStream.setNonStrokingColor(Color.RED);
	contentStream.setFont(PDType1Font.HELVETICA_BOLD,6);
 text = headingArray[j];
 //System.out.println("==textx===="+textx);
contentStream.moveTextPositionByAmount(textx,texty-6);
//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-6);
}


else {
	contentStream.setFont(PDType1Font.HELVETICA,5);
	contentStream.setNonStrokingColor(Color.BLACK);
	//System.out.println("= gridmap.get(i)======"+ gridmap.get(i));
	ArrayList testExtracted = (ArrayList) gridmap.get(i);
	//System.out.println("teeeexxxxttttt"+testExtracted.get(j).toString());
	text =testExtracted.get(j).toString();
contentStream.moveTextPositionByAmount(textx,texty);
//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-3); 
}
contentStream.drawString(text);
contentStream.endText();
//textx += colWidth;
}
if (i<=0) {
texty-=firstRowHeight;
}


else {
texty-=rowHeight;
}
//System.out.println("===clnoclnoclnoclnoclnoclno====="+clno);
if(i==2){
	textx = margin+cellMargin;
}
else{
	textx = margin+cellMargin;
}
//System.out.println("===ginst=hbhbhb==="+ginst);
}
if(!(ginst==null)){
	//System.out.println("ginst inside null check");
contentStream.beginText();
contentStream.setFont(PDType1Font.COURIER_BOLD, 7);
contentStream.moveTextPositionByAmount(50, 550-tableHeight);
contentStream.drawString(ginst);
contentStream.endText();

contentStream.setLineWidth((float) .5);
contentStream.addLine(50, 545-tableHeight, 180, 545-tableHeight);
contentStream.closeAndStroke();


contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA_OBLIQUE, 7);
contentStream.moveTextPositionByAmount(50, 530-tableHeight);
contentStream.drawString(genterms);
contentStream.endText();
}
//System.out.println("==inst==="+inst);
if(descarray.size()>0){
contentStream.beginText();
contentStream.setFont(PDType1Font.COURIER_BOLD, 7);
contentStream.moveTextPositionByAmount(50, 500-tableHeight);
contentStream.drawString(inst);
contentStream.endText();

contentStream.setLineWidth((float) .5);
contentStream.addLine(50, 495-tableHeight, 140, 495-tableHeight);
contentStream.closeAndStroke();

int j=1;
for (int i = 0; i < descarray.size(); i++) {

	//System.out.println("descarray.size()"+descarray.size());

	//System.out.println("jkjnhjjnhjnjkjnjjnj"+descarray.get(i));


	contentStream.beginText();
	contentStream.setFont(PDType1Font.HELVETICA_OBLIQUE, 7);
	contentStream.moveTextPositionByAmount(50, 475-tableHeight-j);
	contentStream.drawString(descarray.get(i).toString());
	contentStream.endText();

	j=j+15;
}


contentStream.beginText();
contentStream.setFont(PDType1Font.COURIER, 6);
contentStream.moveTextPositionByAmount(270, 45);
contentStream.drawString("PoweredBy GateWayERP");
contentStream.endText();
}

}*/


