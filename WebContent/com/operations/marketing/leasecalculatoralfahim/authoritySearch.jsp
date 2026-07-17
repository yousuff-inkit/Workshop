<%@page import="com.operations.marketing.leasecalculator.*" %>
<%ClsLeaseCalculatorDAO calcdao=new ClsLeaseCalculatorDAO();%>
 <script type="text/javascript">
    var authdata='<%=calcdao.getAuthority()%>';  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'authname', type: 'String'  },
     						{name : 'authid',type:'String'}
                 ],
                 localdata: authdata,
                
                
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
            $("#authorityGrid").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', filtertype: 'number',datafield: 'doc_no', width: '20%' },
					{ text: 'Authority Id',columntype: 'textbox', filtertype: 'input', datafield: 'authid', width: '20%' },
					{ text: 'Authority Name',columntype: 'textbox', filtertype: 'input', datafield: 'authname', width: '60%' },
					
	              ]
            });

            $('#authorityGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("authority").value= $('#authorityGrid').jqxGrid('getcellvalue', rowindex1, "authname"); 
		                document.getElementById("hidauthority").value = $("#authorityGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                document.getElementById("authid").value = $("#authorityGrid").jqxGrid('getcellvalue', rowindex1, "authid");
		              $('#authoritywindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="authorityGrid"></div>