<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasequotation.ClsLeaseQuotationDAO" %>
<%	ClsLeaseQuotationDAO DAO=new ClsLeaseQuotationDAO();
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String leasereqdocno=request.getParameter("leasereqdocno")==null?"":request.getParameter("leasereqdocno");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String client=request.getParameter("client")==null?"":request.getParameter("client");
	String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile"); 
%>
 
 <script type="text/javascript">
 
    	var data2='<%=DAO.lqtMainSearch(session,docno,leasereqdocno,date,id,client,mobile)%>';  
    
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'leasereqdocno', type: 'String'  },
     						{name : 'date',type:'date'},
     						{name : 'refname',type:'string'},
     						{name : 'mobile',type:'string'}
                 ],
                 localdata: data2,
                
                
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
            $("#lqtMainSearchGridID").jqxGrid(
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
						{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
						{ text: 'Lease Req Doc', datafield: 'leasereqdocno', width: '10%' },
						{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Client', datafield: 'refname', width: '45%' },
						{ text: 'Mobile', datafield: 'mobile', width: '20%' },
	              ]
            });

            $('#lqtMainSearchGridID').on('rowdoubleclick', function (event) { 
	            	var rowindex1=event.args.rowindex;
	            	funReset();
	                document.getElementById("docno").value= $('#lqtMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("leasereqdoc").value = $("#lqtMainSearchGridID").jqxGrid('getcellvalue', rowindex1, "leasereqdocno");
	                $('#date').jqxDateTimeInput('val',$("#lqtMainSearchGridID").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtcustomername").value=$('#lqtMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "refname");
	                document.getElementById("txtcustomermobile").value=$('#lqtMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "mobile");
	                
	                $('#frmLeaseQuotation select').attr('disabled', false);
	                $('#date').jqxDateTimeInput({disabled: false});
	                funSetlabel();
	                document.getElementById("frmLeaseQuotation").submit();
	                $('#frmLeaseQuotation select').attr('disabled', true);
	                $('#date').jqxDateTimeInput({disabled: true});
	
	                $('#window').jqxWindow('close');
            }); 
           
        });
    </script>
    <div id="lqtMainSearchGridID"></div>