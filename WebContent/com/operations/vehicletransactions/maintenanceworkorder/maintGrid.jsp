<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
  <%         
	String fleetno = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();
    String maindoc = request.getParameter("maindoc")==null?"NA":request.getParameter("maindoc").trim();

    %>
    <script type="text/javascript"> 
    
    var temp1='<%=fleetno%>';
    var temp2='<%=maindoc%>';
    var maindata;

    var aa="";
    
    if(temp2!="NA")
    	{
    	aa="";
    maindata='<%=cmwd.searchmaingridrelode(maindoc) %>';

    	}
    else if(temp1!="NA")
    	{
    	aa="add";
     maindata='<%=cmwd.searchfleetgridrelode(fleetno)%>';
    	}
    else
    	{
    	maindata;
    	aa="first";
    	}
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'refsrno' , type: 'number' },
     						{name : 'refdate', type: 'date'  },
     						{name : 'maintype', type: 'string'  },
     						{name : 'damagename' , type: 'string' },
     						{name : 'rem', type: 'string'  },
     						{name : 'clears', type: 'bool'  },
     						{name : 'typedocno', type: 'string'  },
     						 {name : 'hidrefdates', type: 'string'  }, 
     						 {name : 'damageid', type: 'string'  }, 
     						 
     						
     						
     					//	typedocno
     						/* {name : 'clremarks', type: 'string'  },
     						{name : 'cldate', type: 'date'  },
     						{name : 'cltime', type: 'date'  },
     				     
     						{name : 'hidcldate', type: 'string'  },
     						{name : 'hidcltime', type: 'string'  }
     						 */
     						
     						                	],
                 localdata: maindata,
                
                
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
            $("#mainuppergrid").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
               
                editable:true,
                altRows: true,
           
                selectionmode: 'singlecell',
                pagermode: 'default',


 /*                $('#mainuppergrid').on('celldoubleclick', function (event) {
                	var columnindex1=event.args.columnindex;
                	var temp=$('#mode').val();
                	 if (temp=="view")
    		    	 {
    		    			    	 
    		       return false; 
    		    	 }
    		      
                  	  if(columnindex1 == 5)
                  		  { 
                  		  $("#mainuppergrid").jqxGrid('clearselection');
                  		 var rowindextemp = event.args.rowindex;
                  	    document.getElementById("rowindex1").value = rowindextemp;  
                  	   
                  uppertypeSearchContent('seachdamagetype.jsp');
                
                  		  } 
                  	 if(columnindex1 == 4)
             		  { 
             		  $("#mainuppergrid").jqxGrid('clearselection');
             		 var rowindextemp = event.args.rowindex;
             	    document.getElementById("rowindex1").value = rowindextemp;  
             	   
                    damageSearchContent('damagesearch.jsp');
           
             		  } 
                 
             	  
                  	  
                      });     
                 */
                
                handlekeyboardnavigation: function (event) {
                    
               	 var cell1 = $('#mainuppergrid').jqxGrid('getselectedcell');
               	 if (cell1 != undefined && cell1.datafield == 'damagename') {
               	 
             	 /*   if(args.datafield=="type")
                	{ */
             		
                   
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                       	 
                       	 document.getElementById("rowindex1").value = cell1.rowindex;
                     	   damageSearchContent('damagesearch.jsp');
                        $('#mainuppergrid').jqxGrid('render');
                        }
                    }
   
             	   
           	 if(cell1 != undefined && cell1.datafield =='maintype')
              	{
          
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {                                                      
                   	 
                   	   document.getElementById("rowindex1").value = cell1.rowindex;
                    	   
                
                      	uppertypeSearchContent('seachdamagetype.jsp');
                  	$('#maindowngrid').jqxGrid('render');
                    }
                } 
              
              
              }, 
                
                
                
                
                
                
                
                
                
                
	
                columns: [
									{ text: 'SL#', sortable: false, filterable: false, editable: false,
									    groupable: false, draggable: false, resizable: false,
									    datafield: 'sl', columntype: 'number', width: '5%',
									    cellsrenderer: function (row, column, value) {
									        return "<left><div style='margin:4px;'>" + (value + 1) + "</div></left>"; 
									    }  
									  },
									  { text: ' ', datafield: 'clears',columntype: 'checkbox', editable: true, checked: false, width: '5%',cellsalign: 'center', align: 'center'
									  },
									 { text: 'Ref No', datafield: 'refsrno' , width: '10%',editable: false},
									{ text: 'Ref Date', datafield: 'refdate', width: '10%' ,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',editable: false
										 	 },
								{ text: 'Description', datafield: 'damagename' , width: '23%',
												  cellbeginedit: function (row) {
														var temp=$('#mode').val();
													     if (temp=="view")
													    	 {
													    			    	 
													       return false; 
													    	 }
													      
													   
													  }	 },
									{ text: 'Complaint', datafield: 'maintype',   width: '12%',
												  cellbeginedit: function (row) {
														var temp=$('#mode').val();
													     if (temp=="view")
													    	 {
													    			    	 
													       return false; 
													    	 }
													      
													   
													  }	 },
						
									{ text: 'Remarks', datafield: 'rem'  ,width: '35%',
																  cellbeginedit: function (row) {
																		var temp=$('#mode').val();
																	     if (temp=="view")
																	    	 {
																	    			    	 
																	       return false; 
																	    	 }
																	      
																	   
																	  }	 },
									
									{ text: 'typedocno', datafield: 'typedocno'  ,width: '10%' ,hidden:true},
									
									{ text: 'damageid', datafield: 'damageid'  ,width: '10%'  ,hidden:true},
									{ text: 'Ref hide Date', datafield: 'hidrefdates', width: '10%' ,hidden:true  },
									
            ] 
            }); 
           
         if(aa=="add")
        	   { 
            $("#mainuppergrid").jqxGrid('addrow', null, {});
        	   }  

         else if(aa=="first")
  	   { 
      $("#mainuppergrid").jqxGrid('addrow', null, {});
  	   }  

            if((temp2!='NA'))
            	{
            	$("#mainuppergrid").jqxGrid({ disabled: true}); 
            	} 
          
        	  
            $("#mainuppergrid").on('cellclick', function (event) 
              		{
          
                 if(event.args.columnindex ==4)
              	   {
              	
                 $("#mainuppergrid").jqxGrid('clearselection');
              	   }
                 if(event.args.columnindex ==5)
            	   {
            	
               $("#mainuppergrid").jqxGrid('clearselection');
            	   }
          
               
                 
                     }); 
            
            $('#mainuppergrid').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var temp=$('#mode').val();
            	 if (temp=="view")
		    	 {
		    			    	 
		       return false; 
		    	 }
		      
              	  if(columnindex1 == 5)
              		  { 
              		  $("#mainuppergrid").jqxGrid('clearselection');
              		 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex1").value = rowindextemp;  
              	   
              uppertypeSearchContent('seachdamagetype.jsp');
            
              		  } 
              	 if(columnindex1 == 4)
         		  { 
         		  $("#mainuppergrid").jqxGrid('clearselection');
         		 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex1").value = rowindextemp;  
         	   
                damageSearchContent('damagesearch.jsp');
       
         		  } 
             
         	  
              	  
                  });  
           /*  $("#mainuppergrid").on('cellvaluechanged', function (event) 
          		   {
            	var temp=$('#mode').val();
            	 if (temp=="view")
		    	 {
		    			    	 
		       return false; 
		    	 }
		          		  
          		       var rowBoundIndex = event.args.rowindex;
          		       
          		       var datafield = event.args.datafield;
          		       
           		
          		     if(datafield=="refdate")
          		       {
          		    	 
          		 
          		    	 
            		    	  
            		    	   var text1 = $('#mainuppergrid').jqxGrid('getcelltext', rowBoundIndex, "refdate");
         		        	// alert(text1);
         		        	  $('#mainuppergrid').jqxGrid('setcellvalue',rowBoundIndex, "hidrefdates",text1);
          		       }
          		     
          		     
          		     
          		       
          		  });   
        	   */
          

        }); 
    </script>
    <div id="mainuppergrid"></div>
    <input type="hidden" id="rowindex1">
    
