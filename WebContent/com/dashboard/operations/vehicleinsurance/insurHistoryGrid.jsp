<%@page import="com.dashboard.operations.vehicleinsurance.*" %>
<%
ClsVehicleInsuranceDAO vehdao=new ClsVehicleInsuranceDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
%> 
<script type="text/javascript">
var historydata;
var id='<%=id%>';
if(id=="1"){
	historydata='<%=vehdao.getInsurHistory(agmtno,id)%>'; 
}
else{
	historydata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'agmtno', type: 'string'  },
                 	{name : 'vendor',type:'string'},
                 	{name : 'client',type:'string'},
                 	{name : 'invno',type:'string'},
                 	{name : 'invdate',type:'date'},
                 	{name : 'invamount',type:'number'},
                 	{name : 'insurfromdate',type:'date'},
                 	{name : 'insurtodate',type:'date'}
					
						
						],
				    localdata: historydata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#insurHistoryGrid").on("bindingcomplete", function (event) {
    	// your code here.
    	$("#overlay, #PleaseWait").hide();
    });         
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#insurHistoryGrid").jqxGrid(
    {
        width: '99%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Agmt No', datafield: 'agmtno', width: '10%' },
						{ text: 'Client',datafield:'client',width:'22.5%'},
						{ text: 'Account ',datafield:'vendor',width:'22.5%'},
						{ text: 'Inv No',datafield:'invno',width:'8%'},
						{ text: 'Inv Date',datafield:'invdate',width:'8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Inv Amount',datafield:'invamount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right'},
						{ text: 'Inur From Date',datafield:'insurfromdate',width:'8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Insur To Date',datafield:'insurtodate',width:'8%',cellsformat:'dd.MM.yyyy'}
						
					
					]
    
    });

    $('#insurHistoryGrid').on('rowdoubleclick', function (event) 
    		{ 
    	var args = event.args;
	    // row's bound index.
	    var boundIndex = event.args.rowindex;
	    // row's visible index.
	    var visibleIndex = event.args.visibleindex;
	    // right click.
	    var rightclick = event.args.rightclick; 
	    // original event.
	    var ev = event.args.originalEvent;
	    
    		});
});

	
	
</script>
<div id="insurHistoryGrid"></div>
