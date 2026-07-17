<%@page import="com.dashboard.serviceandmaintenance.workorderstatus.ClsWorkOrderStatus"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsWorkOrderStatus DAO= new ClsWorkOrderStatus(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");%> 
           	  
<style type="text/css">
      
   .greyClass
   {
       background-color: #E0ECF8;
   }
</style>

<script type="text/javascript">
	 var temp1='<%=branch%>';
	 var from='<%=fromDate%>';
	 var to='<%=toDate%>';
	 var data;

	 if(temp1!='NA')
     {
		 data= '<%=DAO.maintenanceDetailsGridLoading(branch,fromDate,toDate)%>';
     }
	
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(typeof(value) == "undefined"){
       		value=0.00;
       	}
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }
        var cellclassname = function (row, column, value, data) {
 
            if (value=='All' || value=='') {
                   return "greyClass";
             }
          };
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'dtype', type: 'string'  },
					{name : 'status', type: 'string'  },
					{name : 'value', type: 'string'  }
						
					],
				    localdata: data,
        
        
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
    
    
    $("#jqxmaintenanceDetails").jqxGrid(
    {
        width: '90%',
        height: 250,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
						{ text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
						{ text: 'Dtype', datafield: 'dtype', width: '10%', hidden:true },
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();    
    		
    $('#jqxmaintenanceDetails').on('rowdoubleclick', function (event) {
    	var boundIndex = event.args.rowindex;
    	
    	var dtype = $('#jqxmaintenanceDetails').jqxGrid('getcelltext',boundIndex, "dtype");
	    
    	$("#overlay, #PleaseWait").show();
    	
	    $("#workOrderStatusDiv").load("workOrderStatusGrid.jsp?fromdate="+from+"&todate="+to+"&branchval="+temp1+"&dtype="+dtype);
       	
    }); 
    
});

	
	
</script>
<div id="jqxmaintenanceDetails"></div>