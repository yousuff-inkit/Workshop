<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
 <% String docNo1 = request.getParameter("txtclientdocno2")==null?"0":request.getParameter("txtclientdocno2"); %> 
<script type="text/javascript">
        
        var data4;
        $(document).ready(function () { 	
        	var temp1='<%=docNo1%>';
             
             if(temp1>0)
           	 {   
            	 data4='<%=DAO.documentsAttachGridReloading(docNo1)%>';     
           	 }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'extension', type: 'string'  },
     						{name : 'description', type: 'string'    },
     						{name : 'filename', type: 'string'    },
     						{name : 'dtype', type: 'string'    }
     						     						
                 ],
                  localdata: data4, 
                
                
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

            
            
            $("#jqxDocumentsAttach").jqxGrid(
            {
                width: '99.5%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxDocumentsAttach').jqxGrid('getrows');
               	    var rowlength= rows.length;
                    var cell = $('#jqxDocumentsAttach').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'dtype' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxDocumentsAttach").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                
                columns: [
							{ text: 'No', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc Type', datafield: 'extension', width: '10%' },
							{ text: 'Description', datafield: 'description', width: '35%' },
							{ text: 'Attach', datafield: 'filename', width: '25%' },
							{ text: 'From', datafield: 'dtype', width: '25%' },
																					
	              ]
            });
            
          //Add empty row
          if(temp1==0){
       	   $("#jqxDocumentsAttach").jqxGrid('addrow', null, {});
          }
          
       	  if(temp1>0){  
           	  $("#jqxDocumentsAttach").jqxGrid({ disabled: true});
          	  }
          
          
        /*  //Delete row
	       	$("#deleteRows").click(function () {
	            var rowIndexes = $('#jqxDocumentsAttach').jqxGrid('getselectedrowindexes');
	            var rowIds = new Array();
	            for (var i = 0; i < rowIndexes.length; i++) {
	                var currentId = $('#jqxDocumentsAttach').jqxGrid('getrowid', rowIndexes[i]);
	                rowIds.push(currentId);
	            };
	            $('#jqxDocumentsAttach').jqxGrid('deleterow', rowIds);
	           // $('#jqxDocumentsAttach').jqxGrid('clearselection');
	        }); */
        });
    </script>
    <div id="jqxDocumentsAttach"></div>
    <!-- <button id="deleteRows">
            Delete selected rows</button> -->