<%@page import="com.dashboard.workshop.jobcardcompletev5.*" %>
<% ClsJobCardCompleteV5DAO DAO=new ClsJobCardCompleteV5DAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String clientmode = request.getParameter("clientmode")==null?"":request.getParameter("clientmode");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.clientData(clientname, check)%>'; 
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'},
     						{name : 'clientname', type: 'string'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '20%' },
							{ text: 'Client', datafield: 'clientname', width: '80%' }
						]
            });
            
             $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                var clientmode='<%=clientmode%>';
                if(clientmode=="sec"){
                	document.getElementById("seccldocno").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                	document.getElementById("secclientname").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "clientname");
					
                }
                else{
	                document.getElementById("cldocno").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
	                document.getElementById("clientname").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "clientname");
					
                }
                
            	$('#clientSearchWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="clientSearchGridID"></div>