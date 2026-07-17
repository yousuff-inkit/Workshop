
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
<%
ClsbookingDAO viewDAO= new ClsbookingDAO();
String qutdocno = request.getParameter("qutdocno")==null?"0":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String clmob = request.getParameter("clmob")==null?"0":request.getParameter("clmob");
 String qutdate = request.getParameter("qutdate")==null?"0":request.getParameter("qutdate");
 
 String quttype = request.getParameter("quttype")==null?"0":request.getParameter("quttype"); 
 
 
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno"); 


%> 

 <script type="text/javascript">
 
 var bookmasterdata; 
 

 bookmasterdata='<%=viewDAO.searchMaster(session,qutdocno,clientname,clmob,qutdate,quttype,regno)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {            
     		
         datatype: "json",
         datafields: [          
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'voc_no' , type: 'number' },
                	{name : 'qoutrefno' , type: 'String' },
                   	{name : 'date' , type: 'date' },
                    {name : 'reftype' , type: 'String' },
                  	{name : 'refno' , type: 'String' },
                  	{name : 'sal_name' , type: 'String' },
                  	{name : 'sagid' , type: 'int' },
                	{name : 'attn' , type: 'String' },
                	{name : 'contactno' , type: 'String' },
                	{name : 'guestdet' , type: 'String'} ,
                    {name : 'refname' , type: 'String'} ,
                    {name : 'cldocno' , type: 'String'} ,
                    {name : 'address' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                  	{name : 'rsrno' , type: 'int' },
                  	{name : 'brand_name' , type: 'String' },
                	{name : 'brdid' , type: 'int' },
                	{name : 'model' , type: 'String' },
                     {name : 'modid' , type: 'int' },
                   	{name : 'color' , type: 'String' },
                   	{name : 'colid' , type: 'int' },
                   	{name : 'gname' , type: 'String' },
                 	{name : 'grpid' , type: 'int' },
                 	{name : 'rtype' , type: 'String'} ,
                 	{name : 'frmdate' , type: 'date' },
                 	{name : 'frmtime' , type: 'String'} ,
                    {name : 'todate' , type: 'date'} ,
                    {name : 'totime' , type: 'String'} ,
                 	{name : 'delivery' , type: 'String' },
                 	{name : 'chuef' , type: 'String'} ,
                    {name : 'delloc' , type: 'String'} ,
                    {name : 'remarks' , type: 'String'} ,
                    {name : 'fleet_no' , type: 'String'} ,
                    
                   	{name : 'acno' , type: 'String' },
                 	{name : 'insuex' , type: 'String'} ,
                    {name : 'invtype' , type: 'String'} ,
                    {name : 'advchk' , type: 'int'} ,
                    {name : 'locid' , type: 'String'} ,  
                    {name : 'delchg' , type: 'String'} ,

                    {name : 'tdocno' , type: 'number'} ,
                    {name : 'rano' , type: 'number'} ,
                    {name : 'refclientdet' , type: 'string'} ,
                    
                    {name : 'usrname' , type: 'string'} ,
                    
 
                    
                    
                    
                    
                   // acno, insuex, invtype, advchk, locid, delchg,
						
                   	],
          localdata: bookmasterdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            }		
     );
     $("#bookmasterSearch").jqxGrid(
     {
         width: '100%',
         height: 290,
         source: dataAdapter,
         columnsresize: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
       

         columns: [
                 	
                   // voc_no qoutrefno
				{ text: 'hidDoc No', datafield: 'doc_no', width: '7%',hidden:true },
				{ text: 'Doc No', datafield: 'voc_no', width: '7%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'reftype', datafield: 'reftype', width: '20%',hidden:true },
				{ text: 'refname', datafield: 'qoutrefno', width: '25%',hidden:true },
				{ text: 'hiderefname', datafield: 'refno', width: '25%',hidden:true },
				
				{ text: 'sal_name', datafield: 'sal_name', width: '35%',hidden:true },
				{ text: 'sagid', datafield: 'sagid', width: '20%',hidden:true },
				{ text: 'attn', datafield: 'attn', width: '15%',hidden:true },
				{ text: 'guestdet', datafield: 'guestdet', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'refname', width: '25%' },
				{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Address', datafield: 'address', width: '33%' },
				{ text: 'MOB', datafield: 'contactno', width: '20%' },
				{ text: 'email', datafield: 'email', width: '20%',hidden:true },
				
		 		{ text: 'fromDate', datafield: 'frmdate', width: '15%',cellsformat:'dd.MM.yyyy',hidden:true },
				{ text: 'frmTime', datafield: 'frmtime', width: '25%' ,hidden:true},
				{ text: 'todate', datafield: 'todate', width: '15%',cellsformat:'dd.MM.yyyy' ,hidden:true},
				{ text: 'toTime', datafield: 'totime', width: '25%',hidden:true },
				
					{ text: 'rsrno', datafield: 'rsrno', width: '25%',hidden:true },
				{ text: 'brand_name', datafield:'brand_name', width: '35%',hidden:true },
				{ text: 'brdid', datafield: 'brdid', width: '20%',hidden:true },
				{ text: 'model', datafield: 'model', width: '15%',hidden:true },
				{ text: 'modid', datafield: 'modid', width: '20%',hidden:true },
				{ text: 'color', datafield: 'color', width: '20%',hidden:true },
				{ text: 'colid', datafield: 'colid', width: '20%',hidden:true },
				{ text: 'gname', datafield: 'gname', width: '20%',hidden:true },
				{ text: 'grpid', datafield: 'grpid', width: '20%',hidden:true },
				{ text: 'rtype', datafield: 'rtype', width: '20%',hidden:true },
			
				{ text: 'delivery', datafield: 'delivery', width: '20%',hidden:true },
				{ text: 'chuef', datafield: 'chuef', width: '20%',hidden:true },
				{ text: 'delloc', datafield: 'delloc', width: '20%',hidden:true },
				{ text: 'remarks', datafield: 'remarks', width: '20%',hidden:true } ,
				{ text: 'fleet_no', datafield: 'fleet_no', width: '20%',hidden:true } ,
				
				
				 // acno, insuex, invtype, advchk, locid, delchg,
				
				{ text: 'acno', datafield: 'acno', width: '20%',hidden:true },
				{ text: 'insuex', datafield: 'insuex', width: '20%',hidden:true  },
				{ text: 'invtype', datafield: 'invtype', width: '20%',hidden:true },
				{ text: 'advchk', datafield: 'advchk', width: '20%',hidden:true  } ,
				{ text: 'locid', datafield: 'locid', width: '20%',hidden:true  } ,
				{ text: 'delchg', datafield: 'delchg', width: '20%',hidden:true } ,
				{ text: 'tdocno', datafield: 'tdocno', width: '20%',hidden:true } ,
				
				{ text: 'rano', datafield: 'rano', width: '20%',hidden:true } ,
				
				{ text: 'refclientdet', datafield: 'refclientdet', width: '20%',hidden:true } ,
				
				{ text: 'usrname', datafield: 'usrname', width: '20%',hidden:true } 
				
				
				]
     });
   /*   $("#bookmasterSearch").jqxGrid('addrow', null, {}); */
     
      $('#bookmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
 	 $('#jqxBookingDate').jqxDateTimeInput({ disabled: false});
 	 
 	 
 	$('#jqxVehicleFromDate').jqxDateTimeInput({ disabled: false});
	$('#jqxVehicleToDate').jqxDateTimeInput({ disabled: false});
	$('#jqxVehicleFromTime').jqxDateTimeInput({ disabled: false});
	$('#jqxVehicleToTime').jqxDateTimeInput({ disabled: false});
     $('#jqxBookingDate').val($("#bookmasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
     
  
     $('#jqxVehicleFromDate').val($("#bookmasterSearch").jqxGrid('getcellvalue', rowindex1, "frmdate")) ;
     
      $('#jqxVehicleFromTime').val ($('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "frmtime"));
     $('#jqxVehicleToDate').val($("#bookmasterSearch").jqxGrid('getcellvalue', rowindex1, "todate")) ;
   
     $('#jqxVehicleToTime').val ($('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "totime"));

     	
 	 var reftype=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "reftype");
     
 	document.getElementById("setusernametxt").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "usrname");
     //  alert(cldocnval);
       if(reftype=="QOT")
     	  {
     	 //alert(reftype);
    	   $('#cmbreftype').val(reftype);
    	   document.getElementById("reftypeval").value="QOT";
    	   document.getElementById("clientdetails").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "refclientdet");
     	  }
       else  if(reftype=="ONL")
  	  {
       	 //alert(reftype);
      	   $('#cmbreftype').val(reftype);
      	   document.getElementById("reftypeval").value="ONL";
       	
       	  }
       else
    	   {
    	   $('#cmbreftype').val(reftype);
    	   document.getElementById("reftypeval").value="";
    	   }
      
       document.getElementById("docno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
       document.getElementById("masterdoc_no").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
       
       $('#bookrefno').attr('disabled', false);
       document.getElementById("refqouteno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "refno");
       document.getElementById("bookrefno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "qoutrefno");
       
       document.getElementById("booksalesAgentid").value= $('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "sagid");
       document.getElementById("booksalesAgent").value= $('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
       document.getElementById("bookclientno").value= $('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
   	var temp="";
  	 temp=temp+" NAME: "+$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
          temp=temp+" , "+" ADDRESS: "+$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
          
          document.getElementById("ranos").value= $('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "rano");
         
     document.getElementById("bookclientname").value=temp;
     document.getElementById("bookcontactno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "contactno");
     document.getElementById("bookemail").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
     
     document.getElementById("guestremark").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "guestdet");
     document.getElementById("bookattention").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "attn");
   
      
	  document.getElementById("bookslno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "rsrno");
	     document.getElementById("bookbrand").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "brand_name");
	     document.getElementById("bookbrandid").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "brdid");
	     
	     document.getElementById("bookmodel").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "model");
	     document.getElementById("bookmodelid").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "modid");
	     
	     document.getElementById("bookcolor").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "color");
	     document.getElementById("bookcolorid").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "clrid");
	     
	     
	     document.getElementById("bookgroup").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "gname");
	     document.getElementById("bookgroupid").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "grpid");
	     
	     document.getElementById("renttype").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "rtype");
      
 
	        
	        document.getElementById("delivery_chkval").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "delivery");
	        document.getElementById("chauffeur_chkval").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "chuef");
	        
	        document.getElementById("dellocation").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "delloc");
	        document.getElementById("bookremark").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
	    	 
	        document.getElementById("fleetno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
	        
	        if(parseInt($('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "advchk"))==1)
	        {
	     
	        document.getElementById("advance_chkval").value=1;
	        }
	        else
	        	{
	        	
		       
		        document.getElementById("advance_chkval").value=0;
	        	
	        	}
	        
	        document.getElementById("clientacno").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "acno");
	        document.getElementById("excessinsur").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "insuex");
	        document.getElementById("invoice").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "invtype");
	        document.getElementById("advance_chk").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "advchk");
	        document.getElementById("vehloc").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "locid");
	        document.getElementById("delcharge").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "delchg");
	        
	        document.getElementById("tarifdoc").value=$('#bookmasterSearch').jqxGrid('getcellvalue', rowindex1, "tdocno");
	/*     
	   	 private String  delcharge,excessinsur,advance_chk,invoice,invoval,advance_chkval,vehloc,codenos;  */
	 	
	        
	   	 // acno, insuex, invtype, advchk, locid, delchg,
	        
	   
         $('#window').jqxWindow('close');
         $('#jqxBookingDate').jqxDateTimeInput({ disabled: false});
     	     	$('#jqxVehicleFromDate').jqxDateTimeInput({ disabled: false});
     	$('#jqxVehicleToDate').jqxDateTimeInput({ disabled: false});
     	$('#jqxVehicleFromTime').jqxDateTimeInput({ disabled: false});
     	$('#jqxVehicleToTime').jqxDateTimeInput({ disabled: false});
         $('#refno').attr('disabled', false);
         $('#delcharge').attr('disabled', false);
         $('#bookslno').attr('disabled', false);
         funSetlabel();
       document.getElementById("frmBooking").submit();
        
        
     
     		 });	
     
 });
</script>
<div id="bookmasterSearch"></div>

