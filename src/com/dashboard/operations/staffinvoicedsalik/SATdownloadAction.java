package com.dashboard.operations.staffinvoicedsalik;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import org.openqa.selenium.support.ui.Select;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.NewSatDownload.SATdownloadDAO;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.bcel.internal.generic.DCONST;
import com.sun.xml.internal.ws.api.server.Adapter.Toolkit;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.imageio.ImageIO;

import org.apache.catalina.connector.Request;
import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.jetty.html.Image;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.Point;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.Capabilities;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.seleniumhq.jetty7.io.BufferCache;
import org.openqa.selenium.OutputType.*;


public class SATdownloadAction extends TimerTask {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	private  final Logger log = Logger.getLogger( SATdownloadAction.class.getName() );

	private  final String JAVASCRIPT_SRC = 
			" var impl = { " +
					"     run: function() { " +
					"         println ('Hello, World!'); " +
					"     } " +
					" }; ";

	private String category="";
	private String hiddencategory="";
	private String chck_salikautomatic="";
	private String cmbsaliksite="";
	private String hidcmbsaliksite="";
	private String cmbtype="ldays";
	private String hidcmbtype="";
	private String jqxStartDate="";
	private String jqxEndDate="";
	private String hidjqxStartDate="";
	private String hidjqxEndDate="";
	private String txtusername="";
	private String txtsalikfleetno="";
	private String txtsalikregno="";
	private String txtsaliktagno="";
	private String docs="0";
	private String captcha="";
	//private boolean radio_traffic=false;
	private String chck_trafficautomatic="";
	private String cmbtrafficsite="";
	private String hidcmbtrafficsite="";
	private String chck_trafficfileno="";
	private String txttrafficplateno="";
	private String txtsalikplatecode="";
	private String txttrafficcategory="";
	private String txttrafficauthority="";
	private String captchapath="";
	private int captchacount=0;
	private int iscaptcha=0;
	private String txtdescription="";
	private String captchatxt;
	private String msg;
	private int iscaptchaloaded=0;
	private String hidChck_trafficfileno="";



	public String getHidChck_trafficfileno() {
		return hidChck_trafficfileno;
	}

	public void setHidChck_trafficfileno(String hidChck_trafficfileno) {
		this.hidChck_trafficfileno = hidChck_trafficfileno;
	}

	public int getIscaptchaloaded() {
		return iscaptchaloaded;
	}

	public void setIscaptchaloaded(int iscaptchaloaded) {
		this.iscaptchaloaded = iscaptchaloaded;
	}

	public String getTxtsalikregno() {
		return txtsalikregno;
	}

	public void setTxtsalikregno(String txtsalikregno) {
		this.txtsalikregno = txtsalikregno;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getIscaptcha() {
		return iscaptcha;
	}

	public void setIscaptcha(int iscaptcha) {
		this.iscaptcha = iscaptcha;
	}

	public int getCaptchacount() {
		return captchacount;
	}

	public void setCaptchacount(int captchacount) {
		this.captchacount = captchacount;
	}

	public String getCaptchapath() {
		return captchapath;
	}

	public void setCaptchapath(String captchapath) {
		this.captchapath = captchapath;
	}

	public String getCaptchatxt() {
		return captchatxt;
	}

	public void setCaptchatxt(String captchatxt) {
		this.captchatxt = captchatxt;
	}

	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	public String getHiddencategory() {
		return hiddencategory;
	}
	public void setHiddencategory(String hiddencategory) {
		this.hiddencategory = hiddencategory;
	}
	public String getDocs() {
		return docs;
	}
	public void setDocs(String docs) {
		this.docs = docs;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	//	public boolean isCategory() {
	//		return category;
	//	}
	//	public void setCategory(boolean category) {
	//		this.category = category;
	//	}




	public String getChck_salikautomatic() {
		return chck_salikautomatic;
	}
	public void setChck_salikautomatic(String chck_salikautomatic) {
		this.chck_salikautomatic = chck_salikautomatic;
	}
	public String getCmbsaliksite() {
		return cmbsaliksite;
	}
	public void setCmbsaliksite(String cmbsaliksite) {
		this.cmbsaliksite = cmbsaliksite;
	}


	public String getHidcmbsaliksite() {
		return hidcmbsaliksite;
	}
	public void setHidcmbsaliksite(String hidcmbsaliksite) {
		this.hidcmbsaliksite = hidcmbsaliksite;
	}





	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}


	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}


