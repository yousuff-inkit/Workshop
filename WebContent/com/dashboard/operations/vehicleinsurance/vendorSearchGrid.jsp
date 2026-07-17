<%@page import="com.dashboard.operations.vehicleinsurance.*" %>
<%
ClsVehicleInsuranceDAO vehdao=new ClsVehicleInsuranceDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%> 
<script type="text/javascript">
var type='<%=type%>';
var invdata;
var id='<%=id%>';
if(id=="1"){
	vendordata='<%=vehdao.getVendor(id)%>';
}
else{
	vendordata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	
					{name : 'refname', type: 'string'  },
					
					{name : 'account',type:'string'},
					{name : 'acno',type:'string'}
					
						
						],
				    localdata: vendordata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#vendorSearchGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#vendorSearchGrid").jqxGrid(
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

						
						{ text: 'Name', datafield: 'refname', width: '80%'},
						{ text: 'Account No',datafield:'account',width:'20%'},
						{ text: 'Ac No',datafield:'acno',width:'15%',hidden:true}
						
					
					]
    
    });

  
    $('#vendorSearchGrid').on('rowdoubleclick', function (event) 
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
    		    if(type=="1"){
        		    $('#singlevendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'refname'));
        		    //$('#singlehidvendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
        		    $('#singlevendoracno').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'acno'));    		    	
    		    }
    		    else{
        		    $('#multiplevendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'refname'));
        		    //$('#multiplehidvendor').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
        		    $('#multiplevendoracno').val($('#vendorSearchGrid').jqxGrid('getcellvalue',boundIndex,'acno'));    		    	
    		    }

    			$('#vendorwindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="vendorSearchGrid"></div>