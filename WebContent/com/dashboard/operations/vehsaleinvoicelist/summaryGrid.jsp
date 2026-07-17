<%@page import="com.dashboard.operations.vehsaleinvoicelist.ClsVehSaleInvoiceListDAO"%>
<%ClsVehSaleInvoiceListDAO DAO= new ClsVehSaleInvoiceListDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
//     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
   %>
     <% String contextPath=request.getContextPath();%>
<script type="text/javascript">
      var data2;
      var summaryexceldata;
      var temp='<%=branchval%>';
     <%--  var temp1='<%=type%>'; --%>
      
	  	if(temp!='NA'){ 
	  		   data2='<%=DAO.summary(branchval, fromDate, toDate)%>';
	  		 summaryexceldata='<%=DAO.summaryexcel(branchval, fromDate, toDate)%>';
	  	}
	  	
  	
        $(document).ready(function () {
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no' , type: 'int' },
							{name : 'date' , type: 'date' },
							{name : 'client' , type:'string'},
							{name : 'desc' , type:'string'},
							{name : 'type' , type:'string'},
							{name : 'total' , type:'string'}
					      ],
                          localdata: data2,
               
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
            $("#summary").jqxGrid(
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
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no',  width: '10%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '12%' },
							{ text: 'Client',  datafield: 'client',  width: '20%' },
							
							{ text: 'Description',  datafield: 'desc',  width: '30%' },
							{ text: 'Type',  datafield: 'type',   width: '15%'  },
							{ text: 'Total', datafield:'total', width:'13%' },
							
						 ]
            });
            
            if(temp=='NA'){
                $("#summary").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
           

        });

</script>
<div id="summary"></div>
