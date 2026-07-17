package com.operations.marketing.quotation;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

import com.mailwithpdf.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.documentinterchange.taggedpdf.PDLayoutAttributeObject;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.encryption.AccessPermission;
import org.apache.pdfbox.pdmodel.encryption.StandardProtectionPolicy;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDPixelMap;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDXObjectImage;
import org.apache.struts2.ServletActionContext;

import com.sun.jna.platform.win32.WinBase.SYSTEM_INFO;

public class ClspdfCreate {

    public  void newLocal (String client,String address,String mob,String email,String pname,String compname,
    		String compadd,String comptele,String compfax,String loc,String brnch,String date,int docno,
    		String filename,String recep,String path1,HashMap gridmap,String ginst,String inst,
    		ArrayList descarray,String genterms,String formcode,String cst,String tin,String servtax) throws Exception {
        String outputFileName = filename;
        
        System.out.println("=outputFileName===="+outputFileName);
        
        // Create a document and add a page to it
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
        cos.addLine(50, 700, 560, 700);
        cos.closeAndStroke();
        
   
        /*cos.setLineWidth((float) .5);
        cos.addLine(50, 640, 560, 640);
        cos.closeAndStroke();*/
        
        cos.beginText();
        cos.setFont(fontBold, 10);
        //cos.setNonStrokingColor(Color.RED);
        //cos.moveTextPositionByAmount(300, rect.getHeight() - 50*(++line));
        cos.moveTextPositionByAmount(300, 740);
        cos.drawString(pname);
        cos.endText();
        
        
        System.out.println("what is dis"+rect.getHeight());
        // Define a text content stream using the selected font, move the cursor and draw some text
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 20*(++line));
        cos.moveTextPositionByAmount(470, 800);
        cos.drawString(compname);
        cos.endText();
        
