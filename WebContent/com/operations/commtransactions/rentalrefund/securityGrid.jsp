<%@page import="com.operations.commtransactions.rentalrefund.ClsRentalRefundDAO" %>
<%ClsRentalRefundDAO rrd=new ClsRentalRefundDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String rDocNo = request.getParameter("txtagreement2")==null?"0":request.getParameter("txtagreement2");%> 
<% String rType = request.getParameter("cmbratype2")==null?"0":request.getParameter("cmbratype2");%>
<% String toAccId = request.getParameter("txtsecurityacno2")==null?"0":request.getParameter("txtsecurityacno2"); %> 
<% String trNo = request.getParameter("txttranno2")==null?"0":request.getParameter("txttranno2"); %>
<script type="text/javascript">
		 var datas;  
        $(document).ready(function () { 
           
            var temp='<%=rDocNo%>';
            var tempTrNo='<%=trNo%>';
            
            if(tempTrNo>0)
            {
           	   datas='<%=rrd.securityGridDetailsGridReloading(trNo, toAccId) %>';   
            }
            else if(temp>0){   
            	 datas='<%=rrd.securityGridDetails(rDocNo,rType)%>';     
           	 }
               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'  },
     						{name : 'dtype', type: 'string' }, 
     						{name : 'date', type: 'date' },
     						{name : 'description', type: 'string' },
     						{name : 'amount', type: 'number' },
     						{name : 'out_amount', type: 'number' },
     						{name : 'balance', type: 'number' },
     						{name : 'tobepaid', type: 'number' },
     						{name : 'securityacno', type: 'int' },
     						{name : 'tranid', type: 'int'   },
     						{name : 'currency', type: 'string'   }
                        ],
                         localdata: datas,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSecurity").jqxGrid(
            {
                width: '94%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
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
							{ text: 'Doc No', datafield: 'doc_no', editable: false, width: '8%' },
                            { text: 'Doc Type', datafield: 'dtype', editable: false, width: '8%' },
                            { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '8%' },
                            { text: 'Description', datafield: 'description', editable: false, width: '31%' },
							{ text: 'Security', datafield: 'amount', cellsformat: 'd2',  editable: false, width: '10%',  cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Paid', datafield: 'out_amount', cellsformat: 'd2',  editable: false, width: '10%',  cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Balance', datafield: 'balance', cellsformat: 'd2',  editable: false, width: '10%',  cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'To be Paid', datafield: 'tobepaid', cellsformat: 'd2',  width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Security Account No', hidden: true, datafield: 'securityacno',  width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
						]
            });
            
            //Add empty row
            //if(temp==0){   
         	   $("#jqxSecurity").jqxGrid('addrow', null, {});
          	 //}
            if(tempTrNo>0){
            	$("#jqxSecurity").jqxGrid('disabled', true);
            }
            
            var applied1="";
         	 $("#jqxSecurity").on('cellvaluechanged', function (event){
               
               var applied=$('#jqxSecurity').jqxGrid('getcolumnaggregateddata', 'tobepaid', ['sum'], true);
               if(applied != "undefined"){
  	             applied1=applied.sum;
  	             document.getElementById("txtamount").value=applied1;
				 getNetTotal();
           		}
           		else{
     		    	 $('#txtamount').val(0.00);
					 $('#txtnetamount').val(0.00);
     		         }  
               
               
               var dataField = event.args.datafield;
               var rowIndex = event.args.rowindex;
               var value = $('#jqxSecurity').jqxGrid('getcellvalue', rowIndex, "balance");
               var value1=$("#jqxSecurity").jqxGrid('getcellvalue', rowIndex, "tobepaid");
         		if(dataField=="tobepaid"){
         			if(value1>value){ 
         		        $("#jqxSecurity").jqxGrid('showvalidationpopup', rowIndex, "tobepaid", "Limit Already Reached,Invalid Amount.");
         		        $('#txtvalidation').val(1);
         		         return true;  
         		        }
         		    else{  
         		        $("#jqxSecurity").jqxGrid('hidevalidationpopups');
         		         $('#txtvalidation').val(0);
         		        return false;  
         		        }
         		}      		
               
         	});
         	 
         	if(!($('#mode').val()=='view')){
         		document.getElementById("txtsecurityacno").value = $('#jqxSecurity').jqxGrid('getcellvalue',0, "securityacno");
                
         		var applied=$('#jqxSecurity').jqxGrid('getcolumnaggregateddata', 'tobepaid', ['sum'], true);
         	     if(applied != "undefined"){
	             applied1=applied.sum;
	             document.getElementById("txtamount").value=applied1;
				 getNetTotal();
         		 }
         		else{
   		    	 $('#txtamount').val(0.00);
				 $('#txtnetamount').val(0.00);
   		         } 
         	}
        });
    </script>
    <div id="jqxSecurity"></div>
    
 <input type="hidden" id="rowindex"/> 