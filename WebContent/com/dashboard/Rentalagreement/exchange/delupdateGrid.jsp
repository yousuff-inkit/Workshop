<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

 <%
 
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
var datasssss;
 var aa;
  if(temp4!='NA')
 { 
 	

 
datasssss='<%=crad.exchange(barchval)%>';


aa=0;
 }
  
  else
	  {
	  
	  datasssss;
	 aa=1; 
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
     						{name : 'brhid', type: 'string'  }
     						
     						
      						
                          	],
                          	localdata: datasssss,
                          	       
          
				
                
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
							{ text: 'RA NO', datafield: 'doc_no', width: '6%' ,hidden:true},
							{ text: 'RA NO', datafield: 'voc_no', width: '5%' },
							{ text: 'Client Name', datafield: 'refname', width: '22%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '9%' },
							{ text: 'Fleet name', datafield: 'flname', width: '15%' },
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '10%'},
							{ text: 'Out Date', datafield: 'odate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Time', datafield: 'otime', width: '6%' },
							
							 { text: 'KM', datafield: 'okm', width: '10%' },
							 { text: 'Fuel', datafield: 'ofuel', width: '10%' },
							 
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
    
            if(aa==1)
        	{
        	 $("#delupdategrid").jqxGrid('addrow', null, {});
        	}
      
				            
				          $('#delupdategrid').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				        	  
				        	  document.getElementById("eorc").value="";
				      	    document.getElementById("indriver").value="";
				      		document.getElementById("inkm").value="";
				      		document.getElementById("infuel").value="";
				      	    
				      		document.getElementById("outfleet").value="";
				      		document.getElementById("outdriver").value="";
				      	    document.getElementById("outkm").value="";
				      		document.getElementById("outfuel").value="";
				      		document.getElementById("outfuelval").value="";
				      	    document.getElementById("outloc").value="";
				      		document.getElementById("outdriverid").value="";
				      		
				      		document.getElementById("cldocno").value="";
				      		document.getElementById("vehloca").value="";
				      	    document.getElementById("group").value="";
				      		document.getElementById("rentaldoc").value="";
				      		document.getElementById("fleetno").value="";
				      	    document.getElementById("out_km").value="";
				      		document.getElementById("branchids").value="";
				      		document.getElementById("remarkss").value="";
				    
				    	    $("#indetailss input").prop("disabled", true);
						    $("#indetailss select").prop("disabled", true);
						   $('#indate').jqxDateTimeInput({ disabled: true});
						   $('#intime').jqxDateTimeInput({ disabled: true});
						   
					 		$("#outdetailss input").prop("disabled", true);
				   		    $("#outdetailss select").prop("disabled", true);
				   		   $('#exdate').jqxDateTimeInput({ disabled: true});
				   		   $('#extime').jqxDateTimeInput({ disabled: true});
				   		   
				   		  $("#remarkss").prop("readonly", true);
				        		 
				         		$('#exdate').val(new Date());
				         		$('#extime').val(new Date());
				         			
				         	
				      	 	
				      	     $('#indate').val(new Date());
				      	      $('#intime').val(new Date());
				      		
				      		

				      	 $('#driverUpdate').attr("disabled",false);
				      		
				      	 $('#attachbtns').attr("disabled",false);
				     		
				     	       $("#eorc").prop("disabled", false);  
				            	
				        	  document.getElementById("rentaldoc").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				        	  
				        	
				        	  
				               document.getElementById("fleetno").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
				              
				               document.getElementById("group").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "gid");
				               document.getElementById("indriver").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "sal_name");
				   
				               
				              
				               document.getElementById("out_km").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "okm");
				              // document.getElementById("out_fuel").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "hidfuel");
				               $('#jqxDateOut').val($('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "odate")) ; 
				               
				               
				               $('#jqxTimeOut').val($('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "otime")) ; 
				               
				               
				               document.getElementById("branchids").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "brhid");         
				               document.getElementById("vehloca").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "a_loc");         	  
				               document.getElementById("cldocno").value=$('#delupdategrid').jqxGrid('getcellvalue', rowindex1, "cldocno");         	  
				               
				              // document.getElementById("eorc").focus();
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="delupdategrid"></div>