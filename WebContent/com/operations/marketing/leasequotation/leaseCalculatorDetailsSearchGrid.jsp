<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasequotation.ClsLeaseQuotationDAO" %>
<%	ClsLeaseQuotationDAO DAO=new ClsLeaseQuotationDAO();
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String leasereqdocno=request.getParameter("leasecalcreqdocno")==null?"":request.getParameter("leasecalcreqdocno");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String client=request.getParameter("client")==null?"":request.getParameter("client");
	String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
	String leasequotdocno=request.getParameter("leaseQuotationDocno")==null?"":request.getParameter("leaseQuotationDocno");
%>
 
 <script type="text/javascript">
 
    	var data1='<%=DAO.leaseCalcSearch(session,docno,leasereqdocno,date,id,client,mobile)%>';  
    
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'vocno' , type: 'String' },
     						{name : 'leasereqdocno', type: 'String'  },
     						{name : 'date',type:'date'},
     						{name : 'refname',type:'string'},
     						{name : 'mobile',type:'string'},
     						{name : 'address',type:'string'},
     						{name : 'email',type:'string'},
     						{name : 'sal_name',type:'string'},
     						{name : 'cldocno',type:'int'},
     						{name : 'doc_no' , type: 'int' }
     						
                 ],
                 localdata: data1,
                
                
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
            $("#leaseCalculatorSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,

                columns: [
						{ text: 'Doc No', datafield: 'vocno', width: '10%' },
						{ text: 'Lease Req Doc', datafield: 'leasereqdocno', width: '10%' },
						{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Client', datafield: 'refname', width: '45%' },
						{ text: 'Mobile', datafield: 'mobile', width: '20%' },
						{ text: 'Address', datafield: 'address', width: '10%', hidden: true },
						{ text: 'Email', datafield: 'email', width: '10%', hidden: true },
						{ text: 'Salesname', datafield: 'sal_name', width: '10%', hidden: true },
						{ text: 'Cldocno', datafield: 'cldocno', width: '10%', hidden: true },
						{ text: 'Doc No', datafield: 'doc_no', width: '10%', hidden: true },
	              ]
            });

            $('#leaseCalculatorSearchGridID').on('rowdoubleclick', function (event) { 
	            	var rowindex1=event.args.rowindex;
	            	document.getElementById("txtquotationvocno").value= $('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "vocno");
	                document.getElementById("txtquotationno").value= $('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("leasereqdoc").value = $("#leaseCalculatorSearchGridID").jqxGrid('getcellvalue', rowindex1, "leasereqdocno");
	                document.getElementById("txtcustomerdocno").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
	                document.getElementById("txtcustomername").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "refname");
	                document.getElementById("txtcustomeraddress").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "address");
	                document.getElementById("txtcustomermobile").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "mobile");
	                document.getElementById("txtcustomeremail").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "email");
	                document.getElementById("txtsalesman").value=$('#leaseCalculatorSearchGridID').jqxGrid('getcellvalue', rowindex1, "sal_name");
	                
	                $('#leaseQuotationDiv').load('leaseQuotationGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("txtquotationno").value);
	
	                $('#leaseCalculatorDetailsWindow').jqxWindow('close');
            }); 
           
        });
    </script>
    <div id="leaseCalculatorSearchGridID"></div>