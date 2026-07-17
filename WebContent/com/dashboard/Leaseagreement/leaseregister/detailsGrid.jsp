<%@ page import="com.dashboard.leaseagreement.leaseregister.ClsleaseregisterDAO" %>
 <%

 	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();
  	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
  	
  
  	ClsleaseregisterDAO clad=new ClsleaseregisterDAO();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=status%>';
 var datalease;
 var exceldetail;
 var aa;
  if(temp4!='NA')
 { 
	  datalease='<%=clad.detailsgrid(branchval,fromdate,todate,status)%>' ;
	  
	  exceldetail='<%=clad.detailexcel(branchval,fromdate,todate,status)%>' ;
	
 aa=0;
 }
  
  
  else
	  {
	  datalease;
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
     						 {name : 'reg_no', type: 'String'}, 
     						{name : 'outdate', type: 'date'  },
     						
     					 	{name : 'lcost', type: 'string'  },
     						{name : 'enddate', type: 'date'  },
     						
     						{name : 'invd',type:'String'}, 
     						{name : 'bal',type:'String'},
     						
                          	],
                          	localdata: datalease,
                          	       
          
				
                
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
            	
            	
            	width: '99%',
                height: 520,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                columnsresize:true,
     					
                columns: [
                          
      
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                          
							{ text: 'LA NO', datafield: 'doc_no', width: '4%',hidden:true }, 
							{ text: 'LA NO', datafield: 'voc_no', width: '7%' },             
							{ text: 'Fleet', datafield: 'fleet_no', width: '7%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '15%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%' },
							{ text: 'Client Name', datafield: 'refname', width: '17%' },
						
							{ text: 'Start Date', datafield: 'outdate', width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'End Date', datafield: 'enddate', width: '8%',cellsformat:'dd.MM.yyyy'}, 
							{ text: 'Lease Cost', datafield: 'lcost', width: '9%' ,cellsformat:'d2',cellsalign:'right'},
							{ text: 'Invoiced', datafield: 'invd', width: '9%' ,cellsformat:'d2',cellsalign:'right'},
								
							{ text: 'Balance',datafield:'bal',width:'9%' ,cellsformat:'d2',cellsalign:'right' }, 
							
					
					]
            });


     	   $("#overlay, #PleaseWait").hide();
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>