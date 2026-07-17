<%@page import="com.dashboard.audit.smslist.*" %>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id"); 
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
ClsSMSListDAO smsdao=new ClsSMSListDAO();
%>
<script type="text/javascript">
var id='<%=id%>';
var smsdata;
if(id=="1"){
	smsdata='<%=smsdao.getSMSListData(fromdate, todate, id)%>';
}
$(document).ready(function () {
        	
	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'edate', type: 'date' },
					{ name: 'message', type: 'string' },
					{ name: 'phone', type: 'string' }
	            ],
                localdata: smsdata,
               
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
            $("#smsListGrid").jqxGrid(
            {
                width: '98%',
                height: 485,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize:true,
                filterable:true,
                showfilterrow:true,
                columns: [
						{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					 },
						{ text: 'Date', datafield: 'edate', width: '10%',cellsformat:'dd.MM.yyyy HH:mm' },
						{ text: 'Message', datafield: 'message', width: '85%' },
						{ text: 'Mobile', datafield: 'phone', width: '12%',hidden:true }
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="smsListGrid"></div>
