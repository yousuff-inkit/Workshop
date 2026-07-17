<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var aa;
  if(temp4!='NA')
 { 

 
	  datasssss='<%=crad.complimentarylist(barchval,fromdate,todate)%>';
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
     						{name : 'voc_no', type: 'string'  }
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
                height: 501,
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
							{ text: 'Mob NO', datafield: 'per_mob', width: '10%'},
							{ text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Out Time', datafield: 'otime', width: '5%' },
							{ text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy'},
						    { text: 'DueTime', datafield: 'dtime', width: '5%' },
							{ text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
							{ text: 'docno', datafield: 'doc_no', width: '10%',hidden:true }
					
					
					]
            });
     
                 	  $("#overlay, #PleaseWait").hide();
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>