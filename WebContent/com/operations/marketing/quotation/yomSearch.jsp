
<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>
<script type="text/javascript">

			 var yomdata= '<%=viewDAO.searchYOM() %>';
			 //alert(yomdata);
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'yom', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: yomdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#yomsearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'YOM', datafield: 'yom', width: '100%' }
						
						
	             
						]
            });
            
          $('#yomsearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
              //  alert($('#yomsearch').jqxGrid('getcellvalue', rowindex2, "brand_name"));
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "yom",$('#yomsearch').jqxGrid('getcellvalue', rowindex2, "yom"));
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "yomid",$('#yomsearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              
              $('#yomsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="yomsearch"></div> 