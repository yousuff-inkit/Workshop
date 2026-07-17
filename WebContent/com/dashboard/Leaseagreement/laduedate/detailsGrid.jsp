<%@ page import="com.dashboard.leaseagreement.laduedate.ClslaDueDateDAO"%>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
  
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();
  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();
  	ClslaDueDateDAO clad=new ClslaDueDateDAO();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var laduedata;
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 
	 	  laduedata='<%=clad.detailsgrid(barchval,uptodate,cldocno,fleet)%>';
	 	 dataildata='<%=clad.exceldetailsgrid(barchval,uptodate,cldocno,fleet)%>';
	
 aa=0;
 }
  
  
  else
	  {
	  laduedata;
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
     						
     						{name : 'outdate', type: 'date'  },
     						{name : 'outtime', type: 'String'  },
     						
     					
     					
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						
     						{name : 'drname', type: 'String'  },
     						{name : 'mrno', type: 'String'  },
     						
						{name : 'sal_name', type: 'string'  },
						{name : 'duedate', type: 'date'  },
										
     						
                          	],
                          	localdata: laduedata,
                          	       
          
				
                
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
                height: 540,
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
							{ text: 'LA NO', datafield: 'voc_no', width: '4%' },             
							{ text: 'Fleet', datafield: 'fleet_no', width: '5%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '12%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '16%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%'},
							{ text: 'Driver', datafield: 'drname', width: '10%'},
							{ text: 'Mob NO', datafield: 'per_mob', width: '7%'},
							{ text: 'Out Date', datafield: 'outdate', width: '6%',cellsformat:'dd.MM.yyyy'},
							 { text: 'Out Time', datafield: 'outtime', width: '5%' },
							 { text: 'Due Date', datafield: 'duedate', width: '6%',cellsformat:'dd.MM.yyyy'},	
								{ text: 'Manual LA', datafield: 'mrno', width: '6%'},
								
							{ text: 'Salesman', datafield: 'sal_name', width: '12%'},
							
					
					]
            });


     	   $("#overlay, #PleaseWait").hide();
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>