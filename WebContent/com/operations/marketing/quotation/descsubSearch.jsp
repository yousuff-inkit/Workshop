
      

<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>
        
       <script type="text/javascript">

			 var descdata1= '<%=viewDAO.descSearch()%>';
			 
			// alert(descdata1);
		$(document).ready(function () { 	
        	
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'description', type: 'string'  }
                           
     						
                        ],
                		
                		//  url: url1,
                 localdata: descdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#descSearch").jqxGrid(
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
                              { text: 'Description', datafield: 'description', width: '100%' },
                              
						
						
	             
						]
            });
            
          $('#descSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex7').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#descgrid').jqxGrid('setcellvalue', rowindex1, "desid" ,$('#descSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#descgrid').jqxGrid('setcellvalue', rowindex1, "description" ,$('#descSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                var rows = $('#descgrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                $("#descgrid").jqxGrid('addrow', null, {});	
                }
                
                
              $('#descsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="descSearch"></div>