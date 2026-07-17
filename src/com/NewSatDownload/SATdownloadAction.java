package com.NewSatDownload;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import javax.imageio.ImageIO;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.interactions.Actions;

import com.NewSatDownload.SATdownloadDAO;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;


public class SATdownloadAction extends ActionSupport {

	private static final Logger log = Logger.getLogger( SATdownloadAction.class.getName() );

	private static final String JAVASCRIPT_SRC = 
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
	private String txttrafficpsource;
	private String txttrafficpsourceid;
	private String txttrafficpcolor;
	private String txttrafficpcolorid;
	private String txttrafficptype;
	private String txttrafficptypeid;
	private String txttrafficpno;
	private int chck_salikpdata;

	public int getChck_salikpdata() {
		return chck_salikpdata;
	}
	public void setChck_salikpdata(int chck_salikpdata) {
		this.chck_salikpdata = chck_salikpdata;
	}
	public String getTxttrafficpno() {
		return txttrafficpno;
	}
	public void setTxttrafficpno(String txttrafficpno) {
		this.txttrafficpno = txttrafficpno;
	}
	public String getTxttrafficpsource() {
		return txttrafficpsource;
	}
	public void setTxttrafficpsource(String txttrafficpsource) {
		this.txttrafficpsource = txttrafficpsource;
	}
	public String getTxttrafficpsourceid() {
		return txttrafficpsourceid;
	}
	public void setTxttrafficpsourceid(String txttrafficpsourceid) {
		this.txttrafficpsourceid = txttrafficpsourceid;
	}
	public String getTxttrafficpcolor() {
		return txttrafficpcolor;
	}
	public void setTxttrafficpcolor(String txttrafficpcolor) {
		this.txttrafficpcolor = txttrafficpcolor;
	}
	public String getTxttrafficpcolorid() {
		return txttrafficpcolorid;
	}
	public void setTxttrafficpcolorid(String txttrafficpcolorid) {
		this.txttrafficpcolorid = txttrafficpcolorid;
	}
	public String getTxttrafficptype() {
		return txttrafficptype;
	}
	public void setTxttrafficptype(String txttrafficptype) {
		this.txttrafficptype = txttrafficptype;
	}
	public String getTxttrafficptypeid() {
		return txttrafficptypeid;
	}
	public void setTxttrafficptypeid(String txttrafficptypeid) {
		this.txttrafficptypeid = txttrafficptypeid;
	}
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


	static String url="",urldet="",ts="",pass="";
	static String browser="chrome";
	WebDriver driver=null;
	private static ChromeDriverService service;
	String defaultwindow = "";
	String popupwindow = "";
	Document docDet,doc;
	boolean flag=false;
	String fineno="",dat="0",time="",curPage="0",timeappend="",salik_fdate="" ;
	String [] tformat=new String[10];
	int txtStPage=1;
	int rollno=1;
    int srno=0,xsasrno,xsadoc=0,serno=0,xdoc=0;
	int dno=0,excaptcha=0,rtalogin=0;
	String xdocs="0";
	String branch="";
	String SATEXCELCONFIG="0",SATEXCEL="";
	
	ClsConnection connobj=new  ClsConnection();
	Connection conn = connobj.getMyConnection();
	ClsCommon com= new ClsCommon();

