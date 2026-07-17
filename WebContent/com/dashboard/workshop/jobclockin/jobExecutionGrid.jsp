<%@page import="com.dashboard.workshop.jobclockin.*"%>
<%
ClsJobClockinDAO clockdao=new ClsJobClockinDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String jcno=request.getParameter("jcno")==null?"":request.getParameter("jcno");
String sjob=request.getParameter("sjob")==null?"0":request.getParameter("sjob");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var clockdata;
var clockexportdata;

if(id=='1'){
	clockdata='<%=clockdao.getClockInData(fromdate,todate,id,jcno,sjob)%>';
	clockexportdata='<%=clockdao.getClockInExportData(fromdate,todate,id,jcno,sjob)%>';
}
else{
	clockdata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'jcdocno',type:'number'},
                  		{name : 'techname',type:'string'},
                  		{name : 'techid',type:'number'},
                  		{name : 'startdate',type:'date'},
                  		{name : 'starttime',type:'time'},
                  		{name : 'closedate',type:'date'},
                  		{name : 'closetime',type:'time'}
                  		],
				    localdata: clockdata,
        
				   
    
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
       				{ text: 'Doc No',datafield:'doc_no',width:'11%'},
       				{ text: 'Job Card No',datafield:'jcdocno',width:'11%'},
       				{ text: 'Technician',datafield:'techname',width:'25%'},
       				{ text: 'Technician ID',datafield:'techid',width:'11%',hidden:true},
       				{ text: 'Start Date',datafield:'startdate',width:'12%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Start Time',datafield:'starttime',width:'12%',cellsformat:'h:mm:ss tt'},
       				{ text: 'Close Date',datafield:'closedate',width:'12%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Close Time',datafield:'closetime',width:'12%',cellsformat:'h:mm:ss tt'}
    
					]
    });
    $('#jobExecutionGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  	 	$('#closedate').jqxDateTimeInput('setDate',new Date());
  	 	$('#closetime').jqxDateTimeInput('setDate',new Date());
  		document.getElementById("clockDocno").value =$('#jobExecutionGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
      		});	 
     
  
    });

	
	
</script>
<div id="jobExecutionGrid"></div>