<%@page import="com.operations.saleofvehicle.vehiclestockcheck.ClsVehicleStockCheckDAO" %>
<%ClsVehicleStockCheckDAO vsd=new ClsVehicleStockCheckDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String username = request.getParameter("username")==null?"0":request.getParameter("username");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
%> 

 <script type="text/javascript">
 
 			var data1='<%=vsd.vstcMainSearch(session, username, docNo, date)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            
     						{name : 'date', type: 'date'  },
     						{name : 'doc_no', type: 'int' },
     						{name : 'user_name', type: 'String' },
     						{name : 'readytorent', type: 'int' },
     						{name : 'unrentable', type: 'int' },
     						{name : 'total', type: 'int' },
     						{name : 'remarks', type: 'String' }
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxVehicleStockMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '25%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'User Name', datafield: 'user_name', width: '55%' },
					 { text: 'Ready to Rent', datafield: 'readytorent', hidden: true, width: '10%' },
					 { text: 'Un Rentable', datafield: 'unrentable', hidden: true, width: '10%' },
					 { text: 'Total', datafield: 'total', hidden: true, width: '10%' },
					 { text: 'Remarks', datafield: 'remarks', hidden: true, width: '10%' },
					]
            });
            
			  $('#jqxVehicleStockMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                $("#jqxStockCheckDate").jqxDateTimeInput('val', $("#jqxVehicleStockMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("docno").value= $('#jqxVehicleStockMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtreadytorent").value= $('#jqxVehicleStockMainSearch').jqxGrid('getcellvalue', rowindex1, "readytorent");
                document.getElementById("txtunrentable").value= $('#jqxVehicleStockMainSearch').jqxGrid('getcellvalue', rowindex1, "unrentable");
                document.getElementById("txttotal").value= $('#jqxVehicleStockMainSearch').jqxGrid('getcellvalue', rowindex1, "total");
                document.getElementById("txtremarks").value= $('#jqxVehicleStockMainSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
                var brch=document.getElementById("brchName").value;
                var indexVal = document.getElementById("docno").value;
	   			if(indexVal>0){
	   	         $("#vehicleStockCheckDiv").load("vehicleStockCheckGrid.jsp?txtvehstockcheckdocno2="+indexVal+'&branch='+brch);
	   			}
               $('#window').jqxWindow('close');
            });   
}); 
				       
                       
    </script>
    <div id="jqxVehicleStockMainSearch"></div>
    