<%@page import="com.operations.commercialreceipt.ClsCommercialReceiptDAO" %>
<% ClsCommercialReceiptDAO DAO=new ClsCommercialReceiptDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 
 String salper = request.getParameter("salper")==null?"0":request.getParameter("salper");
 
 
%> 

 <script type="text/javascript">
 
	var clientData='<%=DAO.clientAccountsDetails(session, "CMR", atype, accountno, accountname, mobile, currency, date, check,salper)%>';
 	$(document).ready(function () { 

 		var source = 
         {
             datatype: "json",
             datafields: [
                           {name : 'doc_no', type: 'int'   },
  						   {name : 'account', type: 'string'   },
  						   {name : 'description', type: 'string'  },
  						   {name : 'currency', type: 'string'  },
  						   {name : 'mobile', type: 'string'  },
  						   {name : 'curid', type: 'int'  },
  						   {name : 'rate', type: 'string'  },
  						   {name : 'cldocno', type: 'int'  },
  						   {name : 'email', type: 'string'  },
  						   
  						 {name : 'sal_name', type: 'string'  }, 
  						 
                       	],
                       	localdata: clientData,
             
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
         $("#jqxAccountsTypeSearch").jqxGrid(
         {
             width: '100%',
             height: 300,
             source: dataAdapter,
             selectionmode: 'singlerow',
  			 editable: false,
  			 localization: {thousandsSeparator: ""},
  			
             columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '20%' },
						{ text: 'Account Name', datafield: 'description', width: '35%' },
						
						{ text: 'Sales Person ', datafield: 'sal_name', width: '20%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Mobile', datafield: 'mobile', width: '15%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
						{ text: 'Cldocno', hidden: true, datafield: 'cldocno', width: '5%' },
						{ text: 'Email', hidden: true, datafield: 'email', width: '10%' },
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               	   var rowindex1 = event.args.rowindex;
               	   
            	   document.getElementById("txtacno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                   document.getElementById("txtcldocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                   document.getElementById("txtclientid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
               	   document.getElementById("txtclientname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
               	   document.getElementById("email").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "email");
               	
	        		var indexVal = document.getElementById("txtacno").value;
	    	       	$("#applyInvoicing1").load("applyInvoiceGrid.jsp?accountno="+indexVal);
	       	  
	                $('#clientDetailsWindow').jqxWindow('close'); 
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    