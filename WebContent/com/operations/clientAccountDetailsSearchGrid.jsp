<%@page import="com.search.ClsAccountSearch"%>
<% ClsAccountSearch DAO= new ClsAccountSearch(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String debitcredit = request.getParameter("debitcredit")==null?"0":request.getParameter("debitcredit");
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var clientData='<%=DAO.clientAccountsDetails(session, dtype, atype, accountno, accountname, mobile, currency, date, check)%>';
 	$(document).ready(function () { 
 		var doctype='<%=dtype%>';
 		var debitcredit='<%=debitcredit%>';

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
  						   {name : 'cldocno', type: 'int'  }
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
						{ text: 'Account', datafield: 'account', width: '25%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Mobile', datafield: 'mobile', width: '15%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
						{ text: 'Cldocno', hidden: true, datafield: 'cldocno', width: '5%' },
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               var rowindex1 = event.args.rowindex;
               if(debitcredit=="1"){
            	   document.getElementById("txtacno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                   document.getElementById("txtcldocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                   document.getElementById("txtclientid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
               	   document.getElementById("txtclientname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
               }else if(debitcredit=="2"){
            	   document.getElementById("txtclientdocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
               	   document.getElementById("txtclientname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
               }
	          
	          if(doctype=="RRV"){
	        		var indexVal = document.getElementById("txtacno").value;
	    	       	$("#applyInvoicing1").load("applyInvoiceGrid.jsp?accountno="+indexVal);
	       	   }

	          $('#clientDetailsWindow').jqxWindow('close'); 
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    