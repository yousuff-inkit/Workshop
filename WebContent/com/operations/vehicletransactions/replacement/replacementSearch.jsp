<%@page import="com.operations.vehicletransactions.replacement.ClsReplacementDAO"%>
<%ClsReplacementDAO repdao=new ClsReplacementDAO(); %>
 <script type="text/javascript">
       var searchdata='<%=repdao.getSearchData()%>';	
        $(document).ready(function () { 	
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int'  },
     						{name : 'date', type: 'date'  },
     						{name : 'rfleetno', type: 'String'}
     					
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
	                    alert(error);    
	                    }
		            }		
            );
            $("#replacementSearch").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '50%' },
							{ text: 'Date', datafield: 'date', width: '40%',cellsformat:'dd.MM.yyyy' },
						 	{ text: 'Fleet ', datafield: 'rfleetno', width: '10%'}
						
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
            var rows=$("#replacementSearch").jqxGrid('getrows');
            if(rows.length==0){
            	$("#replacementSearch").jqxGrid('addrow', null, {});	
            }
            
            $('#replacementSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
   				document.getElementById("docno").value=$("#replacementSearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
   				document.getElementById("txtfleetno").value=$("#replacementSearch").jqxGrid('getcellvalue', rowindex1, "rfleetno");
                $("#date").jqxDateTimeInput('val',$("#replacementSearch").jqxGrid('getcellvalue', rowindex1, "date"));
              $('#window').jqxWindow('close');
              document.getElementById("frmReplacement").submit();
            });  
        });
    </script>
    <div id="replacementSearch"></div>
