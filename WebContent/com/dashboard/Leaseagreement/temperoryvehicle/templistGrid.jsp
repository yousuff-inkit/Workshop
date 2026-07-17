<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>
 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 var temp4='<%=barchval%>';
 var datss;

  if(temp4!='NA')
 { 
 	
datss='<%=clad.temperoryVehicle(barchval)%>'; 
 	
 } 
 else
 { 
 	
	 datss;
 
 	}  


 

         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
                 		
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'flname', type: 'String'}, 
     						 
     						{name : 'reg_no', type: 'String'},
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     					/* 	{name : 'okm', type: 'number'  },
     						{name : 'ofuel', type: 'String'  },
     						
     					
     						{name : 'drid', type: 'String'  },*/
     						{name : 'perfleet_no', type: 'string'  },
     						{name : 'btnsave', type: 'string'  }, 
     						{name : 'brhid', type: 'string'  },
     						
     						
     						
     						
     						
                          	],
                          	localdata: datss,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#templistupdategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 526,
           
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                
                handlekeyboardnavigation: function (event) {
                    
                 	 var cell1 = $('#templistupdategrid').jqxGrid('getselectedcell');
                 	 
                 	 
                 	 if (cell1 != undefined && cell1.datafield == 'perfleet_no') {
                 	 var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                          if (key == 114) {  
                        	  var doc_no=$('#templistupdategrid').jqxGrid('getcellvalue',cell1.rowindex, "doc_no");
                          document.getElementById("rowindex").value = cell1.rowindex;
                    	  fleetSearchContent('Perfleetsearch.jsp?doc_no='+doc_no);
                         
                          }
                      }

               	       	
                
                }, 	
                columns: [
                          
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'LA NO', datafield: 'voc_no', width: '6%',editable:false },
							{ text: 'Client Name', datafield: 'refname', width: '17%',editable:false },
							{ text: 'Temperory Fleet', datafield: 'fleet_no', width: '8%',editable:false },
							{ text: 'Fleet Name', datafield: 'flname', width: '14%' ,editable:false},
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '9%',editable:false},
							{ text: 'Out Date', datafield: 'odate', width: '8%',cellsformat:'dd.MM.yyyy',editable:false},
							
							 { text: 'Time', datafield: 'otime', width: '6%',editable:false },
							 { text: 'Permanent Fleet', datafield: 'perfleet_no', width: '8%',editable:false},
					      { text: 'Fleet Name', datafield: 'perflname', width: '14%',editable:false },
								
					/* 		 { text: 'KM', datafield: 'okm', width: '10%' },
							 { text: 'Fuel', datafield: 'ofuel', width: '10%' },*/
							 { text: ' ', datafield: 'btnsave', width: '7%',columntype: 'button',editable:false, filterable: false}, 
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
							 { text: 'LA NO', datafield: 'doc_no', width: '6%',editable:false ,hidden:true  },
					
					
					]
            });
            

            $("#overlay, #PleaseWait").hide();
            $("#templistupdategrid").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            		    var columnindex = event.args.columnindex;
          			  
               	
          			  if(columnindex>7)
          				  {
          				  if(columnindex!=10)
          					  {
          				  if($('#templistupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
          					 $.messager.alert('Message',' Click Edit Button ','warning'); 
          					 
          				        }
          				  
          					  }
          				  
          				  
          				  } 
            		    
            if(datafield=="btnsave"){
           	 if($('#templistupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
           		
           		
           		 
           		 //for 
           		  var radocno= $('#templistupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
            		 var branchval= $('#templistupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 var permfleet= $('#templistupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "perfleet_no");
            		 
            		 
            		 if(permfleet==""||typeof(permfleet)=="undefined")
            		 {
            			
            			  $.messager.alert('Message','Select Permanent Fleet','warning');
                       
            			  
            				return false; 
            			
			            		 }
            		 
            		 
               		 
           		
				    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				    		        	  
				    	     		       
									       		        	if(r==false)
									       		        	  {
									       		        		return false; 
									       		        	  }
									       		        	else{
									        				 savegriddata(radocno,branchval,permfleet);
									       		        	   }
				    		                      });
           	                      }
								           	 else {
								           		 
								           	
								           	  $('#templistupdategrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
								           	         }
								             }
            });
            
            
            
            $('#templistupdategrid').on('celldoubleclick', function (event) {
            	
           	 var dataField = event.args.datafield;

      		
           	
           	
              	  if(dataField == "perfleet_no")
              		  { 
              		 var rowindextemp = event.args.rowindex;
               		document.getElementById("rowindex").value = rowindextemp;  
              		 
               	  var doc_no=$('#templistupdategrid').jqxGrid('getcellvalue',rowindextemp, "doc_no");
               	  
              
              	  fleetSearchContent('Perfleetsearch.jsp?doc_no='+doc_no);
            
              		  } 
              	  
              	
         	  
              	  
                  }); 
           
       });
   		          
        
        
        function savegriddata(radocno,branchval,permfleet)
        {
        	
        	var x=new XMLHttpRequest();
        	x.onreadystatechange=function(){
        	if (x.readyState==4 && x.status==200)
        		{
        		
             			
        			var items=x.responseText;
        			
        			
        			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
    				     
    			     });
        			 funreload(event); 
        			 
        			 
        			
        			}
        		
        	}
        		
        x.open("GET","savefleetdate.jsp?radocno="+radocno+"&branchval="+branchval+"&permfleet="+permfleet,true);
        
        x.send();
        		
        }
        
        
				       
                       
    </script>
    <input type="hidden" id="rowindex">
    <div id="templistupdategrid"></div>