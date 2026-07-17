<%@page import="com.dashboard.workshop.gipupdate.*"%>
<%
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String todate = request.getParameter("tdt")==null?"0":request.getParameter("tdt").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String type =request.getParameter("ldtype")==null?"0":request.getParameter("ldtype");
String client =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
ClsGIPUpdateDAO DAO= new ClsGIPUpdateDAO();
%>
<script type="text/javascript">
 
var data=[];
var chk='<%=check%>';
if(chk!='0'){ 
	data='<%=DAO.masterdetails(fromdate,todate,check,type,client)%>';
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
                   						{name : 'insurcmpny', type: 'string'    },
                   						{name : 'estimator', type: 'string'    },
                   						{name : 'srvadvsr', type: 'string'    },
                   						{name : 'inssrvor', type: 'string'    },
                   						{name : 'rfrby', type: 'string'    },
                   						{name : 'srvpkg', type: 'string'    },
                   						{name : 'estvocno', type: 'number'    },
                   						{name : 'estdocno', type: 'number'    },
                   						{name : 'jobvocno', type: 'number'    },
                   						{name : 'jobdocno', type: 'number'    },
                   						{name : 'voc_no',type:'number'},
                   						{name : 'kmin',type:'number'}
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
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
                columnsresize: true,
                showaggregates:true,
                enabletooltips:true,
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
							  { text: 'GIP #', datafield: 'doc_no', width: '5%',hidden:true },
							  { text: 'GIP #', datafield: 'voc_no', width: '5%'}, 
							  { text: 'Est.#', datafield: 'estvocno', width: '5%' }, 
							  { text: 'Est.#', datafield: 'estdocno', width: '5%',hidden:true }, 
							  { text: 'Job Card #', datafield: 'jobvocno', width: '5%' },
							  { text: 'Job Card #', datafield: 'jobdocno', width: '5%',hidden:true },  
							  { text: 'gateinpassdoc', datafield: 'gateinpassdoc', width: '8%' , hidden:true}, 
							  { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Time',datafield:'time',width:'5%',cellsformat:'HH:mm'},
							  { text: 'Repair Type', datafield: 'reptype', width: '8%' }, 
							  { text: 'Customer Name', datafield: 'customer', width: '12%' },  
							  { text: 'Insurance Company', datafield: 'insurcmpny', width: '12%' },  
							  { text: 'Reg No', datafield: 'regno', width: '5%' },
								{ text: 'P.code', datafield: 'pcode', width: '4%' },
								{ text: 'Brand', datafield: 'brand', width: '8%' },
								{ text: 'Model', datafield: 'model', width: '8%' },
								  { text: 'Days-GIPdate', datafield: 'gipdate', width: '5%' },
								  { text: 'Exp.delivery', datafield: 'expdelivery', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								  { text: 'Time', datafield: 'dtime',width:'6%',cellsformat:'HH:mm'},
								  { text: 'Description', datafield: 'description', width: '8%' },
								  { text: 'Vehicle user', datafield: 'username', width: '6%' },
								  { text: 'Mobile No', datafield: 'mobile', width: '8%' },
								  { text: 'GIP User', datafield: 'gipuser', width: '6%' },
								  { text: 'Estimated By', datafield: 'estimtdby', width: '7%' },
								  { text: 'Estimator', datafield: 'estimator', width: '7%' },
								  { text: 'Service Advisor', datafield: 'srvadvsr', width: '7%' },
								  { text: 'Insurance Survivor', datafield: 'inssrvor', width: '7%' },
								  { text: 'Referenced By', datafield: 'rfrby', width: '7%' },
								  { text: 'Service Package', datafield: 'srvpkg', width: '7%' },
								  { text: 'Estimation No.', datafield: 'estimationno', width: '7%',hidden:true},
								  { text: 'Date', datafield: 'estdate', width: '8%',cellsformat:'dd.MM.yyyy',hidden:true },
								  { text: 'Approval Status', datafield: 'approval', width: '7%',hidden:true },
								  { text: 'Job No.', datafield: 'jobno', width: '7%',hidden:true},
								  { text: 'Date', datafield: 'jdate', width: '8%',cellsformat:'dd.MM.yyyy',hidden:true },
								  { text: 'User', datafield: 'user', width: '7%',hidden:true },
								  { text: 'Status', datafield: 'jstatus', width: '7%',hidden:true },
								  { text: 'Kmin', datafield: 'kmin', width: '7%',hidden:true }
	              ]
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
              		{ 
          	  var rowindex1=event.args.rowindex;
              $('#gipdocno').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
              $('#gipvocno').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'voc_no'));
              $('#lblgip').text('GIP #'+$('#gipvocno').val());
              $('#estkm').val($('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'kmin'));
              $('#estdate').jqxDateTimeInput('val',$('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'expdelivery'));
              $('#esttime').jqxDateTimeInput('val',$('#jqxFleetGrid').jqxGrid('getcellvalue',rowindex1,'dtime'));
           	});	 
            
        });
 	
    </script>
    <div id="jqxFleetGrid"></div>


