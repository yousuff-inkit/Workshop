<%@page import="com.dashboard.salik.ClsSalikDAO" %>
<% ClsSalikDAO csd=new ClsSalikDAO(); %>
<script type="text/javascript">

var	tadata= '<%=csd.tagsearch()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'salik_tag', type: 'string'  },
					
						],
				    localdata: tadata,
        
        
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
    
    
    $("#tagsearch").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Tag No', datafield: 'salik_tag', width: '100%' },
					
					]
    
    });
    $('#tagsearch').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("tagno").value= $('#tagsearch').jqxGrid('getcellvalue',boundIndex, "salik_tag");
    		   // 
    		
    		    
    	        $('#tagwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="tagsearch"></div>