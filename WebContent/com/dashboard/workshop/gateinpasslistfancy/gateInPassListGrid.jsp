<%@page import="com.dashboard.workshop.gateinpasslist.ClsGateInPassListDAO"%>
<%
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String todate = request.getParameter("tdt")==null?"0":request.getParameter("tdt").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String datetype =request.getParameter("datetype")==null?"0":request.getParameter("datetype");
String client =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String txttype =request.getParameter("txttype")==null?"0":request.getParameter("txttype").trim();
String load =request.getParameter("type")==null?"0":request.getParameter("type").trim();
String cmbcategory =request.getParameter("cmbcategory")==null?"0":request.getParameter("cmbcategory").trim();
ClsGateInPassListDAO DAO= new ClsGateInPassListDAO();
%>
 <script type="text/javascript">
 
 var data1=[];
 var exceldata=[];
 var chk='<%=check%>';
 	if(chk=="1"){ 
 		data1='<%=DAO.getdet(fromdate,todate,check,datetype,client,txttype,load,cmbcategory)%>';
 		<%-- exceldata='<%=DAO.getDataForFancyExcel(fromdate,todate,check,type,client)%>'; --%>
        }
 	else
 	{
 		
 		data1=[];
 		clientexceldata=[];
 	}
    
 	$(document).ready(function () { 
 		
 		var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
           }
    	
         var rendererstring1=function (aggregates){
            var value1=aggregates['sum1'];
            return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
           }
         
 		// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                        {name : 'srno', type: 'number'   },
                                        {name : 'doc_no', type: 'number'   },
                                        {name : 'voc_no', type: 'number'   },
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
                   						{name : 'clcat', type: 'string'    },
                   						{name : 'insurcmpny', type: 'string'    },
                   						{name : 'estimator', type: 'string'    },
                   						{name : 'srvadvsr', type: 'string'    },
                   						{name : 'inssrvor', type: 'string'    },
                   						{name : 'rfrby', type: 'string'    },
                   						{name : 'srvpkg', type: 'string'    },
                   						{name : 'outdate',type:'date'},
                   						{name : 'outtime',type:'string'},
                   						{name : 'invvocnoall',type:'string'},
                   						{name : 'mininvdate',type:'date'},
                   						{name : 'invtaxtotal',type:'number'},
                   						{name : 'delindate',type:'date'},
                   						{name : 'extdate',type:'date'},
                   						{name : 'promisedate',type:'date'},
                   						{name : 'sparetotal',type:'number'},
                   						{name : 'labourtotal',type:'number'},
                   						{name : 'esttotal',type:'number'},
                   						{name : 'estall',type:'string'},
                   						{name : 'estdate',type:'date'},
                   						{name : 'yom',type:'string'},
                   						{name : 'color',type:'string'},
                   						{name : 'jobvocno',type:'number'},
										{name : 'jobcompletedate',type:'date'},
										{name : 'estclaimno',type:'string'}
                   						
                 ],
                 localdata: data1,
                
                
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
                showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25, 
             	enabletooltips:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                          
                              { text: 'SrNo', datafield: 'srno', width: '5%' },
				        	  { text: 'Docno', datafield: 'doc_no', width: '5%',hidden:true },
							  { text: 'GIP DocNo', datafield: 'voc_no', width: '5%' }, 
							  { text: 'gateinpassdoc', datafield: 'gateinpassdoc', width: '8%' , hidden:true}, 
							  { text: 'GIP Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Time',datafield:'time',width:'5%',cellsformat:'HH:mm'},
							  { text: 'Repair Type', datafield: 'reptype', width: '8%' }, 
							  { text: 'Customer Name', datafield: 'customer', width: '12%' },  
							  { text: 'Client Category', datafield: 'clcat', width: '12%' },  
								 { text: 'Insurance Company', datafield: 'insurcmpny', width: '12%' },  
							  { text: 'Reg No', datafield: 'regno', width: '5%' },
								{ text: 'P.code', datafield: 'pcode', width: '4%' },
								{ text: 'Brand', datafield: 'brand', width: '8%' },
								{ text: 'Model', datafield: 'model', width: '8%' },
								{ text: 'Color', datafield: 'color', width: '6%' },
								{ text: 'Yom', datafield: 'yom', width: '6%' },
								{ text: 'Est Date', datafield: 'estdate', width: '8%',cellsformat:'dd.MM.yyyy'},
								{ text: 'Est Doc No (Additions)', datafield: 'estall', width: '8%' },
								{ text: 'Est Total', datafield: 'esttotal', width: '8%' ,cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
								{ text: 'Est Spare Total', datafield: 'sparetotal', width: '8%' ,cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
								{ text: 'Est Labour Total', datafield: 'labourtotal', width: '8%' ,cellsalign:'right',align:'right',cellsformat:'d2',hidden:true,aggregates: ['sum'],aggregatesrenderer:rendererstring},
								{ text: 'Claim #', datafield: 'estclaimno', width: '9%' },
								{ text: 'Job Date', datafield: 'jdate', width: '8%',cellsformat:'dd.MM.yyyy'},
								{ text: 'Job Doc No', datafield: 'jobvocno', width: '8%' },
								{ text: 'Promise Date', datafield: 'promisedate', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								{ text: 'Ext.Date', datafield: 'extdate', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								{ text: 'Ready for Del.', datafield: 'delindate', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								{ text: 'Job Complete', datafield: 'jstatus', width: '7%'},
								{ text: 'Job Complete Date', datafield: 'jobcompletedate', width: '7%',cellsformat:'dd.MM.yyyy'},
								{ text: 'Inv Doc No', datafield: 'invvocnoall', width: '8%' },
								{ text: 'Inv Date', datafield: 'mininvdate', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								{ text: 'Inv Amount', datafield: 'invtaxtotal', width: '8%' ,cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
								{ text: 'GOP Date', datafield: 'outdate', width: '8%',cellsformat:'dd.MM.yyyy' },
								{ text: 'GOP Time', datafield: 'outtime', width: '7%'},
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
								  { text: 'Approval Status', datafield: 'approval', width: '7%',hidden:true },
								  { text: 'Job No.', datafield: 'jobno', width: '7%',hidden:true},
								  { text: 'User', datafield: 'user', width: '7%',hidden:true },
								  
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


