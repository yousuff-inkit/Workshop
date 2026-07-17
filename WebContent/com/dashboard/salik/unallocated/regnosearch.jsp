<%@page import="com.dashboard.salik.ClsSalikDAO" %>
<% ClsSalikDAO csd=new ClsSalikDAO(); %>
<script type="text/javascript">

var	regdata= '<%=csd.regsearch()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'reg_no', type: 'string'  },
					
						],
				    localdata: regdata,
        
        
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
    
    
    $("#regsearch").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Reg No', datafield: 'reg_no', width: '100%' },
					
					]
    
    });
    $('#regsearch').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("regno").value= $('#regsearch').jqxGrid('getcellvalue',boundIndex, "reg_no");
    		   // 
    		
    		    
    	        $('#regwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="regsearch"></div>