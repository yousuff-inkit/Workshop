<%@page import="com.dashboard.analysis.revenuereportapex.*"%>
<%
ClsRevenueReportDAO DAO=new ClsRevenueReportDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
String hidrepairtype=request.getParameter("hidrepairtype")==null?"":request.getParameter("hidrepairtype");
String hidserviceadvisor=request.getParameter("hidserviceadvisor")==null?"":request.getParameter("hidserviceadvisor");
String sumtype=request.getParameter("sumtype")==null?"":request.getParameter("sumtype");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var rrdetaildata;
var clockexportdata;
var type='<%=sumtype%>';


if(id=='1'){
	rrdetaildata=<%=DAO.getSummaryData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id,sumtype,hidserviceadvisor)%>;
	clockexportdata=[];

}
else{
	rrdetaildata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		
                  		{name : 'refname',type:'string'},
                  		{name : 'category',type:'string'},
                  		{name : 'total',type:'number'},
                  		{name : 'income',type:'number'},
                  		{name : 'expense',type:'number'},
                  		],
				    localdata: rrdetaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     $("#rrDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	if(type!="clt"){
    		$("#rrDetailGrid").jqxGrid('hidecolumn', 'category');  
    	}
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#rrDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates: true,
        showstatusbar: true,
        statusbarheight: 25,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				
       				{ text: 'Refname',datafield:'refname'},
       				{ text: 'Client Category',datafield:'category',width:'10%'},
       				{ text: 'Total ',datafield:'total',width:'13%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Income',datafield:'expense',width:'13%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Expense',datafield:'income',width:'13%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				    
					]
    });
    $('#rrDetailGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		document.getElementById("clockDocno").value =$('#rrDetailGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
      		});	 
     
  
    });

	
	
</script>
<div id="rrDetailGrid"></div>