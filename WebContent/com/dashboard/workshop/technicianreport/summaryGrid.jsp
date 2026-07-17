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
String stype=request.getParameter("stype")==null?"":request.getParameter("stype");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var data1;


if(id=='1'){
	data1='<%=DAO.getSummaryData(fromdate,todate,techid,jcno,clientid,clcatid,stype,id)%>';

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
						{name : 'refno',type:'number'},
						{name : 'refname',type:'string'},
						{name : 'totalhours',type:'number'},
						{name : 'totalcost',type:'number'},
						{name : 'avgcostperhr',type:'number'},
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#summaryGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#summaryGrid").jqxGrid(
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
       				{ text: 'Ref No',datafield:'refno',width:'10%'},
       				{ text: 'Ref Name',datafield:'refname',width:'40%'},
       				{ text: 'Total Hours',datafield:'totalhours',width:'15%',cellsformat:'d2'},
       				{ text: 'Total Cost',datafield:'totalcost',width:'15%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Avg.Cost / Hour',datafield:'avgcostperhr',width:'15%',align:'right',cellsalign:'right',cellsformat:'d2'},
					]
    });
    $('#summaryGrid').on('rowdoubleclick', function (event) 
      		{ 
      		});	 
     
  
    });

	
	
</script>
<div id="summaryGrid"></div>