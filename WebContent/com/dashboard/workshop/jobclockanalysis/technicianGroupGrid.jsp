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
var techdata=[];

if(id=='1'){
	techdata='<%=clockdao.getTechnicianGroupData(fromdate,todate,jcno,techid,id,brhid)%>';
}

$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'refno',type:'number'},
                  		{name : 'refname',type:'string'},
                  		{name : 'total',type:'number'},
                  		{name : 'designation',type:'string'},
                  		{name : 'dept',type:'string'},
                  		{name : 'esthrs',type:'number'},
                  		{name : 'hrsdiff',type:'number'},
                  		{name : 'variancepercent',type:'number'}
                  		],
				    localdata: techdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var cellclassname = function (row, column, value, data) {
    	if(parseFloat(data.hrsdiff)<0.0){
        	return "redClass";
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
	showaggregates:true,
        showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Ref No',datafield:'refno',width:'7%'},
       				{ text: 'Ref Name',datafield:'refname',width:'32%'},
       				{ text: 'Designation',datafield:'designation',width:'12%'},
       				{ text: 'Department',datafield:'dept',width:'12%'},
       				{ text: 'Total Hours',datafield:'total',width:'8%',cellsformat:'d2',aggregates: ['sum'],align:'right',cellsalign:'right'},
       				{ text: 'Est.Hrs',datafield:'esthrs',width:'8%',cellsformat:'d2',aggregates: ['sum'],align:'right',cellsalign:'right',cellclassname:cellclassname},
       				{ text: 'Hrs.Diff',datafield:'hrsdiff',width:'8%',cellsformat:'d2',aggregates: ['sum'],align:'right',cellsalign:'right',cellclassname:cellclassname},
       				{ text: 'Variance(%)',datafield:'variancepercent',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname:cellclassname},

					]
    });
    $('#jobExecutionGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		/* document.getElementById("clockDocno").value =$('#jobExecutionGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');*/
      		});	  
     
  
    });

	
	
</script>
<div id="jobExecutionGrid"></div>