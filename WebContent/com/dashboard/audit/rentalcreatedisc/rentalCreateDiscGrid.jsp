<%String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<%@page import="com.dashboard.audit.rentalcreatedisc.*" %>
<%ClsRentalCreateDiscDAO rentaldao=new ClsRentalCreateDiscDAO();%>
<script type="text/javascript">
      var radata;
      var temp='<%=branchval%>';
      var id='<%=id%>';
      if(id=='1'){
    	  radata='<%=rentaldao.getRentalAgmtAudit(branchval,id)%>';
      }
	  		
	  	
  	
        $(document).ready(function () {
        	
        	$("#btnExcel").click(function() {
    			$("#rentalCreateDiscGrid").jqxGrid('exportdata', 'xls', 'Rental Create Audit');
    		});
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'doc_no', type: 'int' },
					{ name: 'vocno', type: 'int' },
					{ name: 'brhid', type: 'string' },
					{ name: 'refname', type: 'string' },
					{ name: 'vehicle', type: 'string' },
                    { name: 'rentaltype', type: 'string' },
                    { name: 'total', type: 'number' },
                    { name: 'discount', type: 'number' },
                    { name: 'prcent', type: 'string' },
                
	            ],
                localdata: radata,
               
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
            $("#rentalCreateDiscGrid").jqxGrid(
            {
                width: '98%',
                height: 465,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                //Add row method
                columns: [
                          
						{ text: 'SL#', sortable: false, filterable: false, editable: false, 
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '4%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						  },
						{ text: 'Agreement No', datafield: 'vocno', width: '7%' },
						{ text: 'Client Name', datafield: 'refname', width: '27%' },
						{ text: 'Vehicle', datafield: 'vehicle', width: '23%' },
	                    { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
	                    { text: 'Sum Of Total', datafield: 'total', cellsformat: 'd2' , width: '11%',cellsalign: 'right', align:'right' },
	                    { text: 'Sum Of Discount', datafield: 'discount', cellsformat: 'd2' , width: '11%' ,cellsalign: 'right', align:'right'},
	                    { text: 'Percentage', datafield: 'prcent',  width: '10%',cellsalign: 'center', align:'center' },
	                    { text: 'Branch Id', hidden: true, datafield: 'brhid', width: '15%' },
	                    { text: 'docno',  datafield: 'doc_no', width: '15%',hidden:true }
					 ]
            });
     	   $("#overlay, #PleaseWait").hide();
            if(temp=='NA'){
                $("#rentalCreateDiscGrid").jqxGrid("addrow", null, {});
            }
            
            $('#rentalCreateDiscGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#rentalCreateDiscGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtdocnoss").value = $('#rentalCreateDiscGrid').jqxGrid('getcellvalue', rowindex1, "vocno");
                document.getElementById("txtbranchid").value = $('#rentalCreateDiscGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
            }); 

        });

</script>
<div id="rentalCreateDiscGrid"></div>
