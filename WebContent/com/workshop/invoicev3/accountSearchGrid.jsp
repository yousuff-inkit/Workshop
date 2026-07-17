 <%@page import="com.workshop.invoicev3.*" %>
 <%ClsInvoiceV3DAO invdao=new ClsInvoiceV3DAO();
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 %>

 <script type="text/javascript">
var id='<%=id%>';
var accountdata=[];
if(id=="1"){
	accountdata='<%=invdao.getAccountData(id)%>';
}
 $(document).ready(function () {
	 
	 
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
						
  						{name : 'account', type: 'string'},
  						{name : 'doc_no', type: 'string'},
  						{name : 'description', type: 'string'}
  						     						
              ],
              localdata: accountdata,
             
             
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
	 
	 $("#accountSearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 300,
                pageable: false,
                source: dataAdapter,
                editable: false, 
                autoheight: false,
                sortable: false,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                
                columns: [
							
							{ text: 'Account No', datafield: 'account', width: '30%' },
							{ text: 'Doc. No Original', datafield: 'doc_no', width: '18%',hidden:true },
							{ text: 'Account Name', datafield: 'description', width: '70%'}
																					
	              ]
            });
	 
	 $('#accountSearchGrid').on('rowdoubleclick', function (event) {
         var rowindex=event.args.rowindex;
		  	document.getElementById("excessamountaccount").value = $("#accountSearchGrid").jqxGrid('getcellvalue', rowindex, "account");
		  	document.getElementById("excessamountacname").value = $("#accountSearchGrid").jqxGrid('getcellvalue', rowindex, "description");
		  	document.getElementById("excessamountacno").value = $("#accountSearchGrid").jqxGrid('getcellvalue', rowindex, "doc_no");
			$('#searchWindow').jqxWindow('close'); 
     });
	 
	 
 });
 
 </script>
 <div id="accountSearchGrid"></div>