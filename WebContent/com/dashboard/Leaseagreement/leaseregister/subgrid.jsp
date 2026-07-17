<%@ page import="com.dashboard.leaseagreement.leaseregister.ClsleaseregisterDAO" %>

 <%
          
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
  	
  	ClsleaseregisterDAO cfld=new ClsleaseregisterDAO();
  	
           	  %> 
<script type="text/javascript">
	var temp1='<%=branchval%>';
	 var leasedata;
	 var bb;
	if(temp1!='NA')
{
		leasedata= '<%=cfld.subDetails(fromdate,todate,branchval) %>';
		
		bb=0;
}
	else{
		leasedata;
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
						{name : 'count', type: 'string'  },
						
						
						],
				    localdata: leasedata,
        
        
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
    
    
    $("#statusdetails").jqxGrid(
    {
        width: '92%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#statusdetails").jqxGrid('addrow', null, {});
	}
    $("#overlaysub, #PleaseWaitsub").hide();
    $('#statusdetails').on('rowdoubleclick', function (event) 
    		{ 
    		
    		    var boundIndex = event.args.rowindex;
    	
    		    $("#overlay, #PleaseWait").show();
    		    var status = $('#statusdetails').jqxGrid('getcelltext',boundIndex, "status");
    		  
    		    $("#detlist").load("detailsGrid.jsp?status="+status+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>'+"&branchval="+'<%=branchval%>');
    	 
    		});
});

	
	
</script>
<div id="statusdetails"></div>