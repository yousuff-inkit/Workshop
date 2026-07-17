<%@page import="com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqDAO" %>
<%ClsvehpurchasereqDAO vpd=new ClsvehpurchasereqDAO(); %>


 <%
           	String vehreqdoc = request.getParameter("vehreqdoc")==null?"0":request.getParameter("vehreqdoc").trim();
           	  %> 
<script type="text/javascript">



   

        	
var vahreqdata;
           	  
           	  
           	var temp1='<%=vehreqdoc%>';
            var hide;
            if(temp1>0) 
            
          	 {
            	 vahreqdata= '<%=vpd.searchrelode(vehreqdoc)%>';
          	   hide=2; 
          	 } 
            else
          	 { 
            	 vahreqdata;
            	
          
          	 } 
   
        $(document).ready(function () { 	
        
          
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brand', type: 'string' },
     						{name : 'brdid', type: 'int'  },
     						{name : 'model', type: 'string'   },
     						{name : 'modid', type: 'string'   },
     						{name : 'specification', type: 'string'  },
     						{name : 'color', type: 'string'   },
     						{name : 'clrid', type: 'string'   },
     						{name : 'remarks', type: 'string'   },
     						{name : 'qty', type: 'number'  },
     						{name : 'sr_no', type: 'int'  }
     						
     											
                 ],
                 localdata: vahreqdata,
                
                
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

            
            
            $("#purchasedetails").jqxGrid(
            {
                width: '100%',
                height: 352,
                source: dataAdapter,
                disabled:true,
                editable:true ,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
          
               handlekeyboardnavigation: function (event) {
                   
            	   
                  // alert("key"+keyCode);
                  
          /*         if(args.datafield=="remarks")
					{              
                	  var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 9) {   
                    
                    	  var cell = $('#purchasedetails').jqxGrid('getselectedcell');
                    	  
                      	  var row1=cell.rowindex;
                      	 var rows = $('#purchasedetails').jqxGrid('getrows');
                         var rowlength= rows.length;
                        
                      	  if(row1== rowlength - 1)
                      		  {
                      	  $("#purchasedetails").jqxGrid('addrow', null, {});
                      		  }
                      	 
                      	$('#purchasedetails').jqxGrid('selectcell',row1+1, 'sl');
                                  }
                  	  
               }
            	    */
            	
            	     
                    var cell2 = $('#purchasedetails').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'brand') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     document.getElementById("rowindex1").value =cell2.rowindex;
                  
                    	if (key == 114) { 
                    		brandinfoSearchContent('brandSearch.jsp');
                        	 $('#purchasedetails').jqxGrid('render');
             	           
                          }
                    	}
            	    
            	    
            /* 	   
            	   if(args.datafield=="brand")
               	{
                   
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {                                                      
                        	brandinfoSearchContent('brandSearch.jsp');
                        	 $('#purchasedetails').jqxGrid('render');
                        }
                    } */
                    var cell3 = $('#purchasedetails').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'color') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     document.getElementById("rowindex1").value =cell3.rowindex;
                  
                    	if (key == 114) { 
                    		 colorinfoSearchContent('colorSearch.jsp');
                        	 $('#purchasedetails').jqxGrid('render');
             	           
                          }
                    	}
                  
            /* 	   if(args.datafield=="color")
                  	{
               
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {                                                      
                    	 colorinfoSearchContent('colorSearch.jsp');
                    	 $('#purchasedetails').jqxGrid('render');
                     }
                 } */
               
                 
                 var cell4 = $('#purchasedetails').jqxGrid('getselectedcell');
                 if (cell4 != undefined && cell4.datafield == 'model') {
             
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {  
                   	 document.getElementById("rowindex1").value =cell4.rowindex;
                  	  var  brandval= $('#purchasedetails').jqxGrid('getcellvalue', cell4.rowindex, "brdid");
                
                  	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
                  	 $('#purchasedetails').jqxGrid('render');
                    }
                   }
                 
                /*  var cell4 = $('#purchasedetails').jqxGrid('getselectedcell');
                 if (cell4 != undefined && cell4.datafield == 'account') {
 	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
 	                 
 	                   if (key == 114) {   
 	                	
 	                	 document.getElementById("rowindex1").value =cell4.rowindex;
 	                	   var valuess=  $('#purchasedetails').jqxGrid('getcellvalue', cell4.rowindex, "type");
 	              
 	                     CashSearchContent('accountGridSearch.jsp?atype='+valuess);
 	                	   $('#purchasedetails').jqxGrid('render');
 	        	           }
 	                   }
                  */
              
                    }, 
               
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<left><div style='margin:4px;'>" + (value + 1) + "</div></left>";
                              }  
                            },	
							{ text: 'Brand', datafield: 'brand', width: '15%', editable: true },	
							{ text: 'Model', datafield: 'model', width: '15%', editable: true },
							{ text: 'Specification', datafield: 'specification', width: '15%' },	
							{ text: 'Color', datafield: 'color', width: '10%', editable: true },
							{ text: 'Qty', datafield: 'qty', width: '6%'},
							{ text: 'Remarks', datafield: 'remarks', width: '35%'},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
			              ]
               
            });
         
            $("#purchasedetails").jqxGrid('addrow', null, {});
            	
            $("#purchasedetails").on('cellclick', function (event) 
            		{
        	   var rowindextemp2 = event.args.rowindex;
            
               document.getElementById("rowindex1").value = rowindextemp2;
               if(event.args.columnindex ==1)
            	   {
            	
               $("#purchasedetails").jqxGrid('clearselection');
            	   }
               if(event.args.columnindex ==2)
        	   {
        	
               $("#purchasedetails").jqxGrid('clearselection');
        	   } 
               if(event.args.columnindex ==4)
        	   {
        	
               $("#purchasedetails").jqxGrid('clearselection');
        	   } 
               
           
               
                    }); 
          /*   $("#purchasedetails").on('cellunselect', function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // get the column's text.
            		   alert("");
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // cell value
            		    var value = event.args.value;
            		    if(dataField=="remarks")
        		    	{
            		    	
            		    $('#purchasedetails').jqxGrid('selectcell', rowBoundIndex+1, 'brand');
        		    	}
            		});  */
            	/* 	  $("#purchasedetails").on('cellendedit', function (event) 
                      		{
                      		  
                      		    var dataField = event.args.datafield;
                      		    // row's bound index.
                      		    var rowBoundIndex = event.args.rowindex;
                      		   
                      		    if(dataField=="remarks")
                      		    	{
                      		    	 
                      		      $("#purchasedetails").jqxGrid('addrow', null, {});
                      		    	}
                      		   
                      		}); */
            		
         
             $("#purchasedetails").on('cellendedit', function (event) 
            		{
            		  
            		    var dataField = event.args.datafield;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		   
            		    if(dataField=="remarks")
            		    	{
            		
                            
                            	
                              
            		    
            		    	
            		    	}
            		   
            		}); 
            		   
            $('#purchasedetails').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
              	  if(columnindex1 == 1)
              		  { 

              		  $('#purchasedetails').jqxGrid('clearselection');
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex1").value = rowindextemp;  
              	   
              	brandinfoSearchContent('brandSearch.jsp');
              	
              		  } 
              	  
              	 if(columnindex1 == 2)
         		  { 

              		  $('#purchasedetails').jqxGrid('clearselection');
         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex1").value = rowindextemp;  
         	   var  brandval=document.getElementById("brandval").value;
         	   //alert("brandval"+brandval);
         	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
         	
         		  } 
         	  
              	 if(columnindex1 == 4)
        		  { 
              		  $('#purchasedetails').jqxGrid('clearselection');
      		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex1").value = rowindextemp;  
        	   
        	    colorinfoSearchContent('colorSearch.jsp');
        			
        		  } 
        	  
              	
              	  
                  }); 
            
            
        
      
            
        });
    </script>
    <div id="purchasedetails"></div>
  <input type="hidden" id="rowindex1"/> 