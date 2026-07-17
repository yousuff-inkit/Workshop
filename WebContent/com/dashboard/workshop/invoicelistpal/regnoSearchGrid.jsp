<%@ page import="com.dashboard.workshop.invoicelistpal.*" %>
<% ClsWSInvoiceListDAO listdao=new ClsWSInvoiceListDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String id = request.getParameter("id")==null?"":request.getParameter("id");%>
<script type="text/javascript">
var regnodata=[];
var id='<%=id%>';
if(id=="1"){
	regnodata= '<%=listdao.getRegnoData(id)%>'; 
}
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
      						{name : 'regno',type:'string'},
      						{name : 'platecode',type:'string'}
     						
                        ],
                		 localdata: regnodata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#regnoSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow:true,
                sortable:true,
                columns: [
                			{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '20%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
							{ text: 'Reg No',  datafield: 'regno', width: '40%'},
							{ text: 'Plate Code', datafield: 'platecode', width: '40%' }
						]
            });
            
              $('#regnoSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("regno").value = $('#regnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "regno");
            	$('#regnowindow').jqxWindow('close'); 
            });   
        });
    </script>
    <div id="regnoSearchGrid"></div>
 