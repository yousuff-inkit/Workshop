<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.agreement.leaseclose_alfahim.*"%>
<%ClsLeaseCloseAlFahimDAO leasedao=new ClsLeaseCloseAlFahimDAO(); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
    
    //  var drvdata='getCollect.jsp';	
    
      
      
        $(document).ready(function () { 	
            var checkindata='<%=leasedao.getCheckIn()%>';

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'sal_name',type: 'String'}
     					
                 ],
                localdata: checkindata,
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
            $("#checkInGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '25%' },
							{ text: 'Name',filtertype:'input',columntype:'textbox', datafield: 'sal_name',width:'75%'}
	              ]
            });
           
            $('#checkInGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("checkin").value=$('#checkInGrid').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
            	document.getElementById("hidcheckin").value=$('#checkInGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				// $("#closedate").jqxDateTimeInput('val', $("#gridRaSearch").jqxGrid('getcellvalue', rowindex1, "edate"));
            	//document.getElementById("frmRentalClose").submit();
            	//checkAgmtDelivery();
              $('#checkinWindow').jqxWindow('close');
               
                
            });  
        });
    </script>
    <div id="checkInGrid"></div>
