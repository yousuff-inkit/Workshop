<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
var duedateexcel;
 var aa;
  if(temp4!='NA')
 { 

 
 datasssss='<%=crad.duedate(barchval)%>';
duedateexcel='<%=crad.duedateexc(barchval)%>';
 aa=0;
 }
  
  
  else
	  {
	  datasssss;
	   duedateexcel;
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
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'vehdetails', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						
     						
     						{name : 'ddate', type: 'date'  },
     						{name : 'dtime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						{name : 'fdate', type: 'date'  },
     						{name : 'sal_name', type: 'string'  }
     						
     						
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
            $("#duedategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 400,
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
                          
							{ text: 'RA NO', datafield: 'doc_no', width: '4%',hidden:true },
							{ text: 'RA NO', datafield: 'voc_no', width: '4%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '10%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '12%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '11%'},
							
							{ text: 'Mob NO', datafield: 'per_mob', width: '8%'},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Out Time', datafield: 'otime', width: '5%' },
							
							 
							 
							 { text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy'},
								
							 { text: 'DueTime', datafield: 'dtime', width: '5%' },
							 
							 { text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },

							{ text: 'Salesman', datafield: 'sal_name', width: '12%'},
							
							 { text: 'branchid', datafield: 'brhid', width: '5%',hidden:true },
					
					
					]
            });
            
            
            $("#overlay, #PleaseWait").hide();
         
            if(aa==1)
        	{
        	 $("#duedategrid").jqxGrid('addrow', null, {});
        	}
      
            $('#duedategrid').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	  document.getElementById("rentaldoc").value="";
        	  document.getElementById("remarks").value="";
        	  document.getElementById("branchids").value="";
        	  
        	  
        	  $('#cmbinfo').val("");
        		 $('#cmbinfo').attr("disabled",false);
        		 $('#remarks').attr("readonly",false);
        		 $('#driverUpdate').attr("disabled",false);
        	  
        	  document.getElementById("rentaldoc").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        	  document.getElementById("fleetno").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            
        	  document.getElementById("branchids").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	  $('#duegridDate').val($('#duedategrid').jqxGrid('getcellvalue', rowindex1, "ddate")) ; 
              
        		
              
              $('#timeDue').val($('#duedategrid').jqxGrid('getcellvalue', rowindex1, "dtime")) ; 
              
              
              $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        	  
            		});
            
        });
        
        
				       
                       
    </script>
    <div id="duedategrid"></div>