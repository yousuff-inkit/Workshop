<%@page import="com.dashboard.trafficfine.trafficstatus.ClsTrafficdetailsDAO" %>
<%ClsTrafficdetailsDAO ctd=new ClsTrafficdetailsDAO(); %>
	
<%
 String relodestatus = request.getParameter("relodestatus")==null?"NN":request.getParameter("relodestatus").trim();
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
String ticketno = request.getParameter("ticketno")==null?"":request.getParameter("ticketno").trim();
%>
 <script type="text/javascript">
 
 var data1,dataexcel;
 var temp='<%=relodestatus%>';
 
 	if(temp!='NN'){ 
 		data1='<%=ctd.masterdetails(relodestatus,fromdate,todate,ticketno)%>';
    	dataexcel='<%=ctd.masterdetailsExcel(relodestatus,fromdate,todate,ticketno)%>';
 	}
 	else
 	{
 		data1;
 	}
    
 	$(document).ready(function () { 
 		
 		var rendererstring=function (aggregates){
 	     	var value=aggregates['sum'];
 	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
 		}

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                       
                                        	
                   						{name : 'regno', type: 'string'  },
                   						{name : 'fleetno', type: 'string'    },
                   						{name : 'source', type: 'string'    },
                   						{name : 'ticket_no', type: 'string'    },
                   						{name : 'traffic_date', type: 'date'    },
										{name : 'postdate', type: 'date'    },
                   						{name : 'receiptno', type: 'string'    },
                   						{name : 'receiptdate', type: 'date'    },
								
										{name : 'time', type: 'string'    },
                   						{name : 'location', type: 'string'    },
                   						{name : 'amount', type: 'string'    },
                   						{name : 'invno', type: 'string'    },
                   						{name : 'invtype', type: 'string'    },
                   						{name : 'rano', type: 'string'    },
                   						{name : 'dtypedesc', type: 'string'    },
										{name : 'code_name',type:'string'},
										{name : 'tcno',type:'string'},
										{name : 'ch_no',type:'string'},
										{name : 'refname', type: 'string'    },
										{name : 'trafficsrvc',type:'number'},
                   						{name : 'postdocno', type: 'string'    },
                   						{name : 'out_amount', type: 'number'    },
                   						{name : 'fine_source', type: 'string'    },
                   						
                   						
                   						
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
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
                
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
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
								{ text: 'Post DocNo', datafield: 'postdocno', width: '8%' },  
								{ text: 'Post Date', datafield: 'postdate', width: '8%',cellsformat:'dd.MM.yyyy' }, 
								{ text: 'Inv No', datafield: 'invno', width: '8%' },
								{ text: 'Inv Type', datafield: 'invtype', width: '6%' },
								{ text: 'RA No', datafield: 'rano', width: '8%' },
								{ text: 'Type', datafield: 'dtypedesc', width: '12%' },
								{ text: 'Client/Employee', datafield: 'refname', width: '12%' },
							    { text: 'Reg No', datafield: 'regno', width: '7%' },
								{ text: 'Ticket No.', datafield: 'ticket_no', width: '14%' },
								{ text: 'TC No',datafield:'tcno',width:'10%'},
								{ text: 'Fleet No', datafield: 'fleetno', width: '8%' },
								{ text: 'Plate Code',datafield:'code_name',width:'7%'},
								{ text: 'Chassis No',datafield:'ch_no',width:'12%'},
								{ text: 'Traffic Date', datafield: 'traffic_date', width: '7%',cellsformat:'dd.MM.yyyy' },
								{ text: 'Traffic Time', datafield: 'time', width: '7%' },
								{ text: 'Location', datafield: 'location', width: '12%' },
								{ text: 'Source', datafield: 'source', width: '16%' },
								{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' , aggregates: ['sum'],aggregatesrenderer:rendererstring },
								{ text: 'Service Charge', datafield: 'trafficsrvc', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
								{ text: 'Reciept Number', datafield: 'receiptno', width: '12%',cellsformat: 'd2',cellsalign: 'right', align:'right'  },
								{ text: 'Receipt Date', datafield: 'receiptdate', width: '12%',cellsformat:'dd.MM.yyyy' },
								{ text: 'Received Amount', datafield: 'out_amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
								{ text: 'Fine Source', datafield: 'fine_source', width: '15%' },
								
							/*   regno, fleetno source ticket_no traffic_date traffic_date amount
							  { text: 'Reg No.', datafield: 'regno', width: '12%' },
								{ text: 'Fleet No.', datafield: 'fleetno', width: '12%' },
								{ text: 'Fine Source', datafield: 'source', width: '26%' },
								{ text: 'Ticket No.', datafield: 'ticket_no', width: '15%' },
								{ text: 'Date', datafield: 'traffic_date', width: '12%',cellsformat:'dd.mm.yyyy' },
								{ text: 'Time', datafield: 'time', width: '8%' },
								{ text: 'Amount', datafield: 'amount', width: '15%',cellsformat:'d2' }, */
														
	              ]
            });
            $("#overlay, #PleaseWait").hide();
        	if(temp=="ANI")  //not invo
    		{
        		
     		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invno');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invtype');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdate');
    		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
    		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');
    		   
    		}
        	else if(temp=="AIN")  //not invo>0
        		{
        		
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invno');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invtype');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
        		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
        		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdate');
        		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');
        		}
        	else if(temp=="RES")
        		{
        		
        		  $('#jqxFleetGrid').jqxGrid('showcolumn', 'invno');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invtype');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
       		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
       		$('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdate');
       		$('#jqxFleetGrid').jqxGrid('showcolumn', 'out_amount');
        		}
        	
        	else if(temp=="POS")
    		{
    		
 		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invno');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invtype');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'postdocno');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'postdate');
		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');
    		}
        	
        	else
        		{
        	   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invno');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invtype');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'rano');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'dtypedesc');
      		// $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
      		// $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdate');
      		// $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');

			$('#jqxFleetGrid').jqxGrid('hidecolumn', 'refname');
		
        		}
            
            
            if(temp=='NN'){
                $("#jqxFleetGrid").jqxGrid("addrow", null, {});
            }
        });
    </script>
    <div id="jqxFleetGrid"></div>


