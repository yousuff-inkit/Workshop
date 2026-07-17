<%@ page import="com.dashboard.leaseagreement.revenuerecognition.ClsrevenuerecognitionDAO" %>
 <%

 	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();
  	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
  	
  
  	ClsrevenuerecognitionDAO clad=new ClsrevenuerecognitionDAO();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=status%>';
 var datarev;
 var exceldata;
 var aa;
  if(temp4!='NA')
 { 
	  datarev='<%=clad.detailsgrid(branchval,fromdate,todate,status)%>' ;
	  
	  exceldata='<%=clad.exceldetails(branchval,fromdate,todate,status)%>';
	//  alert(exceldata);
	
 aa=0;
 }
  
  
  else
	  {
	  datarev;
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
     						
     						{name : 'enddate', type: 'date'  },
     						{name : 'revdate', type: 'date'  },
     						{name : 'totrev', type: 'string'  },
     						{name : 'proc',type:'String'}, 
     						{name : 'bal',type:'String'},
     						
                          	],
                          	localdata: datarev,
                          	       
          
				
                
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
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '14%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '16%' },
						
							{ text: 'Start Date', datafield: 'outdate', width: '6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'End Date', datafield: 'enddate', width: '6%',cellsformat:'dd.MM.yyyy'}, 
							{ text: 'Revenue Till Date', datafield: 'revdate', width: '8%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Total Revenue', datafield: 'totrev', width: '9%' ,cellsformat:'d2',cellsalign:'right'},
								
							{ text: 'Processed',datafield:'proc',width:'9%' ,cellsformat:'d2',cellsalign:'right' }, 
							{ text: 'Balance',datafield:'bal',width:'9%' ,cellsformat:'d2',cellsalign:'right' },
					
					]
            });


     	   $("#overlay, #PleaseWait").hide();
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>