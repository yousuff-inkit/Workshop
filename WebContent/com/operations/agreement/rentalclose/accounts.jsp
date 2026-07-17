<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
<%
   	String docnovalss = request.getParameter("docnovals")==null?"0":request.getParameter("docnovals").trim();
ClsRentalAgreementDAO rentaldao=new ClsRentalAgreementDAO();
   	%>

<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
       
</style> 
<script type="text/javascript">


      
	
var accountsdata;
var tempss='<%=docnovalss%>';
if(tempss>0)
{
accountsdata= '<%=rentaldao.accountstatementSearch(docnovalss)%>';
	
}
else
	{
	accountsdata;
	}
  	
        $(document).ready(function () {
        	
       
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'rentaldoc' , type:'string'},
							{name : 'rentaltype',type:'string'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
							{name : 'description' , type:'string'},
							{name : 'brhid',type:'string'}
							
	                      ],
                          localdata: accountsdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                /* else{
                	return "greyClass";
                }; */
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#accountsStatement").jqxGrid(
            {
            	 width: '95%',
                 height: 380,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
              	rowsheight:25,
             	statusbarheight:25, 
                editable: false,
              
                //Add row method
                columns: [   
							{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '14%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '12%' },
							{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '12%'   },
							{ text: 'Branch',  datafield: 'brhid',  cellclassname: cellclassname, width: '12%',hidden:true },
							{ text: 'RA No',  datafield: 'rentaldoc',  cellclassname: cellclassname, width: '12%' ,hidden:true  },
							 { text: 'RA Type', datafield:'rentaltype', cellclassname: cellclassname, width:'12%',hidden:true},
							{ text: 'Description',  datafield: 'description',  cellclassname: cellclassname, width: '26%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							/* { text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '6%'  },
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '6%',cellsformat: 'd2'},
							{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right'},
							{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 }, */
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '18%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '18%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
				 ]
            });
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#accountsStatement").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#accountsStatement").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       
                   }
                   else {
                     var doctype=document.getElementById("printdoctype").value;
                     var url=document.URL;
                     if(doctype=="INV" || doctype=="INS" || doctype=="INT"){
                    	 
                      	 var reurl=url.split("agreement");
                      	 //var branch=document.getElementById("cmbagmtbranch").value; 
                      	 var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                      	 var printdocno="";
                         var win= window.open(reurl[0]+"commtransactions/invoice/printManualInvoice?fromno="+document.getElementById("printinvno").value+"&tono="+document.getElementById("printinvno").value+"&branch="+branch+"&printdocno="+printdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                         win.focus();	 
                     }
                     else if(doctype=="BPV"){
                       var reurl=url.split("operations");
						var win= window.open(reurl[0]+"finance/transactions/bankpayment/printBankPayment?docno="+document.getElementById("printinvno").value+"&branch="+document.getElementById("cmbagmtbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                      win.focus(); 
                     
                     }
                     else if(doctype=="BRV"){
                    	 var reurl=url.split("operations");
                    	 var win= window.open(reurl[0]+"finance/transactions/bankreceipt/printBankReciept?docno="+document.getElementById("printinvno").value+"&branch="+document.getElementById("cmbagmtbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                         win.focus();
                         }
                     else if(doctype=="CNO"){
  	                 	  var reurl=url.split("operations");
                    	  var win= window.open(reurl[0]+"finance/transactions/creditnote/printCreditNote?docno="+document.getElementById("printinvno").value+"&branch="+document.getElementById("cmbagmtbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                          win.focus(); 
                     }
                     else if(doctype=="CRV"){
                     	 var reurl=url.split("operations");
                    	 var win= window.open(reurl[0]+"finance/transactions/cashreciept/printCashReceipt?docno="+document.getElementById("printinvno").value+"&branch="+document.getElementById("cmbagmtbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                         win.focus(); 
                     }
                   }
               });
               $("#accountsStatement").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#accountsStatement").jqxGrid('selectrow', event.args.rowindex);
                       var rowindex=event.args.rowindex;
                       document.getElementById("printinvno").value=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'transno');
                       document.getElementById("printdoctype").value=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'transtype');
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
               });

       /*      
            var debit1="";var credit1="";var netamount="";
            var debit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            credit1=credit.sum; */
           
        });

</script>
<div id='jqxWidget'>
    <div id="accountsStatement"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Print</li>
        </ul>
       </div>
       </div>
       </div>


<input type="hidden" name="printinvo" id="printinvno">
<input type="hidden" name="printdoctype" id="printdoctype">