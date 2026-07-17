<%@page import="com.dashboard.audit.datalog.ClsDataLogDAO" %>
<%ClsDataLogDAO ctd=new ClsDataLogDAO(); %>


 <%
           	String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
	String fromdate = request.getParameter("from")==null?"0":request.getParameter("from").trim();
  	String todate = request.getParameter("to")==null?"0":request.getParameter("to").trim();
  	String value = request.getParameter("value")==null?"0":request.getParameter("value").trim();
  	String branch = request.getParameter("branch")==null?"0":request.getParameter("branch").trim();
  	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	String hidform = request.getParameter("hidform")==null?"0":request.getParameter("hidform").trim();
  	String hiduser = request.getParameter("hiduser")==null?"0":request.getParameter("hiduser").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas= '<%=ctd.subDetails(branch, fromdate, todate, id, hiduser, hidform,value)%>';
		
		bb=0;
}
	else{
		vehdatas;
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
                    
                 
						{name : 'user', type: 'string'  },
						{name : 'count', type: 'string'  }
						
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#vehdetails").jqxGrid(
    {
        width: '90%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'User', datafield: 'user', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring}
						
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#vehdetails").jqxGrid('addrow', null, {});
	}
   <%--  $('#vehdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
   
    		    $("#overlay, #PleaseWait").show();
    		    var relodestatus = $('#vehdetails').jqxGrid('getcelltext',boundIndex, "relodestatus");

  $("#fleetdiv").load("detailsgrid.jsp?relodestatus="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>');
    	 
    		}); --%>
});

	
	
</script>
<div id="vehdetails"></div>