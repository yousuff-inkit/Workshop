<%@page import="com.dashboard.security.ClsSecurity" %>
<%ClsSecurity cs=new ClsSecurity();%>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	 String agreementClosedDays = (request.getParameter("agreementcloseddays")==null || request.getParameter("agreementcloseddays").trim().equalsIgnoreCase(""))?"0":request.getParameter("agreementcloseddays").trim();
     String clientAccount = request.getParameter("clientAccount")==null?"0":request.getParameter("clientAccount").trim();%>  
     
<style type="text/css">
	   .securityClass
	  {
	      background-color: #F1F8E0;
	  }
	  .balanceClass
	  {
	      background-color: #FBEFF5;
	  }
	  .netValueClass
	  {
	      background-color: #E0F8F1;
	  }
</style>

<script type="text/javascript">
        
		var data;
		var temp='<%=branchval%>';
		
			if(temp!='NA'){
			   data='<%=cs.refundable(branchval, upToDate, agreementClosedDays, clientAccount)%>'; 
			}
			
        $(document).ready(function () { 
        	
        	/*$("#btnExcel").click(function() {
    			$("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
    		});*/
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'clientname', type: 'string'   },
							{name : 'mobile', type: 'string'  },
     						{name : 'rano', type: 'int'   },
     						{name : 'aggvocno', type: 'String'   },
     						{name : 'radate', type: 'date'  },
     						{name : 'closedate', type: 'date' },
     						{name : 'securityamount', type: 'number' },
     						{name : 'invoiceamount', type: 'number' },
     						{name : 'receiptamount', type: 'number' },
     						{name : 'creditnoteamount', type: 'number' },
     						{name : 'balance', type: 'number'   },
     						{name : 'netvalue', type: 'number'   },
     						{name : 'rtype', type: 'string'  },
     						{name : 'cldocno', type: 'string'   },
     						{name : 'clacno', type: 'int'   },
     						{name : 'brhid', type: 'int'   },
     						{name : 'empinfo', type: 'string'  }
                        ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxRefund").jqxGrid(
            {
            	width: '98%',
                height: 530,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Client Name',  datafield: 'clientname', width: '20%' },
							{ text: 'Mobile',  datafield: 'mobile', width: '8%' },
							{ text: 'Agmt No.', datafield: 'rano', hidden: true, width: '7%' },
							{ text: 'Agreement', datafield: 'aggvocno',  width: '6%' },
							{ text: 'Agmt Date', datafield: 'radate', width: '6%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Closed Date', datafield: 'closedate', width: '6%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Security', datafield: 'securityamount', width: '9%',cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'securityClass' },
							{ text: 'Invoice', datafield: 'invoiceamount', width: '9%',cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'balanceClass' }, 
							{ text: 'Receipt', datafield: 'receiptamount', width: '9%',cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'balanceClass' },
							{ text: 'Credit Note', datafield: 'creditnoteamount', width: '9%',cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'balanceClass' },
							{ text: 'Balance', datafield: 'balance', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'balanceClass',aggregates: ['sum'] },
							{ text: 'Net Value', datafield: 'netvalue', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'netValueClass' },
							{ text: 'Agmt Type', datafield: 'rtype', hidden: true, width: '7%' },
							{ text: 'Cldocno.', datafield: 'cldocno', hidden: true, width: '7%' },
							{ text: 'Client Account', datafield: 'clacno', hidden: true, width: '7%' },
							{ text: 'Brhid', datafield: 'brhid', hidden: true, width: '7%' },
							{ text: 'Emp Info', datafield: 'empinfo', hidden: true, width: '10%' },
						]
            });
           
            if(temp=='NA'){
                $("#jqxRefund").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

            $('#jqxRefund').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                $('#cmbtype').attr('disabled', false );$('#txtremarks').attr('readonly', false );$('#btnRefund').attr('disabled', false );
       	        $('#btnRelease').attr('disabled', false );$('#date').jqxDateTimeInput({disabled: false});
       	        document.getElementById("hidchckibbranch").value=0;
                document.getElementById("txtclientdocno").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtclaccount").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "clacno");
                document.getElementById("txtclname").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "clientname");
                document.getElementById("txtrano").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "rano");
                document.getElementById("txtrtype").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "rtype");
                document.getElementById("txtmainbrhid").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "brhid");
                document.getElementById("txtsecurityamount").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "securityamount");
                document.getElementById("txtbalanceamount").value = $('#jqxRefund').jqxGrid('getcellvalue', rowindex1, "balance");
              
                var values= $('#jqxRefund').jqxGrid('getcellvalue',rowindex1, "empinfo");
                
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("clientinfo").value=sum2;
            });  
            
            var netamount1="";
            var netamount=$('#jqxRefund').jqxGrid('getcolumnaggregateddata', 'balance', ['sum'], true);
            netamount1=netamount.sum;
            if(!isNaN(netamount1)){
      		    funRoundAmt(netamount1,"txtnetamount");
      		  }
      		else{
		    	 funRoundAmt(0.00,"txtnetamount");
		    }
            
});
</script>
<div id="jqxRefund"></div>
 