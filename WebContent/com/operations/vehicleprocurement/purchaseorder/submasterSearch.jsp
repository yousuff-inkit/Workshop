<%@page import="com.operations.vehicleprocurement.purchaseorder.ClsvehpurchaseorderDAO" %>
<%ClsvehpurchaseorderDAO cvpo=new ClsvehpurchaseorderDAO(); %>

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
 
/*  String brchName = request.getParameter("brchName")==null?"0":request.getParameter("brchName");  */
 
 
 %>
<script type="text/javascript">

var vahOrdermaster1= '<%=cvpo.searchmaster(session,docnoss,accountss,accnamess,datess,reftypess,aa) %>'; 
            	
        $(document).ready(function () { 	
        
 
                     
            //  prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                             
                        /*      refmaster voc_no */
                             
                             
                             {name : 'voc_no', type: 'int'},
                             
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'type', type: 'string'   },
     						{name : 'rno', type: 'string'   },
     						{name : 'refmaster', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'headdoc', type: 'string'   },
     						{name : 'expdeldt', type: 'date'   },
     						{name : 'desc1', type: 'string'  },
     						{name : 'nettotal', type: 'string'  }
     						
     											
                 ],
                 localdata: vahOrdermaster1,
                
                
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

            
            
            $("#vehorderMaster").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
             
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                                  { text: 'masterDoc NO', datafield: 'doc_no', width: '7%' ,hidden:true},	
							{ text: 'Doc NO', datafield: 'voc_no', width: '7%' },	
							{ text: 'Date', datafield: 'date', width: '13%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Type', datafield: 'type', width: '7%' },
							{ text: 'rno', datafield: 'rno', width: '10%',hidden:true },
							{ text: 'rnofno', datafield: 'refmaster', width: '10%',hidden:true },
							{ text: 'Account', datafield: 'account', width: '8%' },
							{ text: 'Account Name', datafield: 'description', width: '25%' },
							{ text: 'Description', datafield: 'desc1', width: '40%' },	
							{ text: 'expdeldt', datafield:'expdeldt', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'headdoc', datafield: 'headdoc', width: '65%' ,hidden:true },
							{ text: 'nettotal', datafield: 'nettotal', width: '65%' ,hidden:true },	
			              ]
               
            });
            
            $('#vehorderMaster').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                $('#vehrefno').attr('disabled', false);
     
                $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
    			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                           	
    			 document.getElementById("masterdoc_no").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   document.getElementById("docno").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   
                   $('#vehpurorderDate').val ($('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "date"));
                   $('#vehpurorderdelDate').val( $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "expdeldt")) ;
                   document.getElementById("vehrefno").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "rno");
                   document.getElementById("masterrefno").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "refmaster");
                   
                   document.getElementById("nettotal").value  = $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "nettotal");
                   
                   
                   document.getElementById("accid").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "account");
                   document.getElementById("vehpuraccname").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "description");
                   document.getElementById("headacccode").value =  $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "headdoc");
                   $('#vehtypeval').val($('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "type"));
                  document.getElementById("vehdesc").value  = $('#vehorderMaster').jqxGrid('getcellvalue', rowindex2, "desc1");
             
                         
                    
                
                
              $('#window').jqxWindow('close'); 
         	 $('#vehpurorderdelDate').jqxDateTimeInput({ disabled: false });
        	 $('#vehpurorderDate').jqxDateTimeInput({ disabled: false});

        	 $('#vehrefno').attr('disabled', false);
        	
        	 funSetlabel();
            document.getElementById("frmpurorder").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehorderMaster"></div>
