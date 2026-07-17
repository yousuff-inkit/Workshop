<%@page import="com.dashboard.workshop.pricefollowup.ClsPriceFollowupDAO"%>
<%

 String froms = request.getParameter("froms")==null?"NN":request.getParameter("froms").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String process = request.getParameter("process")==null?"0":request.getParameter("process").trim();
String gipno = request.getParameter("gipno")==null?"0":request.getParameter("gipno").trim();
ClsPriceFollowupDAO DAO= new ClsPriceFollowupDAO();
%>
 <script type="text/javascript">
 
 var data1;
 var clientexceldata;
 var chk='<%=check%>';
 	if(chk!='NN'){ 
 		
 		data1='<%=DAO.masterdetails(froms,todate,cldocno,check,process,gipno)%>';
 		<%-- clientexceldata='<%=DAO.masterdetailsexcel(fromdate,cldocno,check)%>'; --%>
 		//alert(clientexceldata);
        }
 	else
 	{
 		
 		data1;
 		clientexceldata;
 		//alert(clientexceldata);
 	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                        {name : 'doc_no', type: 'String'   },
										{name : 'date', type: 'date'   },	
										{name : 'time', type: 'String'   },
										{name : 'reptype', type: 'string'  },
										{name : 'customer', type: 'string'  },
                   						{name : 'regno', type: 'string'  },
                   						{name : 'pcode', type: 'string'    },
                   						{name : 'brand', type: 'string'    },
                   						{name : 'model', type: 'String'    },
                   						{name : 'gipdate', type: 'String'    },
                   						{name : 'expdelivery', type: 'date'    },	
										{name : 'dtime', type: 'String'   },
										{name : 'description', type: 'string'  },
                   						{name : 'username', type: 'string'  },
                   						{name : 'estimtdby', type: 'string'    },
                   						{name : 'estimationno', type: 'string'    },
                   						{name : 'approval', type: 'string'    },
                   						
                   						
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
          /*   $("#jqxFleetGrid").on("bindingcomplete", function (event) {
            	if(temp=='A'){
            						    $('#jqxFleetGrid').jqxGrid('hidecolumn', 'estimtdby');
            							$("#jqxFleetGrid").jqxGrid('hidecolumn', 'estimationno');
            			    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'estdate');
            			    		    $('#jqxFleetGrid').jqxGrid('hidecolumn', 'approval');
            							
            	}
            	   else if(temp=='B'){
            		   $("#jqxFleetGrid").jqxGrid('hidecolumn', 'jobno');
   	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jdate');
   	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'user');
   	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jstatus');
         			    			}
            	   else if(temp=='C'){
            		   $("#jqxFleetGrid").jqxGrid('hidecolumn', 'jobno');
      	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jdate');
      	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'user');
      	    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jstatus');
            			    			}
            	
            }); */
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxFleetGrid").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							    }  
							  },
							  { text: 'Docno', datafield: 'doc_no', width: '8%' },
							  { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Time',datafield:'time',width:'8%',cellsformat:'HH:mm'},
							  { text: 'Repair Type', datafield: 'reptype', width: '8%' }, 
								{ text: 'Customer Name', datafield: 'customer', width: '8%' },  
							  { text: 'Reg No', datafield: 'regno', width: '8%' },
								{ text: 'P.code', datafield: 'pcode', width: '8%' },
								{ text: 'Brand', datafield: 'brand', width: '8%' },
								{ text: 'Model', datafield: 'model', width: '8%' },
								  { text: 'Days-GIPdate', datafield: 'gipdate', width: '8%' },
								  { text: 'Exp.delivery', datafield: 'expdelivery', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								  { text: 'Time', datafield: 'dtime',width:'6%',cellsformat:'HH:mm'},
								  { text: 'Description', datafield: 'description', width: '8%' },
								  { text: 'User Open', datafield: 'username', width: '8%' },
								  { text: 'Estimated By', datafield: 'estimtdby', width: '7%' },
								  { text: 'Estimation No.', datafield: 'estimationno', width: '7%' },
								  
								  { text: 'Approval Status', datafield: 'approval', width: '7%' },
	              ]
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
              		{ 
          	  var rowindex1=event.args.rowindex;
              $('#estimno').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'estimationno'));
              $('#gipnoo').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
              		});	 
            
        });
 	
    </script>
    <div id="jqxFleetGrid"></div>


