<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.cashflow.ClsCashFlowDAO"%>
<% ClsCashFlowDAO DAO= new ClsCashFlowDAO(); %>
 <% String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
    String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
    String den = request.getParameter("den")==null?"0":request.getParameter("den"); 
    String chk = request.getParameter("chk")==null?"0":request.getParameter("chk"); %> 

 <script type="text/javascript">
 
 		var data2= '<%=DAO.accountDetails(den, accNo, partyname, chk)%>';   
 		
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'  },
                          	],
                          	localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#bankAccountSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',

                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Account', datafield: 'account', width: '25%' },
							{ text: 'Account Name', datafield: 'description', width: '70.5%' },
					    ]
            });
				           
}); 
                       
</script>

<div id="bankAccountSearchGridID"></div>
    
</body>
</html>