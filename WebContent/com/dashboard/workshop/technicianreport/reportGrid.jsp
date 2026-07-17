<%@page import="com.dashboard.workshop.technicianreport.*"%>
<%
ClsTechnicianReportDAO DAO=new ClsTechnicianReportDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String techid=request.getParameter("techid")==null?"":request.getParameter("techid");
String jcno=request.getParameter("jcno")==null?"":request.getParameter("jcno");
String clientid=request.getParameter("clientid")==null?"":request.getParameter("clientid");
String clcatid=request.getParameter("clcatid")==null?"":request.getParameter("clcatid");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var data1;


if(id=='1'){
	data1='<%=DAO.getTechReport(fromdate,todate,techid,jcno,clientid,clcatid,id)%>';

}
else{
	data1=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'docno',type:'number'},
						{name : 'gatedocno',type:'number'},
						{name : 'estdocno',type:'number'},
                  		{name : 'jcdocno',type:'number'},
                  		{name : 'client',type:'string'},
                  		{name : 'name',type:'string'},
                  		{name : 'startdate',type:'date'},
                  		{name : 'closedate',type:'date'},
                  		{name : 'technician',type:'string'},
                  		{name : 'jobcard',type:'string'},
                  		{name : 'category',type:'string'},
                  		{name : 'starttime',type:'string'},
                  		{name : 'closetime',type:'string'},
                  		{name : 'totalhours',type:'number'},
                  		{name : 'stdcostperhr',type:'number'},
                  		{name : 'totalcost',type:'number'},
                  		
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#techReportGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#techReportGrid").jqxGrid(
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
       				{ text: 'Technician',datafield:'technician',width:'15%'},
       				{ text: 'Job Card',datafield:'jobcard',width:'6%'},
       				{ text: 'Client',datafield:'client',width:'16%'},
       				{ text: 'Category',datafield:'category',width:'12%'},
       				{ text: 'Start Date',datafield:'startdate',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Start Time',datafield:'starttime',width:'6%'},
       				{ text: 'Close Date',datafield:'closedate',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Close Time',datafield:'closetime',width:'6%'},
       				{ text: 'Total Hours',datafield:'totalhours',width:'6%',cellsformat:'d2'},
       				{ text: 'STD Cost/Hrs',datafield:'stdcostperhr',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Total Cost',datafield:'totalcost',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2'},
					]
    });
    $('#techReportGrid').on('rowdoubleclick', function (event) 
      		{ 
      		});	 
    });

	
	
</script>
<div id="techReportGrid"></div>