       /* System.out.println("what is dis===="+rect.getHeight() - 50*(++line));*/
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 790);
        cos.drawString(compadd);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 780);
        cos.drawString("TELE:"+comptele);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 770);
        cos.drawString("FAX: "+compfax);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 760);
        cos.drawString("BRANCH : "+brnch);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 750);
        cos.drawString("LOCATION : "+loc);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 740);
        cos.drawString("Service Tax : "+servtax);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 730);
        cos.drawString("TIN No : "+tin);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 720);
        cos.drawString("CST No : "+cst);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 685);
        cos.drawString("Customer Name :  "+client);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 675);
        cos.drawString("Address :  "+address);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 665);
        cos.drawString("Tel :  "+mob);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(80, 655);
        cos.drawString("E-Mail :  "+email);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(470, 685);
        cos.drawString("DocNo : "+docno);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(470, 675);
        cos.drawString("Date : "+date);
        cos.endText();
        
   
        
        drawTable(page1,cos,
        		600,50,gridmap,ginst,genterms,descarray,inst
        		);
        
        
        // Make sure that the content stream is closed:
        cos.close();


        /*int keyLength = 128;

        AccessPermission ap = new AccessPermission();

        // disable printing, everything else is allowed
        ap.setCanPrint(false);

        // owner password (to open the file with all permissions) is "12345"
        // user password (to open the file but with restricted permissions, is empty here) 
        StandardProtectionPolicy spp = new StandardProtectionPolicy("12345", "", ap);
        spp.setEncryptionKeyLength(keyLength);
        spp.setPermissions(ap);
        document.protect(spp);
*/
       // Save the results and ensure that the document is properly closed:
        //document.addPage(page1);
        document.save(outputFileName);
        document.close();
        
        Thread.sleep(1000);
        File saveFile=new File(outputFileName);
        SendEmailAction sendmail= new SendEmailAction();
        HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();  
		
        //sendmail.SendTomail(saveFile,formcode,recep);
        sendmail.SendTomail( saveFile,formcode,recep,String.valueOf(docno),session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),client);
        
    }
    
    
    public  void newCommon (String client,String address,String mob,String email,String pname,String compname,
    		String compadd,String comptele,String compfax,String loc,String brnch,String date,int docno,
    		String filename,String recep,String path1,HashMap gridmap,String ginst,String inst,
    		ArrayList descarray,String genterms,String formcode) throws Exception {
        String outputFileName = filename;
        
        System.out.println("=outputFileName===="+outputFileName);
        
        // Create a document and add a page to it
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
        cos.addLine(50, 700, 560, 700);
        cos.closeAndStroke();
        
   
        /*cos.setLineWidth((float) .5);
        cos.addLine(50, 640, 560, 640);
        cos.closeAndStroke();*/
        
        cos.beginText();
        cos.setFont(fontBold, 10);
        //cos.setNonStrokingColor(Color.RED);
        //cos.moveTextPositionByAmount(300, rect.getHeight() - 50*(++line));
        cos.moveTextPositionByAmount(300, 740);
        cos.drawString(pname);
        cos.endText();
        
        
        System.out.println("what is dis"+rect.getHeight());
        // Define a text content stream using the selected font, move the cursor and draw some text
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 20*(++line));
        cos.moveTextPositionByAmount(470, 775);
        cos.drawString(compname);
        cos.endText();
        
       /* System.out.println("what is dis===="+rect.getHeight() - 50*(++line));*/
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 765);
        cos.drawString(compadd);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 755);
        cos.drawString("TELE:"+comptele);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 745);
        cos.drawString("FAX: "+compfax);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 735);
        cos.drawString("BRANCH : "+brnch);
        cos.endText();
        
        cos.beginText();
        cos.setFont(fontPlain, 6);
        //cos.moveTextPositionByAmount(500, rect.getHeight() - 19*(++line));
        cos.moveTextPositionByAmount(470, 725);
        cos.drawString("LOCATION : "+loc);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 685);
        cos.drawString("Customer Name :  "+client);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 675);
        cos.drawString("Address :  "+address);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        //cos.moveTextPositionByAmount(80, rect.getHeight() - 18*(++line));
        cos.moveTextPositionByAmount(80, 665);
        cos.drawString("Tel :  "+mob);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(80, 655);
        cos.drawString("E-Mail :  "+email);
        cos.endText();
        
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(500, 685);
        cos.drawString("DocNo : "+docno);
        cos.endText();
        
        
        cos.beginText();
        cos.setFont(fontBold, 6);
        cos.moveTextPositionByAmount(500, 675);
        cos.drawString("Date : "+date);
        cos.endText();
        
   
        
        drawTable(page1,cos,
        		600,50,gridmap,ginst,genterms,descarray,inst
        		);
        
        
        // Make sure that the content stream is closed:
        cos.close();


        /*int keyLength = 128;

        AccessPermission ap = new AccessPermission();

        // disable printing, everything else is allowed
        ap.setCanPrint(false);

        // owner password (to open the file with all permissions) is "12345"
        // user password (to open the file but with restricted permissions, is empty here) 
        StandardProtectionPolicy spp = new StandardProtectionPolicy("12345", "", ap);
        spp.setEncryptionKeyLength(keyLength);
        spp.setPermissions(ap);
        document.protect(spp);
*/
       // Save the results and ensure that the document is properly closed:
        //document.addPage(page1);
        document.save(outputFileName);
        document.close();
        
        Thread.sleep(1000);
        File saveFile=new File(outputFileName);
        SendEmailAction sendmail= new SendEmailAction();
        HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
        //sendmail.SendTomail(saveFile,formcode,recep);
        sendmail.SendTomail( saveFile,formcode,recep,String.valueOf(docno),session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),client);
        
    }
    
    
    public  void drawTable(PDPage page, PDPageContentStream contentStream,
            float y, float margin,HashMap gridmap,String ginst,String genterms,ArrayList descarray,String inst) throws IOException {
final int rows = gridmap.size()+1;
final int cols =11;
final float firstRowHeight = 30f;
final float rowHeight = 20f;
final float colWidth = 45.6f; //tableWidth/(float)cols;
final float tableWidth = colWidth * cols; //page.findMediaBox().getWidth()-(2*margin);
//final float tableWidth =590;
final float tableHeight = rowHeight * rows + firstRowHeight - rowHeight; 

System.out.println("===tableHeight===="+tableHeight);

final float cellMargin= 1f;
/*PDRectangle rectangle = new PDRectangle();
rectangle.setLowerLeftX(10);
rectangle.setLowerLeftY(10);
rectangle.setUpperRightX(10);
rectangle.setUpperRightY(10);
page.setMediaBox(rectangle);
page.setCropBox(rectangle);*/
String  headingArray[]={"SLNO","BRAND","MODEL","SPECIFICATION","YOM","COLOUR","RENTALTYPE","TARIFF","UNIT","DAYS","GROUP"};

//draw the rows
float nexty = y ;
System.out.println("==rows======"+rows);
for (int i = 0; i <= rows; i++) {
//contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
if (i<=0) {
	contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
nexty-= firstRowHeight;
} 

else if (i==rows) {
	contentStream.drawLine(margin,nexty,margin+tableWidth,nexty);
nexty-= firstRowHeight;
}
else {
nexty-= rowHeight;
}
}
//25+60+90+70+30+40+60+50+40+40+55;
//draw the columns
float nextx = margin;
for (int i = 0; i <= cols; i++) {
	
	/*if(i==0){
		nextx=nextx+25;
	}
	else*/ if(i==1){
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

System.out.println("===nextx==inside loop"+nextx);

}

//now add the text

contentStream.setLineWidth(1);
float textx = margin+cellMargin;



float texty = y-15;
//int o = content.length;
int clno=0;
for(int i = 0; i <rows; i++){
	
for(int j = 0 ; j <cols; j++){
	
	
	/*if(j==0){
		textx=textx+25;
	}
	else*/ if(j==1){
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
 System.out.println("==textx===="+textx);
contentStream.moveTextPositionByAmount(textx,texty-6);
//contentStream.setTextRotation(90*Math.PI*0.25,textx+5,texty-6);
}


else {
	contentStream.setFont(PDType1Font.HELVETICA,5);
	contentStream.setNonStrokingColor(Color.BLACK);
	System.out.println("= gridmap.get(i)======"+ gridmap.get(i));
	ArrayList testExtracted = (ArrayList) gridmap.get(i);
	System.out.println("teeeexxxxttttt"+testExtracted.get(j).toString());
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
System.out.println("===clnoclnoclnoclnoclnoclno====="+clno);
if(i==2){
	textx = margin+cellMargin;
}
else{
	textx = margin+cellMargin;
}
System.out.println("===ginst=hbhbhb==="+ginst);
}
if(!(ginst==null)){
	System.out.println("ginst inside null check");
contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA_BOLD, 7);
contentStream.moveTextPositionByAmount(50, 550-tableHeight);
contentStream.drawString(ginst);
contentStream.endText();

contentStream.setLineWidth((float) .5);
contentStream.addLine(50, 545-tableHeight, 180, 545-tableHeight);
contentStream.closeAndStroke();


contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 7);
contentStream.moveTextPositionByAmount(50, 530-tableHeight);
contentStream.drawString(genterms);
contentStream.endText();
}
System.out.println("==inst==="+inst);
if(descarray.size()>0){
contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA_BOLD, 7);
contentStream.moveTextPositionByAmount(50, 500-tableHeight);
contentStream.drawString(inst);
contentStream.endText();

contentStream.setLineWidth((float) .5);
contentStream.addLine(50, 495-tableHeight, 140, 495-tableHeight);
contentStream.closeAndStroke();

int j=1;
for (int i = 0; i < descarray.size(); i++) {

	System.out.println("descarray.size()"+descarray.size());
	
	System.out.println("jkjnhjjnhjnjkjnjjnj"+descarray.get(i));
	
	
	contentStream.beginText();
	contentStream.setFont(PDType1Font.HELVETICA, 7);
	contentStream.moveTextPositionByAmount(50, 475-tableHeight-j);
	contentStream.drawString(descarray.get(i).toString());
	contentStream.endText();

	j=j+15;
}


}

contentStream.beginText();
contentStream.setFont(PDType1Font.HELVETICA, 7);
contentStream.moveTextPositionByAmount(270, 45);
contentStream.drawString("PoweredBy GateWayERP");
contentStream.endText();
}
 
    
       
    

	
}