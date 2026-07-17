<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
        
       <%--  var data1= '<%=com.finance.transactions.cashpayment.ClsCashPaymentDAO.cashPaymentGridSearch() %>';  --%>
      <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
     <%ClsRentalAgreementDAO crad= new ClsRentalAgreementDAO(); %>
      
      
       <script type="text/javascript">
       <%
		String  clientval=request.getParameter("clientval")==null?"0":request.getParameter("clientval");
       
		%>
		var temp='<%=clientval%>';
	
		var clientdir;
		if(temp>0)
			{
			 clientdir= '<%=crad.clientDriver(clientval)%>';
			
			}
		else
			{
			clientdir;
			}
       
		$(document).ready(function () { 	
        	/* var url=""; */
        	
             var num = 0; 
             var data1;
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'dr_id', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation', type: 'string'    },
     						{name : 'mobno', type: 'string'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'issdate', type: 'date'    },
     						{name : 'led', type: 'date'    },
     						{name : 'ltype', type: 'string'    },
     						{name : 'issfrm', type: 'string'    },
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },
     						{name : 'visano', type: 'string'    },
     						{name : 'visa_exp', type: 'date'    },
     						{name : 'hcdlno', type: 'string'    },
     						{name : 'hcissdate', type: 'date'    },
     						{name : 'hcled', type: 'string'    },
     						{name : 'age', type: 'number'    },
     						{name : 'drage', type: 'number'    },
     						{name : 'licyr', type: 'number'    },
     						{name : 'expiryear', type: 'number'}
                        ],
                		
                        localdata: clientdir,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxclientdriverSearch").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              { text: 'clientid', datafield: 'codeno', width: '1%',hidden:true },
                              { text: 'cli drdoc', datafield: 'doc_no', width: '1%' ,hidden:true},
                              { text: 'cli drid', datafield: 'dr_id', width: '1%' ,hidden:true},
							{ text: 'Name', datafield: 'name', width: '15%' },
							{ text: 'Date of Birth', datafield: 'dob', cellsformat: 'dd-MM-yyyy',width: '10%' },
							{ text: 'Nationality', datafield: 'nation', width: '10%' },
							{ text: 'Mob No', datafield: 'mobno', width: '14%' },
							{ text: 'Licence#', datafield: 'dlno', width: '10%' },
							{ text: 'Lic Issued', datafield: 'issdate',cellsformat: 'dd-MM-yyyy', width: '9%' },
							{ text: 'Lic Expiry', datafield: 'led', width: '9%' , cellsformat: 'dd-MM-yyyy'},
							{ text: 'Lic Type', datafield: 'ltype', width: '12%',hidden:true },
							{ text: 'Iss From', datafield: 'issfrm', width: '9%' },
							{ text: 'Passport#', datafield: 'passport_no', width: '10%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp', width: '12%', cellsformat: 'dd-MM-yyyy',hidden:true },
							
							
							
							
							{ text: 'age', datafield: 'age', width: '10%',hidden:true},
							{ text: 'drage', datafield: 'drage', width: '12%' ,hidden:true},
							{ text: 'licyr', datafield: 'licyr', width: '10%',hidden:true },
							{ text: 'expiryear', datafield: 'expiryear', width: '12%' ,hidden:true},
							{ text: 'licexp', datafield: 'licexp', width: '12%',hidden:true } 
	             
						]
            });
            
          $('#jqxclientdriverSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;

             
              var age=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "age");
              var drage=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "drage");
              var licyr=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "licyr");
              var expiryear=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "expiryear");
              var licexp=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "led");
              
              
          
             var today = new Date();
               
                 
                   if(licexp<today)
            	  {
                	 
  				
  				   $.messager.show({
  		                title:'Message',
  		                msg:'Licence Expired',
  		                showType:'fade',
  		                style:{
  		                    right:27,
  		                    left:'',
  		                    top:document.body.scrollTop+document.documentElement.scrollTop,
  		                    bottom:''
  		                }
  		            });  	   
                	   
  				   
  				/*  $.messager.show({title:'Message',msg:'Licence Expired',showType:'fade',
	                            style:{left:0,right:'', top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
  			      */
  				     
                	   return false;
           	     	
            	  } 
                     if(age<drage)
              	    {
                    	 
                  	   $.messager.show({
     		                title:'Message',
     		                msg:'Age Less than 25',
     		                showType:'show',
     		                style:{
     		                   right:27,
     		                    left:'',
     		                    top:document.body.scrollTop+document.documentElement.scrollTop,
     		                    bottom:''
     		                }
     		            });	 
                    	/*    $.messager.show({title:'Message',msg:'Age Less than 25',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
                */
      					
           	      return false;
              	    }
              
             
                    if(expiryear<licyr)
              	  {
                    	
                 	   $.messager.show({
    		                title:'Message',
    		                msg:'Issue Date Less Than One Year',
    		                showType:'show',
    		                style:{
    		                    right:27,
      		                    left:'',
    		                    top:document.body.scrollTop+document.documentElement.scrollTop,
    		                    bottom:''
    		                }
    		            });	
                    	
                    	/*  $.messager.show({title:'Message',msg:'Issue Date Less Than One Year',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); */ 
                    	
                
     
       	         return false;
              	   }
                
              else
        	   {
            	 
        	 
        	   }
             

         
              document.getElementById("clientdrvid").value=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "dr_id");
              document.getElementById("clientdrv").value=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "name");
              
              $('#driverinfowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxclientdriverSearch"></div>
 