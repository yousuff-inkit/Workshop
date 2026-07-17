<%@page import="com.dashboard.workshop.gateinpasslist.*"%>
<%
ClsGateInPassListDAO gatedao=new ClsGateInPassListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var gateexceldata;

if(id=='1'){
 <%-- gatedata='<%=gatedao.getGateInPassData(fromdate,todate,id)%>'; --%>
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
                  		{name : 'date',type:'date'},
                  		{name : 'gateinpassdocno',type:'string'},
                  		{name : 'userdetails',type:'string'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'btnshow',type:'string'}
				
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jobExecutionGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jobExecutionGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Gate In Pass Doc No',datafield:'gateinpassdocno',width:'10%'},
       				{ text: 'User Details',datafield:'fleet_no',width:'27.5%'},
       				{ text: 'Vehicle Details',datafield:'reg_no',width:'27.5%'},
       				{ text: 'Show Details',datafield:'btnshow',width:'10%',columntype:'button'}


					]
    });
    $('#jobExecutionGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      
      		});	 
     
  
    });

	
	
</script>
<div id="jobExecutionGrid"></div>