<%@page import="com.workshop.setup.servicepackage.*" %>
<%ClsServicePackageDAO ccd=new ClsServicePackageDAO(); %>
   <script type="text/javascript">
    var commasterdata= '<%=ccd.mainserch() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                         	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
     						{name : 'code', type: 'String'  },
     						{name : 'amount', type: 'number'  },
                        	{name : 'date', type: 'date'  }
           
                  ],
                 localdata: commasterdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  ///  alert(error);    
	                    }
		            }		
            );
            $("#compmastersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlerow',
                columnsresize: true,
              
                 columns: [
                       	{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: ' Code', datafield: 'code', width: '20%' },
					{ text: ' Name', datafield: 'name', width: '40%' },
					{ text: ' Amount', datafield: 'amount', width: '20%' ,cellsformat:'d2',align:'right',cellsalign:'right'},
					{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
				
					]
            });
       
  $('#compmastersearchgrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("name").value=$('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("code").value=$('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("amount").value=$('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "amount");
                $("#compdate").jqxDateTimeInput('val',$("#compmastersearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#servicepackagegriddiv').load('servicePackageGrid.jsp?docno='+document.getElementById("docno").value);
                $('#window').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="compmastersearchgrid"></div>
