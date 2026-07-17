<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.workshop.carfaregateinpassmaster.*" %>
<%ClsCarfareGateInPassDAO DAO= new ClsCarfareGateInPassDAO();%>
 <%
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_namess = request.getParameter("Cl_namess")==null?"0":request.getParameter("Cl_namess");
String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
%> 

 <script type="text/javascript">
 
 var searchdata=[];
 var id='<%=id%>';
 if(id=="1"){
  searchdata='<%=DAO.searchMaster(session,msdocno,Cl_namess,dates,mobile,regno,id)%>';
}	
  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                      
                    {name : 'doc_no' , type: 'number' },
                    {name : 'voc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                   	{name : 'name' , type: 'String' },
                	{name : 'refno' , type: 'String' },
                   	{name : 'cldocno' , type: 'number' },
                   	{name : 'insurancecomp' , type: 'number' },
                   	{name : 'insurcldocno' , type: 'number' },
                    {name : 'compny' , type: 'String' },
                    {name : 'desc1' , type: 'String' },
                   	{name : 'approvalreq' , type: 'number' },
                	{name : 'username' , type: 'String' },
                    {name : 'mobile' , type: 'String'}, 
                    {name : 'email' , type: 'String'}, 
                    {name : 'other' , type: 'String'},
                    {name : 'regno' , type: 'int'},
                    {name : 'movno' , type: 'int'},
                    {name : 'pltid' , type: 'int'},
                    {name : 'brdid' , type: 'int'},
                    {name : 'modid' , type: 'int'},
                    {name : 'yom' , type: 'int'},
                 	{name : 'vehother' , type: 'String' },
                	{name : 'kmin' , type: 'String' },
                    {name : 'fuel' , type: 'double'}, 
                    {name : 'repairtype' , type: 'String'}, 
                    {name : 'estdeldate' , type: 'date'},
                    {name : 'estdeltime' , type: 'String'},
                    {name : 'mainremarks' , type: 'String'},
                    {name : 'policerep' , type: 'String'},
                    {name : 'policerepdate' , type: 'date'},
                    {name : 'stationname' , type: 'String'},
                    {name : 'insutype' , type: 'int'}, 
                    {name : 'faulttype' , type: 'int'}, 
                    {name : 'claim' , type: 'String'},
                    {name : 'lpo' , type: 'String'},
                    {name : 'lpoamount' , type: 'number'},
                    {name : 'excess' , type: 'int'},
                    {name : 'excessamt' , type: 'number'},
                    {name : 'backjob' , type: 'int'},
                    {name : 'contactperson', type: 'String'},
					{name : 'mail1', type: 'String'  },
					{name : 'per_tel', type: 'String'  },
				    {name : 'address', type: 'String'  }, 
					{name : 'per_mob', type: 'String'  },
					{name : 'luxury', type: 'number'  },
					{name : 'etmdocno', type: 'number'  },
					{name : 'jobdocno', type: 'number'  },
					{name : 'marketingperson',type:'string'},
					{name : 'serviceadvisor',type:'string'},
					{name : 'insurancesurvivor',type:'string'},
					{name : 'referencedby',type:'string'},
					{name : 'servicepackage',type:'string'},
					{name : 'teammaster',type:'string'},
					{name : 'marketingpersonid',type:'string'},
					{name : 'serviceadvisorid',type:'string'},
					{name : 'insurancesurvivorid',type:'string'},
					{name : 'referencedbyid',type:'string'},
					{name : 'servicepackageid',type:'string'},
					{name : 'teammasterid',type:'string'},
                   	{name : 'priority',type:'string'},
                   	{name : 'regexpirydate',type:'date'},
                   	{name : 'colorid',type:'string'},
                   	{name : 'gname',type:'string'},
                   	],
          localdata: searchdata,
         
         
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
     $("#subsearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
                   
        
				{ text: 'Doc No', datafield: 'voc_no', width: '20%' },
				{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Vocno', datafield: 'doc_no', width: '15%',hidden:true },
				{ text: 'Movno', datafield: 'movno', width: '15%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '20%' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '35%',hidden:true },
				{ text: 'Refno', datafield: 'refno', width: '35%',hidden:true },
				{ text: 'Insuchk', datafield: 'insurancecomp', width: '15%',hidden:true },
				{ text: 'InsuranceCompny', datafield: 'compny', width: '20%',hidden:true},
				{ text: 'Insucldocno', datafield: 'insurcldocno', width: '35%',hidden:true },			
				{ text: 'Description', datafield: 'desc1', width: '20%',hidden:true },
				{ text: 'Approvalreq', datafield: 'approvalreq', width: '17%',hidden:true  },
				{ text: 'Username', datafield: 'username', width: '17%',hidden:true  },
				{ text: 'Mobile', datafield: 'mobile', width: '20%' },
				{ text: 'Email', datafield: 'email', width: '17%',hidden:true },
				{ text: 'Other', datafield: 'other', width: '17%',hidden:true },
				{ text: 'Regno', datafield: 'regno', width: '20%' },
				{ text: 'Plateid', datafield: 'pltid', width: '15%',hidden:true },
				{ text: 'Brand', datafield: 'brdid', width: '20%',hidden:true},
				{ text: 'Model', datafield: 'modid', width: '35%',hidden:true },			
				{ text: 'Yom', datafield: 'yom', width: '20%',hidden:true },
				{ text: 'Vehother', datafield: 'vehother', width: '17%',hidden:true  },
				{ text: 'Km', datafield: 'kmin', width: '17%',hidden:true  },
				{ text: 'Fuel', datafield: 'fuel', width: '17%',hidden:true },
				{ text: 'Repairtype', datafield: 'repairtype', width: '17%',hidden:true },
				{ text: 'EstDate', datafield: 'estdeldate', width: '17%',cellsformat:'dd.MM.yyyy',hidden:true },
				{ text: 'EstTime', datafield: 'estdeltime', width: '17%',hidden:true },
				{ text: 'MainRemarks', datafield: 'mainremarks', width: '17%',hidden:true },
				{ text: 'Policereq', datafield: 'policerep', width: '15%',hidden:true },
				{ text: 'PoliceDate', datafield: 'policerepdate', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true},
				{ text: 'Station_name', datafield: 'stationname', width: '35%',hidden:true },			
				{ text: 'Insuretype', datafield: 'insutype', width: '20%',hidden:true },
				{ text: 'Faultype', datafield: 'faulttype', width: '17%',hidden:true  },
				{ text: 'Claim', datafield: 'claim', width: '17%',hidden:true  },
				{ text: 'Lpo', datafield: 'lpo', width: '17%',hidden:true },
				{ text: 'Lpoamount', datafield: 'lpoamount', width: '17%',hidden:true },
				{ text: 'Excess', datafield: 'excess', width: '17%',hidden:true},
				{ text: 'Excessamt', datafield: 'excessamt', width: '17%',hidden:true },
				{ text: 'Backjob', datafield: 'backjob', width: '17%',hidden:true },
				{ text: 'MOB', datafield: 'per_mob', width: '9%',hidden:true },
			    { text: 'TEL', datafield: 'per_tel', width: '8%',hidden:true },
				{ text: 'ADDRESS', datafield: 'address', width: '21%',hidden:true }, 
				{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
				{ text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
				{ text: 'luxury', datafield: 'luxury', width: '20%',hidden:true },
				{ text: 'Jobdocno', datafield: 'jobdocno', width: '20%',hidden:true },
				{ text: 'Estdocno', datafield: 'etmdocno', width: '20%',hidden:true },
				{ text: 'Marketing Person', datafield: 'marketingperson', width: '20%',hidden:true },
				{ text: 'Service Advisor', datafield: 'serviceadvisor', width: '20%',hidden:true },
				{ text: 'Insurance Survivor', datafield: 'insurancesurvivor', width: '20%',hidden:true },
				{ text: 'Referenced By', datafield: 'referencedby', width: '20%',hidden:true },
				{ text: 'Service Package', datafield: 'servicepackage', width: '20%',hidden:true },
				{ text: 'Team Master', datafield: 'teammaster', width: '20%',hidden:true },
				{ text: 'Marketing Person Id', datafield: 'marketingpersonid', width: '20%',hidden:true },
				{ text: 'Service Advisor Id', datafield: 'serviceadvisorid', width: '20%',hidden:true },
				{ text: 'Insurance Survivor Id', datafield: 'insurancesurvivorid', width: '20%',hidden:true },
				{ text: 'Referenced By Id', datafield: 'referencedbyid', width: '20%',hidden:true },
				{ text: 'Service Package Id', datafield: 'servicepackageid', width: '20%',hidden:true },
				{ text: 'Team Master Id', datafield: 'teammasterid', width: '20%',hidden:true },
				{ text: 'Priority', datafield: 'priority', width: '20%',hidden:true },
				{ text: 'Reg Expiry', datafield: 'regexpirydate', width: '20%',hidden:true,cellsformat:'dd.MM.yyyy' },
				{ text: 'Group', datafield: 'gname', width: '20%',hidden:true },
				{ text: 'Color Id', datafield: 'colorid', width: '20%',hidden:true },
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
          var loadid=2;
          
    	  $('#doc_no').attr('disabled', false);
 		 
 		 $('#mode').attr('disabled', false);
 		
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
    	 var temp="";
    	 
      	  temp=temp+" CONTACT PERSON : "+$('#subsearch').jqxGrid('getcellvalue', rowindex1, "contactperson");
          temp=temp+","+" MOB : "+$('#subsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
          temp=temp+","+" EMAIL : "+$('#subsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
          temp=temp+","+" ADDRESS : "+$('#subsearch').jqxGrid('getcellvalue', rowindex1, "address");
          temp=temp+","+" TEL NO : "+$('#subsearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
          
          
      	document.getElementById("clientdetails").value=temp;
      	
      	var jobdoc = $('#subsearch').jqxGrid('getcellvalue', rowindex1, "jobdocno");
      	var estdoc = $('#subsearch').jqxGrid('getcellvalue', rowindex1, "etmdocno");
      	
      	if (jobdoc!="" || estdoc!=""){
      		$('#btnEdit').attr('disabled',true);
      	}
      	else{
      		$('#btnEdit').attr('disabled',false);
      	}
 
         document.getElementById("docno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("refno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("vocno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("cldocno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
         document.getElementById("clientname").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         //$('#hiddate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("hidchkclname").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "insurancecomp");
         document.getElementById("insucompany").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "compny");
         document.getElementById("description").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "desc1");
         document.getElementById("hidchkappr").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "approvalreq");
         document.getElementById("chkbjob").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "backjob");
         document.getElementById("vehusername").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "username");
         document.getElementById("vehusermobile").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "mobile");
         document.getElementById("vehuseremail").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "email");
         document.getElementById("vehuserothers").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "other");
         document.getElementById("vehregno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "regno");
         document.getElementById("vehplatecode").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "pltid");
         document.getElementById("hidcmbbrand").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "brdid");
         document.getElementById("hidcmbmodel").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "modid");
         document.getElementById("hidcmbyom").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "yom");
         document.getElementById("vehothers").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "vehother");
         document.getElementById("vehkm").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
         document.getElementById("latestkm").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
         document.getElementById("hidcmbfueltype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "fuel");
         document.getElementById("hidcmbrepairtype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "repairtype");
         $('#estdate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "estdeldate"));
		 $('#esttime').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "estdeltime"));
         document.getElementById("maintenanceremarks").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "mainremarks");
         document.getElementById("policereport").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "policerep");
         $('#policedate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "policerepdate"));
         document.getElementById("policestation").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "stationname");
         document.getElementById("hidcmbinsutype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "insutype");
         document.getElementById("hidcmbfaulttype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "faulttype");
         document.getElementById("claim").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "claim");
         document.getElementById("lpo").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "lpo");
         document.getElementById("lpoamount").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "lpoamount");
         document.getElementById("chkexces").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "excess");
         document.getElementById("excessamount").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "excessamt");
         document.getElementById("movno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "movno");
         document.getElementById("hidluxury").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "luxury");
         $('#marketingperson').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "marketingperson"));
         $('#serviceadvisor').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "serviceadvisor"));
         $('#insurancesurvivor').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "insurancesurvivor"));
         $('#referencedby').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "referencedby"));
         $('#servicepackage').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "servicepackage"));
         $('#teammaster').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "teammaster"));
         $('#hidmarketingperson').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "marketingpersonid"));
         $('#hidserviceadvisor').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "serviceadvisorid"));
         $('#hidinsurancesurvivor').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "insurancesurvivorid"));
         $('#hidreferencedby').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "referencedbyid"));
         $('#hidservicepackage').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "servicepackageid"));
         $('#hidteammaster').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "teammasterid"));
         var aa=document.getElementById("hidcmbrepairtype").value;
         $('#regexpirydate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "regexpirydate"));
         $('#group').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "gname"));
         $('#hidcmbcolor').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "colorid"));
         $('#hidcmbpriority').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "priority"));
        	 setValues();
			/*  $('#frmGateInPass').submit();//parseFloat( */
			 
         
       
         
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>
