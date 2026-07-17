<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>

<%  String check=request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){  
	  		   data1='<%=ca.rentalCanceledAuditGridLoading(branchval,check)%>';  
	  	}
  	
        $(document).ready(function () {
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'rano', type: 'int' },
					{ name: 'client', type: 'string' },
					{ name: 'vehicle', type: 'string' },
                    { name: 'rentaltype', type: 'string' },
                    { name: 'outdate', type: 'date' },
                    { name: 'outtime', type: 'string' },
                    { name: 'advance', type: 'string' },
                    { name: 'invoice', type: 'string' },
                    { name: 'doc_no', type: 'int' },
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
						{ text: 'Agreement No', datafield: 'rano', width: '7%' },
						{ text: 'Client Name', datafield: 'client', width: '30%' },
						{ text: 'Vehicle', datafield: 'vehicle', width: '25%' },
	                    { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
	                    { text: 'Out Date', datafield: 'outdate', cellsformat: 'dd.MM.yyyy' , width: '7%' },
	                    { text: 'Out Time', datafield: 'outtime', width: '7%' },
	                    { text: 'Advance', datafield: 'advance', width: '7%'},
	                    { text: 'Invoice', datafield: 'invoice', width: '10%' },
	                    { text: 'Agreement Doc No', hidden: true, datafield: 'doc_no', width: '7%' },
	                    { text: 'Branch Id', hidden: true, datafield: 'branchid', width: '15%' }
					 ]
            });
            
            if(temp=='NA'){
                $("#audit").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#audit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtvocno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "rano");
                document.getElementById("txtdocno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtbranchid").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "branchid");
            });  

        });

</script>
<div id="audit"></div>
