<%@page import="com.dashboard.analysis.termloanreports.ClsTermLoanReportsDAO" %>
<%ClsTermLoanReportsDAO cpd=new ClsTermLoanReportsDAO(); %>

<script type="text/javascript">

var	dealnos= '<%=cpd.dealnoseachmove()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'dealno', type: 'string'  },
						 
						 
						],
				    localdata: dealnos,
        
        
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
    
    
    $("#dealnosearchgrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Deal No', datafield: 'dealno', width: '100%' },
				 
						 
					]
    
    });
    $('#dealnosearchgrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("dealno").value= $('#dealnosearchgrid').jqxGrid('getcellvalue',boundIndex, "dealno");
    		    
    	        $('#dealnowindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="dealnosearchgrid"></div>