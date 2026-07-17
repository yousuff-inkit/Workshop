<%@ page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO" %>
<% ClsServiceAndMaintenanceDAO csmd=new ClsServiceAndMaintenanceDAO(); %>

 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
var garagefolupexcel;
 var datasssss;
 var aa;
  if(temp4!='NA')
 { 

 
maindata='<%=csmd.mainfollow(barchval)%>';
garagefolupexcel='<%=csmd.excelmainfollow(barchval)%>';
 aa=0;
 }
  
  
  else
	  {
	  maindata;
	garagefolupexcel;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 		
     						{name : 'date', type: 'date'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'flname', type: 'String'}, 
     						 
     						
     						{name : 'garageid', type: 'String'  },
     						
     						{name : 'name', type: 'String'  },
     						
     						
     						{name : 'dout', type: 'date'  },
     						{name : 'tout', type: 'String'  },
     						{name : 'kmout', type: 'String'  },
     						{name : 'fout', type: 'String'  },
                                                {name : 'reg_no', type: 'String'  },
                                                {name : 'code_name', type: 'String'  },
     						
     						{name : 'brhid', type: 'string'  },
     				
     						{name : 'fdate', type: 'date'  }
     						
     						
     						
                          	],
                          	localdata: maindata,
                          	       
          
				
                
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
                          

                          
							{ text: 'DOC NO', datafield: 'doc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Fleet', datafield: 'fleet_no', width: '8%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '15%' },
							
							{ text: 'Garage', datafield: 'name', width: '13%'},
                                                        { text: 'Reg_no', datafield: 'reg_no', width: '8%'},
							{ text: 'Plate_code', datafield: 'code_name', width: '7%'},
						
						
							{ text: ' Out     '+'  :  '+'     Date' , datafield: 'dout', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Time', datafield: 'tout', width: '4%' },
					
							 { text: 'KM', datafield: 'kmout', width: '7%' },
							 { text: 'Fuel', datafield: 'fout', width: '6%' },
							 
							 { text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
							 { text: 'garageid', datafield: 'garageid', width: '8%',hidden:true },
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
					
					]
            });
         
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
        	  document.getElementById("fleetno").value="";
        	  document.getElementById("grgid").value="";
        	  
        	  $('#cmbinfo').val("");
        		 $('#cmbinfo').attr("disabled",false);
        		 $('#remarks').attr("readonly",false);
        		 $('#driverUpdate').attr("disabled",false);
        	  
        	  document.getElementById("rentaldoc").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        	  document.getElementById("fleetno").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
        	  document.getElementById("grgid").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "garageid");
            
        	  document.getElementById("branchids").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	
              
       
              
              
              $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        	  
            		});
            
        });
        
        
				       
                       
    </script>
    <div id="duedategrid"></div>