
  <%@page import="com.dashboard.salik.salikdetails.ClsSalikdetailsDAO"%> 
 <%
        
 ClsSalikdetailsDAO showDAO = new  ClsSalikdetailsDAO();
 String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
	String fromdate = request.getParameter("from")==null?"0":request.getParameter("from").trim();
  	String todate = request.getParameter("to")==null?"0":request.getParameter("to").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas1;
	 var bb;
	if(temp1!='NA')
{
		vehdatas1= '<%=showDAO.postingDetails(fromdate,todate)%>';
		
		bb=0;
}
	else{
		vehdatas1;
		 bb=1;
	}
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
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
                    
                 
						{name : 'status', type: 'string'  },
						{name : 'value', type: 'string'  },
						{name : 'relodestatus', type: 'string'  }
						
						],
				    localdata: vehdatas1,
        
        
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
    
    
    $("#postdetails").jqxGrid(
    {
        width: '90%',
        height: 100,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'relodestatus', width: '30%' ,hidden:true},
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#postdetails").jqxGrid('addrow', null, {});
	}
    $('#postdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
  
    		    $("#overlay, #PleaseWait").show();
 
    		    
    		    var relodestatus = 'POS';

    		    $("#fleetdiv").load("detailsgrid.jsp?relodestatus="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>');
    	 
    		});
});

	
	
</script>
<div id="postdetails"></div>