

<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>
<script type="text/javascript">

			 var quotbarnddata= '<%=viewDAO.searchBrand() %>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'brand', type: 'string'  },
                            {name : 'brand_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: quotbarnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#quobrandSearch").jqxGrid(
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
                              { text: 'BRAND', datafield: 'brand', width: '25%' },
                              { text: 'BRAND NAME', datafield: 'brand_name', width: '75%' }
						
						
	             
						]
            });
            
          $('#quobrandSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
              //  alert($('#quobrandSearch').jqxGrid('getcellvalue', rowindex2, "brand_name"));
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "brand",$('#quobrandSearch').jqxGrid('getcellvalue', rowindex2, "brand_name"));
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "brdid",$('#quobrandSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                document.getElementById("qubrandval").value=$('#quobrandSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                	
                var rows = $('#tarifcalGrid').jqxGrid('getrows');
                var rowlength= rows.length;
               
               
                if($('#mode').val()=='E')
                	{
                	
                	if(rowindex1==rowlength)
                    {
                    	 $("#tarifcalGrid").jqxGrid('addrow', null,  {});
                    }
                	}
                else
                	{
                	 if(rowindex1==rowlength-1)
                     {
                     	 $("#tarifcalGrid").jqxGrid('addrow', null,  {});
                     }
                	}
                
                
                
              $('#brandsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quobrandSearch"></div> 