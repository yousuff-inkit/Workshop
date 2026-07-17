<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%> 
<%@page import="com.operations.agreement.leaseclose_alfahim.*"%>
<%ClsLeaseCloseAlFahimDAO leasedao=new ClsLeaseCloseAlFahimDAO(); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
    
    //  var drvdata='getCollect.jsp';	
    
      
      
        $(document).ready(function () { 	
            var drvdata='<%=leasedao.getCollect()%>';

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'sal_name',type: 'String'},
     						{name : 'lic_no',type:'String'},
     						{name : 'lic_exp_dt',type:'date'}
                 ],
                localdata: drvdata,
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
            $("#collectionGrid").jqxGrid(
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
							{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
							{ text: 'Name', filtertype:'input',columntype:'textbox',datafield: 'sal_name',width:'50%'},
							{ text: 'License No',filtertype:'input',columntype:'textbox', datafield: 'lic_no',width:'20%'},
							{ text: 'License Expiry',filtertype:'date', datafield: 'lic_exp_dt', width:'20%',cellsformat:'dd-MM-yyyy'}
	              ]
            });
           
            $('#collectionGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("chauffer").value=$('#collectionGrid').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
            	document.getElementById("chaufferid").value=$('#collectionGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				// $("#closedate").jqxDateTimeInput('val', $("#gridRaSearch").jqxGrid('getcellvalue', rowindex1, "edate"));
            	//document.getElementById("frmRentalClose").submit();
              $('#collectionWindow').jqxWindow('close');
               
                
            });  
        });
    </script>
    <div id="collectionGrid"></div>
