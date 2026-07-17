<%@page import="com.dashboard.workshop.goodsissue.ClsGoodsIssueDAO"%>
<%ClsGoodsIssueDAO goodsdao=new ClsGoodsIssueDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String srvcadvisor=request.getParameter("srvcadvisor")==null?"":request.getParameter("srvcadvisor");
%>
<script type="text/javascript">

var id='<%=id%>';
var srvcdata;

if(id=='1'){
  srvcdata='<%=goodsdao.getSrvcAdvisorData(id,fromdate,todate,srvcadvisor)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	srvcdata=[];
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
                     	{name : 'drivername',type:'string'},
                     	{name : 'fleet_no',type:'number'},
                     	{name : 'reg_no',type:'number'},
                     	{name : 'technician',type:'string'},
                     	{name : 'bay',type:'string'},
                     	{name : 'agmtno',type:'number'},
                     	{name : 'agmtvocno',type:'string'},
                     	{name : 'refname',type:'string'},
                     	{name : 'cldocno',type:'string'},
                     	{name : 'brhid',type:'string'},
                     	{name : 'locationid',type:'string'}
                  		/* {name : 'partno',type:'string'},
                  		{name : 'productname',type:'string'},
                  		{name : 'unit',type:'string'},
                  		{name : 'balqty',type:'number'} */
				
                  		],
				    localdata: srvcdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#srvcAdvisorGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#srvcAdvisorGrid").jqxGrid(
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
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'7%'},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Driver',datafield:'drivername',width:'18%' },
       				{ text: 'Fleet No',datafield:'fleet_no',width:'7%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'7%'},
       				{ text: 'Technician',datafield:'technician',width:'12%'},
       				{ text: 'Bay',datafield:'bay',width:'10%'},
       				{ text: 'Agmt Doc No',datafield:'agmtno',width:'10%',hidden:true},
       				{ text: 'Agmt No',datafield:'agmtvocno',width:'8%'},
       				{ text: 'Client',datafield:'refname',width:'20%'},
					{ text: 'Branch ID',datafield:'brhid',width:'10%',hidden:true},
					{ text: 'Client Docno',datafield:'cldocno',width:'10%',hidden:true},
					{ text: 'Location ID',datafield:'locationid',width:'10%',hidden:true}
					
					]
    });

    $('#srvcAdvisorGrid').on('rowdoubleclick', function (event) 
        	{ 
      	  	var rowindex=event.args.rowindex;
      	  	var value=$('#srvcAdvisorGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
      	  	$('#fleetno').val($('#srvcAdvisorGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
      	  	$('#srvcdocno').val(value);
      	  	$('#cldocno').val($('#srvcAdvisorGrid').jqxGrid('getcellvalue',rowindex,'cldocno'));
      	  	$('#locationid').val($('#srvcAdvisorGrid').jqxGrid('getcellvalue',rowindex,'locationid'));
      	  	$('#brhid').val($('#srvcAdvisorGrid').jqxGrid('getcellvalue',rowindex,'brhid'));
      	  	
      	  	$('#partsdiv').load('partsGrid.jsp?id=1&srvcadvisor='+value);	
       });
    });

</script>
<div id="srvcAdvisorGrid"></div>
