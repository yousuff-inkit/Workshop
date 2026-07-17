<%@page import="com.dashboard.trafficfine.trafficstatus.ClsTrafficdetailsDAO" %>
<%ClsTrafficdetailsDAO ctd=new ClsTrafficdetailsDAO();
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
System.out.println("Raw Fromdate:"+request.getParameter("fromdate"));
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim();
%> 
<script type="text/javascript">
	var id='<%=id%>';
	var ticketdata;
	 if(id=="1"){ 
		ticketdata='<%=ctd.getTickets(id,fromdate,todate)%>';
	 } 
	 else{
		 ticketdata=[];
	 }
$(document).ready(function () {
	 
	// prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 
						{name : 'ticketno', type: 'string'  },
						{name : 'status', type: 'string'  }
						
						],
				    localdata: ticketdata,
        
        
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
    
    
    $("#ticketSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        source: dataAdapter,
        filterable:true,
        showfilterrow:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Ticket No', datafield: 'ticketno', width: '50%'},
						{ text: 'Status', datafield: 'status', width: '50%'}
						//relodestatus
					]
    
    });
    
    $('#ticketSearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    $('#ticketno').val($('#ticketSearchGrid').jqxGrid('getcellvalue',boundIndex,'ticketno'));
    		    $('#ticketnowindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="ticketSearchGrid"></div>