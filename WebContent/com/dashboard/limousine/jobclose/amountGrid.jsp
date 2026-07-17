<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.limousine.jobclose.*" %>
<%
ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
System.out.println("Inside Amount Grid");
%>

 <script type="text/javascript">
  var id='<%=id%>';
  var amountdata=null;
  if(id=="1"){
	
	  amountdata='<%=closedao.getAmountData(jobdocno,bookdocno,id)%>';
  }
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
        	
        <%-- 	if(document.getElementById("docno").value>0){
        		invoicedata='<%=invdao.getInvoiceGridData(branch,docno)%>';	
        	}
         --%>
           // alert("Grid Data"+invoicedata); 
        	var num = 1; 
                var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(value=="undefined" || typeof(value)=="undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + ': ' + value + '</div>';
                }
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                             {name :'idno',type:'number'},
     						{name : 'acno', type: 'string'  },
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'String'    },
     						{name : 'rate', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'jobdocno',type:'number'},
     						{name : 'bookdocno',type:'number'},
     						{name : 'jobname',type:'number'},
                 ],               
               localdata:amountdata,
               
               deleterow: function (rowid, commit) {
                   // synchronize with the server - send delete command
                   // call commit with parameter true if the synchronization with the server is successful 
                   // and with parameter false if the synchronization failed.
                   commit(true);
               },
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

            
            
            $("#amountGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight:25,
                //pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlecell',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#amountGrid').jqxGrid('getselectedcell');
                  /*   if (cell != undefined && cell.datafield == 'total' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#amountGrid").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#amountGrid").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#amountGrid").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#amountGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'acno') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	
                    	}
                    }
					},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Book Doc No',datafield:'bookdocno',width:'10%'},
                            { text: 'Job Doc No',datafield:'joobdocno',width:'20%',hidden:true},
                            { text: 'Job Name',datafield:'jobname',width:'10%'},
                            { text: 'ID',datafield:'idno',width:'20%',hidden:true},					
							{ text: 'Account', datafield: 'acno', width: '10%' },
							{ text: 'Description', datafield: 'description', width: '30%' },
							{ text: 'Quantity', datafield: 'qty', width: '10%' },
							{ text: 'Rate', datafield: 'rate', width: '10%' ,cellsalign:'right',cellsformat:'D2'},
							{ text: 'Total', datafield: 'total', width: '15%',cellsalign:'right',cellsformat:'D2',aggregates: ['sum'],aggregatesrenderer:rendererstring
			                  }
	              ]
            });
       
    
     });
    </script>
    <div id="amountGrid"></div>
   