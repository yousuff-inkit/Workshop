<%@page import="com.dashboard.workshop.jobswithoutinvoice.*"%>
<%
ClsJobsWithoutInvoiceDAO jobsdao=new ClsJobsWithoutInvoiceDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");

%>
<style>
.redClass
   		{
   		   background:#FFEBEB;
   		}
</style>
<script type="text/javascript">

var id='<%=id%>';
var jobdata=[];
var exceldata=[];

 if(id=='1'){
	  jobdata='<%=jobsdao.getJobcardWithoutInvoiceData(fromdate, todate, id, branch, jobcard)%>';
	  exceldata='<%=jobsdao.getJobcardWithoutInvoiceExcelData(fromdate, todate, id, branch, jobcard)%>';
} 
 else{
jobdata=[];
exceldata=[];
} 
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'voc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'reftype',type:'string'},
                  		{name : 'refno',type:'string'},
                  		{name : 'estdocno',type:'string'},
                  		{name : 'userdetails', type: 'string'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'btnview',type:'string'},
                  		{name : 'brhid', type: 'string'},
                  		{name : 'savestatus',type:'string'},
                  		{name : 'claimno',type:'string'},
                  		{name : 'lpono',type:'string'},
                  		{name : 'lpoamount',type:'number'}
                  	
                  		],
				    localdata: jobdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jobsWithoutInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var cellclassname = function (row, column, value, data) {
		if(data.processstatus=="10"){
	    	return "redClass";
	    }
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jobsWithoutInvoiceGrid").jqxGrid(
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
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Job Card No',datafield:'voc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Ref Type',datafield:'reftype',width:'6%'},
       				{ text: 'Ref No', datafield: 'refno', width:"10%"},
       				{ text: 'Est No', datafield: 'estdocno', width:"10%"},
       				{ text: 'User Details',datafield:'userdetails',width:'37%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'35%'},
       				{ text: 'View',datafield:'btnview',width:'10%',columntype:'button',hidden:true},
       				{ text: 'brhid', datafield: 'brhid', width:'0%', hidden: true },
       				{ text: 'Save Status', datafield: 'savestatus', width:'0%', hidden: true },
       				{ text: 'Claim No',datafield:'claimno',width:'10%',hidden:true},
       				{ text: 'LPO No', datafield: 'lpono', width:'10%', hidden: true },
       				{ text: 'LPO Amount', datafield: 'lpoamount', width:'10%', hidden: true,cellsformat:'d2' }
					]
    });
    $('#jobsWithoutInvoiceGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			//document.getElementById("Docno").value = $('#jobsWithoutInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "gipdocno");
  	  			

      		});	 
     
  
    });

	
	
</script>
<div id="jobsWithoutInvoiceGrid"></div>