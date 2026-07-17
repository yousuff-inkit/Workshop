<%@page import="com.dashboard.integration.intercompanytransfer.ClsInterCompanyTransferDAO" %>
<% ClsInterCompanyTransferDAO casd=new ClsInterCompanyTransferDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
 String mainAccount = request.getParameter("mainaccount")==null?"0":request.getParameter("mainaccount");
 String checkAccount = request.getParameter("checkaccount")==null?"0":request.getParameter("checkaccount");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var data1= '<%=casd.accountDetails(accNo, partyname, mainAccount, checkAccount, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'  },
     						{name : 'curid', type: 'int'   },
     						{name : 'currency', type: 'string'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'type', type: 'string'  }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsTypeFromSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
							{ text: 'Account', datafield: 'account', width: '30%' },
							{ text: 'Account Name', datafield: 'description', width: '70%' },
							{ text: 'Curid', datafield: 'curid', hidden: true, width: '20%' },
							{ text: 'Currency',  datafield: 'currency', hidden: true, width: '15%' },
							{ text: 'Rate',  datafield: 'rate', hidden: true, cellsformat: 'd2',cellsalign:'right',align:'right', width: '15%' },
							{ text: 'Type',  datafield: 'type', hidden: true, width: '15%' },
						]
            });
            
             $('#jqxAccountsTypeFromSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                if(parseInt($('#txtcheckaccount').val())==1) {
                	
                		document.getElementById("txtmainaccountdocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                		document.getElementById("txtmainaccount").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
            			document.getElementById("txtmainaccountname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
            			document.getElementById("txtmainaccountcurid").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "curid");
            			document.getElementById("txtmainaccountrate").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "rate");
            			document.getElementById("txtmainaccountcurtype").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "type");
            		
                } else {
                    	document.getElementById("txtsubaccountdocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                    	document.getElementById("txtsubaccount").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
                		document.getElementById("txtsubaccountname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
                		document.getElementById("txtsubaccountcurid").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "curid");
                		document.getElementById("txtsubaccountrate").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "rate");
                		document.getElementById("txtsubaccountcurtype").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "type");
                }
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxAccountsTypeFromSearch"></div>
 