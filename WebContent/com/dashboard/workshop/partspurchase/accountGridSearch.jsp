<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%ClsPartsPurchaseDAO viewDAO=new ClsPartsPurchaseDAO();%>
<%String atype = request.getParameter("dtype").toString();
String type = request.getParameter("type").toString(); %>

<script type="text/javascript">
  		var type='<%=type%>';
        var typedata= '<%=viewDAO.accountGridsearch(atype) %>';
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'type', type: 'string'  },
     						
                        ],
                		 localdata: typedata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaccmainSearch").jqxGrid(
            {
            	width: '100%',
                height: 378,
                source: dataAdapter,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Doc No',  datafield: 'doc_no', width: '5%',hidden : true }, 
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '80%' },
							{ text: 'grtype', datafield: 'grtype', width: '8%',hidden : true }
					
						]
            });
            
             $('#jqxaccmainSearch').on('rowdoubleclick', function (event) {
              var rowindex2 = event.args.rowindex;  
               
              var account=$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "account");
              var name=$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "description");
              var actype=$('#jqxaccmainSearch').jqxGrid('getcellvalue', rowindex2, "type");
              
              if(type=="FROM"){
            	  $("#fromaccountid").val(account);
                  $("#fromaccount").val(name);
                  $("#hidfromaccount").val(actype+"###"+account);
                  
              }else if(type=="TO"){
            	  $("#toaccountid").val(account);
                  $("#toaccount").val(name);
                  $("#hidtoaccount").val(actype+"###"+account);
                  
              }

              $('#accountSearchwindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxaccmainSearch"></div>
 