	public String process() throws ParseException, SQLException{

		boolean result=false;

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		try{

			String qryapnd="";

			txtusername=getTxtusername();
			category=getCategory();
			cmbsaliksite=getCmbsaliksite();
			setHiddencategory(getCategory());
			// chck_salikautomatic=getChck_salikautomatic();

			System.out.println("Category ====="+getCategory());
			
			/*Checking Category*/
			
			if(getCategory().equalsIgnoreCase("salik"))
			{

				/*if(getChck_salikautomatic().equalsIgnoreCase("salikautomatic"))
			 {*/

				if(cmbsaliksite.equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("salik"))
				{
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

						rssalik = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' "+qryapnd+"");

						while(rssalik.next())
						{	
							ts=rssalik.getString("username");
							pass=rssalik.getString("password");
							excaptcha=rssalik.getInt("iscaptcha");
							setIscaptcha(excaptcha);
							
							/* VISHAKH.V.P*/
							rtalogin=rssalik.getInt("rta");
							/* VISHAKH.V.P ENDS*/
							
							//url="https://customers.salik.ae/default.aspx?ReturnUrl=%2fModuleCustomer%2fDefault.aspx%3fculture%3deng&culture=eng";
							url="https://customers.salik.ae/connect/login?lang=en";

						}
						try {

							Statement stmt1 = conn.createStatement();
							
							String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
							ResultSet rs1 = stmt1.executeQuery(strSql1);
							
							while(rs1.next ()) {
								setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");
							}

							result=loadfresh();
							if(result==true)
							{
								request.setAttribute("resultdata", result);	

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
				//				System.out.println("=getChck_trafficautomatic==="+getChck_trafficautomatic());

				//				System.out.println("==getChck_trafficfileno==="+getChck_trafficfileno());
				if(!(getChck_trafficfileno()==null))
				{
					setHidChck_trafficfileno(getChck_trafficfileno());
					if(getChck_trafficfileno().equalsIgnoreCase("trafficfileno")){
						//						System.out.println("==getCmbtrafficsite()==="+getCmbtrafficsite());
						if(getCmbtrafficsite().equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("traffic")){
							try{
								String fileno="";


								//								System.out.println("=getTxttrafficplateno()==="+getTxttrafficplateno());

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}

								//url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?actionParam=doSearch&searchMethod=3&trafficFileNo="+rstraffic.getString("username")+"";
								//url="https://traffic.rta.ae/trfesrv/public_resources/revamp/ffu/public-fines-payment.do?serviceCode=301&entityId=-1&trafficFileNo="+rstraffic.getString("username")+"&searchMethod=4";
								url="https://www.rta.ae/";
								if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
									//url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?serviceCode=301&entityId=-1&searchMethod=1&plateNo="+getTxttrafficpno()+"&plateSource="+getTxttrafficpsourceid()+"&plateCategory=2&plateCodeId="+getTxttrafficpcolorid()+"";
									url="https://www.rta.ae/";
								}
								try{
									//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
									loadfresh();
								}catch (Exception ec) {ec.printStackTrace();}					   

								//boolean sveflg= SaveFormData(1, con);
								//									if(sveflg)
								//									{
								//										
								//									}
							}catch(Exception ex){ex.printStackTrace();}



						}
						else if(getCmbtrafficsite().equalsIgnoreCase("AUH")&&getCategory().equalsIgnoreCase("traffic")){

							try{
								String fileno="";

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}

								ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								//								System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								while(rstraffic.next())
								{
									ts=rstraffic.getString("username");

									url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&IT=TS&Culture=en";

									if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
										url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&PN="+getTxttrafficpno()+"&PS="+getTxttrafficpsourceid()+"&PC="+getTxttrafficpcolorid()+"&PK=1&IT=PI&Culture=en";
									}

									//																			System.out.println("==url=111=="+url);
									try{
										//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
										loadfresh();
									}catch (Exception ec) {ec.printStackTrace();}					   

								}
								rstraffic.close();
								//boolean sveflg= SaveFormData(1, con);
								//									if(sveflg)
								//									{
								//										
								//									}
							}catch(Exception ex){ex.printStackTrace();}

						}

					}}


				/*}*/

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
			String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
			//System.out.println("==strSql1===="+strSql1);
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
			conn.close();
			driver.quit();
		}

		return "success";
	}



