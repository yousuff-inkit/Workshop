<%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO" %>
       <%--  var data1= '<%=com.finance.transactions.cashpayment.ClsCashPaymentDAO.cashPaymentGridSearch() %>';  --%>
       <script type="text/javascript">
  /*    var temp=document.getElementById("txtcusid").value;
		if(temp>0)
			{
			var url1='disDriver.jsp?clientid='+temp;
			
			}
		else
			{
			var url1;
			} */
			<%
			ClsEnquiryDAO viewDAO=new ClsEnquiryDAO();
			String  brandval=request.getParameter("brandval")==null?"0":request.getParameter("brandval");
			%>
			//var url1='disDriver.jsp?brandval='+brandval;
			
			 
			 var modeldata= '<%=viewDAO.searchModel(brandval) %>'; 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'vtype', type: 'string'  },
                           {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: modeldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxmodelSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'MODEL', datafield: 'vtype', width: '100%' }
                             
						
						
	             
						]
            });
            
          $('#jqxmodelSearch').on('rowdoubleclick', function (event) {
            	var rowindex3 =$('#rowindex').val();
            	// alert("ggggggg"+rowindex3);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex3, "model" ,$('#jqxmodelSearch').jqxGrid('getcellvalue', rowindex2, "vtype"));

                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex3, "modid" ,$('#jqxmodelSearch').jqxGrid('getcellvalue', rowindex2, "doc_no")); 
              $('#modelsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxmodelSearch"></div>