<%@page import="com.dashboard.workshop.gateinpassfollowup.ClsGateInPassFollowupDAO"%>
<%

 String rds = request.getParameter("rds")==null?"NN":request.getParameter("rds").trim();
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String cldocno = request.getParameter("cldoc")==null?"0":request.getParameter("cldoc").trim();
String process = request.getParameter("process")==null?"0":request.getParameter("process").trim();
String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();
ClsGateInPassFollowupDAO DAO= new ClsGateInPassFollowupDAO();
%>
 <script type="text/javascript">
 
 var data1;
 var exceldata;
 var temp='<%=rds%>';
 var chk='<%=check%>';
 	if(chk!='NN'){ 
 		
 		data1='<%=DAO.masterdetails(fromdate,cldocno,check,process,salid)%>';
 		exceldata='<%=DAO.masterexceldetails(fromdate,cldocno,check,process,salid)%>';
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
                                        {name : 'doc_no', type: 'number'   },
                                        {name : 'gateinpassdoc', type: 'number'   },
										{name : 'date', type: 'date'   },	
										{name : 'time', type: 'String'   },
										{name : 'reptype', type: 'string'  },
										{name : 'customer', type: 'string'  },
                   						{name : 'regno', type: 'string'  },
                   						{name : 'pcode', type: 'string'    },
                   						{name : 'brand', type: 'string'    },
                   						{name : 'model', type: 'String'    },
                   						{name : 'gipdate', type: 'number'    },
                   						{name : 'expdelivery', type: 'date'    },	
										{name : 'dtime', type: 'String'   },
										{name : 'description', type: 'string'  },
                   						{name : 'username', type: 'string'  },
                   						{name : 'estimtdby', type: 'string'    },
                   						{name : 'estimationno', type: 'string'    },
                   						{name : 'estdate', type: 'date'   },
                   						{name : 'approval', type: 'string'    },
                   						{name : 'jobno', type: 'string'    },
                   						{name : 'jdate', type: 'date' },
                   						{name : 'user', type: 'string'    },
                   						{name : 'jstatus', type: 'string'    },
                   						{name : 'mobile', type: 'string'    },
                   						{name : 'gipuser', type: 'string'    },
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            $("#jqxFleetGrid").on("bindingcomplete", function (event) {
            	if(temp=='A'){
            						    $('#jqxFleetGrid').jqxGrid('hidecolumn', 'estimtdby');
            							$("#jqxFleetGrid").jqxGrid('hidecolumn', 'estimationno');
            			    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'estdate');
            			    		    $('#jqxFleetGrid').jqxGrid('hidecolumn', 'approval');
            							$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jobno');
            			    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jdate');
            			    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'user');
            			    			$("#jqxFleetGrid").jqxGrid('hidecolumn', 'jstatus');
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
            	
            });
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
                showfilterrow: true,
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
							  { text: 'gateinpassdoc', datafield: 'gateinpassdoc', width: '8%' , hidden:true}, 
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
								  { text: 'Vehicle user', datafield: 'username', width: '8%' },
								  { text: 'Mobile No', datafield: 'mobile', width: '8%' },
								  { text: 'GIP User', datafield: 'gipuser', width: '8%' },
								  { text: 'Estimated By', datafield: 'estimtdby', width: '7%' },
								  { text: 'Estimation No.', datafield: 'estimationno', width: '7%' },
								  { text: 'Date', datafield: 'estdate', width: '8%',cellsformat:'dd.MM.yyyy' },
								  { text: 'Approval Status', datafield: 'approval', width: '7%' },
								  { text: 'Job No.', datafield: 'jobno', width: '7%' },
								  { text: 'Date', datafield: 'jdate', width: '8%',cellsformat:'dd.MM.yyyy' },
								  { text: 'User', datafield: 'user', width: '7%' },
								  { text: 'Status', datafield: 'jstatus', width: '7%' },
	              ]
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
              		{ 
          	  var rowindex1=event.args.rowindex;
              $('#gipnum').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'gateinpassdoc'));
              $('#jobdocno').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'jobno'));
              $('#estimno').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'estimationno'));
              
	              if($('#gipnum').val()!=""){
	  		    	$('#estimate').show();
	  		      }
              
              });	 
            
        });
 	
    </script>
    <div id="jqxFleetGrid"></div>


