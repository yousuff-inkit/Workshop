<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>

 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datass;

  if(temp4!='NA')
 { 
 	
	  datass='<%=clad.delupdate(barchval)%>';
 	
 } 
 else
 { 
 	
	 datass;
 
 	}

 

         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
                 			{name : 'date', type: 'date'  },
                 		
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'flname', type: 'String'}, 
     						 
     						{name : 'reg_no', type: 'String'},
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						{name : 'okm', type: 'number'  },
     						{name : 'ofuel', type: 'String'  },
     						
     						{name : 'sal_name', type: 'String'  },
     						{name : 'drid', type: 'String'  },
     						{name : 'a_loc', type: 'String'  },
     						{name : 'gid', type: 'string'  },
     						{name : 'gname', type: 'string'  },
     						{name : 'hidfuel', type: 'string'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'chktype', type: 'string'  }
     						
      						
                          	],
                          	localdata: datass,
                          	       
          
				
                
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
            $("#delupdategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 526,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
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
                      	{ text: 'doc NO', datafield: 'doc_no', width: '6%' ,hidden:true},
							{ text: 'DOC NO', datafield: 'voc_no', width: '6%' },
							 { text: 'Type', datafield: 'chktype', width: '5%'},
							{ text: 'Client Name', datafield: 'refname', width: '20%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '9%' },
							{ text: 'Fleet name', datafield: 'flname', width: '16%' },
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%'},
							{ text: 'Out Date', datafield: 'odate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Time', datafield: 'otime', width: '6%' },
							
							 { text: 'KM', datafield: 'okm', width: '9%' },
							 { text: 'Fuel', datafield: 'ofuel', width: '8%' },
							 
							 { text: 'Driver', datafield: 'sal_name', width: '15%' ,hidden:true},
							
							 { text: 'drid', datafield: 'drid', width: '15%' ,hidden:true}, 
							 { text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
							 { text: 'rentaldate', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy',hidden:true},
							 { text: 'gid', datafield: 'gid', width: '15%',hidden:true },
							 { text: 'hidfuel', datafield: 'hidfuel', width: '15%',hidden:true },
							 { text: 'aloc', datafield: 'a_loc', width: '15%',hidden:true },
							 { text: 'brhid', datafield: 'brhid', width: '15%',hidden:true },
						
						
					
					
					]
            });
    
     	   $("#overlay, #PleaseWait").hide();
      
				            
				          $('#delupdategrid').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				        	  // set null
				        	    document.getElementById("rentaldoc").value="";
				        	    document.getElementById("rentaldate").value="";
							    document.getElementById("fleetno").value="";
								document.getElementById("chktype").value="";
								 $('#del_Driver').attr('placeholder', ''); 
								document.getElementById("del_KM").value="";
								document.getElementById("del_Fuel").value="";
								
								document.getElementById("del_Driverid").value="";
								document.getElementById("del_Driver").value="";
								
								$('#jqxDeliveryOut').val(new Date());
								$('#jqxDelTimeOut').val(new Date());
								document.getElementById("group").value="";
								document.getElementById("vehloca").value="";
								document.getElementById("out_km").value="";
								document.getElementById("out_fuel").value="";
								document.getElementById("branchids").value="";
								document.getElementById("cldocno").value="";
								$('#jqxDateOut').val(new Date());
								$('#jqxTimeOut').val(new Date());
				        	  // disabled false
				        	  $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
				     		 $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: false});
				     		 $('#del_KM').attr("readonly",false);
				     		 $('#del_Fuel').attr("disabled",false);
				     		 $('#driverUpdate').attr("disabled",false);
				     		
				     		 $('#attachbtns').attr("disabled",false);
				            	
				        	  document.getElementById("rentaldoc").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				        	  
				        	   document.getElementById("rentaldate").value=$('#delupdategrid').jqxGrid('getcelltext', rowindex1, "date"); 
				        	  
				               document.getElementById("fleetno").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
				              
				               document.getElementById("group").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "gid");
				           				              
				               document.getElementById("del_Driver").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "sal_name");
				               document.getElementById("del_Driverid").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "drid");
				               
				               document.getElementById("out_km").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "okm");
				               document.getElementById("out_fuel").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "hidfuel");
				               $('#jqxDateOut').val($('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "odate")) ; 
				               
				               
				               $('#jqxTimeOut').val($('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "otime")) ; 
				               
				               
				               document.getElementById("branchids").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "brhid");         
				               document.getElementById("vehloca").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "a_loc");         	  
				               document.getElementById("cldocno").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "cldocno");    
				               document.getElementById("chktype").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "chktype");
				               
				               var type=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "chktype");
				               
					          	 if (type == "VCU") {
					     			
					        		 
					     	        $('#del_Driver').attr('placeholder', 'Press F3 TO Search'); 
					     	    }
					          	 else
					          		 {
					          		 $('#del_Driver').attr('placeholder', ''); 
					          		 }   
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="delupdategrid"></div>