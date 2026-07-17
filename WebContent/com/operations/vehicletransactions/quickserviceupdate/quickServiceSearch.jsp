<%@page import="com.operations.vehicletransactions.quickserviceupdate.ClsQuickServiceUpdateDAO"%>
<%ClsQuickServiceUpdateDAO updatedao=new ClsQuickServiceUpdateDAO(); %>
<script type="text/javascript">
    
       var datasearch ='<%=updatedao.mainSearch()%>';
        $(document).ready(function () { 	
        	
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name:'doc_no',type:'int'},
     						{name:'date',type:'String'},
     						{name:'fromdate',type:'String'},
     						{name:'todate',type:'String'},
     						{name :'garageid',type:'string'},
     						{name :'garagename',type:'string'},
     						{name :'cstatus',type:'string'},
     						{name :'remarks',type:'string'}
                 ],               
                 localdata: datasearch,
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

            
            
            $("#serviceSearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                columnsresize: true,
                
                //pageable: true,
                //editable: true,
                altRows: true,
                 showfilterrow: true, 
                 filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#serviceSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fleet_no' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#serviceSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',filtertype:'number' },
							{ text: 'Date', datafield: 'date', width: '15%',columntype:'input' },
							{ text: 'Service Done From', datafield: 'fromdate', width: '15%',columntype:'input',cellsformat:'dd.MM.yyyy' },
							{ text: 'Service UpTo', datafield: 'todate', width: '15%',columntype:'input',cellsformat:'dd.MM.yyyy' },
							{ text: 'Garage ID', datafield: 'garageid', width: '25%',hidden:true},
							{ text: 'Garage Name', datafield: 'garagename', width: '45%',columntype:'input'},
							{ text: 'Confirm Status', datafield: 'cstatus', width: '45%',hidden:true},
							{ text: 'Remarks', datafield: 'remarks', width: '45%',hidden:true}
	              ]
            });
            $('#serviceSearch').on('rowdoubleclick', function (event) {
                var row2=event.args.rowindex;
                document.getElementById("docno").value=$('#serviceSearch').jqxGrid('getcellvalue', row2, "doc_no");
                document.getElementById("garage").value=$('#serviceSearch').jqxGrid('getcellvalue', row2, "garageid");
                document.getElementById("garagename").value=$('#serviceSearch').jqxGrid('getcellvalue', row2, "garagename");
                $("#date").jqxDateTimeInput('val',$("#serviceSearch").jqxGrid('getcellvalue', row2, "date"));
                $("#srvcfromdate").jqxDateTimeInput('val',$("#serviceSearch").jqxGrid('getcellvalue', row2, "fromdate"));
                $("#srvctodate").jqxDateTimeInput('val',$("#serviceSearch").jqxGrid('getcellvalue', row2, "todate"));
                document.getElementById("confirmstatus").value=$('#serviceSearch').jqxGrid('getcellvalue', row2, "cstatus");
                document.getElementById("remarks").value=$('#serviceSearch').jqxGrid('getcellvalue', row2, "remarks");
                $('#servicediv').load('serviceUpdateGrid.jsp?docno='+document.getElementById("docno").value);	 
				 $('#window').jqxWindow('close');
                });
            var rows=$("#serviceSearch").jqxGrid('getrows');
            var rowlength=rows.length;
            if(rowlength==0){
          	  $("#serviceSearch").jqxGrid('addrow', null, {});

            }
        });
    </script>
    <div id="serviceSearch"></div>
