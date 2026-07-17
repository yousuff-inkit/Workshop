<%@ page import="com.dashboard.rentalagreement.lponumber.ClsmranochangeDAO" %>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String salesman = request.getParameter("salesmandoc")==null?"NA":request.getParameter("salesmandoc").trim();
  	
  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	
 	String catid = request.getParameter("catid")==null?"NA":request.getParameter("catid").trim(); 

 	ClsmranochangeDAO crad=new ClsmranochangeDAO();
  	
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 

	 dataildata='<%=crad.detailedgrid(barchval,fromdate,todate,cldocno,status,fleet,salesman,type,outchk,inchk,catid)%>';
	 
	  datasssss='<%=crad.detailedgrid(barchval,fromdate,todate,cldocno,status,fleet,salesman,type,outchk,inchk,catid)%>';
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

                             
                 			{name : 'RA NO', type: 'String'  },   //this is the agreement
     						{name : 'Client Name', type: 'String'},
     						
     						 {name : 'Fleet', type: 'String'}, 
     						 {name : 'Fleet Name', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'Docno', type: 'String'},
     						{name : 'PO NO', type: 'String'},
     						
     						{name : 'Due Date', type: 'date'  },
     						{name : 'DueTime', type: 'String'  },
     						{name : 'Rental Type', type: 'String'  },
     						{name : 'Mob NO', type: 'String'  },
     						{name : 'Contact Person', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'Reg NO', type: 'string'  },
     						
     						{name : 'Driver', type: 'String'  },
     						{name : 'Manual RA', type: 'String'  },
     						{name : 'Rent', type: 'number'  },
     						{name : 'CDW', type: 'number'  },
     						{name : 'Ref No', type: 'string'  },
     						
     						
     						
     						
     						
     						{name : 'Inv Rent', type: 'number'  },
     						{name : 'Inv CDW', type: 'number'  },
     						
     						
						{name : 'Salesman', type: 'string'  },
     						 
     						{name : 'Contract Fleet', type: 'string'  },
     						{name : 'Contract Reg No', type: 'string'  },
     						{name : 'Open User', type: 'string'  },
     						{name : 'Close User', type: 'string'  },
     						
     						
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
            $("#detailedGrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 600,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
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

							{ text: 'RA NO', datafield: 'RA NO', width: '6%' },   //voc no
							
							{ text: 'Fleet', datafield: 'Fleet', width: '6%' },
							{ text: 'Fleet Name', datafield: 'Fleet Name', width: '13%' },
							{ text: 'Reg NO', datafield: 'Reg NO', width: '8%' },
							{ text: 'LPO NO', datafield: 'PO NO', width: '8%' },
							{ text: 'Contract Fleet', datafield: 'Contract Fleet', width: '8%' },
							{ text: 'Contract Reg No', datafield: 'Contract Reg No', width: '8%' },
							{ text: 'Client Name', datafield: 'Client Name', width: '18%' },
							{ text: 'Salesman', datafield: 'Salesman', width: '15%'},
							{ text: 'Contact Person', datafield: 'Contact Person', width: '12%'},
							{ text: 'Driver', datafield: 'Driver', width: '10%'},
							{ text: 'Mob NO', datafield: 'Mob NO', width: '10%'},
							
							 { text: 'Rental Type', datafield: 'Rental Type', width: '7%' },
							
							
							  
							
							 { text: 'Due Date', datafield: 'Due Date', width: '6%',cellsformat:'dd.MM.yyyy'},
								
							 { text: 'DueTime', datafield: 'DueTime', width: '5%' },
							 { text: 'Ref No', datafield: 'Ref No', width: '6%'},
						     { text: 'Manual RA', datafield: 'Manual RA', width: '6%'},
								
								
								 
							{ text: 'Rent', datafield: 'Rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								{ text: 'CDW', datafield: 'CDW', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								 
									{ text: 'Inv Rent', datafield: 'Inv Rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
									{ text: 'Inv CDW', datafield: 'Inv CDW', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
									{ text: 'Open User', datafield: 'Open User', width: '15%'},
									{ text: 'Close User', datafield: 'Close User', width: '12%'},
						
									
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
								
								
							// regno contract,fleetno contract
					
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            
            $('#detailedGrid').on('rowdoubleclick', function (event) {
               
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("ra_no").value=$('#detailedGrid').jqxGrid('getcellvalue', rowindex2, "Docno");
                document.getElementById("oldlpo").value=$('#detailedGrid').jqxGrid('getcellvalue', rowindex2, "PO NO");
                
            }); 
   
        });
       
        
				       
                       
    </script>
    <div id="detailedGrid"></div>