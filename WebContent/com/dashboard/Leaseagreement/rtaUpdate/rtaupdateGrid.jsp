<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>

<% String contextPath=request.getContextPath();%>
 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var dat;

  if(temp4!='NA')
 { 
 	
	 dat='<%=clad.rtaupdate(barchval)%>';
 
 } 
 else
 { 
 	
	 dat;

 	
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
     						{name : 'okm', type: 'number'  },
     						{name : 'ofuel', type: 'String'  },
     						
     					
     						{name : 'drid', type: 'String'  },
     						{name : 'hidfuel', type: 'string'  },
     						{name : 'btnsave', type: 'string'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'btnattach', type: 'string'  },
     						
                          	],
                          	localdata: dat,
                          	       
          
				
                
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
            $("#rtaupdategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 526,
           
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
                          
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							  { text: 'LA NO', datafield: 'voc_no', width: '6%' },
							
							{ text: 'Client Name', datafield: 'refname', width: '19%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '10%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '13%' },
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%'},
							{ text: 'Out Date', datafield: 'odate', width: '8%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Time', datafield: 'otime', width: '5%' },
							
							 { text: 'KM', datafield: 'okm', width: '8%' },
							 { text: 'Fuel', datafield: 'ofuel', width: '8%' },
							 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
							 { text: ' ', datafield: 'btnattach', width: '6%',columntype: 'button',editable:false, filterable: false},
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
				
							 { text: 'LA NO', datafield: 'doc_no', width: '6%' ,hidden:true},
					
					]
            });
            

            $("#overlay, #PleaseWait").hide();
            
            $("#rtaupdategrid").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            		    if(datafield=="btnattach"){
                           	
                      		 
                      		 document.getElementById("docnoss").value=$('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
                      		 
                      		 document.getElementById("brh").value=$('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
                      		 
                      		
                      		 funAttachBtn();
                      		 
                      		 
            			 }		    
            		    
            if(datafield=="btnsave"){
           	 if($('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
           		
           		
           		 
           		 //for 
           		  var radocno= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
            		 var branchval= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
           		 
           		
				    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				    		        	  
				    	     		       
									       		        	if(r==false)
									       		        	  {
									       		        		return false; 
									       		        	  }
									       		        	else{
									        				 savegriddata(radocno,branchval);
									       		        	   }
				    		                      });
           	                      }
								           	 else {
								           		 
								           	
								           	  $('#rtaupdategrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
								           	         }
								             }
            });
   		          
         }); 
        
        function savegriddata(radocno,branchval)
        {
        	
        	var x=new XMLHttpRequest();
        	x.onreadystatechange=function(){
        	if (x.readyState==4 && x.status==200)
        		{
        		
             			
        			var items=x.responseText;
        			
        			
        			 $.messager.alert('Message', '  Record successfully Updated ', function(r){
        		 		 
        		 		 
    				     
    			     });
        			 funreload(event); 
        			 
        			 
        			
        			}
        		
        	}
        		
        x.open("GET","savedrtadate.jsp?radocno="+radocno+"&branchval="+branchval,true);
        
        x.send();
        		
        }
        
        function funAttachBtn(){
        	
      	  $("#windowattach").jqxWindow('setTitle',"LAG - "+document.getElementById("docnoss").value);
      		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=LAG&docno="+document.getElementById("docnoss").value+"&barchvals="+document.getElementById("brh").value);		
      	
      }
  
				       
                       
    </script>
    <input type="hidden" id="docnoss">
<input type="hidden" id="brh">
    <div id="rtaupdategrid"></div>