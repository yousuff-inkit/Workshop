<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var aa;
  if(temp4!='NA')
 { 

 
	  datasssss='<%=crad.complimentary(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type) %>';
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
     						
     						{name : 'drname', type: 'String'  },
     						{name : 'mrno', type: 'String'  },
     						{name : 'rent', type: 'number'  },
     						{name : 'cdw', type: 'number'  },
     						{name : 'refnos', type: 'string'  },
     						
     						{name : 'invdate', type: 'date'  },
     						{name : 'invrental', type: 'number'  },
     						{name : 'invcdw', type: 'number'  },
     						{name : 'voc_no', type: 'String'  },
     						
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
							{ text: 'RA NO', datafield: 'voc_no', width: '4%' },
							
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '13%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%' },
							{ text: 'Client Name', datafield: 'refname', width: '15%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%'},
							{ text: 'Driver', datafield: 'drname', width: '10%'},
							{ text: 'Mob NO', datafield: 'per_mob', width: '10%'},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Out Time', datafield: 'otime', width: '5%' },
							
							 { text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy'},
								
							 { text: 'DueTime', datafield: 'dtime', width: '5%' },
							 { text: 'Ref No', datafield: 'refnos', width: '6%'},
								{ text: 'Manual RA', datafield: 'mrno', width: '6%'},
								{ text: 'Rent', datafield: 'rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								{ text: 'CDW', datafield: 'cdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								 { text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy'},
									{ text: 'Inv Rent', datafield: 'invrental', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
									{ text: 'Inv CDW', datafield: 'invcdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
			
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
								{ text: 'RA NO', datafield: 'doc_no', width: '4%',hidden:true },
					
					
					]
            });
     
            $('#detailsgrid').on('rowdoubleclick', function (event) {
                
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("rano").value="";
                document.getElementById("masterrano").value="";
                $('#raupdate input').attr('disabled', false);
                document.getElementById("rano").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex2, "voc_no");
                document.getElementById("masterrano").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
            
            }); 
            
            
            
     	   $("#overlay, #PleaseWait").hide();
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>