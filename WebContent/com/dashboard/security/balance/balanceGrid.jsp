<%@page import="com.dashboard.security.ClsSecurity"%>
<%ClsSecurity DAO= new ClsSecurity(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String clientAccount = request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount").trim();
     String agreementType = request.getParameter("agreementtype")==null?"OPEN":request.getParameter("agreementtype").trim();%>  

<script type="text/javascript">
        
		var data;
		var temp='<%=branchval%>';
		
			if(temp!='NA'){
			   data='<%=DAO.balanceGridLoading(branchval, upToDate, clientAccount,agreementType)%>'; 
			}
			
        $(document).ready(function () { 
        	
        	/*$("#btnExcel").click(function() {
    			$("#jqxBalance").jqxGrid('exportdata', 'xls', 'SecurityBalance');
    		});*/
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'clientname', type: 'string'   },
							{name : 'mobile', type: 'string'  },
     						{name : 'aggvocno', type: 'string'   },
     						{name : 'radate', type: 'date'  },
     						{name : 'closedate', type: 'date' },
     						{name : 'securityreceived', type: 'number' },
     						{name : 'securitypaid', type: 'number' }, 
     						{name : 'balance', type: 'number'   }
                        ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxBalance").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Client Name',  datafield: 'clientname', width: '32%' },
							{ text: 'Mobile',  datafield: 'mobile', width: '8%' },
							{ text: 'Agreement', datafield: 'aggvocno',  width: '10%' },
							{ text: 'Agreement Date', datafield: 'radate', width: '10%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Close Date', datafield: 'closedate', width: '10%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Security Received', datafield: 'securityreceived',  width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Security Paid', datafield: 'securitypaid', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right' }, 
							{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						]
            });
           
            if(temp=='NA'){
                $("#jqxBalance").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
			
			var netamount1="";
            var netamount=$('#jqxBalance').jqxGrid('getcolumnaggregateddata', 'balance', ['sum'], true);
            netamount1=netamount.sum;
            if(!isNaN(netamount1)){
      		    funRoundAmt(netamount1,"txtnetamount");
      		  }
      		else{
		    	 $('#txtnetamount').val(0.00);
		    }
});
</script>
<div id="jqxBalance"></div>
 