<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.agreement.rentalclosesayara.*"%>
<%ClsRentalCloseSayaraDAO closedao=new ClsRentalCloseSayaraDAO(); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
    
    //  var drvdata='getCollect.jsp';	
    
      
      
        $(document).ready(function () { 	
            var rentalagentdata='<%=closedao.getRentalAgent()%>';

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'sal_name',type: 'String'}
     					
                 ],
                localdata: rentalagentdata,
                //url: url,
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
            $("#rentalAgentGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                filterable:true,
                showfilterrow:true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', filtertype:'number',datafield: 'doc_no', width: '25%' },
							{ text: 'Name', filtertype:'input',columntype:'textbox',datafield: 'sal_name',width:'75%'}
	              ]
            });
           
            $('#rentalAgentGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("rentalagent").value=$('#rentalAgentGrid').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
            	document.getElementById("hidrentalagent").value=$('#rentalAgentGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				// $("#closedate").jqxDateTimeInput('val', $("#gridRaSearch").jqxGrid('getcellvalue', rowindex1, "edate"));
            	//document.getElementById("frmRentalClose").submit();
              $('#rentalAgentWindow').jqxWindow('close');
               
                
            });  
        });
    </script>
    <div id="rentalAgentGrid"></div>
