<%@page import="com.dashboard.operations.vehicleinsurance.*" %>
<%
ClsVehicleInsuranceDAO vehdao=new ClsVehicleInsuranceDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%> 
<script type="text/javascript">
var type='<%=type%>';
var invdata;
var id='<%=id%>';
if(id=="1"){
	invdata='<%=vehdao.getInvoiceCountData(uptodate,branch,id)%>';
}
else{
	invdata=[];
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
				    localdata: invdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#invoiceGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#invoiceGrid").jqxGrid(
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

  
    $('#invoiceGrid').on('rowdoubleclick', function (event) 
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
    			$("#overlay, #PleaseWait").show();
    			$('#desc').val($('#invoiceGrid').jqxGrid('getcellvalue',boundIndex,'desc1'));
    			var desc=$('#desc').val();
    			/* if($('#desc').val()=='Insured'){
    	    		if(type=="1"){
    	    			$('#vehicleInsurGrid').jqxGrid({height:300});	
    	    		}
    	    		else{
    	    			$('#multipleVehicleInsurGrid').jqxGrid({height:300});
    	    		}
    				
    	    		$('#insurhistorydiv').show();
    	    	}
    	    	else{
    	    		if(type=="1"){
    	    			$('#vehicleInsurGrid').jqxGrid({height:500});	
    	    		}
    	    		else{
    	    			$('#multipleVehicleInsurGrid').jqxGrid({height:500});
    	    		}
    	    		
    	    		$('#insurhistorydiv').hide();
    	    	}
    			 */
    			 
    			if(desc=="Insured" && type=="1"){
    				$('#vehicleinsurdiv,#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',true);
    				$('#vehicleInsurGrid').jqxGrid({height:300});	
    				$('#vehicleinsurdiv,#insurhistorydiv').attr('hidden',false);
    			}
    			else if(desc=="Not Insured" && type=="1"){
    				$('#vehicleinsurdiv,#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',true);
    				$('#vehicleInsurGrid').jqxGrid({height:500});	
    				$('#vehicleinsurdiv').attr('hidden',false);
    			}
    			else if(desc=="Insured" && type=="2"){
    				$('#vehicleinsurdiv,#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',true);
    				$('#multipleVehicleInsurGrid').jqxGrid({height:300});
    				$('#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',false);
    			}
    			else if(desc=="Not Insured" && type=="2"){
    				$('#vehicleinsurdiv,#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',true);
    				$('#multipleVehicleInsurGrid').jqxGrid({height:500});
    				$('#multiplevehicleinsurdiv').attr('hidden',false);
    			}
    			else{
    				
    			}
    			if(type=="1"){
    				$('#vehicleinsurdiv').load('vehicleInsurGrid.jsp?desc='+$('#desc').val().replace(/ /g, "%20")+'&id=1&uptodate='+uptodate+'&branch='+branch+'&type='+type);	
    			}
    			else{
    				$('#multiplevehicleinsurdiv').load('multipleVehicleInsurGrid.jsp?desc='+$('#desc').val().replace(/ /g, "%20")+'&id=1&uptodate='+uptodate+'&branch='+branch+'&type='+type);
    			}
    			
    			
    			
    		});
});

	
	
</script>
<div id="invoiceGrid"></div>
<input type="hidden" name="desc" id="desc">