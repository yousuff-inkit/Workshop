<%@page import="com.dashboard.client.ClsClientDAO" %>
<%ClsClientDAO ccd=new ClsClientDAO(); %>

<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
 var temp='<%=check%>';
 
 var data;
 	if(temp=="load") {
	 	data = '<%=ccd.clientListGridLoading(check)%>';
     	var dataExcelExport='<%=ccd.clientListExcelExport(check)%>';
	}
 
        $(document).ready(function () { 
        	
        	var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'category', type: 'string' },
                    { name: 'cldocno', type: 'number' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'invc_method', type: 'string' },
                    { name: 'del_charges', type: 'string' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // initialize jqxGrid 
            $("#client").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                selectionmode: 'singlecell',
                groups: ['category','sal_name'],
                columns: [
          
                  { text: 'Category', groupable: true, datafield: 'category', width: '13%' },
                  { text: 'Name', groupable: true, datafield: 'refname', width: '20%' },
                  { text: 'Client Code', groupable: true, datafield: 'cldocno', width: '10%' },
                  { text: 'Mobile', groupable: true, datafield: 'per_mob', width: '10%' },
                  { text: 'Salesman', groupable: false, datafield: 'sal_name', width: '10%' },
                  { text: 'Address', groupable: false, datafield: 'address', width: '23%' },
                  { text: 'Email Id', groupable: false, datafield: 'mail1', width: '13%' },
                  { text: 'INV Method', groupable: false, datafield: 'invc_method', width: '6%' },
                  { text: 'Del. Charges', groupable: false, datafield: 'del_charges', width: '5%' },
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
    
            $("#overlay, #PleaseWait").hide();
				           
        
}); 
				                              
</script>

<div id="client"></div>