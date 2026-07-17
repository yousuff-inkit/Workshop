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
		ticketdata='<%=ctd.getRegno(id,fromdate,todate)%>';
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
                    
                 
						{name : 'regno', type: 'string'  }
						
						
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
    
    
    $("#regnoSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        source: dataAdapter,
        filterable:true,
        showfilterrow:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
                      { text: 'SL#', sortable: false, filterable: false, editable: false,
	                   groupable: false, draggable: false, resizable: false,
	                    datafield: 'sl', columntype: 'number', width: '10%',
	                    cellsrenderer: function (row, column, value) {
                    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
	                      }  
	                      },
						{ text: 'Reg No', datafield: 'regno', width: '90%'}
						
						//relodestatus
					]
    
    });
    
    $('#regnoSearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    $('#regno').val($('#regnoSearchGrid').jqxGrid('getcellvalue',boundIndex,'regno'));
    		    $('#regnowindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="regnoSearchGrid"></div>