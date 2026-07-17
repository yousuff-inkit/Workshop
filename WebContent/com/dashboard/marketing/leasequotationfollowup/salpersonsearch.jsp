 <%@page import="com.dashboard.marketing.leasequotationfollowup.leaseQuotationFollowupDAO"%>
     <%leaseQuotationFollowupDAO cmd= new leaseQuotationFollowupDAO(); %>
 <%-- <%
		
	String  brandid=request.getParameter("brdid")==null?"0":request.getParameter("brdid");
	String  modid=request.getParameter("modid")==null?"0":request.getParameter("modid");

       
		%> --%>
<script type="text/javascript">

var	salper= '<%=cmd.salpersonSearch()%>' ;

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'sal_name', type: 'string'  },
						
						{name : 'doc_no', type: 'string'  },
						
				
						],
				    localdata: salper,
        
        
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
    
    
    $("#salpersonsearchGridqot").jqxGrid(
    {
        width: '100%',
        height: 336,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						
						{ text: 'Name', datafield: 'sal_name', width: '100%'},
						
						{ text: 'doc', datafield: 'doc_no', width: '%',hidden:true},
						
						
					]
    
    });
    $('#salpersonsearchGridqot').on('rowdoubleclick', function (event) 
    		{ 
    	
    	var rowindex1=event.args.rowindex;
    		  
    			  document.getElementById("salperson").value= $('#salpersonsearchGridqot').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
	                document.getElementById("hidsalperson").value = $("#salpersonsearchGridqot").jqxGrid('getcellvalue', rowindex1, "doc_no");
	               
    	        $('#salpersonwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="salpersonsearchGridqot"></div>