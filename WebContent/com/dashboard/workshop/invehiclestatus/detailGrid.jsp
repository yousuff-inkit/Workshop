<%@page import="com.dashboard.workshop.invehiclestatus.ClsInVehicleStatusDAO"%>
<%
ClsInVehicleStatusDAO gatedao=new ClsInVehicleStatusDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String gipdocno=request.getParameter("gipdocno")==null?"":request.getParameter("gipdocno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String process=request.getParameter("process")==null?"":request.getParameter("process");
%>

<script type="text/javascript">
var id='<%=id%>';
var detaildata;
var detailexceldata;

if(id=='1'){
	detaildata='<%=gatedao.getDetailData(id,todate,cldocno,gipdocno,regno,process,branch)%>';
 	detailexceldata='<%=gatedao.getDetailExcelData(id,todate,cldocno,gipdocno,regno,process,branch)%>';
}
else{
	detaildata=[];
	detailexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'gipvocno',type:'number'},
                  		{name : 'gipdate',type:'date'},
                  		{name : 'estvocno',type:'number'},
                  		{name : 'jobcardvocno',type:'number'},
                  		{name : 'invvocno',type:'number'},
                  		{name : 'invdate',type:'date'},
                  		{name : 'refname',type:'string'},
                  		{name : 'vehicleinfo',type:'string'},
                  		{name : 'total',type:'number'},
                  		{name : 'partstotal',type:'number'},
                  		{name : 'servicestotal',type:'number'}
				
                  		],
				    localdata: detaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#detailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#detailGrid").jqxGrid(
    {
        width: '98%',
        height: 575,
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
       				{ text: 'GIP No',datafield:'gipvocno',width:'6%'},
       				{ text: 'GIP Date',datafield:'gipdate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Est No',datafield:'estvocno',width:'6%'},
       				{ text: 'Job Card No',datafield:'jobcardvocno',width:'7%'},
       				{ text: 'Invoice No',datafield:'invvocno',width:'7%'},
       				{ text: 'Invoice Date',datafield:'invdate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Client',datafield:'refname',width:'15%'},
       				{ text: 'Vehicle Details',datafield:'vehicleinfo',width:'15%'},
       				{ text: 'Total Invoice',datafield:'total',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Parts Total',datafield:'partstotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Services Total',datafield:'servicestotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right'}


					]
    });
    $('#detailGrid').on('cellclick', function (event) 
    { 
  		
    });	 
     
  
    });

	
	
</script>
<div id="detailGrid"></div>