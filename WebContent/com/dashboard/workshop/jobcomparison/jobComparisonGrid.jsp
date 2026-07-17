<%@page import="com.dashboard.workshop.jobcomparison.*" %>
<% 
ClsWSJobComparisonDAO jobdao=new ClsWSJobComparisonDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var data1=[];
var jobdata=[];
var jobexceldata=[];
if(id=='1'){
	jobdata='<%=jobdao.getJobCompareData(fromdate,todate,cldocno,id)%>';
	jobexceldata='<%=jobdao.getJobCompareDataExcel(fromdate,todate,cldocno,id)%>';
}
else{
	jobdata=[];
	jobexceldata=[];
}
 var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
$(document).ready(function () {
	
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'voc_no',type:'number'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'billto',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'estsparetotal',type:'number'},
                  		{name : 'estlabourtotal',type:'number'},
                  		{name : 'jccsparetotal',type:'number'},
                  		{name : 'jcclabourtotal',type:'number'},
                  		{name : 'invtaxtotal',type:'number'}
                  		],
				    localdata: jobdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jobComparisonGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jobComparisonGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: true, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Job No',datafield:'voc_no',width:'4%'},
       				{ text: 'Job No',datafield:'doc_no',width:'4%',hidden:true},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'20%'},
       				{ text: 'Client',datafield:'refname',width:'15%'},
       				{ text: 'Insur.Company',datafield:'billto',width:'14%'},
       				{ text: 'Est.Spare Total',datafield:'estsparetotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Est.Labour Total',datafield:'estlabourtotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'JCC.Spare Total',datafield:'jccsparetotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'JCC.Labour Total',datafield:'jcclabourtotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Invoice Total',datafield:'invtaxtotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
  

					]
    });
    
});

	
</script>
<div id="jobComparisonGrid"></div>