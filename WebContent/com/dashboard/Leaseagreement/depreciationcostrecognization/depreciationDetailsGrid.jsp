<%@page import="com.dashboard.leaseagreement.depreciationcostrecognization.ClsDepreciationCostRecognizationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsDepreciationCostRecognizationDAO DAO= new ClsDepreciationCostRecognizationDAO(); 
   String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval"); %> 
           	  
<style type="text/css">
      
   .allClass
   {
       background-color: #E0ECF8;
   }
   .toBePostedClass
   {
      color: #FC4747;
   }
</style>

<script type="text/javascript">
	 var temp1='<%=branch%>';
	 var upto='<%=upToDate%>';
	 var data;

	 if(temp1!='NA')
     {
		 data= '<%=DAO.depreciationDetailsGridLoading(branch,upToDate)%>';
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
                   return "allClass";
            } else if (value=='To be Posted') {
            	   return "toBePostedClass";
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
    
    
    $("#depreciationDetailsGridID").jqxGrid(
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
    		
    $('#depreciationDetailsGridID').on('rowdoubleclick', function (event) {
    	var boundIndex = event.args.rowindex;
    	
    	var dtype = $('#depreciationDetailsGridID').jqxGrid('getcelltext',boundIndex, "dtype");
	    
    	if(dtype=='NO') {
    		$('#btnGenerate').attr('disabled', false);
    	} else {
    		$('#btnGenerate').attr('disabled', true);
    	}
    	
    	$("#overlay, #PleaseWait").show();
    	$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: false});
	    $("#depreciationCostRecognizationDiv").load("depreciationCostRecognizationGrid.jsp?uptodate="+upto+"&branchval="+temp1+"&dtype="+dtype);
       	
    }); 
    
});

	
	
</script>
<div id="depreciationDetailsGridID"></div>