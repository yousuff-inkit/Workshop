<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 %>
<script type="text/javascript">

var vahOrdermaster= '<%=cvp.searchmaster(session,docnoss,accountss,accnamess,datess,reftypess,aa) %>'; 
 
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                             
                             
				            {name : 'voc_no', voc_no: 'int'},
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'type', type: 'string'   },
     						{name : 'rno', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'headdoc', type: 'string'   },
     						{name : 'expdeldt', type: 'date'   },
     						{name : 'desc1', type: 'string'  },
     						{name : 'nettotal', type: 'string' },
     						{name : 'purdate', type: 'date'  },
     						{name : 'purno', type: 'string' },
     						{name : 'refno', type: 'string' },
     						{name : 'tr_no', type: 'string' },
     						
     						
     						
     						/* 
     						{name : 'dwnpyt', type: 'number'},
     						{name : 'loanamt', type: 'date'  },
     						{name : 'type', type: 'string'   },
     						{name : 'rno', type: 'string'   },
     						{name : 'account', type: 'string'   },
     					 	{name : 'description', type: 'string'   },
     						{name : 'headdoc', type: 'string'   },
     						{name : 'expdeldt', type: 'date'   },
     						{name : 'desc1', type: 'string'  },
     						{name : 'nettotal', type: 'string' },
     						{name : 'purdate', type: 'date'  },
     						{name : 'purno', type: 'string' },
     						
     						
     						dwnpyt, loanamt, stdate, perintst, clcumtd, noinstmt, sectychqno, chqname, amt, pytmtd, desc1, finaccname, 
     						finaccid, findocno, bankaccname, bankaccid, bankdocno, intstaccname, intstaccid, instdocno, loanaccname, loanaccid, loandocno;		 */		
     					
     											
                 ],
                 localdata: vahOrdermaster,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#vehpurchase").jqxGrid(
            {
                width: '100%',
                height: 282,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                           { text: 'masterDoc NO', datafield: 'doc_no', width: '7%',hidden:true },	
							{ text: 'Doc NO', datafield: 'voc_no', width: '7%' },	
							{ text: 'Date', datafield: 'date', width: '13%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Type', datafield: 'type', width: '7%' },
							{ text: 'rno', datafield: 'rno', width: '10%',hidden:true },
							{ text: 'Account', datafield: 'account', width: '8%' },
							{ text: 'Account Name', datafield: 'description', width: '25%' },
							{ text: 'Description', datafield: 'desc1', width: '40%' },	
							{ text: 'expdeldt', datafield:'expdeldt', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'headdoc', datafield: 'headdoc', width: '65%' ,hidden:true },
							{ text: 'nettotal', datafield: 'nettotal', width: '65%' ,hidden:true },	
							{ text: 'ref NO', datafield: 'refno', width: '7%' ,hidden:true},	
							
							{ text: 'INV NO', datafield: 'purno', width: '5%' ,hidden:true },
							{ text: 'INV DATE', datafield: 'purdate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
							
							{ text: 'tr_no', datafield: 'tr_no', width: '5%'  ,hidden:true },
							
							
			              ]
               
            });
            
            $('#vehpurchase').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                $('#vehrefno').attr('disabled', false);
     
                $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
    			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                           	
    			
    			
    			   document.getElementById("tranno").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "tr_no");
                   document.getElementById("docno").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   
                   document.getElementById("masterdoc_no").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   
                   
                   $('#vehpurorderDate').val ($('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "date"));
                   $('#vehpurorderdelDate').val( $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "expdeldt")) ;
                   
                   $('#vehpurinvDate').val( $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "purdate")) ;
                   
                   
                   document.getElementById("vehrefno").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "refno");
                   
                   document.getElementById("masterrefno").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "rno");
                   
                   document.getElementById("nettotal").value  = $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "nettotal");
                   
                  
                   document.getElementById("accid").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "account");
                   document.getElementById("vehpuraccname").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "description");
                   document.getElementById("headacccode").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "headdoc");
                   $('#vehtypeval').val($('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "type"));
                   
                   
                   document.getElementById("invno").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "purno");
                  
                   
                  document.getElementById("vehdesc").value  = $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "desc1");
             
             
              $('#window').jqxWindow('close'); 
         	 $('#vehpurorderdelDate').jqxDateTimeInput({ disabled: false });
        	 $('#vehpurorderDate').jqxDateTimeInput({ disabled: false});
        	 $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
            	
        	 $('#vehrefno').attr('disabled', false);
        	
        	 funSetlabel();
            document.getElementById("frmpurchase").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehpurchase"></div>
