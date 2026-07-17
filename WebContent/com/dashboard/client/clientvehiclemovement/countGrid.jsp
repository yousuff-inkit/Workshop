<%@page import="com.dashboard.client.clientvehiclemovement.*"%>
<%
ClsClientVehicleMovementDAO movdao=new ClsClientVehicleMovementDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String client=request.getParameter("client")==null?"":request.getParameter("client");
%>
<script type="text/javascript">
var countdata;
var id='<%=id%>';
if(id=="1"){
	countdata='<%=movdao.getCountData(fromdate,todate,branch,id,client)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  }
					
						
						],
				    localdata: countdata,
        
        
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
    
    
    $("#countGrid").jqxGrid(
    {
        width: '100%',
        height: 68,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'}
						
					
					]
    
    });
    $('#countGrid').on('rowdoubleclick', function (event) 
    		{ 
    			$('#desc').val($('#countGrid').jqxGrid('getcellvalue',event.args.rowindex,'desc1'));
    			var client=$('#hidclient').val();
    			var desc=$('#desc').val();
    			var fromdate=$('#fromdate').jqxDateTimeInput('val');
    			var todate=$('#todate').jqxDateTimeInput('val');
    			$('#detaildiv').load('detailGrid.jsp?client='+client+'&desc='+desc+'&id=1&fromdate='+fromdate+'&todate='+todate);
    		});
});

</script>
<div id="countGrid"></div>
<input type="hidden" name="desc" id="desc">