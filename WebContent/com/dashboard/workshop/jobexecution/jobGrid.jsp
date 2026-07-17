<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% 
ClsJobExecutionDAO jedao=new ClsJobExecutionDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String date=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String jcno=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var data1;


if(id=='1'){
	data1='<%=jedao.getJobData(date,id,jcno)%>';  
	jobexceldata='<%=jedao.getJobExcelData(date,id,jcno)%>'
}
else{
	data1=[];
jobexceldata=[];
}
 
$(document).ready(function () {
	
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'jobno',type:'number'},
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
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jobgrid1").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jobgrid1").jqxGrid(
    {
        width: '98%',
        height: 200,
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
       				{ text: 'Job No',datafield:'jobno',width:'8%'},
       				{ text: 'Client',datafield:'client',width:'15%'},
       				{ text: 'Reg No', datafield:'regno',width:'10%'},
       				{ text: 'Plate',datafield:'plate',width:'6%'},
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'15%'},
       				{ text: 'Repair Type',datafield:'repairtype',width:'10%'},
       				{ text: 'Days From JC',datafield:'daysjc',width:'6%'},
       				{ text: 'User',datafield:'user',width:'15%'},
       				{ text: 'Docno',datafield:'doc_no',width:'15%',hidden:true},
       				{ text: 'clDocno',datafield:'cldocno',width:'15%',hidden:true}
  

					]
    });
    $('#jobgrid1').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			
  	  			document.getElementById("jcDocno").value = $('#jobgrid1').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	  			document.getElementById("cldocno").value = $('#jobgrid1').jqxGrid('getcellvalue', rowindex1, "cldocno");
  	  			document.getElementById("jobno").value = $('#jobgrid1').jqxGrid('getcellvalue', rowindex1, "jobno");
  	  			serviceload(event);
  	  			sparepartload(event);
  	  			
      		});	 
});

function serviceload(event)

{	
    var docno=document.getElementById("jcDocno").value;
     $("#overlay, #PleaseWait").show();  
    $("#jobexecutiongrid2div").load("serviceGrid.jsp?docno="+docno+"&id=1"); 
   	
}

function sparepartload(event)

{	
    var docno=document.getElementById("jcDocno").value;
     $("#overlay, #PleaseWait").show();  
    $("#jobexecutiongrid3div").load("partsGrid.jsp?docno="+docno+"&id=1"); 
}

	
</script>
<div id="jobgrid1"></div>