package com.dashboard.invoices.groupedinvoice;
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
	    	
	
    public  void pdfCreateLocal (String filename,String path1,String compname,String compadd,String compfax,String tele,String branch,String client,
    		String account,String add,String add1,String phone,String mob,String fax,String driven,String contractstart,String mrano,
    		String invno,String date,String rano,String invfrm,String invto,String contractveh,String ratype,String total,String netamnt,
    		String amntwrds,String chkby,String finaldate,String loc,String billpono,String brnchcode,String dateyear,
    		ArrayList printdetin,String processby,String formcode,HttpSession session,String recep,String invoicebranch,String tinno,String servtax,String cstno,int isindian) throws Exception {
        String outputFileName = filename;
        
 //System.out.println();       
        
        //System.out.println("==recep===in ClspdfCreate"+recep);
        
        // Create a document and add a page to it
        String invbranch=session.getAttribute("BRANCHID").toString();
        
		 String invyear=date.substring(date.lastIndexOf("/")+1, date.length());
		 
     
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		java.util.Date dates = new java.util.Date();
//		System.out.println(dateFormat.format(dates)); //2014/08/06 15:59:48
		
	
    	
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
        
      
        cos.setLineWidth(1);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 720, 560, 720);
        cos.closeAndStroke();
        
   
        
        
        cos.beginText();
        cos.setFont(fontBold, 10);
        //cos.setNonStrokingColor(Color.RED);
        //cos.moveTextPositionByAmount(300, rect.getHeight() - 50*(++line));
        cos.moveTextPositionByAmount(300, 750);
        cos.drawString("Grouped Invoice");
        cos.endText();
        
        
//        System.out.println("what is dis"+rect.getHeight());
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
        
        
        if(isindian>=1){
        
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
        }
        
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
        
        
        /*cos.beginText();
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
        cos.closeAndStroke();*/
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 625, 560, 625);
        cos.closeAndStroke();
        
        
        detailTable(page1,cos,620,50,printdetin,total,netamnt,amntwrds,chkby,processby,currdate);
        
        
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
    
    
    
    
    
    public  void detailTable(PDPage page, PDPageContentStream contentStream,
            float y, float margin,ArrayList printdetin,String total,String netamt,String amtinwrds,String chkby,String processby,String currdate) throws IOException {
final int rows = printdetin.size();
final int cols =8;
final float firstRowHeight = 25f;
final float rowHeight = 10f;
final float colWidth = 45.6f; //tableWidth/(float)cols;
final float tableWidth = colWidth * cols; //page.findMediaBox().getWidth()-(2*margin);
//final float tableWidth =590;
final float tableHeight = rowHeight * rows + firstRowHeight - rowHeight; 


final float cellMargin= 1f;
String  headingArray[]={"Sl.No","Inv No","Agmt No","Agmt Type","Charge Description","Unit","Rate","Total"};
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
		nextx=nextx+30;
	}
	else if(i==3){
		nextx=nextx+30;
	}
	else if(i==4){
		nextx=nextx+40;
	}
	else if(i==5){
		nextx=nextx+100;
	}
	else if(i==6){
		nextx=nextx+40;
	}
	else if(i==7){
		nextx=nextx+40;
	}
	
		
	
//contentStream.drawLine(nextx,y,nextx,y-tableHeight);
//nextx += colWidth;


}

//now add the text

contentStream.setLineWidth((float) .5);
float textx = margin+cellMargin+50;



float texty = y-15;
//int o = content.length;
int clno=0;
for(int i = -1; i <rows; i++){
	
for(int j = 0 ; j <cols; j++){
	
	
	if(j==0){
		textx=textx;
	}
	else if(j==1){
		textx=textx+25;
	}
	else if(j==2){
		textx=textx+30;
	}
	else if(j==3){
		textx=textx+30;
	}
	else if(j==4){
		textx=textx+40;
	}
	else if(j==5){
		textx=textx+140;
	}
	else if(j==6){
		textx=textx+50;
	}
	else if(j==7){
		textx=textx+45;
	}
	
	
	clno=j;
String text = "";
contentStream.beginText();
if (i<0) {
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
	String getcoldata=(String) printdetin.get(i);
    String getdata[]=getcoldata.split("::");
	text =getdata[j].toString();

contentStream.moveTextPositionByAmount(textx,texty);
//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-3); 
}
contentStream.drawString(text);
contentStream.endText();
//textx += colWidth;
}
if (i<0) {
texty-=firstRowHeight;
}
else {
texty-=rowHeight;
}
//texty-=rowHeight;
//System.out.println("==texty in ifcondition===="+texty);
/*if(i==2){
	textx = margin+cellMargin+50;
}
else{
	textx = margin+cellMargin+50;
}*/

textx = margin+cellMargin+50;
}

//System.out.println("==textx===="+textx);

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


//System.out.println("==575-tableHeight===575-"+tableHeight);

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
    
    
