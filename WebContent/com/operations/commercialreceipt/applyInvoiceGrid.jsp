<%@page import="com.operations.commercialreceipt.ClsCommercialReceiptDAO" %>
<% ClsCommercialReceiptDAO crd=new ClsCommercialReceiptDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String toAccId = request.getParameter("txttoaccid1")==null?"0":request.getParameter("txttoaccid1"); %> 
<% String trNo = request.getParameter("txttotrno1")==null?"0":request.getParameter("txttotrno1"); %>
<% String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");%>
<script type="text/javascript">
        
		var data;
        $(document).ready(function () { 	
        	 
            var tempToAcc='<%=toAccId%>'; 
            var temp='<%=accountno%>';
            
            if(temp>0)
          	 { 
           	   data='<%=crd.applyInvoicingGrid(accountno)%>';   
          	 }
            else if(tempToAcc>0)
            {
           	    data='<%=crd.applyInvoicingGridReloading(trNo,toAccId)%>';   
            } 
            else 
          	 {} 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'transno', type: 'int' },
     						{name : 'transtype', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'rtype', type: 'string'   },
     						{name : 'rdocno', type: 'int' },
     						{name : 'description', type: 'string'   },
     						{name : 'tramt', type: 'number' },
     		     		    {name : 'applying', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'out_amount', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'id', type: 'int'   },
     						{name : 'currency', type: 'string'   }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            });
            
            $("#jqxApplyInvoice").jqxGrid(
            {
            	width: '100%',
                height: 230,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '5%' },			
							{ text: 'Doc Type', datafield: 'transtype', editable: false, width: '5%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '6%' },
							{ text: 'Ref Type', datafield: 'rtype', editable: false, width: '8%' },
							{ text: 'Ref No.', datafield: 'rdocno', editable: false, width: '7%' },
							{ text: 'Remarks', datafield: 'description', editable: false, width: '34%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', editable: false,  cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Applying', datafield: 'applying', width: '10%',  cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Balance', datafield: 'balance', width: '10%', editable: false, cellsformat: 'd2',  cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  cellsformat: 'd2', width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Id', hidden: true, datafield: 'id',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
						]
            });
            
            if(temp==0 && tempToAcc==0){
               //Add empty row
          	   $("#jqxApplyInvoice").jqxGrid('addrow', null, {});
            }
            
            if(tempToAcc>0)
         	 { 
            	$("#jqxApplyInvoice").jqxGrid('disabled', true);
         	 }
            
               var applied1="";
         	  $("#jqxApplyInvoice").on('cellvaluechanged', function (event){
         		 var rowindex1=event.args.rowindex;
                 var value = $('#jqxApplyInvoice').jqxGrid('getcellvalue', rowindex1, "tramt");
                 var value1=$("#jqxApplyInvoice").jqxGrid('getcellvalue', rowindex1, "applying");
                 var balance= parseFloat(value)-parseFloat(value1);
                 $('#jqxApplyInvoice').jqxGrid('setcellvalue', rowindex1, "balance",balance);
                
                var applied=$('#jqxApplyInvoice').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
                applied1=applied.sum;
                document.getElementById("txtapplyinvoiceapply").value=applied1;
                
                var totamount = $('#txtapplyinvoiceamt').val();
      		    var totapply = $('#txtapplyinvoiceapply').val();
      		    if(!isNaN(totamount || totapply)){
      		    var totbalance= parseFloat(totamount) - parseFloat(totapply);
      		    funRoundAmt(totbalance,"txtapplyinvoicebalance");
      		  }
      		else{
		    	 $('#txtapplyinvoiceamt').val(0.00);
		    }
          }); 
         	 
         	$("#jqxApplyInvoice").on('cellvaluechanged', function (event) {
          		var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;
                var value = $('#jqxApplyInvoice').jqxGrid('getcellvalue', rowIndex, "tramt");
                var value1=$("#jqxApplyInvoice").jqxGrid('getcellvalue', rowIndex, "applying");
          		var amount = document.getElementById("txtamount").value;
          		
          		var applied=$('#jqxApplyInvoice').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
          		applied1=parseFloat(applied.sum); 
          		if(dataField=="applying"){
          			if(applied1>amount){ 
          		        $("#jqxApplyInvoice").jqxGrid('showvalidationpopup', rowIndex, "applying", "Limit Already Reached,Invalid Amount.");
          		        $('#txtvalidation').val(1);
          		         return true;  
          		        }
          		    else if(value1>value){
          		    	$("#jqxApplyInvoice").jqxGrid('showvalidationpopup', rowIndex, "applying", "Invalid Amount.");
          		    	$('#txtvalidation').val(1);
         		         return true; 
          		    }  
          		    else{  
          		        $("#jqxApplyInvoice").jqxGrid('hidevalidationpopups');
          		        $('#txtvalidation').val(0);
          		        return false;  
          		        }
          		}      		
          	});
         	
         	$("#jqxApplyInvoice").on('cellbeginedit', function (event) {
   			    var dataField = event.args.datafield;
   			    if(dataField=="applying"){
    			    var amount = document.getElementById("txtamount").value;
            		if(amount == '' || amount == '0' || amount == '0.00'){
            			document.getElementById("errormsg").innerText="Please Enter Amount before Applying.";
     				    return 0;
            		}
            		document.getElementById("errormsg").innerText="";
   			    }
         	});
         	 
        });
    </script>
    <div id="jqxApplyInvoice"></div>
 