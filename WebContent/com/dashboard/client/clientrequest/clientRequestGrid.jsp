<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();%>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=cld.clientRequestGridLoading(branchval, upToDate,check)%>';  
	  	}
  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#clientRequest").jqxGrid('exportdata', 'xls', 'ClientRequest');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'branchname', type: 'string'  },
				    {name : 'date' , type: 'date' },
				    {name : 'doc_no' , type: 'int' },
				    {name : 'refno', type: 'string'  },
				    {name : 'refname', type: 'string'  },
				    {name : 'agreement', type: 'string'  },
				    {name : 'servicetype', type: 'string'  },
				    {name : 'servicedesc' , type: 'string' },
					{name : 'amount', type: 'number'  },
					{name : 'cldocno', type: 'int'  },
					{name : 'brhid', type: 'int'  },
					{name : 'aggno', type: 'int'  },
					{name : 'rtype' , type: 'string' },
					{name : 'type_id', type: 'int'  }
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
            $("#clientRequest").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Branch', datafield: 'branchname', width: '10%' },
						{ text: 'Request Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Doc No.', datafield: 'doc_no', width: '6%' },
						{ text: 'Ref. No.', datafield: 'refno', width: '7%' },
						{ text: 'Client', datafield: 'refname', width: '17%' },
						{ text: 'Agreement', datafield: 'agreement', width: '7%' },
						{ text: 'Service Type', datafield: 'servicetype', width: '17%' },
						{ text: 'Description', datafield: 'servicedesc', width: '20%' },
						{ text: 'Amount', datafield: 'amount',width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
						{ text: 'Cldocno', datafield: 'cldocno', hidden: true, width: '10%' },
						{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
						{ text: 'Rdocno', datafield: 'aggno', hidden: true, width: '10%' },
						{ text: 'RType', datafield: 'rtype', hidden: true, width: '10%' },
						{ text: 'Type Id', datafield: 'type_id', hidden: true, width: '10%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#clientRequest").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#clientRequest').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcldocno").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtclientname").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "refname");
            	document.getElementById("txtamount").value = $('#clientRequest').jqxGrid('getcelltext', rowindex1, "amount");
            	document.getElementById("txtbrhid").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "brhid");
            	document.getElementById("txtagreement").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "agreement");
            	document.getElementById("txtagreementno").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "aggno");
            	document.getElementById("txtrtype").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "rtype");
				document.getElementById("txttypeid").value = $('#clientRequest').jqxGrid('getcellvalue', rowindex1, "type_id");
            	$('#cmbprocess').attr('disabled', false);$('#txtamount').attr('readonly', false);$('#txtremarks').attr('readonly', false);$('#btnupdate').attr("disabled",false);
            });  

        });

</script>
<div id="clientRequest"></div>
