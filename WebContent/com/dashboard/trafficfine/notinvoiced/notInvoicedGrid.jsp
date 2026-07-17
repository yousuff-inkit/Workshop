<%@page import="com.dashboard.trafficfine.*" %>
 <%String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentalType = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 ClsTrafficfineDAO trafficdao=new ClsTrafficfineDAO();
 %>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 
 
 	if(temp!='0'){ 
 		data1='<%=trafficdao.notInvoicedGridLoading(branchval,fromDate, toDate, cldocno, rentalType, agmtNo)%>';
    }

        $(document).ready(function () { 	
    
        	$("#btnExcel").click(function() {
    			$("#jqxNotInvoiced").jqxGrid('exportdata', 'xls', 'Traffic-Fine-ToBeInvoiced');
    		});            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'ticket_no', type: 'string'    },
     						{name : 'amount', type: 'string'    },
     						{name : 'traffic_date',type:'date'},
     						{name : 'ra_no',type:'string'},
     						{name : 'rtype',type:'string'},
     						{name : 'vocno',type:'string'}
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
             $("#jqxNotInvoiced").on("bindingcomplete", function (event) {
					$("#overlay, #PleaseWait").hide();
    	
				});
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxNotInvoiced").jqxGrid(
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
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
						{ text: 'Original Agmt No.', datafield: 'ra_no', width: '7%',hidden:true },
						{ text: 'Agmt No.', datafield: 'vocno', width: '7%' },
						{ text: 'Agmt Type.', datafield: 'rtype', width: '7%' },
						{ text: 'Reg No.', datafield: 'regno', width: '8%' },
						{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
						{ text: 'Traffic Date', datafield: 'traffic_date', width: '8%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Location', datafield: 'location', width: '20%' },
						{ text: 'Source', datafield: 'source', width: '15%' },
						{ text: 'Ticket No.', datafield: 'ticket_no', width: '10%' },
						{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxNotInvoiced").jqxGrid("addrow", null, {});
            }
        });
</script>
<div id="jqxNotInvoiced"></div>
