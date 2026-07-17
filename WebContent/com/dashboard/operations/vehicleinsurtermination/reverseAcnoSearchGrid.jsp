<%@page import="com.dashboard.operations.vehicleinsurancetermination.*" %>
<%
ClsVehicleInsuranceTerminationDAO termdao=new ClsVehicleInsuranceTerminationDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%> 
<script type="text/javascript">
var reversedata;
var id='<%=id%>';
if(id=="1"){
	reversedata='<%=termdao.getReverseAccount(id)%>';
}
else{
	reversedata=[];
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
				    localdata: reversedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#reverseAcnoSearchGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#reverseAcnoSearchGrid").jqxGrid(
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

  
    $('#reverseAcnoSearchGrid').on('rowdoubleclick', function (event) 
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
    		    $('#reverseaccount').val($('#reverseAcnoSearchGrid').jqxGrid('getcellvalue',boundIndex,'description'));
    		    $('#reverseacno').val($('#reverseAcnoSearchGrid').jqxGrid('getcellvalue',boundIndex,'acno'));
    			$('#reversewindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="reverseAcnoSearchGrid"></div>