	public boolean loadfresh() throws IOException, InterruptedException, SQLException
	{
		boolean result=false;

		try{

			java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
			java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);

			/* VISHAKH.V.P */
			
			ResultSet resultSET = conn.createStatement().executeQuery("select method from gl_config where field_nme='SATSALIKEXCELDOWNLOAD'");

			while(resultSET.next()) {
				SATEXCELCONFIG=resultSET.getString("method");
			}
			
			if(SATEXCELCONFIG.equalsIgnoreCase("1")) {
				
				/* EXCEL DOWNLOAD */
				
				ResultSet resultSET1 = conn.createStatement().executeQuery("Select imgPath from my_comp");
	
				while(resultSET1.next()) {
					SATEXCEL=(resultSET1.getString("imgPath")+"\\SATEXCEL");
				}
				
				System.out.println("SATEXCEL ="+SATEXCEL);
				
				FirefoxProfile profile = new FirefoxProfile();
				profile.setPreference("browser.download.dir", SATEXCEL);
				profile.setPreference("browser.download.folderList", 2);
				profile.setPreference("browser.helperApps.neverAsk.openFile","text/csv,application/x-msexcel,application/excel,application/x-excel,application/vnd.ms-excel,image/png,image/jpeg,text/html,text/plain,application/msword,application/xml");
				profile.setPreference("browser.helperApps.neverAsk.saveToDisk","text/csv,application/x-msexcel,application/excel,application/x-excel,application/vnd.ms-excel,image/png,image/jpeg,text/html,text/plain,application/msword,application/xml");
				profile.setPreference("browser.helperApps.alwaysAsk.force", false);
				profile.setPreference("browser.download.manager.alertOnEXEOpen", false);
				profile.setPreference("browser.download.manager.focusWhenStarting", false);
				profile.setPreference("browser.download.manager.useWindow", false);
				profile.setPreference("browser.download.manager.showAlertOnComplete", false);
				profile.setPreference("browser.download.manager.closeWhenDone", false);
				profile.setPreference( "browser.download.manager.showWhenStarting", false );
				profile.setPreference( "pdfjs.disabled", true );
				driver = new FirefoxDriver(profile);  
			
			} else {			
				driver = new FirefoxDriver();
			}
			
			/* VISHAKH.V.P ENDS*/
			
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
			//			System.out.println("=result==="+result);
			//			System.out.println("getCategory()"+getCategory());

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

					String data="",disc="",Fees="",remark="";
					String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="";
					String [] dateformat=null;
					java.sql.Date traffic_date=null;

					driver.findElement(By.xpath("//*[@id='set-1']/ul/li[1]/a")).click();

					//driver.findElement(By.id("show_login")).click();

					String fileno="";
					if(!(getTxttrafficplateno().equals(""))){
						fileno="and t.username='"+getTxttrafficplateno()+"'";
					}
					else{
						fileno="and 1=1";

					}

					ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='DXB' "+fileno+"");

					while(rstraffic.next())
					{
						//driver.findElement(By.id("userID")).sendKeys(rstraffic.getString("username"));
						driver.findElement(By.id("username")).sendKeys(rstraffic.getString("username"));
						driver.findElement(By.id("password")).sendKeys(rstraffic.getString("password"));

					}

					//driver.findElement(By.xpath("//*[@id='loginButtonTD']/input")).click();
					
					//driver.findElement(By.xpath("//*[@id='loginControl']/input")).click();
					
					driver.findElement(By.xpath("//*[@id='loginControl']/div/div[1]/div/input")).click();
					
					//WebElement submit = driver.findElement(By.id("LoginForm"));
					//submit.submit();
					Thread.sleep(1000);

					driver.findElement(By.xpath("//*[@id='nav']/ul[2]/li[6]/a")).click();
					
					driver.findElement(By.xpath("//*[@id='widFines']/div/div[2]/a")).click();
					
					driver.findElement(By.xpath("//*[@class='srvdatarit fr']/p[2]/a")).click();
					
					driver.findElement(By.xpath("//*[@class='myfins']/a")).click();
					
					/*Boolean iselementpresent = driver.findElements(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).size()!= 0;
					if(iselementpresent==true){
						driver.findElement(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).click();
					}*/

					//driver.findElement(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).click();

					//driver.findElement(By.xpath("//*[@id='set-2']/ul/li[2]/a/span")).click();
					//driver.findElement(By.xpath("//*[@id='show_manage_account']/span")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='layoutContainers']/div[2]/div[2]/div[2]/section/div[2]/table/tbody/tr/td[2]/a")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='readMe']/div[4]/div[1]/div/div/div[2]/p[2]/a/strong")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='readMe']/div[5]/div[2]/div[2]/h3/label/a")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='nav']/ul[2]/li[6]/a")).click();

					String count=  driver.findElement(By.xpath("//*[@id='readMe']/ul/li[1]/a/p/span/em")).getText();
					ts=driver.findElement(By.xpath("//*[@id='largboxId']/div/ul[2]/li/p[2]/span[2]")).getText();
					int pagenos=Integer.parseInt(count)/10;
					int qot=Integer.parseInt(count)%10;
					if(qot>0){
						pagenos=pagenos+1;
					}

					//					System.out.println("====pagenos===="+pagenos);


					// And iterate over them, getting the cells 
					SATdownloadDAO dao=new SATdownloadDAO();

					int n=0;

					for(int m=1;m<=pagenos;m++){


						WebElement table = driver.findElement(By.className("regularfines")); 

						// Now get all the TR elements from the table 
						List<WebElement> allRows = table.findElements(By.tagName("tr")); 

						int rowlen=allRows.size();

						//						System.out.println("====m====m======"+m);
						int k=0;
						for (WebElement row : allRows) { 
							List<WebElement> cells = row.findElements(By.tagName("td")); 

							int colen=cells.size();	
							//							System.out.println("====colen======"+colen);
							int j=0;
							for (WebElement cell : cells) { 

								//								System.out.println("====datatatatata"+j+"=="+cell.getText());
								data=cell.getText();

								//								System.out.println("==datadatadatadata====="+data);

								if(j==1){
									DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

									Time=data.substring( data.lastIndexOf( ' ') + 1);

									//									System.out.println("==Time==="+Time);

									data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

									try {
										java.util.Date date1 = formatter.parse(data);
										java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
										//fBrowse.cache.setData("traffic_date", dtvalue);
										traffic_date=dtvalue;

										//										System.out.println("==traffic_date==="+traffic_date);

									} catch (ParseException e) {e.printStackTrace();} 


								}
								if(j==2){
									fine_Source=data;
								}

								if(j==3){
									pcolor=data.substring(0,1);
									regNo=data.substring(1,data.length()).replaceAll("[^0-9]+", "");
								}
								if(j==4){
									Amount=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==6){
									Ticket_No=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==7){

									int l=k+1;
									int t=k-1;
									driver.findElement(By.xpath("//*[@id='conttab1']/table/tbody/tr["+l+"]/td[8]/a/em")).click();
									String test=driver.findElement(By.xpath("//*[@id='actions_div"+t+"']")).getText().replaceAll("[^a-zA-Z0-9 ]+", "").replaceAll("Violations", "");
									String test1[]=test.split("Location");
									DESC1=test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim();

								}


								j++;
							}
							if(k!=0){


								plate_source="Dubai";


								java.util.Date dates=new  java.util.Date();


								java.sql.Date date=com.getSqlDate(dates);

								/*								System.out.println("==Ticket_No==="+Ticket_No+"==traffic_date==="+traffic_date+"==Time==="+Time+"==fine_Source==="
										+ ""+fine_Source+"==regNo==="+regNo+"PlateCategory"+PlateCategory+"pcolor"+pcolor+"Double.parseDouble(Amount)"
										+Double.parseDouble(Amount)+"type"+type+"date"+date);
								 */
								result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
										Double.parseDouble(Amount),null,null,DESC1,null,type,category,srno+n,ts,xdoc,date,branch,plate_source,
										getCmbtrafficsite(),"",xdocs);
							}
							n++;
							k++;
						}

						System.out.println("after 1st page completed");

						/*if (driver instanceof JavascriptExecutor) {
							System.out.println("goToPage("+m+"-1)");
							((JavascriptExecutor)driver).executeScript("goToPage("+m+"-1);");
						}

						else {
						    throw new IllegalStateException("This driver does not support JavaScript!");
						}*/
						//						Thread.sleep(1000);
						if(m!=pagenos){
							int a=m+1;
							if(m==1){
								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a")).click();
							}
							else{
								//driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a["+m+"]")).click();

								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a[2]")).click();
							}
							//							Thread.sleep(5000);
						}




					}


