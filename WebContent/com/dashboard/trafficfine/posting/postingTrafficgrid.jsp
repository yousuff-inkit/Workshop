<%@page import="com.dashboard.trafficfine.posting.ClsPostingDAO" %>
<%ClsPostingDAO cpd=new ClsPostingDAO(); %>


 <% 
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
 String chk = request.getParameter("chk")==null?"NN":request.getParameter("chk").trim(); 
  String ticketno=request.getParameter("ticketno")==null?"":request.getParameter("ticketno");
 //System.out.println("------chk----"+chk);

	%>
 <style>
 .greenClass{
            background-color: #ACF6CB;
        }
.whiteClass{
           background-color: #fff;
        }
 </style>

 <script type="text/javascript">
 
 var data1;

 var temp='<%=chk%>';
 	if(temp!='NN'){ 
		data1='<%=cpd.postingGridLoading(fromDate,toDate,ticketno)%>'; 
		
		//alert(data1);
        }
 	else
 	{
 		data1;
 	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                       
                                        	
                   						{name : 'regno', type: 'string'  },
                   						{name : 'fleetno', type: 'string'    },
                   						{name : 'source', type: 'string'    },
                   						{name : 'ticket_no', type: 'string'    },
                   						{name : 'traffic_date', type: 'date'    },
                   						{name : 'location', type: 'string'    },
                   						{name : 'amount', type: 'string'    },
                   						
                   						{name : 'invno', type: 'string'    },
                   						{name : 'invtype', type: 'string'    },
                   						{name : 'rano', type: 'string'    },
                   						{name : 'dtypedesc', type: 'string'    },
                   						{name : 'tinvno', type: 'string'    },
                   						
                   						
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
         	    
         	  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
     	        if(typeof(data.totalamount)=="undefined" || data.totalamount=="" ){
     	        	return "whiteClass"; 
     	        }
     	        else{
     	        	return "greenClass";
     	        };
     	          };   
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxFleetGrid").jqxGrid(
            {
                height: 340,
                width: '98%',
              
                source: dataAdapter,
                filtermode:'excel',
              //  filterable: true,
                //showfilterrow: true, 
                //filterable: true, 
                //sortable: true,
                showaggregates:true,
    	        selectionmode: 'checkbox',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '4%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							    }  
							  },
							  
							{ text: 'tinvno', datafield: 'tinvno', width: '8%',cellclassname: cellclassname ,hidden:true},
							{ text: 'Inv No', datafield: 'invno', width: '8%' ,cellclassname: cellclassname},
							{ text: 'Inv Type', datafield: 'invtype', width: '6%',cellclassname: cellclassname },
							{ text: 'RA No', datafield: 'rano', width: '6%',cellclassname: cellclassname },
							{ text: 'Type', datafield: 'dtypedesc', width: '14%',cellclassname: cellclassname },
							    { text: 'Reg No', datafield: 'regno', width: '8%',cellclassname: cellclassname },
								{ text: 'Fleet No', datafield: 'fleetno', width: '10%' ,cellclassname: cellclassname},
								{ text: 'Ticket No.', datafield: 'ticket_no', width: '10%' ,cellclassname: cellclassname},
								{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname: cellclassname},
								{ text: 'Net Amount', datafield: 'totalamount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname,hidden:true},
								{ text: 'Traffic Date', datafield: 'traffic_date', width: '10%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
								{ text: 'Location', datafield: 'location', width: '12%',hidden:true ,cellclassname: cellclassname},
								{ text: 'Source', datafield: 'source', width: '11%',cellclassname: cellclassname },
						
					
							  
					
														
	              ]
            });
        
            
            
            
            
            
            
            
            
            
            var rows=$("#jqxFleetGrid").jqxGrid("getrows");
    	    var rowcount=rows.length;
    	    if(rowcount==0){
    	    	$("#jqxFleetGrid").jqxGrid("addrow", null, {});	
    	    }
    	    
    	    $("#jqxFleetGrid").on('cellvaluechanged', function (event) {
      		 var datafield = event.args.datafield;
    	     if(datafield=="totalamount"){
    	      		     
    	    var amount1=0.0,amountcomm1=0.0;
    	    var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
    	   // alert("select  "+selectedrows);
    	    var i=0;
            var j=0;
    	    for (i = 0; i < rows.length; i++) {
    	    	
    	    	//alert("---i--"+i);
    	    	//for(selectedrows.size())
    	    		
 
              if(selectedrows[j]==i){
            	  
            	  
    					 var amount = $('#jqxFleetGrid').jqxGrid('getcellvalue', i, "amount");
    	                 var amountcomm= $("#jqxFleetGrid").jqxGrid('getcellvalue', i, "totalamount");
    	                 
    	               //  alert("amoount"+amount);
    	                 
    	                // alert("amountcomm"+amountcomm);
    	                 
    	                amount1=parseFloat(amount1)+parseFloat(amount); 
    	                 
    	                 amountcomm1=parseFloat(amountcomm1)+parseFloat(amountcomm);     	
    	                
    				     
    	         /*      if(!isNaN(amount)){
    	                	 amount1=amount1+amount;
                     	   }else if(isNaN(amount)){
                     		  amount=0.00;
                     		  amount1=amount1+amount;
                       	   }
    	                 
    	                 if(!isNaN(amountcomm)){
    	                	 amountcomm1=amountcomm1+amountcomm;
                     	   }else if(isNaN(amountcomm)){
                     		  amountcomm=0.00;
                     		  amountcomm1=amountcomm1+amountcomm;
                       	   }  */
    	                
    	                 j++; 
    	                 
                         // alert("amount1====="+amount1);
    	                 
    	                ///// alert("amountcomm1==="+amountcomm1);
    			}
    	
             }
    	
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "docno", $('#txttypedocno').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "type", $('#txttypeatype').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "accounts", $('#txttypeaccid').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "accountname1", $('#txttypeaccname').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "credit", amount1);
    	    
    	
    	    if(!isNaN(amount1)){
    	
    	     
    	       	
    	       	
    		    if($('#txttypetype').val().trim()=="M"){
    		  
    
    		    	
    		    		var baseamount1 = parseFloat(amount1) * parseFloat($('#txttyperate').val());
   
    		    		$("#postingJV").jqxGrid('setcellvalue', 0, "baseamount", baseamount1);
    		    }else{
    		  
    		    	var baseamount1 = parseFloat(amount1) / parseFloat($('#txttyperate').val());
    	    		$("#postingJV").jqxGrid('setcellvalue', 0, "baseamount", baseamount1);
    		    }
    	    }
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "description", "Posting as  JVT on "+$('#date').val()+"");
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "currencyid", $('#txttypecurid').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "currencytype", $('#txttypetype').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 0, "rate", $('#txttyperate').val());
    	    
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "docno", $('#txtdocno').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "type", $('#txtatype').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "accounts", $('#txtaccid').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "accountname1", $('#txtaccname').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "debit", amountcomm1);
    	    if(!isNaN(amountcomm1)){
    		    if($('#txtcurtype').val().trim()=="M"){
    		    		var commnetbaseamount1 = parseFloat(amountcomm1) * parseFloat($('#txtrate').val());
    		    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commnetbaseamount1);
    		    }else{
    		    	var commnetbaseamount1 = parseFloat(amountcomm1) / parseFloat($('#txtrate').val());
    	    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commnetbaseamount1);
    		    }
    	    }
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "description", "Posting as JVT on "+$('#date').val()+"");
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "currencyid", $('#txtcurid').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "currencytype", $('#txtcurtype').val());
    	    $("#postingJV").jqxGrid('setcellvalue', 1, "rate", $('#txtrate').val());
    	   
    	     }
    	    });
    	    
    	    $("#overlay, #PleaseWait").hide();
            
        	
                   });
    </script>
    <div id="jqxFleetGrid"></div>


