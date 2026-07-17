<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String docNo2 = request.getParameter("txtclientdocno3")==null?"0":request.getParameter("txtclientdocno3"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
		var data2;
        $(document).ready(function () { 	
        	var temp2='<%=docNo2%>';
             
             if(temp2>0)
           	 {   
            	 data2='<%=DAO.referenceDetailsGridReloading(docNo2,check)%>';     
           	 } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'cperson', type: 'string'  },
     						{name : 'desig', type: 'string'    },
     						{name : 'mob', type: 'string'    },
     						{name : 'email', type: 'string'    }
     						     						
                 ],
                 localdata: data2,
                
                
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

            
            
            $("#jqxReferenceDetails").jqxGrid(
            {
            	width: '99.5%',
                height: 230,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxReferenceDetails').jqxGrid('getrows');
               	    var rowlength= rows.length;
                    var cell = $('#jqxReferenceDetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'email' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
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
							{ text: 'Name', datafield: 'cperson', width: '30%' },
							{ text: 'Relationship', datafield: 'desig', width: '15%' },
							{ text: 'Mob No.', datafield: 'mob', width: '20%' },
							{ text: 'E-Mail', datafield: 'email', width: '30%' },
																					
	              ]
            });
            
            //Add empty row
            if(temp2==0){ 
        	 $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
            }
            
             if(temp2>0){  
           	  $("#jqxReferenceDetails").jqxGrid({ disabled: true});
          	  }
             
           });
    </script>
    <div id="jqxReferenceDetails"></div>