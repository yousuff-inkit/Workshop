<%@page import="com.dashboard.operations.vehicleinsurancetermination.*" %>
<%
ClsVehicleInsuranceTerminationDAO termdao=new ClsVehicleInsuranceTerminationDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%> 
<script type="text/javascript">
var expensedata;
var id='<%=id%>';
if(id=="1"){
	expensedata='<%=termdao.getExpenseAccount(id)%>';
}
else{
	expensedata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	
					{name : 'description',type:'string'},
					{name : 'account',type:'string'},
					{name : 'acno',type:'string'}
					
						
						],
				    localdata: expensedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#expenseAcnoSearchGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#expenseAcnoSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
       // showaggregates:true,
       // filtermode:'excel',
       	filterable: true,
       	showfilterrow:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
						{ text: 'Description',datafield:'description',width:'60%'},
						{ text: 'Account No',datafield:'account',width:'30%'},
						{ text: 'Ac No',datafield:'acno',width:'15%',hidden:true}
						
					
					]
    
    });

  
    $('#expenseAcnoSearchGrid').on('rowdoubleclick', function (event) 
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
    		    $('#expenseaccount').val($('#expenseAcnoSearchGrid').jqxGrid('getcellvalue',boundIndex,'description'));
    		    $('#expenseacno').val($('#expenseAcnoSearchGrid').jqxGrid('getcellvalue',boundIndex,'acno'));
    			$('#expensewindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="expenseAcnoSearchGrid"></div>