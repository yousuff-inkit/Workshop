<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>
<%--    <jsp:include page="../../../includes.jsp"></jsp:include> --%>   
 <% String dtype=request.getParameter("dtype");%>
 <% String rowIndex=request.getParameter("rowBoundIndex")==null?"0":request.getParameter("rowBoundIndex");
 System.out.println("rowBoundIndex=="+rowIndex);%>
<script type="text/javascript">
    var data= '<%= cas.accsearch_gl() %>';
    var dtype='<%=dtype%>';
    var rowIndex='<%=rowIndex%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  },
     						{name : 'acc', type: 'String'  }
                 ],
                 localdata: data,
                
                
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
            $("#jqxAccountsGrid").jqxGrid(
            {
                width: '100%',
                height: 410,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
		 filterable: true,
                showfilterrow: true,
               
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true },
					{ text: 'Account No', datafield: 'acc', width: '20%' },
					{ text: 'Account',datafield: 'description', width: '80%' }
	              ]
            });

            $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                $('#acntCntrlRegId').jqxGrid('setcellvalue', rowIndex, "acno",$('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
		                $('#acntCntrlRegId').jqxGrid('setcellvalue', rowIndex, "accountname",$('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"));
		                $('#acntCntrlRegId').jqxGrid('setcellvalue', rowIndex, "account",$('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "acc"));
		              $('#accountWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxAccountsGrid"></div>
