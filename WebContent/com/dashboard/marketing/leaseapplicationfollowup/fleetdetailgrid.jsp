<%@page import="com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO"%>
     <%ClsleaseApplicationFollowupDAO cmd= new ClsleaseApplicationFollowupDAO(); %>

 <%
 
String srno = request.getParameter("srno")==null?"0":request.getParameter("srno");
 %>
 <script type="text/javascript">
  
 var detailslease='<%=cmd.fleetDetails(srno)%>' ; 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'brand', type: 'String'  },
                 		
     						{name : 'model', type: 'String'},
     						
     						 {name : 'nmonth', type: 'String'},
     						{name : 'vcost' , type : 'String'},
     						{name : 'brdid', type: 'String'  },
    						{name : 'modelid', type: 'String'  },
    						{name : 'residalvalue', type: 'String'  },
    						{name : 'prchcost', type: 'String'  },
    						{name : 'refdoc', type: 'String'  },
    						{name : 'reqsrno', type: 'String'  },
    						
    						{name : 'dealerno', type: 'String'  },
    						{name : 'dealername', type: 'String'  },
    						{name : 'allotno', type: 'String'  },
    						{name : 'vendacno', type: 'String'  },
    						{name : 'chasisno', type: 'String'  },
    						
    						
                          	],
                          	localdata: detailslease,
                          	       
          
				
                
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
            $("#fleetdetailsgrid").jqxGrid(
            { 
            	
            	
            	width: '99%',
                height: 140,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
						
							{ text: 'Brand', datafield: 'brand', width: '15%'},
							
							 { text: 'Model', datafield: 'model', width: '30%' },
				
							 { text: 'No. of Months', datafield: 'nmonth', width: '20%'},	
							 
							 { text: 'Vehicle Cost', datafield: 'vcost', width: '20%',cellsformat:'d2',cellsalign:'right' },
							 
							 { text: 'brandid', datafield: 'brdid', width: '10%',hidden:true},
							 { text: 'modelid', datafield: 'modelid', width: '10%',hidden:true},
							 { text: 'residalvalue', datafield: 'residalvalue', width: '10%',hidden:true},
							 { text: 'prchcost', datafield: 'prchcost', width: '10%',hidden:true},
							 { text: 'Ref Doc', datafield: 'refdoc',  width: '6%',hidden:true },
							 { text: 'ReQ srno', datafield: 'reqsrno',  width: '6%',hidden:true },
							 
							 { text: 'dealerno', datafield: 'dealerno', width: '10%',hidden:true},
							 { text: 'dealername', datafield: 'dealername',  width: '6%',hidden:true },
							 { text: 'VSB No', datafield: 'allotno',  width: '6%'},
							 { text: 'vendacno', datafield: 'vendacno', width: '10%',hidden:true},
							 { text: 'Chasis No', datafield: 'chasisno', width: '15%'},
							 
					
					]
            });
         
        
            $('#fleetdetailsgrid').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	
        		 
        		  $('#date').jqxDateTimeInput({ disabled: true});
        			 $('#purdealer').attr("disabled",true);
        		 $('#txtallot').attr("disabled",true);
       			 $('#txtallotremark').attr("disabled",true);
       			 $('#allotUpdate').attr("disabled",true);
       			 $('#txtvehremark').attr("disabled",true);
       			   $('#vehreleaseUpdate').attr("disabled",true);
       				 $('#vehreleasePrint').attr("disabled",true);
        			 
        			 $('#purchaseUpdate').attr("disabled",true);
        			 $('#fleetdate').jqxDateTimeInput({ disabled: false});
        			 $('#txtfleetno').attr("disabled",false);
        			 $('#dealer').attr("disabled",false);
        			 $('#fleetUpdate').attr("disabled",false);
        			 $('#txtalloc').attr("disabled",false);
        			 $('#txtinv').attr("disabled",false);
        			 
        			 document.getElementById("brandid").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "brdid");
        			 document.getElementById("modelid").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "modelid");
        			 document.getElementById("nomonth").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "nmonth");
        			 document.getElementById("vehcost").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "vcost");
        			 document.getElementById("resval").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "residalvalue");
        			 document.getElementById("purcost").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "prchcost");
        			 document.getElementById("leaseappdoc").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "refdoc");
        			 document.getElementById("lasrno").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "reqsrno");
        			 
        			 document.getElementById("hiddealer").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "dealerno");
        			 document.getElementById("dealer").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "dealername");
        			 document.getElementById("txtalloc").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "allotno");
        			 document.getElementById("vendacno").value=$('#fleetdetailsgrid').jqxGrid('getcellvalue', rowindex1, "vendacno");
        			 
            		 });	 
            
           
        });
        
        
				       
                       
    </script>
    <div id="fleetdetailsgrid"></div>