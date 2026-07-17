<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>
 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var dat1;

  if(temp4!='NA')
 { 
 	
	  
 dat1='<%=clad.openstatus(barchval)%>';

 } 
 else
 { 
 	
	 dat1;

 	
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
     					
     						{name : 'brhid', type: 'string'  },
     						
     						
     						
     						
     						
                          	],
                          	localdata: dat1,
                          	       
          
				
                
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
            $("#openshow").jqxGrid(
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
                        
							  { text: 'LA NO', datafield: 'doc_no', width: '6%' ,hidden:true},
							{ text: 'LA NO', datafield: 'voc_no', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '19%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '10%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '16%' },
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '10%'},
							{ text: 'Out Date', datafield: 'odate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Time', datafield: 'otime', width: '6%' },
							
							 { text: 'KM', datafield: 'okm', width: '10%' },
							 { text: 'Fuel', datafield: 'ofuel', width: '10%' },
						
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
				
					
					
					]
            });

            $("#overlay, #PleaseWait").hide();

          
                 
         }); 
        
   
        
        
				       
                       
    </script>
    <div id="openshow"></div>