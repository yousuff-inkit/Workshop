<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasequotation.ClsLeaseQuotationDAO" %>
<% String contextPath=request.getContextPath();%>
<% ClsLeaseQuotationDAO DAO=new ClsLeaseQuotationDAO(); %>
<% String reqdocno=request.getParameter("reqdocno")==null?"0":request.getParameter("reqdocno"); 
   String mode = request.getParameter("mode")==null?"0":request.getParameter("mode"); 
   String docno=request.getParameter("docno")==null?"0":request.getParameter("docno"); 
   String leaseQuotDocno=request.getParameter("leaseQuotationDocno")==null?"0":request.getParameter("leaseQuotationDocno");%>
   
<style type="text/css">
        .advanceClass
        {
            background-color: #FFEBEB;
        }
        .installmentClass
        {
            color: #FC4747;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
</style>

<script type="text/javascript">
		var temp='<%=leaseQuotDocno%>';
    	var temp1='<%=mode%>';
		var data;
		
		var datas='<%=DAO.getLeaseCDW()%>';
		
		if(temp>0 && temp1=='E'){   
    		data= '<%=DAO.applicationGridEditReloading(session,leaseQuotDocno,docno,reqdocno) %>';     
      	} else if(temp>0){   
    		data= '<%=DAO.applicationGridReloading(session,leaseQuotDocno) %>';     
      	} else {
      		data= '<%=DAO.applicationGridLoading(reqdocno,docno) %>';
      	}
		        
		var list = datas.split(",");
		
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'leasefromdate', type: 'date' }, 
     						{name : 'brand', type: 'string'   },
     						{name : 'model', type: 'string'  },
     						{name : 'specification', type: 'string'   },
     						{name : 'color', type: 'string'   },
     						{name : 'leasemonths', type: 'number' },
     						{name : 'kmpermonth',type:'number'},
     						{name : 'gname',type:'string'},
     						{name : 'qty',type:'number'},
     						{name : 'rateperamount',type:'number'},
     						{name : 'totalcost',type:'number'},
     						{name : 'advance',type:'number'},
     						{name : 'noofinstallments',type:'int'},
     						{name : 'amountpermonth',type:'number'},
     						{name : 'cdw', type: 'string' },
     						{name : 'brdid',type:'number'},
     						{name : 'modelid',type:'number'},
     						{name : 'clrid',type:'number'},
     						{name : 'grpid',type:'number'},
     						{name : 'reqsrno',type:'int'}
     						
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
                if(data.advance>data.totalcost){
                	return "advanceClass";
                } else if(data.noofinstallments>data.leasemonths){
                	return "installmentClass";
                }
                else{
                	return "whiteClass";
                }
                  };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            
            $("#leaseReqGrid").jqxGrid(
            {
                width: '98%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{ text: 'Lease From', datafield: 'leasefromdate',  width: '7%',cellsformat:'dd.MM.yyyy',editable: false,cellclassname:cellclassname },	
							{ text: 'Brand', datafield: 'brand', width: '7%',editable: false,cellclassname:cellclassname},	
							{ text: 'Model', datafield: 'model',  width: '8%' ,editable: false,cellclassname:cellclassname},
							{ text: 'Specification', datafield: 'specification',editable: false,hidden: true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Color', datafield: 'color', width: '5%' ,editable: false,cellclassname:cellclassname},
							{ text: 'Lease in Months', datafield: 'leasemonths', width: '8%' ,editable: false,cellclassname:cellclassname},
							{ text: 'KM/Month', datafield: 'kmpermonth', width: '8%' ,editable: false,cellclassname:cellclassname},
							{ text: 'Group', datafield: 'gname', width: '5%' ,editable: false,hidden: true,cellclassname:cellclassname},
							{ text: 'Qty', datafield: 'qty', width: '5%' ,editable: false,align:'right',cellsalign:'right',cellclassname:cellclassname, cellsformat: 'd2'},
							{ text: 'Rate/Month', datafield: 'rateperamount', width: '9%' ,editable: false,align:'right',cellsalign:'right',cellclassname:cellclassname, cellsformat: 'd2'},
							{ text: 'Total Cost', datafield: 'totalcost', width: '9%' ,editable: false,align:'right',cellsalign:'right',cellclassname:cellclassname, cellsformat: 'd2'},
							{ text: 'Advance', datafield: 'advance', width: '9%' ,align:'right',cellsalign:'right',cellclassname:cellclassname, cellsformat: 'd2' },
							{ text: 'Installments', datafield: 'noofinstallments', width: '6%' ,cellclassname:cellclassname },
							{ text: 'Installment/Month', datafield: 'amountpermonth', width: '9%' ,align:'right',cellsalign:'right',cellclassname:cellclassname, cellsformat: 'd2',editable: false},
							{ text: 'CDW', datafield: 'cdw', width: '5%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
							{ text: 'Brand Id',datafield:'brdid',width:'10%',hidden: true },
							{ text: 'model Id',datafield:'modelid',width:'10%',hidden: true },
							{ text: 'Color Id',datafield:'clrid',width:'10%',hidden: true },
							{ text: 'Group Id',datafield:'grpid',width:'10%',hidden: true },
							{ text: 'Req Srno',datafield:'reqsrno',width:'10%',hidden: true },
						]
            });
            
            if(temp>0) {
            	$("#leaseReqGrid").jqxGrid({ disabled: true});
            }
            
            if(temp>0 && temp1=='E') {
            	$("#leaseReqGrid").jqxGrid({ disabled: false});
            }
            
        	 $("#leaseReqGrid").on('cellvaluechanged', function (event){
               var rowindex1=event.args.rowindex;
               var dataField = event.args.datafield;
               var totalcostvalue = $('#leaseReqGrid').jqxGrid('getcellvalue', rowindex1, "totalcost");
               var advancevalue=$("#leaseReqGrid").jqxGrid('getcellvalue', rowindex1, "advance");
               var installmentvalue=$("#leaseReqGrid").jqxGrid('getcellvalue', rowindex1, "noofinstallments");
               var leasemonthsvalue=$("#leaseReqGrid").jqxGrid('getcellvalue', rowindex1, "leasemonths");
               var amountpermonthvalue= (parseFloat(totalcostvalue) - parseFloat(advancevalue))/parseFloat(installmentvalue);
               $('#leaseReqGrid').jqxGrid('setcellvalue', rowindex1, "amountpermonth",amountpermonthvalue);
               
               
               if(dataField=="advance"){
         			if(advancevalue>totalcostvalue){ 
         		        $("#leaseReqGrid").jqxGrid('showvalidationpopup', rowindex1, "advance", "Limit Already Reached,Invalid Advance Amount.");
         		        $('#txtadvanceamountvalidation').val(1);
         		        return true;  
         		    } else{  
         		        $("#leaseReqGrid").jqxGrid('hidevalidationpopups');
         		        $('#txtadvanceamountvalidation').val(0);
         		        return false;  
         		    }
         		} 
              
               if(dataField=="noofinstallments"){
            	   if(installmentvalue>leasemonthsvalue){
        		    	$("#leaseReqGrid").jqxGrid('showvalidationpopup', rowindex1, "noofinstallments", "Installment/Month need not be greater than Lease in Months.");
        		    	$('#txtinstallmentvalidation').val(1);
       		            return true; 
        		    } else{  
        		        $("#leaseReqGrid").jqxGrid('hidevalidationpopups');
        		        $('#txtinstallmentvalidation').val(0);
        		        return false;  
        		    }
               }
               
            });
         	            
});

</script>
<div id="leaseReqGrid"></div>