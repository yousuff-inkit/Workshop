package com.operations.commtransactions.rentalreceipts;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

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

import com.sun.jna.platform.win32.WinBase.SYSTEM_INFO;
import com.sun.jna.platform.win32.WinDef.LPARAM;

public class ClspdfCreate {
	
	
	
    public  void pdfCreateLocal (String formcode,String filename,String compname,String compadd,String tele,String compfax,String loc,String branch,
    		String cstno,String tinno,String servtax,String client,
    		String receiptno,String receiptdate,String rentalno,String rentaltype,String refno,String contractstart,String advsec,String desc,
    		String cardno,String cardexp,String chqno,String chqdate,String paymode,String amount,String amtinwords,String total,String preparedby,
    		ArrayList printapplyingsarray,HttpSession session,String path1,String recep,int isindian) throws Exception {
        String outputFileName = filename;
        

       
        try{
        	
       
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		java.util.Date dates = new java.util.Date();
		System.out.println(dateFormat.format(dates)); //2014/08/06 15:59:48
		
		
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
        cos.drawString("RENTAL RECEIPT");
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
        
        if(isindian==1){
        	
        
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
        cos.drawString("Received With Thanks From  ");
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 695);
        cos.drawString("     "+client);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(300, 705);
        cos.drawString("RA No. :  "+rentalno);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(300, 695);
        cos.drawString("RA Type :  "+rentaltype);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(300, 685);
        cos.drawString("Ref No. :  "+refno);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(450, 705);
        cos.drawString("Receipt No. :  "+receiptno);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(450, 695);
        cos.drawString("Receipt Date :  "+receiptdate);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(450, 685);
        cos.drawString("Contract Start :  "+contractstart);
        cos.endText();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 650, 560, 650);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 630, 560, 630);
        cos.closeAndStroke();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 630, 50, 650);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(320, 630, 320, 650);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(450, 630, 450, 650);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(560, 630, 560, 650);
        cos.closeAndStroke();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(170, 640);
        cos.drawString("Description");
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(370, 640);
        cos.drawString("Payment Mode");
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(520, 640);
        cos.drawString("Amount");
        cos.endText();
        
        
        //.............................................................................
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 630, 560, 630);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 570, 560, 570);
        cos.closeAndStroke();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 570, 50, 630);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(320, 570, 320, 630);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(450, 570, 450, 630);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(560, 570, 560, 630);
        cos.closeAndStroke();
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 622);
        cos.drawString(advsec);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 615);
        cos.drawString(desc);
        cos.endText();
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 605);
        cos.drawString("Card No.  "+cardno);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 595);
        cos.drawString("Cheque No.  "+chqno);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(250, 605);
        cos.drawString("Card Exp.  "+cardexp);
        cos.endText();
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(250, 595);
        cos.drawString("Cheque Date.  "+chqdate);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(370, 605);
        cos.drawString(paymode);
        cos.endText();
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(520, 605);
        cos.drawString(amount);
        cos.endText();
        
        //---------------------------------------------------------------------------------
             
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 570, 560, 570);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 550, 560, 550);
        cos.closeAndStroke();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 550, 50, 570);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(320, 550, 320, 570);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(450, 550, 450, 570);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(560, 550, 560, 570);
        cos.closeAndStroke();

        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA_BOLD, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(60, 560);
        cos.drawString("Amount In Words  :"+amtinwords);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA_BOLD, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(430, 560);
        cos.drawString("Total");
        cos.endText();
        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA_BOLD, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(540-total.length()*2, 560);
        cos.drawString(total);
        cos.endText();
        
        //--------------------------------------------------------------------------------
        
        if(printapplyingsarray.size()>0){
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 530, 560, 530);
        cos.closeAndStroke();
        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 510, 560, 510);
        cos.closeAndStroke();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(50, 510, 50, 530);
        cos.closeAndStroke();
        
