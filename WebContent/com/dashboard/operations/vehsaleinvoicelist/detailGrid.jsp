<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="com.dashboard.operations.vehsaleinvoicelist.ClsVehSaleInvoiceListDAO"%>
<%ClsVehSaleInvoiceListDAO DAO= new ClsVehSaleInvoiceListDAO(); %>
<%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

%>
<script type="text/javascript">

var temp='<%=branchval%>';
if(temp!='NA'){ 
	var datafleet='<%=DAO.detail(branchval, fromDate, toDate)%>';
	var detailexceldata='<%=DAO.detailexcel(branchval, fromDate, toDate)%>';

	} 
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
						{name : 'doc_no' , type: 'String' },
						{name : 'client', type: 'String'  },
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no',type:'string'},
     						{name : 'salesprice',type:'number'},
     						{name : 'dep_posted',type:'date'},
     						{name : 'pur_value',type:'number'},
     						{name : 'acc_dep',type:'number'},
     						{name : 'cur_dep',type:'number'},
     						{name : 'netbook',type:'number'},
     						{name : 'net_pl',type:'number'}
     						
     					
                 ],
                localdata: datafleet,
                //url: url,
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
            $("#detailGrid").jqxGrid(
            {
            	 width: '98%',
                 height: 550,
                 source: dataAdapter,
                 rowsheight:25,
                 filtermode:'excel',
                 filterable: true,
                 sortable: true,
                 selectionmode: 'singlerow',
                 editable: false,
                localization: {thousandsSeparator: ""},
                //Add row method
                      
                columns: [
					{ text: 'Doc No', datafield: 'doc_no',editable:false, width: '5%'},
					{ text: 'Client', datafield: 'client',editable:false, width: '14%'},
								{ text: 'Fleet', datafield: 'fleet_no',editable:false, width: '6%'},
							{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '14%'},
							{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '6%'},
							{ text: 'Sales Price', datafield: 'salesprice', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Dep Posted', datafield: 'dep_posted', width: '8%',editable:false ,cellsformat:'dd.MM.yyyy',cellsalign:'right',align:'right'},
							{ text: 'Purchase Value', datafield: 'pur_value', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Acc.Dep', datafield: 'acc_dep', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Current Dep',datafield:'cur_dep', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net Book',datafield:'netbook', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net P /(L)',  datafield:'net_pl',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'}
							
							]
            });
            if(temp=='NA'){
                $("#detailGrid").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
           
           
        });
    </script>
    <div id="detailGrid"></div>
