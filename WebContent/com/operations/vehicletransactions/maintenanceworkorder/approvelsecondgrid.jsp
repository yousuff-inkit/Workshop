<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
  <%         
	
    String maindoc = request.getParameter("maindoc1")==null?"NA":request.getParameter("maindoc1").trim();

    %>
    <script type="text/javascript"> 
    
   
    var temp2='<%=maindoc%>';
    var maindatass;

    var aa="";
    
    if(temp2!="NA")
    	{
    	aa="";
    maindatass='<%=cmwd.searchmaingridrelodes(maindoc) %>';
    // alert(maindatass);
    	}
  
    else
    	{
    	maindatass;
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
     						 
     						{name : 'cldate', type: 'date'  },   
     						{name : 'cltime', type: 'string'  },
     						 
     						{name : 'hidcldate', type: 'string'  }, 
     						{name : 'hidcltime', type: 'string'  }
     			
     						/* {name : 'clremarks', type: 'string'  },
     						{name : 'cldate', type: 'date'  },
     						{name : 'cltime', type: 'date'  },
     				     
     						{name : 'hidcldate', type: 'string'  },
     						{name : 'hidcltime', type: 'string'  }
     						 */
     						
     						                	],
                 localdata: maindatass,
                
                
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
            $("#apprsecgrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                disabled: true,
                editable:true,
                altRows: true,
           
                selectionmode: 'singlecell',
                pagermode: 'default',
             
              
	
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
								{ text: 'Description', datafield: 'damagename' , width: '20%',
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
						
									{ text: 'Remarks', datafield: 'rem'  ,width: '24%',
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
									 { text: 'Cl.Time', datafield: 'cltime', width: '5%' ,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
							               editor.jqxDateTimeInput({ showCalendarButton: false });
							               
							             
							           }
									 
							         
									
							        },
									{ text: 'Cl.Date', datafield: 'cldate',width:"9%",columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
										 
									},
									
									{ text: 'hideCl.Date', datafield: 'hidcldate',width:"9%",hidden:true},
									{ text: 'hideCl.Time', datafield: 'hidcltime',width:"9%",hidden:true},
									
									
            ] 
            }); 
           
   
           // $("#apprsecgrid").jqxGrid('addrow', null, {});
            $("#apprsecgrid").jqxGrid({ disabled: true}); 

       /*      if((temp2!='NA'))
            	{
            	$("#apprsecgrid").jqxGrid({ disabled: true}); 
            	} */
          
        	  
            $("#apprsecgrid").on('cellclick', function (event) 
              		{
          
                 if(event.args.columnindex ==4)
              	   {
              	
                 $("#apprsecgrid").jqxGrid('clearselection');
              	   }
                 if(event.args.columnindex ==5)
            	   {
            	
               $("#apprsecgrid").jqxGrid('clearselection');
            	   }
          
               
                 
                     }); 
            
            $('#apprsecgrid').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var temp=$('#mode').val();
            	 if (temp=="view")
		    	 {
		    			    	 
		       return false; 
		    	 }
		      
              	  if(columnindex1 == 5)
              		  { 
              		  $("#apprsecgrid").jqxGrid('clearselection');
              		 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex1").value = rowindextemp;  
              	   
              uppertypeSearchContent('seachdamagetype.jsp');
            
              		  } 
              	 if(columnindex1 == 4)
         		  { 
         		  $("#apprsecgrid").jqxGrid('clearselection');
         		 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex1").value = rowindextemp;  
         	   
                damageSearchContent('damagesearch.jsp');
       
         		  } 
             
         	  
              	  
                  });  
           /*  $("#apprsecgrid").on('cellvaluechanged', function (event) 
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
          		    	 
          		 
          		    	 
            		    	  
            		    	   var text1 = $('#apprsecgrid').jqxGrid('getcelltext', rowBoundIndex, "refdate");
         		        	// alert(text1);
         		        	  $('#apprsecgrid').jqxGrid('setcellvalue',rowBoundIndex, "hidrefdates",text1);
          		       }
          		     
          		     
          		     
          		       
          		  });   
        	   */
            $("#apprsecgrid").on('cellvaluechanged', function (event) 
                    {
                    	
                       
                        var datafield = event.args.datafield;
                      
                        var rowBoundIndex = event.args.rowindex;
                        // new cell value.
                        var value = event.args.newvalue;
                       
                    
                        
                   /*      if(datafield=="date")
            		       {
            		    	  		       
            		          var hidrefdate = $('#apprsecgrid').jqxGrid('getcelltext', rowBoundIndex, "date");
         		        	 // alert(text);
         		        	  $('#apprsecgrid').jqxGrid('setcellvalue',rowBoundIndex, "hidrefdate",hidrefdate);
         		           } */
         		           
         		         /*  if(($('#mode').val()=='A'))
         		        	  { */
         		           
         		        /*   if(datafield=="clear")
         		        	  
         		          {
         		        	  
         		        	var val= $('#apprsecgrid').jqxGrid('getcelltext', rowBoundIndex, "clear");
         		        	if(val==true)
         		        	  {
         		           $('#apprsecgrid').jqxGrid('setcellvalue', rowBoundIndex, "cldate",new Date());
         		          $('#apprsecgrid').jqxGrid('setcellvalue', rowBoundIndex, "cltime" ,new Date());
         		          
         		        	
         		        	  }
         		        	else{
         		        		 $('#apprsecgrid').jqxGrid('setcellvalue', rowBoundIndex, "cldate","");
         		        		  $('#apprsecgrid').jqxGrid('setcellvalue', rowBoundIndex, "cltime" ,"");
         		        	}
        		          } 
         		        	  } */
                        if(datafield=="cltime")
         		        	  
         		          {
         		        	  
         		        
         		         $('#apprsecgrid').jqxGrid('setcellvalue', rowBoundIndex, "hidcltime" ,$('#apprsecgrid').jqxGrid('getcelltext', rowBoundIndex, "cltime"));
         		        	
         		        	 
        		          } 
         		       
            		       
                        if(datafield=="cldate")
         		          {
         		    	   
         		       
         		              var hidcldate = $('#apprsecgrid').jqxGrid('getcelltext', rowBoundIndex, "cldate");
        		        	 // alert(text);
        		        	  $('#apprsecgrid').jqxGrid('setcellvalue',rowBoundIndex, "hidcldate",hidcldate);
        		          }
         		       
            		      
                   
                         
                    });
        }); 
    </script>
    <div id="apprsecgrid"></div>
    <input type="hidden" id="rowindex1">
    
