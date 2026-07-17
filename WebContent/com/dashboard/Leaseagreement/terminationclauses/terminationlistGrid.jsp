 <%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>
 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var dat1;

  if(temp4!='NA')
 { 
 	
	  
 dat1='<%=clad.terminationgrid(barchval,fromdate,todate)%>';

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
            $("#leasetermination").jqxGrid(
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

            $('#leasetermination').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	    		
        	  $('#lano').attr("readonly",true);
  		 	
 			 $('#m1').attr("readonly",false);
 			 $('#m2').attr("readonly",false);
 			 $('#amt1').attr("readonly",false);	
 		 	
 			 $('#m3').attr("readonly",true);
 			 $('#m4').attr("readonly",false);
 			 $('#amt2').attr("readonly",false);	
 			 
 			 $('#m5').attr("readonly",true);
 			 $('#m6').attr("readonly",false);
 			 $('#amt3').attr("readonly",false);	
 			 
 			 $('#m7').attr("readonly",true);
 			 $('#m8').attr("readonly",false);
 			 $('#amt4').attr("readonly",false);	
 			 
 			 $('#m9').attr("readonly",true);
 			 $('#m10').attr("readonly",false);
 			 $('#amt5').attr("readonly",false);	
 			 
 			 
 			 
 			 
 			 $('#terUpdate').attr("disabled",false);	
 			
			 	 document.getElementById("m1").value="";	
			 	 document.getElementById("m2").value="";
			 	 document.getElementById("amt1").value="";
			 	
			 	
			 	document.getElementById("m3").value="";	
			 	document.getElementById("m4").value="";
			 	document.getElementById("amt2").value="";
			 	
			 	document.getElementById("m5").value="";	
			 	document.getElementById("m6").value="";
			 	document.getElementById("amt3").value="";
			 	
			 	document.getElementById("m7").value="";	
			 	document.getElementById("m8").value="";
			 	document.getElementById("amt4").value="";
			 	
			 	document.getElementById("m9").value="";	
			 	document.getElementById("m10").value="";
			 	document.getElementById("amt5").value="";
			 	
			 	
			 	document.getElementById("ladocno").value="";
			 	document.getElementById("lano").value="";
            	
        	  document.getElementById("lano").value=$('#leasetermination').jqxGrid('getcellvalue', rowindex1, "voc_no");
        	  
        	  document.getElementById("ladocno").value=$('#leasetermination').jqxGrid('getcelltext', rowindex1, "doc_no");
 
               
            
            		 });	
                 
         }); 
        
   
        
        
				       
                       
    </script>
    <div id="leasetermination"></div>