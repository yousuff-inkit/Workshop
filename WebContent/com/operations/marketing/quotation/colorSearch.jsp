<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>

       <script type="text/javascript">
  
			 var colorddata1= '<%=viewDAO.searchColor() %>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'color1', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: colorddata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#quotcolorSearch").jqxGrid(
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
                              { text: 'COLOR', datafield: 'color1', width: '100%' },
                           
						
						
	             
						]
            });
        
          $('#quotcolorSearch').on('rowdoubleclick', function (event) {
            	//var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
               var temp2=$('#quotcolorSearch').jqxGrid('getcellvalue', rowindex2, "color1");
             
                $('#qutgrid').jqxGrid('setcellvalue',$('#rowindex').val(), "color",temp2);
                $('#qutgrid').jqxGrid('setcellvalue',$('#rowindex').val(), "clrid" ,$('#quotcolorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
           
                
              $('#colorsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotcolorSearch"></div> 