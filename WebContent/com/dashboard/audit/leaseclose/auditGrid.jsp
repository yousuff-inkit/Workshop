<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>

<%  String check=request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var lacolse;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		lacolse='<%=ca.leasecloseaudit(branchval,check)%>';  
	  	}
  	
        $(document).ready(function () {
        	
             	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'doc_no', type: 'int' },
					{ name: 'lano', type: 'int' },
					{ name: 'branchid', type: 'string' },
					{ name: 'client', type: 'string' },
					{ name: 'vehicle', type: 'string' },
                    { name: 'total', type: 'number' },
                    { name: 'discount', type: 'number' },
                    { name: 'percent', type: 'string' },
                
	            ],
                localdata: lacolse,
               
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
            $("#lacloseaudit").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                //Add row method
                columns: [
                      	{ text: 'SL#', sortable: false, filterable: false, editable: false, 
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '4%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						  },
						{ text: 'Agreement No', datafield: 'lano', width: '8%' },
						{ text: 'Client Name', datafield: 'client', width: '28%' },
						{ text: 'Vehicle', datafield: 'vehicle', width: '25%' },
	                    { text: 'Sum Of Total', datafield: 'total', cellsformat: 'd2' , width: '12%',cellsalign: 'right', align:'right' },
	                    { text: 'Sum Of Discount', datafield: 'discount', cellsformat: 'd2' , width: '12%' ,cellsalign: 'right', align:'right'},
	                    { text: 'Percentage', datafield: 'percent',  width: '11%',cellsalign: 'center', align:'center' },
	                    { text: 'Branch Id', hidden: true, datafield: 'branchid', width: '15%' },
	                    { text: 'docno',  datafield: 'doc_no', width: '15%',hidden:true }
					 ]
            });
            $("#overlay, #PleaseWait").hide();
            if(temp=='NA'){
                $("#lacloseaudit").jqxGrid("addrow", null, {});
            }
            
            $('#lacloseaudit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#lacloseaudit').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtdocnoss").value = $('#lacloseaudit').jqxGrid('getcellvalue', rowindex1, "lano");
                document.getElementById("txtbranchid").value = $('#lacloseaudit').jqxGrid('getcellvalue', rowindex1, "branchid");
            }); 

        });

</script>
<div id="lacloseaudit"></div>
