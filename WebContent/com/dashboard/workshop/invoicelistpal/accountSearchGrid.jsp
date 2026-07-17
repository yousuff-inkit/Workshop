<%@ page import="com.dashboard.workshop.invoicelistpal.*" %>
<% ClsWSInvoiceListDAO listdao=new ClsWSInvoiceListDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
 String id = request.getParameter("id")==null?"":request.getParameter("id");
 String type = request.getParameter("type")==null?"":request.getParameter("type");%>
<script type="text/javascript">
var accountdata=[];
var id='<%=id%>';
if(id=="1"){
	accountdata= '<%=listdao.getAccountSearchData(clientname, docno,type,id)%>'; 
}
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
      						{name : 'account',type:'number'},
      						{name : 'acno',type:'number'},
      						{name : 'acname',type:'string'},
      						{name : 'type',type:'string'},
     						
                        ],
                		 localdata: accountdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#accountSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow:true,
                sortable:true,
                columns: [
                			{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '10%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
							{ text: 'Account #',  datafield: 'account', width: '10%',columntype: 'number' },
							{ text: 'Account Name', datafield: 'acname', width: '50%' },
							{ text: 'Type', datafield: 'type', width: '30%'},
							{ text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
						]
            });
            
              $('#accountSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("account").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("accountname").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "acname");
            	document.getElementById("acno").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "acno");
            	$('#accountwindow').jqxWindow('close'); 
            });   
        });
    </script>
    <div id="accountSearchGrid"></div>
 