
<%@page import="com.limousine.limoinvoice.*" %>
<%ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();%>
<%String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex");%>
 <script type="text/javascript">
 var gridrowindex='<%=gridrowindex%>';
 var typesearchdata='<%=invoicedao.getTypeSearchData()%>'; 
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'doc_no',type:'int'},
     						{name : 'details', type: 'string'  },
     						{name : 'acno', type: 'number'}

                 ],               
               localdata:typesearchdata,
               
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

            
            
            $("#typeSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                selectionmode: 'singlerow',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
 
				},
                
                columns: [
                            
                            {text: 'Doc No',datafield:'doc_no',width:'20%'},					
                            { text: 'Type',datafield:'details',width:'80%'},
							{ text: 'Account', datafield: 'acno', width: '20%',hidden:true}
	              ]
            });
       $('#typeSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'type',$('#typeSearchGrid').jqxGrid('getcellvalue',row1,'details'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'typeno',$('#typeSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
    	   $('#typewindow').jqxWindow('close');

       });
       
        });
    </script>
    <div id="typeSearchGrid"></div>
