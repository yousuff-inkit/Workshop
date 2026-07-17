<%@page import="com.dashboard.workshop.jobplanning.*" %>
<% 
ClsWSJobPlanningDAO jedao=new ClsWSJobPlanningDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String date=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String jcno=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var data1=[];


if(id=='1'){
	data1='<%=jedao.getJobData(date,id,jcno,brhid)%>';  
}
 
$(document).ready(function () {
	
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'jobno',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'client',type:'string'},
                  		{name : 'regno',type:'string'},
                  		{name : 'plate',type:'string'},
                  		{name : 'brand',type:'string'},
                  		{name : 'model',type:'string'},
                  		{name : 'daysjc',type:'string'},
                  		{name : 'user',type:'string'},
                  		{name : 'doc_no',type:'number'},
                  		{name : 'cldocno',type:'number'},
                  		{name : 'repairtype',type:'string'},
                  		{name : 'jobdocno',type:'number'},
                  		{name : 'serviceadvisor',type:'number'},
                  		{name : 'jobdatetime',type:'date'},
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jobPlanningGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jobPlanningGrid").jqxGrid(
    {
        width: '98%',
        height: 250,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: true, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Job No',datafield:'jobno',width:'4%'},
       				{ text: 'Date',datafield:'date',width:'8%',cellsformat:'dd.MM.yyyy',hidden:true},
       				{ text: 'Date Time',datafield:'jobdatetime',width:'9%',cellsformat:'dd.MM.yyyy HH:mm'},
       				{ text: 'Client',datafield:'client',width:'15%'},
       				{ text: 'Reg No', datafield:'regno',width:'5%'},
       				{ text: 'Plate',datafield:'plate',width:'3%'},
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'13%'},
       				{ text: 'Repair Type',datafield:'repairtype',width:'8%'},
       				{ text: 'Age',datafield:'daysjc',width:'3%'},
       				{ text: 'User',datafield:'user',width:'14%'},
       				{ text: 'Docno',datafield:'doc_no',width:'15%',hidden:true},
       				{ text: 'clDocno',datafield:'cldocno',width:'15%',hidden:true},
       				{ text: 'Job Doc No',datafield:'jobdocno',width:'15%',hidden:true},
       				{ text: 'Service Advisor',datafield:'serviceadvisor',width:'11%'}
  

					]
    });
    $('#jobPlanningGrid').on('rowdoubleclick', function (event) 
    { 
    	var rowindex1=event.args.rowindex;
    	$('#jobdocno').val($('#jobPlanningGrid').jqxGrid('getcellvalue',rowindex1,'jobdocno'));
  	  	$('#baygriddiv').load('bayGrid.jsp?id=1');
  	  	$('#serviceteamgriddiv').load('serviceTeamGrid.jsp?id=1');
    });	 
});

	
</script>
<div id="jobPlanningGrid"></div>