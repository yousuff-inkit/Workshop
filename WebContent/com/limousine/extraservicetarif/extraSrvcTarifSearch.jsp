<%@page import="com.limousine.extraservicetarif.*" %>
<%ClsExtraSrvcTarifDAO extradao=new ClsExtraSrvcTarifDAO(); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var searchdata= '<%=extradao.getSearchData()%>';
  
  
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                             
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'date', type: 'String'  },
     						{name : 'fromdate', type:'date'},
     						{name : 'todate', type:'date'},
     						{name : 'desc1', type:'String'}
     						
                 ],
                localdata: searchdata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
            $("#extraSrvcTarifSearch").jqxGrid(
            {
                width: '100%',
                height: 372,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
							{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
							{ text: 'From Date', datafield: 'fromdate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'To Date', datafield: 'todate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Description', datafield:'desc1',width:'32%'},
							
	              ]
            });
           
            $('#extraSrvcTarifSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#extraSrvcTarifSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $("#date").jqxDateTimeInput('val',$("#extraSrvcTarifSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $("#fromdate").jqxDateTimeInput('val',$("#extraSrvcTarifSearch").jqxGrid('getcellvalue', rowindex1, "fromdate"));
                $("#todate").jqxDateTimeInput('val',$("#extraSrvcTarifSearch").jqxGrid('getcellvalue', rowindex1, "todate"));
           		document.getElementById("desc").value=$("#extraSrvcTarifSearch").jqxGrid('getcellvalue', rowindex1, "desc1");
           		setValues();
           		
                 $('#window').jqxWindow('close');
                // $( "#docno" ).focus();
                
            });  
        });
    </script>
    <div id="extraSrvcTarifSearch"></div>