	public String getJqxStartDate() {
		return jqxStartDate;
	}
	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}





	public String getJqxEndDate() {
		return jqxEndDate;
	}
	public void setJqxEndDate(String jqxEndDate) {
		this.jqxEndDate = jqxEndDate;
	}


	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}
	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}


	public String getHidjqxEndDate() {
		return hidjqxEndDate;
	}
	public void setHidjqxEndDate(String hidjqxEndDate) {
		this.hidjqxEndDate = hidjqxEndDate;
	}





	public String getTxtusername() {
		return txtusername;
	}
	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}


	public String getTxtsalikfleetno() {
		return txtsalikfleetno;
	}
	public void setTxtsalikfleetno(String txtsalikfleetno) {
		this.txtsalikfleetno = txtsalikfleetno;
	}


	public String getTxtsaliktagno() {
		return txtsaliktagno;
	}
	public void setTxtsaliktagno(String txtsaliktagno) {
		this.txtsaliktagno = txtsaliktagno;
	}



	public void setChck_trafficautomatic(String chck_trafficautomatic) {
		this.chck_trafficautomatic = chck_trafficautomatic;
	}
	private String getChck_trafficautomatic() {
		// TODO Auto-generated method stub
		return  chck_trafficautomatic;
	}

	public String getCmbtrafficsite() {
		return cmbtrafficsite;
	}
	public void setCmbtrafficsite(String cmbtrafficsite) {
		this.cmbtrafficsite = cmbtrafficsite;
	}


	public String getHidcmbtrafficsite() {
		return hidcmbtrafficsite;
	}
	public void setHidcmbtrafficsite(String hidcmbtrafficsite) {
		this.hidcmbtrafficsite = hidcmbtrafficsite;
	}


	public String getChck_trafficfileno() {
		return chck_trafficfileno;
	}
	public void setChck_trafficfileno(String chck_trafficfileno) {
		this.chck_trafficfileno = chck_trafficfileno;
	}





	public String getTxttrafficplateno() {
		return txttrafficplateno;
	}
	public void setTxttrafficplateno(String txttrafficplateno) {
		this.txttrafficplateno = txttrafficplateno;
	}





	public String getTxtsalikplatecode() {
		return txtsalikplatecode;
	}
	public void setTxtsalikplatecode(String txtsalikplatecode) {
		this.txtsalikplatecode = txtsalikplatecode;
	}


	public String getTxttrafficcategory() {
		return txttrafficcategory;
	}
	public void setTxttrafficcategory(String txttrafficcategory) {
		this.txttrafficcategory = txttrafficcategory;
	}



	public String getTxttrafficauthority() {
		return txttrafficauthority;
	}
	public void setTxttrafficauthority(String txttrafficauthority) {
		this.txttrafficauthority = txttrafficauthority;
	}


	 String url="",urldet="",ts="",pass="";
	 String browser="chrome";
	WebDriver driver=null;
	private  ChromeDriverService service;
	String defaultwindow = "";
	String popupwindow = "";
	Document docDet,doc;
	boolean flag=false;
	String fineno="",dat="0",time="",curPage="0",timeappend="",salik_fdate="" ;
	String [] tformat=new String[10];
	 int txtStPage=1;
	 int rollno=1;
	 int srno=0,xsasrno,xsadoc,serno=0,xdoc=0;
	int dno=0,excaptcha=0;;
	  String xdocs="0";
	String branch="";
	Connection conn = ClsConnection.getMyConnection();



	public void run() {


		String result="";
		ResultSet rsrun;
		String runquery="";
		Statement stmtrun =null;
		try{
			/*stmtrun=conn.createStatement();
			runquery="Select site, time_period, category, username, url, iscaptcha, password, remarks from gl_autowebid";

			rsrun=stmtrun.executeQuery(runquery);*/
			rsrun = conn.createStatement().executeQuery("Select site, time_period, category, username, url, iscaptcha, password, sitecheck from gl_webid where iscaptcha=0");

			while(rsrun.next())
			{	
				setCategory(rsrun.getString("category"));
				if(rsrun.getString("category").equalsIgnoreCase("traffic")){
					
					setChck_trafficautomatic(rsrun.getString("sitecheck"));
					setChck_trafficfileno(rsrun.getString("sitecheck"));
					setTxttrafficplateno(rsrun.getString("username"));
					setCmbtrafficsite(rsrun.getString("site"));
					
				}
				else if(rsrun.getString("category").equalsIgnoreCase("salik")){
					
					setTxtusername(rsrun.getString("username"));
					setCmbsaliksite(rsrun.getString("site"));
					setCmbtype(rsrun.getString("time_period"));
				}

				process();
			}

			result="success";
		}
		catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		finally{
		}
	}


	public String process() throws ParseException, SQLException{

		boolean result=false;

		//		HttpServletRequest request=ServletActionContext.getRequest();
		//		HttpSession session=request.getSession();


		try{


			String qryapnd="";

			txtusername=getTxtusername();
			category=getCategory();
			cmbsaliksite=getCmbsaliksite();

			setHiddencategory(getCategory());

//			System.out.println("=before===getCategory===="+getCategory());

			// chck_salikautomatic=getChck_salikautomatic();


			if(getCategory().equalsIgnoreCase("salik"))
			{

//				System.out.println("==getCategory===="+getCategory());

				/*if(getChck_salikautomatic().equalsIgnoreCase("salikautomatic"))
			 {*/

				if(cmbsaliksite.equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("salik"))
				{
//					System.out.println("==cmbsaliksite===="+cmbsaliksite);

//					System.out.println("==getCategory()===="+getCategory());

					setHidcmbsaliksite(getCmbsaliksite());
					if(txtusername==null ||txtusername.equalsIgnoreCase(""))
					{
						qryapnd="and 1=1" ;
					}
					else
					{
						qryapnd="and t.username='"+txtusername+"'";
					}
					ResultSet rssalik;
					try {

//						System.out.println("Select * from gl_webid t where t.site='DXB'"+qryapnd+"");
						rssalik = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' "+qryapnd+"");

						while(rssalik.next())
						{	
							ts=rssalik.getString("username");
							pass=rssalik.getString("password");
							excaptcha=rssalik.getInt("iscaptcha");
							setIscaptcha(excaptcha);
							url="https://customers.salik.ae/default.aspx?ReturnUrl=%2fModuleCustomer%2fDefault.aspx%3fculture%3deng&culture=eng";

						}
						try {

							Statement stmt1 = conn.createStatement();
							String strSql1 = "select captchaPath from my_comp";
							/*where comp_id='"+session.getAttribute("COMPANYID")+"'*/
//							System.out.println("==strSql1===="+strSql1);
							ResultSet rs1 = stmt1.executeQuery(strSql1);
							while(rs1.next ()) {
								setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");

							}



							result=loadfresh();
							if(result==true)
							{
								//								request.setAttribute("resultdata", result);	

							}
							setHiddencategory(getCategory());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}



				}

				//}


			}
			else if(getCategory().equalsIgnoreCase("traffic"))
			{
//				System.out.println("==traffic=getCategory()===="+getCategory());
//				System.out.println("==getChck_trafficfileno()=inside traffic=="+getChck_trafficfileno());
				if(getChck_trafficautomatic().equalsIgnoreCase("trafficautomatic"))
				{
					//System.out.println("Inside of getChck_salikautomatic");
					// System.out.println("===cmbsaliksite==="+cmbsaliksite);
					if(getCmbtrafficsite().equalsIgnoreCase("AUH") && getCategory().equalsIgnoreCase("traffic"))
					{
//						System.out.println("===getCmbtrafficsite()===="+getCmbtrafficsite());

//						System.out.println("===getCategory()===="+getCategory());

						setHidcmbtrafficsite(getCmbtrafficsite());

						try{
							String fileno="";

							if(!(getTxttrafficplateno().equals(""))){
								fileno="and t.username='"+getTxttrafficplateno()+"'";
							}
							else{
								fileno="and 1=1";

							}

							ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='AUH' "+fileno+"");

//							System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

							while(rstraffic.next())
							{
								ts=rstraffic.getString("username");
								url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&IT=TS&Culture=en";
								try{
									//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
									loadfresh();
								}catch (Exception ec) {ec.printStackTrace();}					   

							}
							//							rstraffic.close();
							//boolean sveflg= SaveFormData(1, con);
							//									if(sveflg)
							//									{
							//										
							//									}
						}catch(Exception ex){ex.printStackTrace();}

					}
					if(getCmbtrafficsite().equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("traffic")){
						try
						{
							setHidcmbtrafficsite(getCmbtrafficsite());	
							ResultSet rsTables = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='DXB'");
							while(rsTables.next())
							{	
								ts=rsTables.getString("username");
								url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?actionParam=doSearch&searchMethod=3&trafficFileNo="+rsTables.getString("username")+"";
								try{ loadfresh();}
								catch (Exception ec) {ec.printStackTrace();}
							}
							//							rsTables.close();
							//							 boolean sveflg= SaveFormData(1, con);
							//							 if(sveflg){}
						}catch(Exception ex){ex.printStackTrace();}



					}


				}
				else
				{

//					System.out.println("==getChck_trafficfileno()==="+getChck_trafficfileno());

					if(!(getChck_trafficfileno()==null))
					{

//						System.out.println("=inside=getChck_trafficfileno="+getChck_trafficfileno());

						setHidChck_trafficfileno(getChck_trafficfileno());
						if(getChck_trafficfileno().equalsIgnoreCase("filenumber")){

//							System.out.println("=inside=getChck_trafficfileno==filenumber="+getChck_trafficfileno());

//							System.out.println("==getCmbtrafficsite==="+getCmbtrafficsite()+"==getCategory="+getCategory());

							if(getCmbtrafficsite().equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("traffic")){

//								System.out.println("=inside=getCmbtrafficsite=DXB=filenumber="+getChck_trafficfileno());
								try{
									String fileno="";

									if(!(getTxttrafficplateno().equals(""))){
										fileno="and t.username='"+getTxttrafficplateno()+"'";
									}
									else{
										fileno="and 1=1";

									}

									ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='DXB' "+fileno+"");

//									System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

									while(rstraffic.next())
									{
										ts=rstraffic.getString("username");
										url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?actionParam=doSearch&searchMethod=3&trafficFileNo="+rstraffic.getString("username")+"";
										try{
											//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
											loadfresh();
										}catch (Exception ec) {ec.printStackTrace();}					   

									}
									//									rstraffic.close();
									//boolean sveflg= SaveFormData(1, con);
									//									if(sveflg)
									//									{
									//										
									//									}
								}catch(Exception ex){ex.printStackTrace();}



							}
							
						
							else if(getCmbtrafficsite().equalsIgnoreCase("AUH")&&getCategory().equalsIgnoreCase("traffic")){
//								System.out.println("===inisde AUH===getCmbtrafficsite==="+getCmbtrafficsite()+"==getCategory==="+getCategory());
								
								
								try{
									String fileno="";

									if(!(getTxttrafficplateno().equals(""))){
										fileno="and t.username='"+getTxttrafficplateno()+"'";
										
//										System.out.println("==fileno==="+fileno);
										
									}
									else{
										fileno="and 1=1";

									}

									ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='AUH' "+fileno+"");

//									System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

									while(rstraffic.next())
									{
										ts=rstraffic.getString("username");

										url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&IT=TS&Culture=en";
										
//										System.out.println("==url==="+url);
										
										try{
											//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
											loadfresh();
										}catch (Exception ec) {ec.printStackTrace();}					   

									}
									//									rstraffic.close();
									//boolean sveflg= SaveFormData(1, con);
									//									if(sveflg)
									//									{
									//										
									//									}
								}catch(Exception ex){ex.printStackTrace();}

							}

						}}


				}

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			reloaddata();
			setCmbsaliksite(getCmbsaliksite());
			setCmbtype(getCmbtype());
			String  path="";

			Statement stmt1 = conn.createStatement();
			String strSql1 = "select captchaPath from my_comp ";
			/*where comp_id='"+session.getAttribute("COMPANYID")+"'*/
//			System.out.println("==strSql1===="+strSql1);
			ResultSet rs1 = stmt1.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("captchaPath");

			}

			String imgPath = path+"/captcha.png";

			try
			{
				File temp=new File(imgPath);
				if (temp.exists()){


					temp.delete();

				}
			}
			catch(Exception e){
				e.printStackTrace();

			}
			//conn.close();
			driver.quit();
		}

		return "success";
	}



	public boolean loadfresh() throws IOException, InterruptedException, SQLException
	{
		boolean result=false;
		java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
		java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);



		driver = new FirefoxDriver();
		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		driver.get(url);
		defaultwindow = driver.getWindowHandle();


		doc= Jsoup.parse(driver.getPageSource());
		//	    if(getCategory().equalsIgnoreCase("traffic"))
		//	    {
		/*org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(2000,2000);
     	    driver.manage().window().setSize(screenResolution);
    	    driver.manage().window().setPosition(new Point(2000,2000));*/
		//	    }

		result=jsoupGetTableData(1);

		if(getCategory().equalsIgnoreCase("traffic"))
		{
			//driver.manage().window().setPosition(new Point(-2000, 0));

			if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
			{

				int rowsize=1500;
				String rowsizes=driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblNoTickets")).getText();

				rowsizes=rowsizes.substring(9, rowsizes.indexOf("-"));
				rowsizes=(Integer.parseInt(rowsizes)/50)+1+"";

				rowsize=Integer.parseInt(rowsizes);

				//gridViewPager
				/*String  rowsizeWebElement=driver.findElement(By.id("gridViewPager")).getText();
	        		System.out.println("=====rowsizeWebElement======rowsizeWebElement==="+rowsizeWebElement);*/
				for(int i=1;i<=rowsize;i++)
				{
					//	        			descriptionPane.setText(descriptionPane.getText()+"\n"+"Processing Page :"+i+"");
					//	        			descriptionPane.update(descriptionPane.getGraphics());

					if (driver instanceof JavascriptExecutor) 
						((JavascriptExecutor)driver).executeScript("__doPostBack('ctl00$ContentPlaceHolder1$gvTickets','Page$"+i+"');");


					WebElement we=null;
					int cnt=0;
					do
					{  
						Thread.sleep(800);//commented by krish
						we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_UpdateProgress1"));
						String style = we.getAttribute("style").trim();

						if (!style.equalsIgnoreCase("display: none;"))
							we=null;
						cnt++;
					}while(we==null && cnt<10);

					url=driver.getCurrentUrl();

					doc= Jsoup.parse(driver.getPageSource());
					if(getCategory().equalsIgnoreCase("traffic"))
						//	        			{
						//							 org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(2000,1000);
						//							 driver.manage().window().setSize(screenResolution);
						//							 driver.manage().window().setPosition(new Point(2000,1000));
						//	        			}

						result=jsoupGetTableData(i);
				}
			}

			if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
			{	        	

				WebElement rowsizeWebElement=driver.findElement(By.id("totalFinesAndAmountLabels"));


				int rowsize=1500;
				String rowsizes=driver.findElement(By.className("paginationCounts")).getText();

				String [] row=rowsizes.split("From");

				rowsizes=(Integer.parseInt(row[1].trim())/10)+1+"";

				rowsize=Integer.parseInt(rowsizes);

				for(int i=1;i< rowsize;i++)
				{

					if (driver instanceof JavascriptExecutor) {
						((JavascriptExecutor)driver).executeScript("goToPage("+i+"-1);");

					}


					WebElement we=null;
					int cnt=0;
					do
					{  
						Thread.sleep(1000);//commented by krish

						we = driver.findElement(By.id("noFinesRow"));

						String style = we.getAttribute("style").trim();

						if (!style.equalsIgnoreCase("display: block;"))
							we=null;
						cnt++;
					}while(we==null && cnt<10);

					url=driver.getCurrentUrl();

					doc= Jsoup.parse(driver.getPageSource());

					result=jsoupGetTableData(i);
				}
			}
		}

		if(getCategory().equalsIgnoreCase("salik"))
		{ 
			if(getCmbsaliksite().equalsIgnoreCase("DXB"))	
			{
				if(flag)
				{
					String k="";
					int d=Integer.parseInt(dat);
					int stpage =txtStPage;
					int count=2,i;

					//int stimer=0;						

					for(i=2;i<=d;i++)
					{
						boolean getdata = true;
						k=String.valueOf((i));
						if(Integer.parseInt(k)<10) k="0"+k;
						WebElement s;
						try
						{

							//	stimer=(i%2==0?30:(i%11==0?6:15));		//15 and 30 for alternate page. for next set of pages 6 seconds.

							if ((i-1)==1){

								//inputCaptcha("Processing "+i+" of "+d+" Pages");
							}


							//Thread.sleep(15*1000);//commented by krish

							if(stpage>d)
							{
								//JOptionPane.showMessageDialog(this.getParent(),MyLib.getUID("Start Page# exceeds total no. of pages - "+d));
								driver.quit();
								return false;
							}
							else if (stpage>1 && i<stpage)
							{
								if (stpage <= (i+(10-(i%10))))
								{

									s=driver.findElement(By.partialLinkText(String.valueOf(stpage)));
									s.click();
									i=stpage;
								}
								else
								{


									s=driver.findElement(By.xpath("//*[@title='Next pages']"));
									s.click();
									i+=(10-(i%10));

									getdata=false;
								}
							}
							else
							{

								s=driver.findElement(By.linkText(String.valueOf(i)));
								//s=driver.findElement(By.partialLinkText(String.valueOf((i))));   				
								s.click();
							}
						}
						catch (Exception e)
						{
							try
							{
								e.printStackTrace();

								s=driver.findElement(By.xpath("//*[@title='Next page']"));
								s.click();
							}catch(Exception e1)
							{
								e1.printStackTrace();

								driver.quit();

								//									 int response = JOptionPane.showConfirmDialog(this.getParent(), "Website Server Error! Do you want to resume?", "Confirm",
								//						            		 JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
								//			ck			             
								//						             if (response == JOptionPane.NO_OPTION) return;

								txtStPage=i-1;						             
								loadfresh();
							}
						}
						/*if (driver instanceof JavascriptExecutor) {       		

				       			((JavascriptExecutor)driver).executeScript("AjaxNS.AR('ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl"+k+"','', 'WorkSpace_ctlCustAVIHistory_ajxResultPanel', event);");
				       			String s="ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl10";

				       		 }*/

						doc=null;
						//int cnt=0;
						//							Elements taEl=null;
						//							do
						//							{
						//								//Thread.sleep(30000);
						//								//if(cnt%2==0)
						//								doc= Jsoup.parse(driver.getPageSource()); 
						//								taEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
						//								//cnt++;
						//								count++;
						//							}while(taEl.isEmpty());

						WebElement we=null;
						int cnt=0;
						do
						{  
							if(count==d)
							{

								Thread.sleep(1000);	
							}
							//Thread.sleep(1000);//--commented by krish
							we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
							String style = we.getAttribute("style").trim();

							if (!style.isEmpty())
								we=null;
							cnt++;
						}while(we==null && cnt<10);
						count++;
						//	 Thread.sleep(20000);


						url=driver.getCurrentUrl();

						//  doc= Jsoup.parse(driver.getPageSource());


						if (getdata)
							result=jsoupGetTableData(i);

						if(count>d)
						{
							//Thread.sleep(5000);
							//loadData();
							Thread.interrupted();
							driver.quit();
						}
						//  count++;
					}
				}
			}
		}
		return result;
	}

	public boolean jsoupGetTableData(int v) throws IOException, InterruptedException, SQLException
	{
		ScriptEngineManager factory = new ScriptEngineManager();
		// create a JavaScript engine

		// evaluate JavaScript code from String

		//		HttpServletRequest request=ServletActionContext.getRequest();
		//		HttpSession session=request.getSession();

		//branch=session.getAttribute("BRANCHID").toString();
		//Connection conn = ClsConnection.getMyConnection();


		boolean result=false;
		//  doc = Jsoup.connect(url).get();
		Elements tableElements = null;
		//Elements detElements = null;
		// WebElement webel=null;
		Elements rowItems=null;
		Elements roi=null;
		PreparedStatement prepst,iprepst;
		String textdescription="";


		//DXB//
		if(getCategory().equalsIgnoreCase("traffic"))
		{			 

			if(getCmbtrafficsite().trim().equalsIgnoreCase("DXB"))
			{
				tableElements = doc.select("table.srchrsult");//div#pnlResults

			}
			else if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
			{
				tableElements = doc.select("table#ctl00_ContentPlaceHolder1_gvTickets");
				tableElements.size();
			}
			Elements tableHeaderEles = tableElements.select("thead tr th");

			for (int i = 0; i < tableHeaderEles.size(); i++) 
			{


			}


			try{
				ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");

				if(rs.next())
				{	

					dno=rs.getInt("max");

					xdoc=dno;
					xdocs=xdocs+","+xdoc;

				}
				//				request.setAttribute("trxdocs", xdocs);
				setDocs(String.valueOf(xdocs));
			}catch (Exception e2) {e2.printStackTrace();}



			Elements tableRowElements = tableElements.select(":not(thead) tr");
			String k="";
			for (int i = 0; i < tableRowElements.size(); i++) 
			{


				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					k=String.valueOf((i+1));
					if(Integer.parseInt(k)<10)
						k="0"+k;
				}



				String aid="ctl00_ContentPlaceHolder1_gvTickets_ctl"+k+"_HyperLink1";
				Element row = tableRowElements.get(i);

				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					Element r=tableRowElements.get(1);
					roi=r.select("td");


					if(row.className().equalsIgnoreCase("")||row.className().equalsIgnoreCase("gridViewFooter")
							||row.className().equalsIgnoreCase("gridViewPager"))
					{
						/* flag=true;
 				    	   dat = rowItems.get(0).text();
 				    	   System.out.println(dat+" - "+curPage+" - "+dat.substring(dat.indexOf("Displaying page")+15, dat.indexOf("of")));
 				    	   dat=dat.substring(dat.indexOf("of")+1);
 				    	   dat=dat.substring(0,dat.indexOf(','));
 				    	   dat=dat.substring(dat.indexOf(' ')+1);
						 */
						continue;
					}
				}

				rowItems = row.select("td");


				if(rowItems.size()>0)
				{
					if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
					{
						rowItems = row.select("td");

					}
				}
				String data="",disc="",Fees="",remark="";
				String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="";
				java.sql.Date date = null,traffic_date=null;

				for (int j = 0; j < rowItems.size(); j++) 
				{	


					data=rowItems.get(j).text();



					if(getCmbtrafficsite().equalsIgnoreCase("AUH")){



						if(j==3){

							Fees=data;
						}
						if(j==5){

							disc=data;

						}

						if(j==4){

							remark=data;
						}

						if(rowItems.get(j).text().equalsIgnoreCase("Details.."))
						{


							new Actions(driver).moveToElement(driver.findElement(By.xpath("//a[@id='"+aid+"']")));
							driver.findElement(By.xpath("//a[@id='"+aid+"']")).click();

							popupwindow=driver.getWindowHandle();
							driver.switchTo().window(popupwindow);
							//driver.switchTo().alert().dismiss();


							//Thread.sleep(15000);
							detailsNewlyOpenedwindow(disc,Fees,srno+i,remark,i);

						}
					}  
					String vio="Black Points:";
					if(getCmbtrafficsite().equalsIgnoreCase("DXB")){


						if(j==1){

							data = rowItems.get(j).text();

							data = rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );


							DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

							data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

							try {
								java.util.Date date1 = formatter.parse(data);
								java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
								//fBrowse.cache.setData("traffic_date", dtvalue);
								traffic_date=dtvalue;

							} catch (ParseException e) {e.printStackTrace();} 

							Time=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

						}
						if(j==2){ 



							fine_Source=rowItems.get(j).text();

						}
						if(j==3){ 

							String s = rowItems.get(j).text().trim();
							//System.out.println("==s====="+s.length());
							if(s.length()>1){

								s = s.substring(s.indexOf(' ') + 1);

								//System.out.println("===sssssss====="+s);

								s = s.substring(0, s.indexOf(' ')); 
								String plc="",plcat="";
								if(s.length()>3){
									plc=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);
									plcat=s;

								}  else{
									plc=s;
									plcat=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

								}
								regNo=rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );
								PlateCategory=plcat;

								pcolor=plc;

							}
							else{
								PlateCategory="";
								pcolor="";
							}
						}
						if(j==4){ 

							Amount=rowItems.get(j).text();

						}
						if(j==5){ 

							vio=vio+rowItems.get(j).text();

						}
						if(j==6){ 

							Ticket_No=rowItems.get(j).text();

						}

						if(j==7){ 

							vio=vio+rowItems.get(5).text()+"  "+rowItems.get(j).text();
							Tick_violat=vio;

							DESC1=vio;

						}
						java.util.Date dates=new  java.util.Date();


						date=ClsCommon.getSqlDate(dates);

						type="TRF";

						if(j==20){


						}

					}

				}

				if(rowItems!=null&&rowItems.size()>0&&getCmbtrafficsite().equalsIgnoreCase("DXB"))
				{
					plate_source="Dubai";
					SATdownloadDAO dao=new SATdownloadDAO();
					if(regNo.length()>1)
					{
						regNo=regNo.substring(1,regNo.length());
					}
					else{
						regNo="0";
					}

					result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,Double.parseDouble(Amount),
							null,null,DESC1,null,type,category,srno+i,ts,xdoc,date,branch,plate_source,getCmbtrafficsite(),"",xdocs);

					rollno++;
					//System.out.println("==rollno====="+rollno);
				}

			}
			if(getCmbtrafficsite().equals("AUH"))
			{

				if(!fineno.equalsIgnoreCase(""))
				{
					if(fineno.equalsIgnoreCase(roi.get(0).text()))
					{
						//driver.quit();
					}
					else
					{
						fineno=roi.get(0).text();


					}
				}
				else	
					if(fineno.equalsIgnoreCase(""))
					{
						fineno=roi.get(0).text();

						// driver.quit();
					}
			}
		}
		else if(getCategory().equalsIgnoreCase("salik"))	//salik
		{
			Elements tabEl = null;
			Elements tableRowElements=null;
			if(v<=1)
			{
				//				 if(zone.equalsIgnoreCase("DXB"))
				//					 System.out.println("driver.getPageSource()--"+doc);
				//				 tableElements = doc.select("table#WorkSpace_Login1");
				//				 driver.findElement(By.id("WorkSpace_Login1_UserName")).sendKeys(ts);
				//				 driver.findElement(By.id("WorkSpace_Login1_Password")).sendKeys(pass);
				//				 WebElement submit = driver.findElement(By.id("WorkSpace_Login1_LoginButton"));

				tableElements = doc.select("table#ctl00_WorkSpace_Login1");
				driver.findElement(By.id("ctl00_WorkSpace_Login1_UserName")).sendKeys(ts);
				driver.findElement(By.id("ctl00_WorkSpace_Login1_Password")).sendKeys(pass);
				WebElement submit = driver.findElement(By.id("ctl00_WorkSpace_Login1_LoginButton"));


				submit.click();

				doc=null;

				doc= Jsoup.parse(driver.getPageSource());
				if(doc!=null)
				{

					driver.findElement(By.linkText("Trips")).click();
					//					 driver.findElement(By.id("ct100_WorkSpace_ctlCustAVIHistory_QuickDates1_rblQuickSearch_"+
					//							 (getCmbtype().equalsIgnoreCase("lhrs")?"0":
					//								 getCmbtype().equalsIgnoreCase("ldays")?"1":"2"))).click();
					//							 				 (rbL24Hrs.isSelected()?"0":
					//							 				  rbL7Days.isSelected()?"1":"2"))).click();

					driver.findElement(By.linkText("Trips")).click();
					driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_QuickDates1_rblQuickSearch_"+
							(getCmbtype().equalsIgnoreCase("lhrs")?"0":
								getCmbtype().equalsIgnoreCase("ldays")?"1":"2"))).click();
					setHidcmbtype(getCmbtype());
					/*driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_QuickDates1_rblQuickSearch_"+
							 "getCmbtype()")).click();*/

					if(!(getTxtsaliktagno().equalsIgnoreCase(""))){

						driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_TagNumberRadioButton")).click();
						driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_TextBoxTagNumber")).sendKeys(getTxtsaliktagno().trim());

					}



					if(getIscaptcha()>0){
						result= inputCaptcha("Retrieving Data...");
						if(result==false){
							return result;
						}
					}
					Thread.sleep(2000);
					driver.findElement(By.id("btnSearch")).click();



					try{
						ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

						if(rs.next())
						{	

							xsadoc=rs.getInt("max");

							xdocs=xdocs+","+xsadoc;	
							xsasrno=0;
						}
						//						request.setAttribute("xdocs", xdocs);
						setDocs(String.valueOf(xdocs));

					}catch (Exception e2) {e2.printStackTrace();}

					doc=null;

					int count=0;
					do
					{  
						// Thread.sleep(1000);//--commented by krish
						if(count%2==0)
							//  JOptionPane.showMessageDialog(this, MyLib.getUID("Please follow browser option!! and click search button"));
							doc= Jsoup.parse(driver.getPageSource()); 
						tabEl = doc.select("table#ctl00_WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
						count++;
					}while(tabEl.isEmpty());
				}
			}
			doc= Jsoup.parse(driver.getPageSource()); 
			tabEl = doc.select("table#ctl00_WorkSpace_ctlCustAVIHistory_rgResult_ctl01");



			if(tabEl!=null){   


				tableRowElements = tabEl.select(":not(thead) tr");



				for (int i = 0; i < tableRowElements.size(); i++) {

					String Trans="";
					String Loc="";
					String Dir="";
					Double Amount=0.0;
					java.sql.Date dtvalue=null,dtripvalue=null;
					java.sql.Date sd = null;
					String plno="",tag="",src="";

					if(i>tableRowElements.size())
						flag=false;


					Element row = tableRowElements.get(i);

					rowItems = row.select("td");
					if(rowItems.size()>0){

						rowItems = row.select("td");
						//sBrowse.cache.Rows=sBrowse.cache.NewRow();


					}

					for (int j = 0; j < rowItems.size(); j++) {


						if(rowItems.get(j).text().equalsIgnoreCase("No transactions to display."))
							return false;

						if(row.className().equalsIgnoreCase("")||row.className().equalsIgnoreCase("GridPager_Default"))
						{
							flag=true;
							dat = rowItems.get(j).text();

							dat=dat.substring(dat.indexOf("of")+1);
							dat=dat.substring(0,dat.indexOf(','));
							dat=dat.substring(dat.indexOf(' ')+1);

							continue;
						}


						if(j==0)
						{
							//sBrowse.cache.setData("Trans", rowItems.get(j).text()); 
							Trans=rowItems.get(j).text();


						}

						if(j==1){
							String	 data = rowItems.get(j).text();//.substring(0,rowItems.get(j).text().indexOf(' ') );

							// java.sql.Date xidate=null;

							DateFormat formatter = new SimpleDateFormat("dd/MMM/yyyy HH:mm:ss");

							//  xidate=MyLib.getSqlDate(data);
							data=(data.substring(0,2)+"/"+data.substring(3,6) +"/"+ data.substring(7,11)+" "+data.substring(12,20));



							time=rowItems.get(j).text().substring(rowItems.get(j).text().indexOf(' ')+1 );



							salik_fdate=time;


							tformat=time.split(" ");
							timeappend=tformat[0].trim().substring(2,tformat[0].length());



							time=time.substring(0,time.indexOf(' '));

							if(tformat[1].trim().equalsIgnoreCase("PM"))
							{
								//System.out.println("Time.parse(((((((((((((("+Time.parse(time)+12);
								//    									      										   System.out.println("tformat[0]"+tformat[0].substring(0,2));
								//    									      										   System.out.println("TAKING THE FIRST TIME"+(Integer.parseInt(tformat[0].substring(0,2))+12));
								if(!tformat[0].substring(0,2).equals("12"))
								{ 
									time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
									time=time+timeappend;

								}
							}


							if(tformat[1].trim().equalsIgnoreCase("AM"))
							{
								//System.out.println("Time.parse(((((((((((((("+Time.parse(time)+12);

								if(tformat[0].substring(0,2).equals("12"))
								{ 
									time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
									time=time+timeappend;

								}
							}



							//sBrowse.cache.setData("salik_time", time);

							//    									   Date date=new Date();
							//    						      		   
							//    							      		 
							//    		cmnted by krish						      		        sd = java.sql.Date(dat.getTime());
							//sBrowse.cache.setData("date", sd);

							java.util.Date date=new java.util.Date();
							//    						      		   
							//    							      		 
							sd = new  java.sql.Date(date.getTime());

							try {
								java.util.Date dat = formatter.parse(data);

								dtripvalue=new java.sql.Date(dat.getTime());



								// sBrowse.cache.setData("salik_date", dtvalue);
							} catch (ParseException e) {e.printStackTrace();}
						}
						//String plno="",tag="",src="";
						if(j==3)
						{
							String s = rowItems.get(j).text();

							plno = s.substring(s.indexOf('-') + 1);
							s=s.substring(0, s.indexOf('-'));
							tag = s.substring(s.indexOf(':')+1);
							src = tag.substring(tag.indexOf(' ')+1);
							tag=tag.substring(0,tag.indexOf(' '));
							plno = plno.substring(plno.indexOf(' ') + 1);
							plno = plno.substring(plno.indexOf(' ') + 1);

							setTxtdescription(getTxtdescription()+"\n"+"Retrieving Row#"+i+"  "+"Retrieving page#"+j+"    TAG NO:"+tag+" - ");
							textdescription=(getTxtdescription()+"\n"+"Retrieving Row#"+i+""  +"Retrieving page#"+j+"    TAG NO:"+tag+" - ");

							log.log( Level.FINE, "processing {0} entries in loop",textdescription);
						}
						if(j==4)
						{
							// sBrowse.cache.setData("Location", rowItems.get(j).text()); 
							Loc= rowItems.get(j).text();
						}
						if(j==5)
						{
							//sBrowse.cache.setData("Direction", rowItems.get(j).text());
							Dir= rowItems.get(j).text();
						}

						if(j==2){
							String	 data = rowItems.get(j).text();
							DateFormat   formatter = new SimpleDateFormat("dd/MMM/yy");
							data=(data.substring(0,2)+"/"+data.substring(3,6) +"/"+ data.substring(7,9));
							java.util.Date date = null;
							try {
								date = formatter.parse(data);
								dtvalue=new java.sql.Date(date.getTime());
								//sBrowse.cache.setData("sal_date",dtvalue); 
							} catch (ParseException e) {e.printStackTrace();}
						}
						if(j==6)
						{
							Amount=Double.parseDouble(rowItems.get(j).text());
							//sBrowse.cache.setData("Amount", rowItems.get(j).text()); 
						}


						// sBrowse.cache.setData("Salik_User", ts);
					}

					try {
						xsasrno++;
						SATdownloadDAO dao=new SATdownloadDAO();

						if(Amount>0){

							result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);

						}
						setDocs(String.valueOf(xsadoc));

					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					finally{
						//driver.quit();
					}

				}

			}
		}
		return  result;

	}

	private void detailsNewlyOpenedwindow(String disc, String fees, int k, String remark,int srno) 
	{
		//		disc="";
		//		fees="";
		String plate_source="",Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Ticket_No="",Tick_violat="",DESC1="",type="",LicenseNo="",LicenseFrom="",NotPayReason="",location="",fine="",remarks="",tcno="";
		java.sql.Date traffic_date=null,sd = null;
		Double Amount=0.0;

		try{


			Set<String> windowHandles1 = driver.getWindowHandles();
			int size = windowHandles1.size();

			for (String string : windowHandles1) 
			{
				driver.switchTo().window(string);

				if(string.equals(defaultwindow))
				{ //driver.manage().window().setPosition(new Point(0, 0));
					//System.out.println("On Main Window");
					//Reporter.log("On Main Window");

				}
				else
				{
					//	        	   org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(-2000,-2000);
					//	        	   driver.manage().window().setSize(screenResolution);
					//	        	   driver.manage().window().setPosition(new Point(-2000, -2000));
					((JavascriptExecutor)driver).executeScript("window.resizeTo(0, 0);");
					docDet= Jsoup.parse(driver.getPageSource());
					Elements tabEl = null;
					tabEl = docDet.select("table#dtTicDetails");


					Elements tableHeaderEles = tabEl.select("thead tr th");

					for (int i = 0; i < tableHeaderEles.size(); i++) {

					}
					//System.out.println();

					Elements tableRowElements = tabEl.select("tr");

					tcno=ts;
					for (int j = 0; j < tableRowElements.size(); j++) {

						Element row = tableRowElements.get(j);
						Elements rowItems = row.select("span");
						String tddata="";
						int a=0;
						for (Element nextTurn : rowItems) {


							tddata=nextTurn.text();

							//System.out.println("===jjj========"+j+"====aaaaaa===="+a+"=tddatatddatatddatatddata==="+tddata);
							if((j==18)&&(a==0)){
								DESC1=tddata;
							}
							a=a+1;


						}

						//System.out.println("Data in the detail window"+j+"daaaatttaaaa"+tddata);
						if(j==0)
							//		ck      	
							//		      		  descriptionPane.setText(descriptionPane.getText()+"Fine# "+tddata);		      		
							//descriptionPane.update(descriptionPane.getGraphics());
						{
							Ticket_No=tddata;
							continue;
						}
						if(j==3){
							String tddatadate = tddata;

							traffic_date=ClsCommon.getSqlDate(tddatadate);

						}
						if(j==4)
						{
							Time=tddata;
						}
						if(j==2)
						{
							fine_Source=tddata;
						}
						if(j==9){
							//pcolor=tddata;
							regNo=tddata;
						}

						if(j==13){
							plate_source=tddata;

						}



						if(j==13){
							plate_source=tddata;

						}

						if(j==11){

							String cat="";
							try{
								//Connection conn = ClsConnection.getMyConnection();
								String z="";

							}catch (Exception e) {
								e.printStackTrace();
							}
							finally{
								cat=tddata;
							}
							PlateCategory=tddata;
							pcolor=cat;
						}


						if(j==16)
						{
							LicenseNo=tddata;
						}
						if(j==17)
						{
							LicenseFrom=tddata;
						}
						if(j==7)
						{
							NotPayReason=" ";
						}
						if(j==3)
						{
							Amount=Double.parseDouble(disc);
						}







						location=disc;
						fine=fees;
						remarks=remark;


						java.util.Date date=new java.util.Date();

						sd=ClsCommon.getSqlDate(date);
						type="TRF";

					}

					//System.out.println("====Ticket_No====="+Ticket_No+"==DESC1======"+DESC1);

					SATdownloadDAO dao=new SATdownloadDAO();
					boolean result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,LicenseNo,LicenseFrom,NotPayReason,
							Amount,location,fine,remarks,sd,type,category,srno,tcno,xdoc,sd,branch,plate_source,getCmbtrafficsite(),DESC1,xdocs);
					setDocs(String.valueOf(xdoc));

					serno=k;
					srno=srno+k;



					driver.close();

					docDet=null;
				}

				driver.switchTo().window(defaultwindow);

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void loadData() throws IOException, InterruptedException
	{
		ArrayList list =new ArrayList();
		HashMap map =new HashMap();

		try{





			ResultSet rsload = conn.createStatement().executeQuery("Select Salik_User,Trans,salik_date,salik_time,sal_date,regNo,Source,TagNo,Location,Direction,Amount,date from gl_salik where Doc_no in ("+xdocs+")");


			while(rsload.next())
			{	


			}	
		}catch (Exception e2) {e2.printStackTrace();}




	}

	public boolean inputCaptcha(String xPmsg) throws UnsupportedEncodingException, SQLException
	{

		SATdownloadDAO sd=new SATdownloadDAO();
		boolean flag=true;
		//		HttpServletRequest request=ServletActionContext.getRequest();
		//		String realPath = request.getRealPath("/captcha.png");
		//		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp ";

		/*where comp_id='"+session.getAttribute("COMPANYID")+"'*/

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			DownloadImage(By.xpath("//img[contains(@src,'CaptchaImage')]"),imgPath);

			Thread.sleep(30000);

			do{ 

				setCaptcha(sd.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("SearchCapthcaControl")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource()); 
				Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 

				if (xSrch){

					driver.findElement(By.id("btnSearch")).click();

				}

			}while(getCaptcha()==null);

			try
			{
				WebElement we=null;
				int count=0;
				int cnt=0;
				//Thread.sleep(8000);
				do
				{  

					////--commented by krish
					we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
					setCaptchacount(0);
					String style = we.getAttribute("style").trim();

					if (!style.isEmpty())
						we=null;
					cnt++;
				}while(we==null && cnt<10);
				count++;

				Thread.sleep(5000);

				we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_lblErrorMessage"));
				String errMsg = we.getText().trim();


				if (!(errMsg.isEmpty() || errMsg.equals("") ||errMsg=="" || errMsg==null  ))
				{	
					setCaptchacount(1);
					driver.quit();
					flag=false;
					setMsg("Captcha Entered is wrong,Please Try Again!!");
					return flag;

					/*System.out.println("errMsg.isEmpty - "+errMsg);
							inputCaptcha("The code you typed has expired after 90 seconds.");*/
					//return;
				}

			}catch(Exception e){e.printStackTrace();}



		}catch(Exception e){e.printStackTrace();}
		return flag;
	}

	public void DownloadImage(By by,String loc)
	{
		try
		{


			//			HttpServletRequest request=ServletActionContext.getRequest();

			WebElement Image=driver.findElement(by);



			File screen=((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
			//File screen=driver.save_screenshot('screenie.png');

			int width=Image.getSize().getWidth();
			int height=Image.getSize().getHeight();
			BufferedImage img=ImageIO.read(screen);

			BufferedImage dest=img.getSubimage(Image.getLocation().getX(), Image.getLocation().getY(), width, height);
			ImageIO.write(dest, "png", screen);
			//			request.setAttribute("image",screen);
			File temp=new File(loc);
			copyFile(screen,temp);
			setIscaptchaloaded(1);


		}catch(Exception e){e.printStackTrace();}


	}

	public  void copyFile(File source, File dest)
			throws IOException {
		Files.copy(source.toPath(), dest.toPath());
	}

	public void reloaddata(){
		setCategory(getCategory());
		setChck_salikautomatic(getChck_salikautomatic());
		setChck_trafficautomatic(getChck_trafficautomatic());
		setCmbsaliksite(getCmbsaliksite());
		setHidcmbtype(getCmbtype());
		setHidcmbsaliksite(getCmbsaliksite());
		setHidcmbtrafficsite( getCmbtrafficsite());
		setCmbtrafficsite(getCmbtrafficsite());
		setHidChck_trafficfileno(getChck_trafficfileno());
	}


}