/*        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(320, 510, 320, 530);
        cos.closeAndStroke();
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(450, 510, 450, 530);
        cos.closeAndStroke();
*/        
        
        cos.setLineWidth((float) .5);
        //cos.setLineCapStyle(0);
        cos.addLine(560, 510, 560, 530);
        cos.closeAndStroke();

        
        cos.beginText();
        cos.setFont(PDType1Font.HELVETICA_BOLD, 8);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(60, 515);
        cos.drawString("APPLYING");
        cos.endText();
        }
        detailTable(page1,cos,510,50,printapplyingsarray,preparedby,currdate,session);
        
        
        // Make sure that the content stream is closed:
        cos.close();

       // Save the results and ensure that the document is properly closed:
        document.save(outputFileName);
        document.close();
        Thread.sleep(1000);
        File saveFile=new File(outputFileName);
        SendEmailAction sendmail= new SendEmailAction();
        
        //sendmail.SendTomail(saveFile,formcode,recep);
        sendmail.SendTomail( saveFile,formcode,recep,receiptno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),client);
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        
        
    }
    
    
    
    
    
    public  void detailTable(PDPage page, PDPageContentStream contentStream,
            float y, float margin,ArrayList pApplyArrayList,String preparedby,String currdate,HttpSession session) throws IOException {
final int rows = pApplyArrayList.size();
final int cols =10;
final float firstRowHeight = 25f;
final float rowHeight = 15f;
final float colWidth = 45.6f;
final float tableWidth =560;
final float tableHeight = rowHeight * rows + firstRowHeight - rowHeight; 
final float cellMargin= 4f;



String username=session.getAttribute("USERNAME").toString();

String  headingArray[]={"Sr.No","Doc.No","Doc Type","Date","Ref Type","Ref No.","Remarks","Amount","Applying","Balance"};


try{
	
//draw the rows
float nexty = y ;

//contentStream.drawLine(margin+50,nexty,margin+250+tableWidth,nexty);
//contentStream.drawLine(margin+50,y-tableHeight,margin+250+tableWidth,y-tableHeight);
//contentStream.drawLine(y,nexty,y-tableHeight,nexty);



	

for (int i = 0; i <= rows; i++) {
	//contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
if (i<=0) {
	if(rows>0){
		contentStream.drawLine(margin,nexty,tableWidth,nexty);
	}
	
nexty-= firstRowHeight;
} else {
nexty-= rowHeight;
}
}

float nextx = margin;
//contentStream.drawLine(margin+50,y,margin+50,y-tableHeight);
//contentStream.drawLine(margin+250+tableWidth,y,margin+250+tableWidth,y-tableHeight);
for (int i = -1; i <= cols; i++) {
	
	if(i==0){
		nextx=nextx;
	}
	else if(i==1){
		nextx=nextx+20;
	}
	else if(i==2){
		nextx=nextx+40;
	}
	else if(i==3){
		nextx=nextx+35;
	}
	else if(i==4){
		nextx=nextx+45;
	}
	else if(i==5){
		nextx=nextx+35;
	}
	else if(i==6){
		nextx=nextx+35;
	}
	else if(i==7){
		nextx=nextx+165;
	}
	else if(i==8){
		nextx=nextx+45;
	}
	else if(i==9){
		nextx=nextx+45;
	}
	else if(i==10){
		nextx=nextx+45;
	}

System.out.println();	
	
//contentStream.drawLine(nextx,y,nextx,y-tableHeight);

}

contentStream.setLineWidth((float) .5);
float textx = margin+cellMargin;



float texty = y-15;
//int o = content.length;
int clno=0;
for(int i = -1; i <rows; i++){
	
for(int j = 0 ; j <cols; j++){
	
	
	if(j==0){
		textx=textx;
	}
	else if(j==1){
		textx=textx+20;
	}
	else if(j==2){
		textx=textx+40;
	}
	else if(j==3){
		textx=textx+35;
	}
	else if(j==4){
		textx=textx+45;
	}
	else if(j==5){
		textx=textx+35;
	}
	else if(j==6){
		textx=textx+35;
	}
	else if(j==7){
		textx=textx+165;
	}
	else if(j==8){
		textx=textx+45;
	}
	else if(j==9){
		textx=textx+45;
	}
	else if(j==10){
		textx=textx+45;
	}
	
	clno=j;
String text = "";
if(rows>0){
contentStream.beginText();
if (i<0) {   
	contentStream.setNonStrokingColor(Color.RED);
	contentStream.setFont(PDType1Font.HELVETICA_BOLD,6);
	text=headingArray[j];
contentStream.moveTextPositionByAmount(textx,texty);
}


else {
	contentStream.setFont(PDType1Font.HELVETICA,6);
	contentStream.setNonStrokingColor(Color.BLACK);
	
	
	String getcoldata=(String) pApplyArrayList.get(i);
    String getdata[]=getcoldata.split("::");
	text =getdata[j].toString();
contentStream.moveTextPositionByAmount(textx,texty); 
}

contentStream.drawString(text);
contentStream.endText();
}
}
if (i<0) {
texty-=firstRowHeight;
}


else {
texty-=rowHeight;
}
if(i==2){
	textx = margin+cellMargin;
}
else{
	textx = margin+cellMargin;
}
}


contentStream.setLineWidth((float) .5);
//contentStream.setLineCapStyle(0);
contentStream.addLine(50, texty, 560, texty);
contentStream.closeAndStroke();


contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 6);
contentStream.moveTextPositionByAmount(50,texty-20);
contentStream.drawString("Prepared By    :"+preparedby);
contentStream.endText();


contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 6);
contentStream.moveTextPositionByAmount(480,texty-20);
contentStream.drawString("Received By    :----------------");
contentStream.endText();


contentStream.setLineWidth((float) .5);
//contentStream.setLineCapStyle(0);
contentStream.addLine(50, 70, 560, 70);
contentStream.closeAndStroke();


contentStream.setLineWidth((float) .5);
//contentStream.setLineCapStyle(0);
contentStream.addLine(50, 60, 560, 60);
contentStream.closeAndStroke();

contentStream.setLineWidth((float) .5);
//contentStream.setLineCapStyle(0);
contentStream.addLine(50, 60, 50, 70);
contentStream.closeAndStroke();

contentStream.setLineWidth((float) .5);
//contentStream.setLineCapStyle(0);
contentStream.addLine(560, 60, 560, 70);
contentStream.closeAndStroke();

contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 6);
contentStream.moveTextPositionByAmount(230, 64);
contentStream.drawString("System Generated Document,Signature and Stamp not Required");
contentStream.endText();

contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 6);
contentStream.moveTextPositionByAmount(270, 44);
contentStream.drawString("PoweredBy GateWayERP");
contentStream.endText();

contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA,5);
contentStream.moveTextPositionByAmount(70, 44);
contentStream.drawString("Printed by "+username+" on "+currdate);
contentStream.endText();


}
catch(Exception e){
	e.printStackTrace();
}

    }
        
    
}
    
    
