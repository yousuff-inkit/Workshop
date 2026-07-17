<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>
<%  String check=request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=ca.refundAuditGridLoading(branchval,check)%>';  
	  	}
	  	
        $(document).ready(function () {
        	
          	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'receipt_no', type: 'int' },
					{ name: 'doctype', type: 'string' },
					{ name: 'docno', type: 'int' },
                    { name: 'agreement', type: 'string' },
                    { name: 'client', type: 'string' },
                    { name: 'paid_as', type: 'string' },
                    { name: 'netamount', type: 'number' },
                    { name: 'branchid', type: 'int' }
	            ],
                localdata: data1,
               
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
            $("#audit").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Receipt No', datafield: 'receipt_no', width: '7%' },
						{ text: 'Doc Type', datafield: 'doctype', width: '10%' },
						{ text: 'Doc No', datafield: 'docno', width: '10%' },
	                    { text: 'Agreement', datafield: 'agreement', width: '10%' },
	                    { text: 'Client Name', datafield: 'client', width: '38%' },
	                    { text: 'Paid As', datafield: 'paid_as', width: '10%' },
	                    { text: 'Net Amount', datafield: 'netamount', cellsformat: 'd2', width: '15%',  cellsalign: 'right', align: 'right' },
	                    { text: 'Branch Id', hidden: true, datafield: 'branchid', width: '15%' }
					 ]
            });
            
            if(temp=='NA'){
                $("#audit").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#audit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("txtsrno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "receipt_no");
                document.getElementById("txtbranchid").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "branchid");
            });  

        });

</script>
<div id="audit"></div>
