<%@page import="com.dashboard.rentalagreement.driverremove.ClsdriverRemoveDAO" %>
 <%

 ClsdriverRemoveDAO RemoveDAO=new ClsdriverRemoveDAO();
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 
 
 %> 
 
 
 <script type="text/javascript">
 
 var temp4='<%=branchval%>';
  
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 

	  var dataildata='<%= RemoveDAO.driverlist(branchval,fromDate,toDate,cldocno,agmtNo)%>';;
 }
  
 
  else
	  {
	  var dataildata;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
//doc_no voc_no fleet_no flname cldocno srno refname drname
                             
                 			{name : 'doc_no', type: 'String'  },   //this is the agreement
     						{name : 'voc_no', type: 'String'},
     						
     						
     						 
     						
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     					 
     					 
     						{name : 'cldocno', type: 'String'  },
      
     						{name : 'srno', type: 'string'  },
     						
     						 {name : 'refname', type: 'String'}, 
     						 {name : 'drname', type: 'String'}, 
     						 
     						 
     						{name : 'btnsave', type: 'string'  },
     						
     						 {name : 'brhid', type: 'String'}, 
     						
                          	],
                          	localdata: dataildata,
                          	       
          
				
                
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
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 500,
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
							{ text: 'RA NO', datafield: 'voc_no', width: '10%' },   //voc no
							
						
							{ text: 'Client Name', datafield: 'refname', width: '25%' },
				 
							{ text: 'Driver', datafield: 'drname', width: '22%'},
						 
							
							{ text: 'Fleet', datafield: 'fleet_no', width: '10%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '20%' },
							 
 
							 { text: ' ', datafield: 'btnsave', width: '10%',columntype: 'button',editable:false, filterable: false},
					
							 { text: 'srno', datafield: 'srno', width: '13%',hidden:true },	 
							 
							 { text: 'brhid', datafield: 'brhid', width: '13%',hidden:true },	 
							  
							 
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            
            
            
            
            
            
            $("#detailsgrid").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            	 
             			  		    
            if(datafield=="btnsave"){
           	 if($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
           		
           		
           		 
           		 //for 
           		  var srno= $('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex, "srno");
            		 
           		var brhid= $('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
           		
				    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				    		        	  
				    	     		       
									       		        	if(r==false)
									       		        	  {
									       		        		return false; 
									       		        	  }
									       		        	else{
									        				 savegriddata(srno,brhid);
									       		        	   }
				    		                      });
           	                      }
								           	 else {
								           		 
								           	
								           	  $('#detailsgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
								           	         }
								             }
            });
   		          
            
            function savegriddata(srno,brhid)
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
            		
            x.open("GET","savedrvdate.jsp?srno="+srno+"&brhid="+brhid,true);
            
            x.send();
            		
            }
              
            
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>