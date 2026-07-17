<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 <%@page import="com.operations.agreement.nonpoolcreate.ClsNonPoolCreateDAO"%>
<%ClsNonPoolCreateDAO nonpooldao=new ClsNonPoolCreateDAO(); %>
 <script type="text/javascript">
       var checkdata='<%=nonpooldao.getCheckData()%>';	
       $(document).ready(function () { 	
    	   var id='<%=request.getParameter("id")%>';
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int'  },
     						{name : 'sal_name', type: 'String'}
     						
     					
                 ],
                localdata: checkdata,
                //url: url,
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
            $("#checkSearch").jqxGrid(
            {
                width: '100%',
                height: 348,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							{ text: 'Name', datafield: 'sal_name', width: '70%'},
						
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
            $('#checkSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	if(id=="1"){
            		document.getElementById("hidcheckin").value=$("#checkSearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
            		document.getElementById("checkin").value=$("#checkSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
            	}
            	if(id=="2"){
            		document.getElementById("hidcheckout").value=$("#checkSearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
            		document.getElementById("checkout").value=$("#checkSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
            	}
            	$('#checkwindow').jqxWindow('close');
            	
            });  
        });
    </script>
    <div id="checkSearch"></div>
