<%@page import="com.dashboard.workshop.jobclockanalysis.*"%>
<%
ClsJobClockAnalysisDAO clockdao=new ClsJobClockAnalysisDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String jcno=request.getParameter("jcno")==null?"":request.getParameter("jcno");
String techid=request.getParameter("techid")==null?"":request.getParameter("techid");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var clockdata=[];

if(id=='1'){
	clockdata='<%=clockdao.getClockInData(fromdate,todate,jcno,techid,id,brhid)%>';
}

$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'jcdocno',type:'number'},
                  		{name : 'techname',type:'string'},
                  		{name : 'startdate',type:'date'},
                  		{name : 'starttime',type:'time'},
                  		{name : 'closedate',type:'date'},
                  		{name : 'closetime',type:'time'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'designation',type:'string'},
                  		{name : 'dept',type:'string'},
						{name : 'totalhrs',type:'number'}
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
       				{ text: 'Job Card #',datafield:'jcdocno',width:'6%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'25%'},
    				{ text: 'Technician',datafield:'techname',width:'15%'},
    				{ text: 'Designation',datafield:'designation',width:'10%'},
    				{ text: 'Department',datafield:'dept',width:'12%'},
       				{ text: 'Start Date',datafield:'startdate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Start Time',datafield:'starttime',width:'6%',cellsformat:'h:mm:ss tt'},
       				{ text: 'Close Date',datafield:'closedate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Close Time',datafield:'closetime',width:'6%',cellsformat:'h:mm:ss tt'},
    				{ text: 'Total Hrs',datafield:'totalhrs',width:'6%',cellsformat:'d2'}
    
					]
    });
    $('#jobExecutionGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		document.getElementById("clockDocno").value =$('#jobExecutionGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
      		});
     
  
    });

	
	
</script>
<div id="jobExecutionGrid"></div>