<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>
<%
String masterdoc = request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").trim();
String orderdoc = request.getParameter("orderdoc")==null?"0":request.getParameter("orderdoc").trim();


%>
<style type="text/css">
        .redClass{
            color: red;
        }
</style>
<script type="text/javascript">
var vahreqdata;
var temp1='<%=orderdoc%>';
var temp2='<%=masterdoc%>';
var aa=0;
if(temp2>0)
	{
	  vahreqdata='<%=cvp.gridsearchrelode(masterdoc)%>'; 
	}

<%-- else if(temp1>0)
{

	vahreqdata='<%=com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO.refsearchrelode(orderdoc)%>';
} --%>
else
	{
      vahreqdata;
      
      aa=1;   	
	}
  
   $(document).ready(function () { 	
       
	/*    var rendererstring=function (aggregates){
           var value=aggregates['sum'];
           if(typeof(value) == "undefined"){
            value=0.00;
           }
           return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
          } */
      
       var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	
        if(typeof(value) == "undefined"){
            value=0.00;
           }
       	
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
       } 
       var rendererstring1=function (aggregates){
          	var value=aggregates['sum1'];
          	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
          }      
		  
		  
       var cellclassname = function (row, column, value, data) {
    	 
   		if(data.inactive=="1"){
       	return "redClass";
       }
   	else{

   	};
   	 
  
       };
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
     						{name : 'inactive',type:'string'},
     						{name : 'sr_no', type: 'int'  },
     					
     						{name : 'chaseno', type: 'string'   },
     						{name : 'enginno', type: 'string'   },
     						{name : 'rowno', type: 'string'   },
     						{name : 'fleet_no', type: 'string'   },
     						{name : 'flstatus', type: 'string'   },
     						
     						{name : 'reg_no', type: 'string'   },
     						
     						
     						
     						
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
            
                 $("#vehoredergrid").on("bindingcomplete", function (event) {
        	
        	
        	var aa=$('#vehoredergrid').jqxGrid('getcellvalue', 0, "price");
         //  alert(aa);
        	if(parseFloat(aa)>0)
        		{
        	
        		
         		
     		    var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
                 
                document.getElementById("pricetottal").value=summaryData.sum;
 
        		}
        
        
        });    
            
            
            $("#vehoredergrid").jqxGrid(
            {
            	width: '100%',
                height: 272,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
              // disabled:true,
               localization: {thousandsSeparator: ""},
                statusbarheight: 20,
                selectionmode: 'singlecell',
                pagermode: 'default',
                //Add row method
               
                handlekeyboardnavigation: function (event) {
                	 if($('#mode').val()=="A" && $('#vehtype').val()=="DIR")
                     {  
		                	  var cell2 = $('#vehoredergrid').jqxGrid('getselectedcell');
		                      if (cell2 != undefined && cell2.datafield == 'brand') {
		                      	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                       document.getElementById("rowindex1").value =cell2.rowindex;
		                    
		                      	if (key == 114) { 
		                      		brandinfoSearchContent('brandSearch.jsp');
		                          	 $('#vehoredergrid').jqxGrid('render');
		               	           
		                            }
		                      	}
		                      
		                      
		                      
		               /*  	   if(args.datafield=="brand")
		                   	{
		                      
		                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                        if (key == 114) {                                                      
		                           	brandinfoSearchContent('brandSearch.jsp');
		                        	$('#vehoredergrid').jqxGrid('render');
		                        }
		                    }
		                   */
		                   
		                   
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
                   
                   
                    }
                   
                   
                   if($('#mode').val()=="A")
                   {
                   	 
                   	 
                   		  if($('#vehtype').val()=="VPO" && parseInt(document.getElementById("masterrefno").value)>0 )
                   		  {  
                   
                   			 var cell7 = $('#vehoredergrid').jqxGrid('getselectedcell');
  		                   if (cell7 != undefined && cell7.datafield == 'sl') {
  		               
  		                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  		                      if (key == 114) {  
  		                     	 document.getElementById("rowindex").value =cell7.rowindex;
  		                       var aa=document.getElementById("masterrefno").value;
  		               	    
  		                          slnoSearchContent('slnosearch.jsp?docnos='+aa);
  		                    	 $('#vehoredergrid').jqxGrid('render');
  		                      }
  		                     }
                     	  
                   			  
                   			  
                   		 }
                   }
           
                   if($('#mode').val()=="view")
                   {
            
				                   var cell5 = $('#vehoredergrid').jqxGrid('getselectedcell');
				                   if (cell5 != undefined && cell5.datafield == 'fleet_no') {
				               
				                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
				                      if (key == 114) {  
				                     	
				                    
				                     	var aa="";
				                      	
				                        var rows = $("#vehoredergrid").jqxGrid('getrows');
				            		  
				            		   for(var i=0 ; i < rows.length ; i++){
				            		  
							            		if(typeof(rows[i].fleet_no)!="undefined" && rows[i].fleet_no!="" )
							            			{
							            			
							            			
							            		    aa=aa+" and fleet_no <> "+rows[i].fleet_no;
							            			
							            			}
				            		   }  
				                      	
				                    if(cell5.rowindex>0)
				                    	{
				                    	 
				               
				                    	 document.getElementById("rowindex").value =cell5.rowindex;
				                 	   
				                 	   fleetSearchContent('fleetsearch.jsp?fleetval='+aa.replace(/ /g, "%20")); 
				                    	
				                    	}
				                    else
				                    	{
				             
				                    	 document.getElementById("rowindex").value =cell5.rowindex;
				                  	   
				                  	   fleetSearchContent('fleetsearch.jsp?fleetval='+aa.replace(/ /g, "%20")); 
				                    	}
				                
				          		          } 
				                	  
				                    	
				                    	 $('#vehoredergrid').jqxGrid('render');
				                      }
				                   
                   		 
                   
                   }
                   
                	
              
              }, 
              
   

                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                              }  
                            },	
                            
							{ text: 'Brand', datafield: 'brand', width: '13%',editable: true,cellclassname: cellclassname,
                            	
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							},	
							{ text: 'Model', datafield: 'model', width: '13%',editable: true,cellclassname: cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							},
							{ text: 'Specification', datafield: 'specification', width: '15%',cellclassname: cellclassname,editable: true,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							    },	
							{ text: 'Color', datafield: 'color', width: '8%',editable: true,cellclassname: cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							    },
							{ text: 'Chassis No', datafield: 'chaseno', width: '10%',editable: true,cellclassname: cellclassname, 
							    	/* cellbeginedit: function (row) {
								var temp=$('#mode').val();
								 if (temp =="view")
									 {
								       return false;
									 }
							    
							  } */
							    },
							{ text: 'Engine No', datafield: 'enginno', width: '10%',cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,editable: true,
								/* cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  } */
							    },
							{ text: 'Price', datafield: 'price', width: '9%',cellclassname: cellclassname,cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
								
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							},
							{ text: 'Fleet', datafield: 'fleet_no', width: '10%',cellclassname: cellclassname,editable: false},
							
							
							{ text: 'Reg No', datafield: 'reg_no', width: '8%',cellclassname: cellclassname,editable: false},
							
							
							
							{ text: 'flstatus', datafield: 'flstatus', width: '11%',cellclassname: cellclassname,editable: false,hidden:true},
							
							{ text: 'rowno', datafield: 'rowno', width: '11%',cellclassname: cellclassname,editable: false,hidden:true},
						
						
							{ text: 'srno', datafield: 'sr_no', width: '9%',cellclassname: cellclassname,hidden:true},
						
							{ text: 'Brandid', datafield: 'brdid', width: '2%',cellclassname: cellclassname,hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',cellclassname: cellclassname,hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',cellclassname: cellclassname,hidden:true },
							{ text: 'srno', datafield: 'srno', width: '10%',cellclassname: cellclassname ,hidden:true},
							{ text: 'tempval', datafield: 'tempval', width: '10%',cellclassname: cellclassname ,hidden:true},
							{ text: 'diff', datafield: 'diff', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'totper', datafield: 'totper', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'inactive', datafield: 'inactive', width: '10%',cellclassname: cellclassname,hidden:true}
				              ]
              
   });
   
           
          //   $("#vehoredergrid").jqxGrid('addrow', null, {});
          
          
       //   alert(aa);
    		if (parseInt(aa)==1) {
    			$("#vehoredergrid").jqxGrid('addrow', null, {});
          //  $("#vehoredergrid").jqxGrid({ disabled: false});
    		}
    		 
    		 
    		 // $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
    		 
    		 if(parseInt(document.getElementById("docno").value)>0)
       	  {
            var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
           
           document.getElementById("totalamount").value=summaryData.sum; 
       	  }
    		

    		
    		
  	      $("#vehoredergrid").on('cellclick', function (event) 
            		{
        	   var rowindextemp2 = event.args.rowindex;
            
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
            
           /*  function valchange(rowBoundIndex)
            {
	         var qutval=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
	         var qty;
            	 
            var quty=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            	if(quty>qutval)
            		{
            		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty  ";
            		
            		
            		qty=qutval;
            	   $('#vehoredergrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);	
            		}
            	else
            		{
            		
            		qty=$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");		
            		}
            	
            	
            		
            	var unitprice=	$('#vehoredergrid').jqxGrid('getcellvalue', rowBoundIndex, "price");	
            	var total=qty*unitprice;
           		
            		
            	 $('#vehoredergrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		
    	        		    var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	                    
    	                   document.getElementById("nettotal").value=summaryData.sum;
    		    
            } */

 /*            $("#vehoredergrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            			
            		    }
            		if(datafield=="price")
        		    {
            			valchange(rowBoundIndex);
        		    }
            	
            		}); */
            
            $('#vehoredergrid').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	
          if($('#mode').val()=="A")
            {
            	  if(columnindex1 == 0)
          		  { 
            	 
            		  if($('#vehtype').val()=="VPO" && parseInt(document.getElementById("masterrefno").value)>0 )
            		  {  
          		 $("#vehoredergrid").jqxGrid('clearselection');
          		 var rowindextemp = event.args.rowindex;
          	    document.getElementById("rowindex").value = rowindextemp;  
          	    var aa=document.getElementById("masterrefno").value;
          	    
                   slnoSearchContent('slnosearch.jsp?docnos='+aa);
               
            		  }
          		  } 
            	  
            	  
            }	  
            	  
          if($('#mode').val()=="A" && $('#vehtype').val()=="DIR")
          {
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
            	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
     
         		  } 
           
          
          
        
              	 if(columnindex1 == 4)
        		  { 
                  
              		 $("#vehoredergrid").jqxGrid('clearselection');
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	   
        	    colorinfoSearchContent('colorSearch.jsp');
        			
        		  } 
              	 
          } 	 
             
          if($('#mode').val()=="view")
          {
          
              	 
              	var datafield = event.args.datafield;
              
              	if(datafield == "fleet_no")
      		      { 
              	
					/* 	var temp=$('#vehoredergrid').jqxGrid('getcellvalue', event.args.rowindex, "flstatus");
						// alert("------"+temp);
						 if (parseInt(temp)< 1)
						
							 { */
						     
					
              		
					              		var aa="";
					                  	
					                    var rows = $("#vehoredergrid").jqxGrid('getrows');
					        		  
					        		   for(var i=0 ; i < rows.length ; i++){
					        		
					        		if(typeof(rows[i].fleet_no)!="undefined" && rows[i].fleet_no!="" )
					        			{
					        		    aa=aa+" and v.fleet_no <> "+rows[i].fleet_no;
					        			
					        			}
					        		   }  
					        		   
					        		 var brandid=$('#vehoredergrid').jqxGrid('getcellvalue', event.args.rowindex, "brdid");
					        		 var modid=$('#vehoredergrid').jqxGrid('getcellvalue', event.args.rowindex, "modid");
					                  	
					                if(event.args.rowindex>0)
					                	{
					                	 
					                	 var rowindextemp = event.args.rowindex;
					             	    document.getElementById("rowindex").value = rowindextemp;          
					             	     fleetSearchContent('fleetsearch.jsp?fleetval='+aa.replace(/ /g, "%20")+'&brandid='+brandid+'&modid='+modid); 
					                	
					                	}
					                else
					                	{
					                	 var rowindextemp = event.args.rowindex;
					              	    document.getElementById("rowindex").value = rowindextemp;  
					              	    fleetSearchContent('fleetsearch.jsp?fleetval='+aa.replace(/ /g, "%20")+'&brandid='+brandid+'&modid='+modid); 
					                	}
					            
					       //}
      		      }
              	
             }
            	  
                  });
            $("#vehoredergrid").on('cellclick', function (event) 
                    {
                		document.getElementById("errormsg").innerText="";
                    		 
                   });
            
          
        });
    </script>
    <div id="vehoredergrid"></div>
  <input type="hidden" id="rowindex"/> 
