<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 

<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>

 <%         

    String maindoc1 = request.getParameter("maindoc1")==null?"NA":request.getParameter("maindoc1").trim();
    %>
    <script type="text/javascript">
    var temp1='<%=maindoc1%>';
    var maindowndata1;
     if(temp1!="NA")
	{
    	 maindowndata1='<%=cmwd.apprreload(maindoc1) %>';
	}
     else
    	 {
    	 maindowndata1;
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
     						{name : 'clears', type: 'bool'  },
     						
     						                	],
                 localdata: maindowndata1,
                
                
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
            $("#approvel").jqxGrid(
            {
                width: '99.9%',
                height: 150,
                
                source: dataAdapter,
                editable: true,
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
                    
                	 var cell1 = $('#approvel').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'type') {
                	 
              	 /*   if(args.datafield=="type")
                 	{ */
              		
                    
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {   
                        	 
                        	 document.getElementById("rowindex1").value = cell1.rowindex;
                        	 TypeservSearchContent('serviecetypeserch.jsp');
                         $('#approvel').jqxGrid('render');
                         }
                     }
    
              	   
            	 if(cell1 != undefined && cell1.datafield =='description')
               	{
           
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {                                                      
                    	   var  mtypename=document.getElementById("mtypename").value;
                    	   document.getElementById("rowindex1").value = cell1.rowindex;
                     	   
                        	descservSearchContent('servdescnamesearch.jsp?mtypename='+mtypename);
                   	$('#approvel').jqxGrid('render');
                     }
                 } 
               
               
               }, 
           	
       		//var rows = $("#maindowngrid").jqxGrid('getrows');
       	   // $('#servicegridlenght').val(rows.length);
	
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '2%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							
							{ text: 'Type', datafield: 'type', width: '10%',editable: false },
							
							{ text: 'Description', datafield: 'description', width: '22.8%',editable: false },
							{ text: 'Remarks', datafield: 'remarks' ,width: '30%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,
								 cellbeginedit: function (row) {
									 
									 
								 var postingstatus=document.getElementById("postingstatus").value;
									 if(parseInt(postingstatus)==1)
										 							 
										 {
										 
										  return false;
										 
										 }
									 	/* var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
									 	 if (!(val=="") && !(typeof(val)=="undefined"))
								    	 {
								    			    	 
								       return false; 
								    	 }
									 	var val1= $('#maindowngrid').jqxGrid('getcellvalue', 0, "type");	
									 	
									 	 if ((val1=="") || (typeof(val1)=="undefined"))
								    	 {
								    			    	 
								       return false; 
								    	 }	 */
									      
									   
									  }	
							},
							{ text: 'Labor Cost', datafield: 'lbrcost',width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, 
								
								cellbeginedit: function (row) {
									
									 var postingstatus=document.getElementById("postingstatus").value;
									if(parseInt(postingstatus)==1)
			 							 
									 {
									 
									  return false;
									 
									 }
								      
								
								  }	
							},
						
							{ text: 'Parts Cost', datafield: 'partscost',width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,
								
							
								cellbeginedit: function (row) {
									 var postingstatus=document.getElementById("postingstatus").value;	 
									 if(parseInt(postingstatus)==1)
			 							 
									 {
									 
									  return false;
									 
									 }
								}
								   
								  }	,
							
						
							{ text: 'Total', datafield: 'total',width:"10%",cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false},
                             
							 { text: ' ', datafield: 'clears',columntype: 'checkbox', editable: true, checked: false, width: '5%',cellsalign: 'center', align: 'center'
							  },
							]
            });
           
           // $("#approvel").jqxGrid('addrow', null, {});
            $("#approvel").jqxGrid({ disabled: true}); 
        	/* if(($('#mode').val()=='A')||($('#mode').val()=='E'))
        		{
        		  $("#approvel").jqxGrid({ disabled: false}); 
        		} */
            
            $("#approvel").on('cellclick', function (event) 
              		{
          
                 if(event.args.columnindex ==1)
              	   {
              	
                 $("#approvel").jqxGrid('clearselection');
              	   }
                 if(event.args.columnindex ==2)
          	   {
          	
                 $("#approvel").jqxGrid('clearselection');
          	   } 
               
                 
                     }); 
            
            $('#approvel').on('celldoubleclick', function (event) {
            	
           	 var postingstatus=document.getElementById("postingstatus").value;	
           	 if(parseInt(postingstatus)==1)
					 
			 {
			 
			  return false;
			 
			 }
            	var columnindex1=event.args.columnindex;
            	
            	
            	 if(columnindex1 == 1)
         		  { 
         		  $("#maindowngrid").jqxGrid('clearselection');
         		 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex1").value = rowindextemp;  
         	   var aa="appr";
         TypeservSearchContent('serviecetypeserch.jsp?val='+aa);
       
         		  } 
         	  
           if(columnindex1 == 2)
    		  { 
         		  $("#maindowngrid").jqxGrid('clearselection');
    		
    	 var rowindextemp = event.args.rowindex;
    	    document.getElementById("rowindex1").value = rowindextemp;  
    	   var  mtypename=document.getElementById("mtypename1").value;
    	   var bb="apprv";
    	descservSearchContent('servdescnamesearch.jsp?mtypename='+mtypename+'&valu='+bb);
   	
    		  }  
         	  
              	  
                  }); 
            
            function valchange(rowBoundIndex)
            {
            	
            	
            	var lbrcost= $('#approvel').jqxGrid('getcellvalue', rowBoundIndex, "lbrcost");	
            	// $('#approvel').jqxGrid('setcellvalue', rowBoundIndex, "total",lbrcost);
            	
            
            		if(lbrcost==""||lbrcost==null||lbrcost=="undefined")
	   			{
            			lbrcost=0;	
	   			}
            	
            	var partscost=	$('#approvel').jqxGrid('getcellvalue', rowBoundIndex, "partscost");	
            	
            	
            	
               	var total=parseFloat(lbrcost)+parseFloat(partscost);
            	if(partscost==""||partscost==null||partscost=="undefined")
	   			{
	   		  $('#approvel').jqxGrid('setcellvalue', rowBoundIndex, "total",lbrcost);
	   			}
	   		else{
	   			$('#approvel').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
	   	     	}
         
            	// 
    	        		   
    	                 /*   
    	                   var summaryData1= $("#approvel").jqxGrid('getcolumnaggregateddata', 'lbrcost', ['sum'],true);
   	                    
    	                   document.getElementById("lbrtotalcost").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
    	                   var summaryData2= $("#approvel").jqxGrid('getcolumnaggregateddata', 'partscost', ['sum'],true);
   	                    
    	                   document.getElementById("partstotalcost").value=summaryData2.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
    	                   var summaryData= $("#approvel").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	                   document.getElementById("totalcost").value=summaryData.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"); */
    	                   
    	      
    		    
            }

            $("#approvel").on('cellvaluechanged', function (event) 
            {
            	
           	 var postingstatus=document.getElementById("postingstatus").value;	
           	 if(parseInt(postingstatus)==1)
					 
			 {
			 
			  return false;
			 
			 }
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    if(datafield=="type")
    		    	{
    		    
    		    	
    		    	 $('#approvel').jqxGrid('setcellvalue', rowBoundIndex, "description","");
	        		   
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
    <div id="approvel"></div>
    <input type="hidden" id="rowindex1">
