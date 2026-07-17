
<%@page import="com.limousine.limoinvoice.*" %>
<%ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();%>
<%String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex");%>
 <script type="text/javascript">
 var gridrowindex='<%=gridrowindex%>';
 var guestsearchdata='<%=invoicedao.getGuestSearchData()%>';
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'doc_no',type:'string'},
     						{name : 'guest', type: 'string'  },
     						{name : 'guestcontactno', type: 'number'}

                 ],               
               localdata:guestsearchdata,
               
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

            
            
            $("#guestSearchGrid").jqxGrid(
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
                            
                            {text: 'Doc No',datafield:'doc_no',width:'10%'},					
                            { text: 'Guest',datafield:'guest',width:'70%'},
							{ text: 'Contact No', datafield: 'guestcontactno', width: '20%'}
	              ]
            });
       $('#guestSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'guest',$('#guestSearchGrid').jqxGrid('getcellvalue',row1,'guest'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'guestno',$('#guestSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
    	   $('#guestwindow').jqxWindow('close');

       });
       
        });
    </script>
    <div id="guestSearchGrid"></div>
