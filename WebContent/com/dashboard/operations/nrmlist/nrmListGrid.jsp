<%@page import="com.dashboard.operations.nrmlist.*"%>
<%
ClsNrmListDAO nrmdao=new ClsNrmListDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
String movtype=request.getParameter("movtype")==null?"":request.getParameter("movtype");
String emptype=request.getParameter("emptype")==null?"":request.getParameter("emptype");
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
String garage=request.getParameter("garage")==null?"":request.getParameter("garage");
String status=request.getParameter("status")==null?"":request.getParameter("status");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
	var nrmdata;
	
   if(id=='1'){
	nrmdata='<%=nrmdao.getNrmList(temp,branch,fromdate,todate,fleet,movtype,emptype,employee,garage,status)%>';  
   	nrmexceldata='<%=nrmdao.getNrmExcelList(temp,branch,fromdate,todate,fleet,movtype,emptype,employee,garage,status)%>';  
   }
else{
	nrmdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'employee',type:'string'},
                  		{name : 'status',type:'string'},
                  		{name : 'outdate',type:'date'},
                  		{name :'outtime',type:'string'},
                  		{name : 'outkm',type:'number'},
                  		{name : 'outfuel',type:'string'},
                  		{name : 'indate',type:'date'},
                  		{name :'intime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		{name : 'infuel',type:'string'},
                  		{name : 'coldate',type:'date'},
                  		{name :'coltime',type:'string'},
                  		{name : 'colkm',type:'number'},
                  		{name : 'colfuel',type:'string'},
                  		{name : 'deldate',type:'date'},
                  		{name :'deltime',type:'string'},
                  		{name : 'delkm',type:'number'},
                  		{name : 'delfuel',type:'string'},            		
                  		{name : 'movtype',type:'string'},
                  		{name : 'date',type:'date'},
                  		{name : 'movtype',type:'string'},
                  		{name : 'garagename',type:'string'},
                  		{name : 'totaldays',type:'number'},

				{name : 'conkm',type:'number'},
				{name : 'ouser',type:'string'},
                  		{name : 'cuser',type:'string'},
				{name : 'flname',type:'string'},
				{name : 'entrytime',type:'date'},
                  		],
				    localdata: nrmdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#nrmListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#nrmListGrid").jqxGrid(
    {
        width: '99%',
        height: 535,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet',datafield:'fleet_no',width:'7%'},
				{ text: 'Fleet Name',datafield:'flname',width:'10%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'5%'},
       				{ text: 'Type',datafield:'movtype',width:'8%'},
       				{ text: 'Garage',datafield:'garagename',width:'15%'},
       				{ text: 'Employee',datafield:'employee',width:'15%'},
       				{ text: 'Status',datafield:'status',width:'5%'},
       				{ text: 'Entry Date & Time',datafield:'entrytime',width:'10%',cellsformat:'dd.MM.yyyy HH:mm'},
				{ text: 'Open User',datafield:'ouser',width:'12%'},
       				{ text: 'Close User',datafield:'cuser',width:'12%'},

       				{ text: 'Days',datafield:'totaldays',width:'6%',cellsalign:'right',align:'right',columngroup:'consdetails'},
       				{ text: 'KM',datafield:'conkm',width:'6%',cellsalign:'right',align:'right',columngroup:'consdetails'},
       				
       				
       				{ text: 'Date',datafield:'outdate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'outdetails'},
       				{ text: 'Time',datafield:'outtime',width:'5%',cellsformat:'HH:mm',columngroup:'outdetails'},
       				{ text: 'Km',datafield:'outkm',width:'6%',columngroup:'outdetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'outfuel',width:'6%',columngroup:'outdetails'},
       				{ text: 'Date',datafield:'deldate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'deldetails'},
       				{ text: 'Time',datafield:'deltime',width:'5%',cellsformat:'HH:mm',columngroup:'deldetails'},
       				{ text: 'Km',datafield:'delkm',width:'6%',columngroup:'deldetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'delfuel',width:'6%',columngroup:'deldetails'},
       				{ text: 'Date',datafield:'coldate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'coldetails'},
       				{ text: 'Time',datafield:'coltime',width:'5%',cellsformat:'HH:mm',columngroup:'coldetails'},
       				{ text: 'Km',datafield:'colkm',width:'6%',columngroup:'coldetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'colfuel',width:'6%',columngroup:'coldetails'},
       				{ text: 'Date',datafield:'indate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'indetails'},
       				{ text: 'Time',datafield:'intime',width:'5%',cellsformat:'HH:mm',columngroup:'indetails'},
       				{ text: 'Km',datafield:'inkm',width:'6%',columngroup:'indetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'infuel',width:'6%',columngroup:'indetails'},
			
				//{ text: 'Cons KM',datafield:'conkm',width:'6%',cellsalign:'right',align:'right'},
       				
       				
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					],columngroups: 
	                     [
	                      { text: 'Consumption', align: 'center', name: 'consdetails'},
	                       { text: 'Out Details', align: 'center', name: 'outdetails'},
	                       { text: 'In Details', align: 'center', name: 'indetails'},
	                       { text: 'Collection Details', align: 'center', name: 'coldetails'},
	                       { text: 'Delivery Details', align: 'center', name: 'deldetails'}
	                    
	                     ]

    });
    $('#nrmListGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	/* document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="nrmListGrid"></div>