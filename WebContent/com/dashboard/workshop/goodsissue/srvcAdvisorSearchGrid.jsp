<%@page import="com.dashboard.workshop.goodsissue.ClsGoodsIssueDAO"%>
<%ClsGoodsIssueDAO goodsdao=new ClsGoodsIssueDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">

var id='<%=id%>';
var srvcsearchdata;

if(id=='1'){
	srvcsearchdata='<%=goodsdao.getSrvcAdvisorSearchData(id,fromdate,todate)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	srvcsearchdata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                     	{name : 'doc_no',type:'number'},
                     	{name : 'date',type:'date'},
                     	{name : 'fleet_no',type:'number'},
                     	{name : 'reg_no',type:'number'},
                     	{name : 'technician',type:'string'},
                     	{name : 'bay',type:'string'}
				
                  		],
				    localdata: srvcsearchdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#srvcAdvisorSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#srvcAdvisorSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 320,
        columnsheight:23,
        source: dataAdapter,
        filterable: true,
        showfilterrow:true,
        columnsresize:true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '7%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text: 'Date',datafield:'date',width:'13%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'10%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'10%'},
       				{ text: 'Technician',datafield:'technician',width:'25%'},
       				{ text: 'Bay',datafield:'bay',width:'25%'}
					
					]
    });

    $('#srvcAdvisorSearchGrid').on('rowdoubleclick', function (event) 
        	{ 
      	  	var rowindex=event.args.rowindex;
      	  	$('#srvcadvisor').val($('#srvcAdvisorSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
      	  	$('#srvcadvisorwindow').jqxWindow('close');
       });
    });

</script>
<div id="srvcAdvisorSearchGrid"></div>
