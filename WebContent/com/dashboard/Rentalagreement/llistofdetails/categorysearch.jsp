<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

       <script type="text/javascript">

        var catdata='<%=crad.catnamesearchdetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'cat_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#catnamegrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
                  
                columns: [
		                      { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Category', datafield: 'cat_name', width: '100%' },
                           
						
						]
            });
            
          $('#catnamegrid').on('rowdoubleclick', function (event) { 
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("catname").value=$('#catnamegrid').jqxGrid('getcellvalue', rowindex2, "cat_name");
                document.getElementById("catid").value=$('#catnamegrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
                
                
           
              $('#catwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="catnamegrid"></div>