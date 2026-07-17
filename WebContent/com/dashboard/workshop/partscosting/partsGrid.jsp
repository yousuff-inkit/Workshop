<%@ page import="com.dashboard.workshop.partscosting.ClsPartsCostingDAO" %>
	
<%
 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();

String estno = request.getParameter("estno")==null?"0":request.getParameter("estno").trim();

ClsPartsCostingDAO cpcdao=new ClsPartsCostingDAO();
%>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=check%>';
 
  	if(temp!='0'){ 
 		
  		data1='<%=cpcdao.sparepartsdetails(estno,check)%>';
         }
  	else
  	{
 		
  		data1;
  	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
										{name : 'rowno', type: 'number' },
										{name : 'description', type: 'string'    },
                   						{name : 'type', type: 'string'  },
                   						{name : 'qty', type: 'number'    },
                   						{name : 'rate', type: 'number'    },
                   						{name : 'total', type: 'number'    },
                   						{name : 'product', type: 'string'    },
                   						{name : 'stdcost', type: 'number'    },
                   						{name : 'vendor', type: 'string'   },
                   						{name : 'vndno', type: 'string' },
                   						{name : 'psrno', type: 'number' },
                   						{name : 'voc_no', type: 'string' },
                   						{name : 'prdid', type: 'string' },
                   						{name : 'munit', type: 'string' },
                   						{name : 'pono', type: 'string' },
                   						{name : 'mspecno', type: 'string' }
                   						
                   						
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#partsGridId").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates: false,
             //   selectionmode: 'singlecell',
                editable: true,
                selectionmode: 'checkbox',
                localization: {thousandsSeparator: ""},
                
                
                columns: [
                              
                              
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '5%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							    }  
							  },
							  
							  
							  { text: 'Description', datafield: 'description', width: '25%', editable: false },  
                              { text: 'Type', datafield: 'type', width: '10%', editable: false },  
							  { text: 'Quantity', datafield: 'qty', width: '10%' },
							  { text: 'Rate', datafield: 'rate', width: '8%',align:'right', cellsalign: 'right', cellsformat: 'd2', editable: false },
							  { text: 'Total', datafield: 'total', width: '8%', align:'right', cellsalign: 'right', cellsformat: 'd2' , editable: false },
							  { text: 'Product', datafield: 'product', width: '16%' , editable: false },
							  { text: 'Vendor Price', datafield: 'stdcost', width: '8%',align:'right', cellsalign: 'right', cellsformat: 'd2', editable: true },
							  
							  { text: 'Vendor', datafield: 'vendor', width: '10%' , editable: false},
							  { text: 'Vendor No', datafield:'vndno', width:"0%", hidden: true},
							  { text: 'rowno', datafield:'rowno', width:"0%", hidden: true},
							  { text: 'psrno', datafield:'psrno', width:"10%", hidden: true},
							  { text: 'jobno', datafield:'voc_no', width:"0%", hidden: true},
							  { text: 'prdid', datafield:'prdid', width:"0%", hidden: true},
							  { text: 'munit', datafield:'munit', width:"0%", hidden: true},
								 { text: 'pono', datafield:'pono', width:"0%", hidden: true},
							      { text: 'specno', datafield:'mspecno', width:"0%", hidden: true}						
	              ]
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#partsGridId').on('celldoubleclick', function (event){ 
	       		  	var rowindex2=event.args.rowindex;
	       		  	if(event.args.datafield=='product'){
	       		  		
	       		  		funproductsearch(rowindex2);
	       		  		}
	       		  	
	       		  	if(event.args.datafield=='vendor'){
	       		  		funvendorsearch(rowindex2);
	       		  		}
            });
            
            
            	var selectedvnd=new Array();
            	var vnd="";
            	var length=0;
        	  $("#partsGridId").on('rowselect', function (event) {
        		 
                var rowindex = event.args.rowindex;
                length++;
				var pono=$("#partsGridId").jqxGrid('getcellvalue', rowindex,'pono');
                if(pono!='0'){
                	$('#partsGridId').jqxGrid('unselectrow', rowindex);
                }
                
                var rows = event.args.row;
                
                if((rows.product=="")||(rows.stdcost=="0")||(rows.vndno=="")){
                	$.messager.alert('Warning','Values not available');
                    $('#partsGridId').jqxGrid('unselectrow', rowindex);
                    
                   
                 }
                
                if(vnd==""){
                	vnd=$("#partsGridId").jqxGrid('getcellvalue', rowindex,'vndno');
                }
                else{
                	if(vnd!=$("#partsGridId").jqxGrid('getcellvalue', rowindex,'vndno')){
                		$.messager.alert('Warning','Same vendors only');
                		$('#partsGridId').jqxGrid('unselectrow', rowindex);
                		 
                	}
                }
                selectlength=$('#partsGridId').jqxGrid('selectedrowindexes');
                if(length==0){
                	vnd="";
                }
               
               });
        	  
        	  $('#partsGridId').on('rowunselect', function (event) 
        		{
        		 	length--;
        		  var rowindex = event.args.rowindex;
        		  delete selectedvnd[rowindex];
        		});
            
        });
 	
 	
 	

    </script>
    <div id="partsGridId"></div>
