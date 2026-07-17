<%@page import="com.dashboard.workshop.serviceadvisor.*"%>
<%
ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String srvcadvisorconfig=request.getParameter("srvcadvisorconfig")==null?"0":request.getParameter("srvcadvisorconfig");
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
var srvcadvisorconfig='<%=srvcadvisorconfig%>';
if(id=='1'){
 gatedata='<%=servicedao.getGateInPassData(fromdate,todate,id)%>';
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
                  		{name : 'processstatus',type:'number'}
				
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateInPassGrid").on("bindingcomplete", function (event) {
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
    
    
    
    $("#gateInPassGrid").jqxGrid(
    {
        width: '98%',
        height: 250,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Branch',datafield:'branchname',width:'12%',cellclassname: cellclassname},
       				{ text: 'Branch Id',datafield:'brhid',width:'12%',hidden:true,cellclassname: cellclassname},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'7%',cellclassname: cellclassname},
       				{ text: 'Reg No',datafield:'reg_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Fleet Name',datafield:'flname',width:'12%',cellclassname: cellclassname},
       				{ text: 'Driver',datafield:'driver',width:'12%',cellclassname: cellclassname},
       				{ text: 'In Date',datafield:'indate',width:'7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'In Time',datafield:'intime',width:'6%',cellsformat:'HH:mm',cellclassname: cellclassname},
       				{ text: 'In Km',datafield:'inkm',width:'7%',cellsalign: 'right', align:'right',cellclassname: cellclassname},
       				{ text: 'In Fuel',datafield:'infuel',width:'6%',cellclassname: cellclassname},
       				{ text: 'Service Due Km',datafield:'serviceduekm',width:'8%',cellsalign: 'right', align:'right',cellclassname: cellclassname},
       				{ text: 'Process Status',datafield:'processstatus',width:'8%',hidden:true,cellclassname: cellclassname}


					]
    });
    $('#gateInPassGrid').on('rowdoubleclick', function (event) 
      		{ 
				var rowindex=event.args.rowindex;
  	  			var brhid=$('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,'brhid');
  	  			var docno=$('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
  	  			var processstatus=$('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
  	  			$('#processstatus').val(processstatus);
  	  			if(processstatus=='2'){
  	  				$('#btnprint').attr('disabled',false);
  	  			}
  	  			else{
  	  				$('#btnprint').attr('disabled',true);
  	  			}
  	  			$('#gateinpassdocno').val(docno);
				$("#overlay, #PleaseWait").show();
				$('#complaintsdiv').load('complaintsGrid.jsp?brhid='+brhid+'&docno='+docno+'&id=1&processstatus='+processstatus);
				$('#maintenancediv').load('maintenanceGrid.jsp?id=1&processstatus='+processstatus+'&docno='+docno);
				$('#partsdiv').load('partsGrid.jsp?id=1&processstatus='+processstatus+'&docno='+docno+'&srvcadvisorconfig='+srvcadvisorconfig);

				$('#regno').val($('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,"reg_no"));
				$('#fleetno').val($('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,"fleet_no"));
				$('#fleetname').val($('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,"flname"));
				$('#indatetime').val($('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,"indate")+" "+
						$('#gateInPassGrid').jqxGrid('getcellvalue',rowindex,"intime"));

      		});	 
     
  
    });

	
	
</script>
<div id="gateInPassGrid"></div>