<%@page import="com.dashboard.workshop.gateinvoice.*"%>
<%
ClsGateInvoiceDAO invoicedao=new ClsGateInvoiceDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cmbbranch=request.getParameter("cmbbranch")==null?"":request.getParameter("cmbbranch");
%>
<style>
	 .greenClass
        {
            background-color: #ACF6CB;
        }
     
</style>
<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var gateexceldata;

if(id=='1'){
 gatedata='<%=invoicedao.getInvoiceData(fromdate,todate,id,client,cmbbranch)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
gatedata=[];
gateexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'brhid',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'branchname',type:'string'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'indate',type:'String'},
                  		{name : 'intime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		{name : 'infuel',type:'string'},
                  		{name : 'driver',type:'string'},
                  		{name : 'serviceduekm',type:'number'},
                  		{name : 'processstatus',type:'number'},
                  		{name : 'invamount',type:'number'},
						{name : 'refname',type:'string'}
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var cellclassname = function (row, column, value, data) {
    	if(data.processstatus==2){
        	return "greenClass";
        }

 	};
 	
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#gateInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Branch',datafield:'branchname',width:'11%',cellclassname: cellclassname},
       				{ text: 'Branch Id',datafield:'brhid',width:'12%',hidden:true,cellclassname: cellclassname},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'7%',cellclassname: cellclassname},
       				{ text: 'Reg No',datafield:'reg_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Fleet Name',datafield:'flname',width:'12%',cellclassname: cellclassname},
       				{ text: 'Client',datafield:'refname',width:'15%',cellclassname: cellclassname},
       				{ text: 'Driver',datafield:'driver',width:'12%',cellclassname: cellclassname},
       				{ text: 'Amount',datafield:'invamount',width:'8%',cellclassname: cellclassname,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'In Date',datafield:'indate',width:'7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'In Time',datafield:'intime',width:'6%',cellsformat:'HH:mm',cellclassname: cellclassname},
       				{ text: 'In Km',datafield:'inkm',width:'6%',cellsalign: 'right', align:'right',cellclassname: cellclassname},
       				{ text: 'In Fuel',datafield:'infuel',width:'6%',cellclassname: cellclassname},
       				{ text: 'Service Due Km',datafield:'serviceduekm',width:'7%',cellsalign: 'right', align:'right',cellclassname: cellclassname},
       				{ text: 'Process Status',datafield:'processstatus',width:'7%',hidden:true,cellclassname: cellclassname}


					]
    });
    $('#gateInvoiceGrid').on('rowdoubleclick', function (event) 
      		{ 
				var rowindex=event.args.rowindex;
  	  			
      		});	 
     
  
    });

	
	
</script>
<div id="gateInvoiceGrid"></div>