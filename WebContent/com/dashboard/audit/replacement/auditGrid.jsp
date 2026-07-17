<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>

<%  String check=request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=ca.replacementAuditGridLoading(branchval,check)%>';  
	  	}
  	
        $(document).ready(function () {
        	
         	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'docno', type: 'int' },
					{ name: 'rep_branch', type: 'string' },
					{ name: 'in_branch', type: 'string' },
					{ name: 'rep_regno', type: 'int' },
					{ name: 'outregno', type: 'int' },
                    { name: 'outdate', type: 'date' },
                    { name: 'outtime', type: 'string' },
                    { name: 'outkm', type: 'int' },
                    { name: 'outfuel', type: 'string' },
                    { name: 'movement_type', type: 'string' },
                    { name: 'del_driver', type: 'string' },
                    { name: 'col_driver', type: 'string' },
                    { name: 'del_collection', type: 'string' },
                    { name: 'usedin', type: 'string' },
                    { name: 'in_branchid', type: 'int' }
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
						{ text: 'Doc No', datafield: 'docno', width: '6%' },
						{ text: 'Replacement Branch', datafield: 'rep_branch', width: '10%' },
						{ text: 'In Branch', datafield: 'in_branch', width: '10%' },
						{ text: 'Rep Reg No', datafield: 'rep_regno', width: '6%' },
						{ text: 'Out Reg No', datafield: 'outregno', width: '6%' },
						{ text: 'Out Date', datafield: 'outdate', cellsformat: 'dd.MM.yyyy' , width: '7%' },
	                    { text: 'Out Time', datafield: 'outtime', width: '6%' },
	                    { text: 'Out KM', datafield: 'outkm', width: '7%'},
	                    { text: 'Out Fuel', datafield: 'outfuel', width: '7%' },
	                    { text: 'Movement Type', datafield: 'movement_type', width: '10%' },
	                    { text: 'Delivery Driver', datafield: 'del_driver', width: '10%' },
	                    { text: 'Collection Driver', datafield: 'col_driver', width: '10%' },
	                    { text: 'Delivery Collection', datafield: 'del_collection', width: '10%' },
	                    { text: 'Used in(Days)', datafield: 'usedin', width: '9%' },
	                    { text: 'InBrhid', datafield: 'in_branchid', hidden: true,width: '9%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#audit").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#audit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("txtbranchid").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "in_branchid");
            });  

        });

</script>
<div id="audit"></div>
