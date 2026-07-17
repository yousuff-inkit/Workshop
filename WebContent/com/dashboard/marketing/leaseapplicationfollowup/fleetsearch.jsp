 <%@page import="com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO"%>
     <%ClsleaseApplicationFollowupDAO cmd= new ClsleaseApplicationFollowupDAO(); %>

 <%
		
	String  brandid=request.getParameter("brdid")==null?"0":request.getParameter("brdid");
	String  modid=request.getParameter("modid")==null?"0":request.getParameter("modid");

       
		%>
<script type="text/javascript">

var	fleet= '<%=cmd.fleetSearch(brandid,modid)%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						{name : 'vin', type: 'string'  },
						{name : 'ch_no', type: 'string'  },
				
						],
				    localdata: fleet,
        
        
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
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 336,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Fleet', datafield: 'fleet_no', width: '20%' },
						{ text: 'Name', datafield: 'flname', width: '45%'},
						{ text: 'Chassis No.', datafield: 'ch_no', width: '35%'},
						{ text: 'doc', datafield: 'doc_no', width: '25%',hidden:true},
						{ text: 'vin', datafield: 'vin', width: '25%',hidden:true},
				 
						
						
						
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    	var rowindex1=event.args.rowindex;
    		  
    			  document.getElementById("txtfleetno").value= $('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex1, "flname"); 
	                document.getElementById("hidfleetno").value = $("#fleetsearchGrid").jqxGrid('getcellvalue', rowindex1, "fleet_no");
	                document.getElementById("fleetdoc").value = $("#fleetsearchGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
	             //   document.getElementById("txtalloc").value = $("#fleetsearchGrid").jqxGrid('getcellvalue', rowindex1, "vin");
	             
    	        $('#fleetinfowindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>