<%@page import="com.operations.commercialreceipt.ClsCommercialReceiptDAO" %>
<% ClsCommercialReceiptDAO crd=new ClsCommercialReceiptDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String accountName = request.getParameter("accountName")==null?"0":request.getParameter("accountName");
 String srNo = request.getParameter("srNo")==null?"0":request.getParameter("srNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String total = request.getParameter("total")==null?"0":request.getParameter("total");
 String refNo = request.getParameter("refNo")==null?"0":request.getParameter("refNo");
%> 

 <script type="text/javascript">
 
 			var data1='<%=crd.cmrMainSearch(session,accountName, srNo, date, total, refNo)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'srno', type: 'int' },
                            {name : 'rdocno', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'description', type: 'String' },
     						{name : 'netamt', type: 'number' },
     						{name : 'refno', type: 'String'  },
						    {name : 'email', type: 'String'  }
                          	],
                          	localdata: data1,
                
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
            $("#jqxrentalreceiptsearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                columnsresize: true,
     					
                columns: [
					 { text: 'RR No', datafield: 'srno', width: '10%' },
					 { text: 'Doc No', datafield: 'rdocno', width: '10%' },
					 { text: 'Date', datafield: 'date', width: '10%',cellsformat: 'dd.MM.yyyy'  },
					 { text: 'Account Name', datafield: 'description', width: '40%' },
					 { text: 'Total', datafield: 'netamt', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					 { text: 'Cheque/Card No.', datafield: 'refno', width: '15%' },
					 { text: 'Email', datafield: 'email', width: '15%',hidden:true },
					]
            });
            
			  $('#jqxrentalreceiptsearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtclientname").value= $('#jqxrentalreceiptsearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxrentalreceiptsearch').jqxGrid('getcellvalue', rowindex1, "rdocno");
                document.getElementById("txtsrno").value= $('#jqxrentalreceiptsearch').jqxGrid('getcellvalue', rowindex1, "srno");
				document.getElementById("email").value= $('#jqxrentalreceiptsearch').jqxGrid('getcellvalue', rowindex1, "email");
                
                $('#frmCommercialReceipt select').attr('disabled', false);
                $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
                $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
                $('#chckib').attr('disabled', false);
                funSetlabel();
                document.getElementById("frmCommercialReceipt").submit();
                $('#chckib').attr('disabled', true);
                $('#frmCommercialReceipt select').attr('disabled', true);
                $('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
                $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                        
    </script>
    <div id="jqxrentalreceiptsearch"></div>
    