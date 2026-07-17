<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.procurement.purchase.purchaseinvoicealice.*"%>
<% ClspurchaseinvoiceAliceDAO purchaseDAO = new ClspurchaseinvoiceAliceDAO(); %> 
<style>
#jobCardSearchInput{
	background-color:#fff;
	height: 20px;
}
</style>
<script type="text/javascript"> 
$(document).ready(function () {
	var jobcarddata='<%=purchaseDAO.searchJobCard()%>';
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'jobcarddocno', type: 'number'  },
            {name : 'jobcardvocno', type: 'number'  },
            {name : 'strjobcard', type: 'string'  }
		],
        localdata: jobcarddata,
	};
    var dataAdapter = new $.jqx.dataAdapter(source);
    // Create a jqxInput
	$("#jobCardSearchInput").jqxInput({ source: dataAdapter, displayMember: "strjobcard", valueMember: "jobcarddocno", width: 140, height: 20});
    $("#jobCardSearchInput").on('select', function (event) {
    	if(event.args) {
        	var item = event.args.item;
            if(item){
            	for(var i = 0; i < dataAdapter.records.length; i++){
                	if(item.value == dataAdapter.records[i].jobcarddocno) {
                    	$('#jobcarddocno').val(dataAdapter.records[i].jobcarddocno);
                    	$('#jobcardvocno').val(dataAdapter.records[i].jobcardvocno);
                        break;
                    }
                }
        	}
		}
	});
	
});
</script>
<input id="jobCardSearchInput" />
     