<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 

<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
 <%         
	
    String maindoc1 = request.getParameter("maindoc1")==null?"NA":request.getParameter("maindoc1").trim();
    %>
    <script type="text/javascript">
    var temp1='<%=maindoc1%>';
    var maindowndata;
     if(temp1!="NA")
	{
    	 maindowndata='<%=cmwd.searchservicegridrelode(maindoc1)%>';
	}
     else
    	 {
    	 maindowndata;
    	 }
   
        $(document).ready(function () { 	
        	 var rendererstring=function (aggregates){
             	var value=aggregates['sum'];
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
        	}
             	var rendererstring1=function (aggregates){
             	var value1=aggregates['sum1'];
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
             }
             	
            /*  	  if(temp1!="NA")
             		{
             	
             	
             	 $('#maindowngrid').on('bindingcomplete', function (event) {
             		 if(parseInt(document.getElementById("docno").value)>0)
             		 {
                var summaryData1= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'lbrcost', ['sum'],true);
                   
                document.getElementById("lbrtotalcost").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                var summaryData2= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'partscost', ['sum'],true);
                
                document.getElementById("partstotalcost").value=summaryData2.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                var summaryData= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                document.getElementById("totalcost").value=summaryData.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
             		 }
             	 });
             		}  */
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'type' , type: 'string' },
     						{name : 'description' , type: 'string' },
     						{name : 'remarks', type: 'string'  },
     						{name : 'lbrcost', type: 'number'  },
     						{name : 'partscost', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'status', type: 'number'  }
     						
     						
     						                	],
                 localdata: maindowndata,
                
                
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
            $("#maindowngrid").jqxGrid(
            {
                width: '99.9%',
                height: 248,
                
                source: dataAdapter,
               // editable: true,
                selectionmode: 'singlecell',
              
           
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 23,
                altRows: true,
                editable:true,
                disabled:true,
                localization: {thousandsSeparator: ""},
               /*  source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                altRows: true,
                editable:true,
                disabled:true,
                selectionmode: 'singlecell', */
               
                //localization: {thousandsSeparator: ""},
                handlekeyboardnavigation: function (event) {
                    
                	 var cell1 = $('#maindowngrid').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'type') {
                	 
              	 /*   if(args.datafield=="type")
                 	{ */
              		
                    
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {   
                        	 
                        	 document.getElementById("rowindex").value = cell1.rowindex;
                        	 TypeservSearchContent('serviecetypeserch.jsp');
                         $('#maindowngrid').jqxGrid('render');
                         }
                     }
    
              	   
            	 if(cell1 != undefined && cell1.datafield =='description')
               	{
           
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {                                                      
                    	   var  mtypename=document.getElementById("mtypename").value;
                    	   document.getElementById("rowindex").value = cell1.rowindex;
                     	   
                        	descservSearchContent('servdescnamesearch.jsp?mtypename='+mtypename);
                   	$('#maindowngrid').jqxGrid('render');
                     }
                 } 
               
               
               }, 
               
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '2%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
					
					{ text: 'Type', datafield: 'type', width: '10%',editable: false },
					
					{ text: 'Description', datafield: 'description', width: '21.8%',editable: false },
					{ text: 'Remarks', datafield: 'remarks' ,width: '36%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,
						
						 cellbeginedit: function (row) {
							 
							 	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
							 	 if (!(val=="") && !(typeof(val)=="undefined"))
						    	 {
						    			    	 
						       return false; 
						    	 }
									
							      
							   
							  }	
					
					
					},
					
					{ text: 'Labor Cost', datafield: 'lbrcost',width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,
						 cellbeginedit: function (row) {
							 
							 
							 
							 	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
							 	 
							 	
							 	 if (!(val=="") && !(typeof(val)=="undefined"))
						    	 {
						    			    	 
						       return false; 
						    	 }
														    
							      
							   
							  }	},
					{ text: 'Parts Cost', datafield: 'partscost',width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,
								  
								  cellbeginedit: function (row) {
										 
									 	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
									 	 if (!(val=="") && !(typeof(val)=="undefined"))
								    	 {
								    			    	 
								       return false; 
								    	 }
											
									      
									   
									  }	
					
					},
					
					{ text: 'Total', datafield: 'total',width:"10%",cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false},
                             ]
            });
           
            $("#maindowngrid").jqxGrid('addrow', null, {});
            $("#maindowngrid").jqxGrid({ disabled: true}); 
        	/* if(($('#mode').val()=='A')||($('#mode').val()=='E'))
        		{
        		  $("#maindowngrid").jqxGrid({ disabled: false}); 
        		} */
            
            $("#maindowngrid").on('cellclick', function (event) 
              		{
          
                 if(event.args.columnindex ==1)
              	   {
              	
                 $("#maindowngrid").jqxGrid('clearselection');
              	   }
                 if(event.args.columnindex ==2)
          	   {
          	
                 $("#maindowngrid").jqxGrid('clearselection');
          	   } 
               
                 
                     }); 
            
            $('#maindowngrid').on('celldoubleclick', function (event) {
            	
            	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
            	 if (!(val=="") && !(typeof(val)=="undefined"))
		    	 {
		    			    	 
		       return false; 
		    	 }
					
            	
          
            	var columnindex1=event.args.columnindex;
            	
              	  if(columnindex1 == 1)
              		  { 
              		  $("#maindowngrid").jqxGrid('clearselection');
              		 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	   var aa="ser";
              TypeservSearchContent('serviecetypeserch.jsp?val='+aa);
            
              		  } 
              	  
                if(columnindex1 == 2)
         		  { 
              		  $("#maindowngrid").jqxGrid('clearselection');
         		
         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         	   var  mtypename=document.getElementById("mtypename").value;
         	   var bb="serv";
         	descservSearchContent('servdescnamesearch.jsp?mtypename='+mtypename+'&valu='+bb);
        	
         		  }  
         	  
              	  
                  }); 
            
            function valchange(rowBoundIndex)
            {
            	
            	
            	var lbrcost= $('#maindowngrid').jqxGrid('getcellvalue', rowBoundIndex, "lbrcost");	
            	
            	
            
            		if(lbrcost==""||lbrcost==null||lbrcost=="undefined")
	   			{
            			lbrcost=0;	
	   			}
            	
            	var partscost=	$('#maindowngrid').jqxGrid('getcellvalue', rowBoundIndex, "partscost");	
            	
            	
            	
               	var total=parseFloat(lbrcost)+parseFloat(partscost);
            	if(partscost==""||partscost==null||partscost=="undefined")
	   			{
	   		  $('#maindowngrid').jqxGrid('setcellvalue', rowBoundIndex, "total",lbrcost);
	   			}
	   		else{
	   			$('#maindowngrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
	   	     	}
         
            	// 
    	        		   
    	                   
    	           /*         var summaryData1= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'lbrcost', ['sum'],true);
   	                    
    	                   document.getElementById("lbrtotalcost").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
    	                   var summaryData2= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'partscost', ['sum'],true);
   	                    
    	                   document.getElementById("partstotalcost").value=summaryData2.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
    	                   var summaryData= $("#maindowngrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	                   document.getElementById("totalcost").value=summaryData.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"); */
    	                   
    	      
    		    
            }

            $("#maindowngrid").on('cellvaluechanged', function (event) 
            {
            	
            	
            	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
            	 if (!(val=="") && !(typeof(val)=="undefined"))
		    	 {
		    			    	 
		       return false; 
		    	 }
						
            
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    if(datafield=="type")
    		    	{
    		    
    		    	
    		    	 $('#maindowngrid').jqxGrid('setcellvalue', rowBoundIndex, "description","");
	        		   
    		    	}
    		     
            		if(datafield=="lbrcost")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="partscost")
        		    {
            			valchange(rowBoundIndex);
        		    }
            		if(datafield=="total")
        		    {
            			valchange(rowBoundIndex);
        		    }
            	
            		});
        }); 
        
        
    </script>
    <div id="maindowngrid"></div>
    <input type="hidden" id="rowindex">
