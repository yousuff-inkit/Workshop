<%@page import="com.operations.vehicleprocurement.purchaseorder.ClsvehpurchaseorderDAO" %>
<%ClsvehpurchaseorderDAO cvpo=new ClsvehpurchaseorderDAO(); %>

<%
String masterdoc = request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").trim();
String reqdoc = request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();
//System.out.println("rrrrrrrrrrrrrrrrrrrr"+reqdoc);

%>

<script type="text/javascript">
var vahreqdata;
var temp1='<%=reqdoc%>';
var temp2='<%=masterdoc%>';
if(temp2>0)
	{
	 vahreqdata='<%=cvpo.gridsearchrelode(masterdoc)%>';
	}

else if(temp1>0)
{
	
	vahreqdata='<%=cvpo.reqsearchrelode(reqdoc)%>';
}
else
	{
      vahreqdata;
            	
	}
  
   $(document).ready(function () { 	
       
       

       var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
       } 
            
       var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
       } 
              
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brand', type: 'string'  },
     						{name : 'brdid', type: 'int'   },
     						{name : 'model', type: 'string'   },
     						{name : 'modid', type: 'string'   },
     						{name : 'specification', type: 'string'  },
     						{name : 'color', type: 'string'   },
     						{name : 'clrid', type: 'string'   },
     						{name : 'qty', type: 'number'  },
     						{ name: 'price', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'sr_no', type: 'int'  },
     						
     						{name : 'rowno', type: 'number'  },
     						{name : 'pqty', type: 'number'  },
     						{name : 'qutval', type: 'number'  },
     						
     						{name : 'saveqty', type: 'number'  },
     						
     											
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

            
            
            $("#vehoredergrid").jqxGrid(
            {
            	width: '100%',
                height: 302,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                 disabled:true,
                statusbarheight: 25,
                selectionmode: 'singlecell',
                pagermode: 'default',
                //Add row method
               
                handlekeyboardnavigation: function (event) {
                   
                       
                    var cell2 = $('#vehoredergrid').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'brand') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     document.getElementById("rowindex").value =cell2.rowindex;
                  
                    	if (key == 114) { 
                    		brandinfoSearchContent('brandSearch.jsp');
                        	 $('#vehoredergrid').jqxGrid('render');
             	           
                          }
                    	}
            	    
                    var cell3 = $('#vehoredergrid').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'color') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     document.getElementById("rowindex").value =cell3.rowindex;
                  
                    	if (key == 114) { 
                    		 colorinfoSearchContent('colorSearch.jsp');
                        	 $('#vehoredergrid').jqxGrid('render');
             	           
                          }
                    	}
                  
                    var cell4 = $('#vehoredergrid').jqxGrid('getselectedcell');
                    if (cell4 != undefined && cell4.datafield == 'model') {
                
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                      	 document.getElementById("rowindex").value =cell4.rowindex;
                     	  var  brandval= $('#vehoredergrid').jqxGrid('getcellvalue', cell4.rowindex, "brdid");
                   
                     	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
                     	 $('#vehoredergrid').jqxGrid('render');
                       }
                      }
                	
                	   
             	/*    if(args.datafield=="brand")
                	{
                   
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {                                                      
                          	brandinfoSearchContent('brandSearch.jsp');
                        	$('#vehoredergrid').jqxGrid('render');
                        }
                    } */
             /* 	  if(args.datafield=="color")
                	{
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {   
                    	
                    	 colorinfoSearchContent('colorSearch.jsp');
                    	 $('#vehoredergrid').jqxGrid('render');
                     }
                 } */
               
           /*   	 if(args.datafield=="model")
              	{
          
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {                                                      
                  	  var  brandval=document.getElementById("brandval").value;
                  	
                  	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
                  	$('#vehoredergrid').jqxGrid('render');
                    }
                }
               */
              
              }, 
              
   

                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<left><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
							{ text: 'Brand', datafield: 'brand', width: '16%' },	
							{ text: 'Model', datafield: 'model', width: '16%' },
							{ text: 'Specification', datafield: 'specification', width: '30%' },	
							{ text: 'Color', datafield: 'color', width: '9%' },
							{ text: 'Qty', datafield: 'qty', width: '5%'},
							{ text: 'rowno', datafield: 'rowno', width: '9%' ,hidden:true},
							{ text: 'pqty', datafield: 'pqty', width: '9%',hidden:true },
							{ text: 'saveqty', datafield: 'saveqty', width: '9%' ,hidden:true}, 
							
							{ text: 'qutval', datafield: 'qutval', width: '9%' ,hidden:true},   
							
							{ text: 'Price', datafield: 'price', width: '10%',cellsformat: 'd2',cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total', width: '10%',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
			              ]
               
            });
   
           
            $("#vehoredergrid").jqxGrid('addrow', null, {});
    		if ($("#mode").val() == "A"||$("#mode").val() == "E") {
          
            $("#vehoredergrid").jqxGrid({ disabled: false});
    		}
    	      $("#vehoredergrid").on('cellclick', function (event) 
              		{
          	   var rowindextemp2 = event.args.rowindex;
          	 document.getElementById("errormsg").innerText="";
                 document.getElementById("rowindex").value = rowindextemp2;
                 if(event.args.columnindex ==1)
              	   {
              	
                 $("#vehoredergrid").jqxGrid('clearselection');
              	   }
                 if(event.args.columnindex ==2)
          	   {
          	
                 $("#vehoredergrid").jqxGrid('clearselection');
          	   } 
                 if(event.args.columnindex ==4)
          	   {
          	
                 $("#vehoredergrid").jqxGrid('clearselection');
          	   } 
                 
             
                 
                      }); 
            function valchange(rowBoundIndex)
            {
            	
           
            	
            	var qty= $('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var unitprice=	$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "price");	
            	var total=qty*unitprice;
           		
    		  
            	 $('#vehoredergrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    	        		    var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	                    
    	                   document.getElementById("nettotal").value=summaryData.sum;
    		    
            }

            $("#vehoredergrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {

            		
                    	if(document.getElementById("vehtype").value=="VPR")
                    		{
                    	
                    		
                    		var qutval=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
               	        
                           	 
                           var quty=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                        
                           
                           
                           
                           	if(quty>qutval)
                           		{
                           		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty ";
                           		
                           		
                           		qty=qutval;
                           	   $('#vehoredergrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
                           	  
                           		}
                           	
                           	
                           	
                           	else
                           		{
                           		
                           		qty=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");		
                           		}
                    		
                        	var rqqty= qty;	
                        	var remqty= $('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");	
                         	 
                         	 
                        	var blance=parseFloat(rqqty)+parseFloat(remqty);
                         
                        	 $('#vehoredergrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",blance);
                    		
                    		}
                    	
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="price")
        		    {
            			valchange(rowBoundIndex);
        		    }
            	
            		});
            
            $('#vehoredergrid').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	
              	  if(columnindex1 == 1)
              		  { 
              		  $("#vehoredergrid").jqxGrid('clearselection');
              		 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	   
              	brandinfoSearchContent('brandSearch.jsp');
            
              		  } 
              	  
              	 if(columnindex1 == 2)
         		  { 
              		  $("#vehoredergrid").jqxGrid('clearselection');
         		
         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         	   var  brandval=document.getElementById("brandval").value;
         	   //alert("brandval"+brandval);
         	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
        	
         		  } 
         	  
              	 if(columnindex1 == 4)
        		  { 
                  
              $("#vehoredergrid").jqxGrid('clearselection');
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	   
        	    colorinfoSearchContent('colorSearch.jsp');
        			
        		  } 
        	  
              	
              	  
                  }); 
            
          
        });
    </script>
    <div id="vehoredergrid"></div>
  <input type="hidden" id="rowindex"/> 