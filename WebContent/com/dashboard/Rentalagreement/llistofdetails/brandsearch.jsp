<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

       <script type="text/javascript">

        var branddata='<%=crad.branddetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'brand_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: branddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brandsearch").jqxGrid(
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
                              { text: 'Brand Name', datafield: 'brand_name', width: '100%' },
                           
						
						]
            });
            
          $('#brandsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("brand").value=$('#brandsearch').jqxGrid('getcellvalue', rowindex2, "brand_name");
                document.getElementById("brandid").value=$('#brandsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("model").value="";
                document.getElementById("modelid").value="";
                
                
                
           
              $('#brandwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="brandsearch"></div>