					//					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a/p")).click();
					//					Thread.sleep(1000);
					count=  driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a/p/span")).getText();



					pagenos=Integer.parseInt(count)/10;
					qot=Integer.parseInt(count)%10;
					if(qot>0){
						pagenos=pagenos+1;
					}

					//					System.out.println("====pagenos in second tab==="+pagenos);

					for(int m=1;m<=pagenos;m++){
						//						System.out.println("====m====m======"+m);

						WebElement table = driver.findElement(By.className("regularfines")); 

						// Now get all the TR elements from the table 
						List<WebElement> allRows = table.findElements(By.tagName("tr")); 

						int rowlen=allRows.size();

						//						System.out.println("====m====m======"+m);
						//						Thread.sleep(5000);
						int k=0;
						for (WebElement row : allRows) { 
							List<WebElement> cells = row.findElements(By.tagName("td")); 

							int colen=cells.size();	
							//							System.out.println("====colen======"+colen);
							int j=0;
							for (WebElement cell : cells) { 

								//								System/.out.println("====datatatatata"+j+"=="+cell.getText());
								data=cell.getText();

								if(j==0){
									DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

									Time=data.substring( data.lastIndexOf( ' ') + 1);

									//									System.out.println("==Time==="+Time);

									data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

									try {
										java.util.Date date1 = formatter.parse(data);
										java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
										//fBrowse.cache.setData("traffic_date", dtvalue);
										traffic_date=dtvalue;

										//										System.out.println("==traffic_date==="+traffic_date);

									} catch (ParseException e) {e.printStackTrace();} 


								}
								if(j==1){
									fine_Source=data;
								}

								if(j==2){
									pcolor=data.substring(0,1);
									regNo=data.substring(1,data.length()).replaceAll("[^0-9]+", "");
								}
								if(j==3){
									Amount=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==6){
									Ticket_No=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==7){

									int l=k+1;
									int t=k-1;
									driver.findElement(By.xpath("//*[@id='conttab2']/table/tbody/tr["+l+"]/td[8]/a/em")).click();
									String test=driver.findElement(By.xpath("//*[@id='actions_div"+t+"']")).getText().replaceAll("[^a-zA-Z0-9 ]+", "").replaceAll("Violations", "");
									String test1[]=test.split("Location");
									DESC1=test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim();

								}

								j++;
							}
							if(k!=0){


								plate_source="Dubai";


								java.util.Date dates=new  java.util.Date();


								java.sql.Date date=com.getSqlDate(dates);


								result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
										Double.parseDouble(Amount),null,null,DESC1,null,type,category,srno+n,ts,xdoc,date,branch,plate_source,
										getCmbtrafficsite(),"",xdocs);
							}
							n++;
							k++;
						}

