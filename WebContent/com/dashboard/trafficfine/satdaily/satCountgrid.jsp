<%@page import="com.SatAutoDownload.SATdownloadDAO" %>
<%SATdownloadDAO sd=new SATdownloadDAO(); %>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>
<script type="text/javascript">
	
	 var satdata;
	 var bb='<%=satcateg%>';
	if(bb!='0'){
		satdata= '<%=sd.getDatewiseCount(fromdate,todate,satcateg)%>';
	}
	

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'date', type: 'string'  },
                 	{name : 'hiddate', type: 'string'  },
						{name : 'datecount', type: 'string'  }
						
						],
				    localdata: satdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#jqxSatCount").jqxGrid(
    {
        width: '100%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Date', datafield: 'date', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'HidDate', datafield: 'hiddate', width: '70%',hidden:true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'datecount', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					]
    
    });
    if(bb==1)
	{
	 $("#jqxSatCount").jqxGrid('addrow', null, {});
	}
    $('#jqxSatCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    var fromdate = $('#jqxSatCount').jqxGrid('getcelltext',boundIndex, "hiddate");
    		    var todate = $('#jqxSatCount').jqxGrid('getcelltext',boundIndex, "hiddate");
    		    
    		    var satcateg;
    			
    			 if (document.getElementById('radio_salik').checked) {
    					
    				 satcateg=$("#radio_salik").val();
    				 $("#overlay, #PleaseWait").show();
    				  $("#loadsalikdata").load("SATloadDetails.jsp?fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
    				  
    				}
    			 else if (document.getElementById('radio_traffic').checked) {
    					
    				 satcateg=$("#radio_traffic").val();
    				 
    				 $("#overlay, #PleaseWait").show();
    				  $("#loadtrafficdata").load("SATTrafficloadDetails.jsp?fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
    				  
    				}
    		    

    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxSatCount"></div>