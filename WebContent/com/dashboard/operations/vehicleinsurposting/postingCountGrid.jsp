<%@page import="com.dashboard.operations.vehicleinsurposting.*" %>
<%
ClsVehicleInsurPostingDAO postdao=new ClsVehicleInsurPostingDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
%>
<script type="text/javascript">
var countdata;
var id='<%=id%>';
if(id=="1"){
	countdata='<%=postdao.getPostingCountData(id,uptodate)%>';
}
else{
	countdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  }
					
						
						],
				    localdata: countdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#postingCountGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#postingCountGrid").jqxGrid(
    {
        width: '100%',
        height: 75,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'}
						
					
					]
    
    });

  
    $('#postingCountGrid').on('rowdoubleclick', function (event) 
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
	   		    
	   		    var uptodate='<%=uptodate%>';
	   			var branch='<%=branch%>';
	   			$('#desc').val($('#postingCountGrid').jqxGrid('getcellvalue',boundIndex,'desc1'));
	   			$("#overlay, #PleaseWait").show();
	   			$('#detailsdiv').load('detailsGrid.jsp?desc='+$('#desc').val().replace(/ /g, "%20")+'&id=1&uptodate='+uptodate+'&branch='+branch);
				if($('#desc').val()=='Posted'){
	   				$('#expenseaccount,#btnpost').attr('disabled',true);
	   			}
	   			else{
	   				$('#expenseaccount,#btnpost').attr('disabled',false);
	   			}
			});
			
			
});
</script>
<div id="postingCountGrid"></div>
<input type="hidden" name="desc" id="desc">