						//System.out.println("after 1st page completed");

						/*if (driver instanceof JavascriptExecutor) {
							System.out.println("goToPage("+m+"-1)");
							((JavascriptExecutor)driver).executeScript("goToPage("+m+"-1);");
						}

						else {
						    throw new IllegalStateException("This driver does not support JavaScript!");
						}*/
						//						Thread.sleep(1000);
						if(m!=pagenos){
							int a=m+1;
							if(m==1){
								driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a")).click();
							}
							else{
								//driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a["+m+"]")).click();
								driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a[2]")).click();
							}
						}
						//						Thread.sleep(5000);


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



									txtStPage=i-1;						             
									loadfresh();
								}
							}
							/*if (driver instanceof JavascriptExecutor) {       		

				       			((JavascriptExecutor)driver).executeScript("AjaxNS.AR('ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl"+k+"','', 'WorkSpace_ctlCustAVIHistory_ajxResultPanel', event);");
				       			String s="ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl10";

				       		 }*/

							doc=null;


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

		}
		catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	public boolean jsoupGetTableData(int v) throws IOException, InterruptedException, SQLException, ParseException
	{
		ScriptEngineManager factory = new ScriptEngineManager();

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		boolean result=false;

		Elements tableElements = null;
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
				/*request.setAttribute("trxdocs", xdocs);*/
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


						date=com.getSqlDate(dates);

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

					result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
							Double.parseDouble(Amount),null,null,DESC1,null,type,category,srno+i,ts,xdoc,date,branch,plate_source,
							getCmbtrafficsite(),"",xdocs);

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


				/* VISHAKH.V.P */
				if(rtalogin==1) {
					
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[7]/a")).click();
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					
					driver.findElement(By.xpath("//*[@id='loginControl']/div[1]/div[1]/div[1]/input")).click();
					
				} else {
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[4]/input")).click();
					
				}
				/* VISHAKH.V.P ENDS*/

				driver.findElement(By.xpath("//*[@id='main']/div/section[1]/div/div/div[2]/div[2]/div[2]/a")).click();

				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[1]/div/div[1]")).click();

				
				if(getCmbtype().equalsIgnoreCase("lhrs")){
			
					driver.findElement(By.xpath("//*[@id='Range_24Hours']")).click();
					
				}
				else if(getCmbtype().equalsIgnoreCase("ldays")){
					driver.findElement(By.xpath("//*[@id='Range_7days']")).click();
				}
				else if(getCmbtype().equalsIgnoreCase("l30d")){
					driver.findElement(By.xpath("//*[@id='Range_30Days']")).click();
					
				}
				/* VISHAKH.V.P */
				else if(getCmbtype().equalsIgnoreCase("customdates")){
					driver.findElement(By.xpath("//*[@id='StartDate']")).click();
					driver.findElement(By.id("StartDate")).sendKeys(getJqxStartDate());
					driver.findElement(By.xpath("//*[@id='EndDate']")).click();
					driver.findElement(By.id("EndDate")).sendKeys(getJqxEndDate());
				}
				/* VISHAKH.V.P ENDS*/
				
				driver.findElement(By.xpath("//*[@id='TripeType']/option[text()='Charged trips']")).click();
				
				if(!(getTxtsaliktagno().equalsIgnoreCase(""))){
					
					driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[3]/div[1]")).click();
					driver.findElement(By.xpath("//*[@id='ByTag']")).click();
					driver.findElement(By.id("Tag_TagNumber")).sendKeys(getTxtsaliktagno().trim());

				}
				

				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[4]/button")).click();

					/* VISHAKH.V.P */
				
					Boolean iselementpresent=true;
					int pagecount=1;
					
					do{
	
						if(SATEXCELCONFIG.equalsIgnoreCase("1") && pagecount==1){
							
							iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
							
							if(iselementpresent==true){
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
							}
							
							driver.findElement(By.xpath("//*[@id='RenderBody']/section/div/div/div/div/div[1]/div[2]/a[2]")).click();
							pagecount++;
							
							Thread.sleep(120000);
							break;
							
						} else if(SATEXCELCONFIG.equalsIgnoreCase("0")) {
						
							iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
		
							if(iselementpresent==true){
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
								pagecount++;
							}
						}
	
					} while(iselementpresent==true);
					/* VISHAKH.V.P ENDS*/
				
				
				
				try{
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

					if(rs.next())
					{	
						xsadoc=0;
						xsadoc=rs.getInt("max");

						xdocs=xdocs+","+xsadoc;	
						xsasrno=0;
					}
					request.setAttribute("xdocs", xdocs);
					setDocs(String.valueOf(xdocs));

				}catch (Exception e2) {e2.printStackTrace();}

				/* VISHAKH.V.P */
				if(SATEXCELCONFIG.equalsIgnoreCase("1")){
					
					SATEXCEL = SATEXCEL.replace("\\", "//");
					
		            FileInputStream input = new FileInputStream(SATEXCEL+"//ExportTrips.xls");
		            POIFSFileSystem fs = new POIFSFileSystem( input );
		            HSSFWorkbook wb = new HSSFWorkbook(fs);
		            HSSFSheet sheet = wb.getSheetAt(0);
		            Row excelRow;
		            
		            for(int i=15; i<(sheet.getLastRowNum()-1); i++){
		            	
		            	String transactionID="",tagNumber="",plate="";
		            	java.sql.Date tripsDate=null;
						java.sql.Date sd = null;
						double amount=0.00;
		            	
		            	SimpleDateFormat formatDate = new SimpleDateFormat("dd MMMM yyyy");
		            	excelRow = sheet.getRow(i);
		                
		                if(excelRow.getCell(2).getCellType()==1){
		                	transactionID = excelRow.getCell(2).getStringCellValue()=="" || excelRow.getCell(2).getStringCellValue()==null?"0":excelRow.getCell(2).getStringCellValue().replace("'", " ");
		                } else {
		                	transactionID = String.valueOf((int) excelRow.getCell(2).getNumericCellValue());	
		                }
		                
		                java.util.Date tripDate = formatDate.parse(excelRow.getCell(3).getStringCellValue()=="" || excelRow.getCell(3).getStringCellValue()==null?"0":excelRow.getCell(3).getStringCellValue());
		                tripsDate = new java.sql.Date(tripDate.getTime());
		                
		                String tripTime = excelRow.getCell(5).getStringCellValue()=="" || excelRow.getCell(5).getStringCellValue()==null?"0":excelRow.getCell(5).getStringCellValue();
		                
		                time=tripTime;
						tformat=time.split(" ");
						timeappend=tformat[0].trim().substring(2,tformat[0].length());
						time=time.substring(0,time.indexOf(' '));

						if(tformat[1].trim().equalsIgnoreCase("PM")) {
							if(!tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
								time=time+timeappend;
							}
						}

						if(tformat[1].trim().equalsIgnoreCase("AM")) {
							if(tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
								time=time+timeappend;
							}
						}
						
		                String transactionPostDate = excelRow.getCell(6).getStringCellValue()=="" || excelRow.getCell(6).getStringCellValue()==null?"0":excelRow.getCell(6).getStringCellValue();
		                String tollGate = excelRow.getCell(7).getStringCellValue()==""  || excelRow.getCell(7).getStringCellValue()==null?"0":excelRow.getCell(7).getStringCellValue();
		                String direction = excelRow.getCell(9).getStringCellValue()==""  || excelRow.getCell(9).getStringCellValue()==null?"0":excelRow.getCell(9).getStringCellValue();
		                
		                if(excelRow.getCell(14).getCellType()==1){
		                	tagNumber = excelRow.getCell(14).getStringCellValue()=="" || excelRow.getCell(14).getStringCellValue()==null?"0":excelRow.getCell(14).getStringCellValue().replace("'", " ");
		                } else {
		                	tagNumber = String.valueOf((int) excelRow.getCell(14).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(15).getCellType()==1){
		                	plate = excelRow.getCell(15).getStringCellValue()=="" || excelRow.getCell(15).getStringCellValue()==null?"0":excelRow.getCell(15).getStringCellValue().replace("'", " ");
		                } else {
		                	plate = String.valueOf((int) excelRow.getCell(15).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(16).getCellType()==1){
		                	amount = Double.parseDouble(excelRow.getCell(16).getStringCellValue()=="" || excelRow.getCell(16).getStringCellValue()==null?"0":excelRow.getCell(16).getStringCellValue().replace("'", " "));
		                } else {
		                	amount = (double) excelRow.getCell(16).getNumericCellValue();
		                }
		                
		                xsasrno++;
						SATdownloadDAO dao=new SATdownloadDAO();
						if(amount>0){
							
//							System.out.println("ts==="+ts+"===plate==="+plate+"===tagNumber==="+tagNumber+"===transactionID==="+transactionID+"===tripsDate==="+tripsDate+"===direction==="+direction+"===tollGate==="+tollGate+"===amount==="+amount+"===time==="+time+"===tripsDate==="+tripsDate+"===xsadoc==="+xsadoc+"===sd==="+sd+"===xsasrno==="+xsasrno+"===salik_fdate==="+salik_fdate+"===branch==="+branch);
							result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,"",direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"",salik_fdate,branch);

						}
		                
		            }
		            
		            /*File currentFile = new File(SATEXCEL,"ExportTrips.xls");
		            currentFile.delete();*/
		            
		            File currentFolder = new File(SATEXCEL);
		            FileUtils.deleteDirectory(currentFolder);
		            
				} else {
					
					WebElement  mytable = driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table"));
	
					List<WebElement> rows_table = mytable.findElements(By.tagName("tr"));
	
					int rows_count = rows_table.size();
	
					int i=0;
	
					String Trans="";
					String Loc="";
					String Dir="";
					Double Amount=0.0;
					java.sql.Date dtvalue=null,dtripvalue=null;
					java.sql.Date sd = null;
					String plno="",tag="",src="";
	
	
					for (int row=0; row<rows_count; row++){
	
	
						List<WebElement> Columns_row = rows_table.get(row).findElements(By.tagName("td"));
	
						int columns_count = Columns_row.size();
						
						
						/*	List<WebElement> th_column = rows_table.get(row).findElements(By.tagName("th"));
	
						int th_count = th_column.size();
						*/
						//System.out.println("Number of cells In Row "+row+" are "+columns_count);
						/* for (int th=0; th<th_count; th++){
							String celtext1 = th_column.get(th).getText();
							
							System.out.println("==celtext1===="+celtext1);
							
							SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
							try{
	
								java.util.Date date = sdf1.parse(celtext1);
								dtvalue = new java.sql.Date(date.getTime());
	
	
							}
							catch(Exception e){
								e.printStackTrace();
							}
	
	
							try {
								java.util.Date dat = sdf1.parse(celtext1);
	
								dtripvalue=new java.sql.Date(dat.getTime());
	
							} catch (ParseException e) {e.printStackTrace();}
	
						}*/
						if(row%2!=0){
						String celtext1 =driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+row+"]/th/span")).getText();
						
	//					System.out.println("==celtext1===="+celtext1);
	//					System.out.println("==celtext1===="+driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+row+"]/th")).getText());
						
						SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
						try{
	
							java.util.Date date = sdf1.parse(celtext1);
							dtvalue = new java.sql.Date(date.getTime());
	
	
						}
						catch(Exception e){
							e.printStackTrace();
						}
	
	
						try {
							java.util.Date dat = sdf1.parse(celtext1);
	//						System.out.println("==== "+dat);
							dtripvalue=new java.sql.Date(dat.getTime());
	// System.out.println("==== "+dtripvalue);
						} catch (ParseException e) {e.printStackTrace();}
						
	//					System.out.println("==celtext1===="+celtext1);
						}
						
						
	
						for (int column=0; column<columns_count; column++){
	
	
							if(row>0){
	
								String celtext = Columns_row.get(column).getText();
								//System.out.println("Cell Value Of row number "+row+" and column number "+column+" Is "+celtext);
								if(row%2!=0){
									if(column==0){
										time=celtext;
	
										tformat=time.split(" ");
										timeappend=tformat[0].trim().substring(2,tformat[0].length());
	
										time=time.substring(0,time.indexOf(' '));
	
										if(tformat[1].trim().equalsIgnoreCase("PM"))
										{
	//									 System.out.println("TAKING THE FIRST TIME"+(Integer.parseInt(tformat[0].substring(0,2))+12));
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
	
	
	
	//									System.out.println("===time===="+time);
									}
									if(column==1){
									//	System.out.println("==celtext.length()===="+celtext.length());
										plno=celtext.substring(celtext.length()-5, celtext.length());
	//									System.out.println("===plno===="+plno);
	
									}
									if(column==2){
	
										src=celtext;
	//									System.out.println("===src===="+src);
	
									}
									if(column==3){
	
										Dir=celtext;
	//									System.out.println("===Dir===="+Dir);
	
									}
									if(column==4){
	
										Amount=Double.parseDouble(celtext);
	//									System.out.println("===Amount===="+Amount);
	
									}
								}
								if(row%2==0){
	
									if(column==2){
										tag=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===tag===="+tag);
									}
									if(column==3){
										Trans=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===Trans===="+Trans);
	
									}
	
	/*								if(column==4){
										String	 data = celtext;//.substring(0,rowItems.get(j).text().indexOf(' ') );
	
										SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
										try{
	
											java.util.Date date = sdf1.parse(data);
											dtvalue = new java.sql.Date(date.getTime());
	
	
										}
										catch(Exception e){
											e.printStackTrace();
										}
	
	
										try {
											java.util.Date dat = sdf1.parse(data);
	
											dtripvalue=new java.sql.Date(dat.getTime());
	
										} catch (ParseException e) {e.printStackTrace();}
	
	
	
									}*/
	
								}
	
								if(column==5){
	
									if(row%2!=0){
	
										driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+(row)+"]/td[6]/button")).click();
										//Thread.sleep(500);
	
									}
	
								}
	
	
	
	
	
							}
	
						}
	
						if(row%2==0 && row>0){
							xsasrno++;
							SATdownloadDAO dao=new SATdownloadDAO();
							if(Amount>0){
	
								result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);
							//	System.out.println("===plno=="+plno+"===src==="+src+"===Dir===="+Dir+"=====amount==="+Amount+"===tag=="+tag+"===Trans=="+Trans+"===dtripvale"+dtripvalue);
							}
							
						}
	
	
	
					}
					
				  }
				  /* VISHAKH.V.P. ENDS*/	

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
						System.out.println("===="+tddata);
						if(j==3){
							String tddatadate = tddata;

							traffic_date=com.getSqlDate(tddatadate);
							System.out.println("===="+traffic_date);							
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

						sd=com.getSqlDate(date);
						type="TRF";

					}

					//System.out.println("====Ticket_No====="+Ticket_No+"==DESC1======"+DESC1);

					SATdownloadDAO dao=new SATdownloadDAO();
					boolean result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,LicenseNo,
							LicenseFrom,NotPayReason,Amount,location,fine,remarks,sd,type,category,srno,tcno,xdoc,sd,branch,
							plate_source,getCmbtrafficsite(),DESC1,xdocs);
					setDocs(String.valueOf(xdocs));

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


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

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

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

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

	public boolean inputCaptchaDXB(String xPmsg) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

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
			DownloadImage(By.xpath("//img[contains(@src,'captchaGenerator')]"),imgPath);

			Thread.sleep(30000);


			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("securityCodeId")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource());

				driver.findElement(By.id("btnSearchByPlate")).click();
				/*Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 

				if (xSrch){

					driver.findElement(By.id("btnSearchByPlate")).click();

				}*/

			}while(getCaptcha()==null);





		}catch(Exception e){e.printStackTrace();}
		return flag;
	}

	public void DownloadImage(By by,String loc)
	{
		try
		{


			HttpServletRequest request=ServletActionContext.getRequest();

			WebElement Image=driver.findElement(by);



			File screen=((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
			//File screen=driver.save_screenshot('screenie.png');

			int width=Image.getSize().getWidth();
			int height=Image.getSize().getHeight();
			BufferedImage img=ImageIO.read(screen);

			BufferedImage dest=img.getSubimage(Image.getLocation().getX(), Image.getLocation().getY(), width, height);
			ImageIO.write(dest, "png", screen);
			request.setAttribute("image",screen);
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
