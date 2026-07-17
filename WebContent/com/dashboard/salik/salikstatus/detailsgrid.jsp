<%@page import="com.dashboard.salik.salikdetails.ClsSalikdetailsDAO"%> 
 <%
        
 ClsSalikdetailsDAO showDAO = new  ClsSalikdetailsDAO();
 String relodestatus = request.getParameter("relodestatus")==null?"NN":request.getParameter("relodestatus").trim();
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
	String chkincrecv = request.getParameter("chkincrecv")==null?"0":request.getParameter("chkincrecv").trim();
	 
%>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=relodestatus%>';
 
 	if(temp!='NN'){ 
 		
 		data1='<%=showDAO.masterdetails(relodestatus,fromdate,todate,chkincrecv)%>';
        }
 	else
 	{
 		data1;
 	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },

						{name : 'salik_date', type: 'date'    },
       						
       						{name : 'salik_time', type: 'string'    },

     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'amount', type: 'string'    },
     						
     						
    						{name : 'invno', type: 'string'    },
       						{name : 'invtype', type: 'string'    },
       						{name : 'rano', type: 'string'    },
       						{name : 'dtypedesc', type: 'string'    },
				
						{name : 'refname', type: 'string'    },
       					  
       						{name : 'out_amount', type: 'number'    },
						{name : 'trans', type: 'number'    },
     						
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
                height: 500,
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
							  
							  
							  { text: 'Inv No', datafield: 'invno', width: '8%' },
								{ text: 'Inv Type', datafield: 'invtype', width: '6%' },
								  { text: 'RA No', datafield: 'rano', width: '8%' },
									{ text: 'Type', datafield: 'dtypedesc', width: '12%' },
							  
									{ text: 'Client/Employee', datafield: 'refname', width: '12%' },

							{ text: 'Reg No.', datafield: 'regno', width: '10%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
							{ text: 'Transaction No.', datafield: 'trans', width: '11%' },

							{ text: 'Salik Date', datafield: 'salik_date', width: '12%',cellsformat:'dd.MM.yyyy' },
							
							{ text: 'Salik Time', datafield: 'salik_time', width: '10%' },

							{ text: 'Location', datafield: 'location', width: '15%' },
							{ text: 'Direction', datafield: 'direction', width: '15%' },
							{ text: 'Source', datafield: 'source', width: '20%' },
							{ text: 'Tag No.', datafield: 'tagno', width: '14%' },
							{ text: 'Amount', datafield: 'amount', width: '13%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Received Amount', datafield: 'out_amount', width: '13%',cellsformat: 'd2',cellsalign: 'right', align:'right' },							
	              ]
            });
            $("#overlay, #PleaseWait").hide();
        	if(temp=="ANI")  //not invo
    		{
        		
     		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invno');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invtype');
    		 //  $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
    		   
    		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
    		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
    		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');

		 $('#jqxFleetGrid').jqxGrid('hidecolumn', 'refname');
    		   
    		}
        	else if(temp=="AIN")  //not invo>0
        		{
        		
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invno');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invtype');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
        		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
        		  // $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
        		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');
        		}
        	else if(temp=="RES")
        		{
        		
        		  $('#jqxFleetGrid').jqxGrid('showcolumn', 'invno');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'invtype');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'rano');
       		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'dtypedesc');
       		 //  $('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
       		$('#jqxFleetGrid').jqxGrid('showcolumn', 'out_amount');
        		}
        	
    
        	else
        		{
        	   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invno');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'invtype');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'rano');
      		   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'dtypedesc');
      		   //$('#jqxFleetGrid').jqxGrid('hidecolumn', 'postdocno');
      		 $('#jqxFleetGrid').jqxGrid('hidecolumn', 'out_amount');
		
		$('#jqxFleetGrid').jqxGrid('hidecolumn', 'refname');
			
        		}
             
            if(temp=='NN'){
                $("#jqxFleetGrid").jqxGrid("addrow", null, {});
            }
        });
    </script>
    <div id="jqxFleetGrid"></div>


