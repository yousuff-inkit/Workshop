<%@ page import="com.dashboard.operations.drvragmtinvoicelist.ClsdriveragreementinvoicelistDAO" %>
<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String drdocno = request.getParameter("drdocno")==null?"0":request.getParameter("drdocno").trim();
 String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 
 

 ClsdriveragreementinvoicelistDAO cild=new ClsdriveragreementinvoicelistDAO();
  
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var temp4='<%=id%>';

var invoicedata;
var invoiceexceldata;
if(temp4=='1')	
{ 
	
  	<%-- invoiceexceldata='<%=cild.invoicelistExcel(branchval,fromDate,toDate,cldocno,agmtNo)%>';    --%>
	  invoicedata='<%=cild.invoicelist(branchval,fromDate,toDate,drdocno,agmtNo)%>';
	 

}
else
{
    /*  invoiceexceldata;
	invoicedata; */
	
	} 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      {name : 'doc_no' , type: 'string', },
                  		
						/* {name : 'branch', type: 'int'    }, */
						{name : 'driver', type: 'String',  },
						{name : 'client', type: 'String',  },
						{name : 'date', type: 'date',  },
						{name : 'agmtno', type: 'number',  },
						{name :'invdate',type:'date',},
						{name :'invtodate',type:'date',},
						{name : 'normalot_hrs', type: 'String',  },
						{name : 'holidayot_hrs', type: 'number',  },
						
						{name : 'totalrate', type: 'number',  },
						{name : 'totalnormalot',type:'number',},
						{name :'totalholidayot',type:'number',},
						
						{name :'traffic',type:'number',},
						{name :'other',type:'number',},

						{name : 'sal_name', type: 'string',  },

						{name :'vat',type:'number',},
						{name :'inschg',type:'number',},
						{name :'chk',type:'string',},
						{name :'status',type:'string', }
						
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.status)==7){
        	return "yellowClass"; 
        }
        else{
        	
        };
          }; 
          
          
          
          $('#rentalInvoiceGrid').on('bindingcomplete', function (event) {
        	  
        	  
        var chk= $('#rentalInvoiceGrid').jqxGrid('getcellvalue', 0,"chk") ;
        
        if(parseInt(chk)==1)
        	{
        	 $('#rentalInvoiceGrid').jqxGrid('hidecolumn', 'vat');
        	}
        	  
        	  
        	    
                	 
        	  
        	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#rentalInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,

        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
					  { text: 'Contract NO.', datafield: 'agmtno', width: '10%', cellclassname:cellclassname  },
					  { text: 'Contract date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
					  { text: 'Driver', datafield: 'driver', width: '10%', cellclassname:cellclassname  },
					  { text: 'Client', datafield: 'client', width: '10%' , cellclassname:cellclassname},
					  { text: 'Doc No', datafield: 'doc_no', width: '10%' , cellclassname:cellclassname},  
					  { text: 'From Date', datafield: 'invdate', width: '10%',cellsformat:'dd.MM.yyyy'  ,cellclassname:cellclassname  },
						{ text: 'To Date', datafield: 'invtodate', width: '10%',cellsformat:'dd.MM.yyyy'  ,cellclassname:cellclassname  },
      					
						
						
						
						
						{ text: 'Normal Overtime Hours', datafield: 'normalot_hrs', width: '7%',  },
						{ text: 'Holiday Overtime Hours', datafield: 'holidayot_hrs', width: '7%',  },
						
						{ text: 'Total Rate', datafield: 'totalrate', width: '7%', cellclassname:cellclassname  },
						{ text: 'Total Normal Overtime Rate', datafield: 'totalnormalot', width: '7%', cellclassname:cellclassname  },
						{ text: 'Total Holiday Overtime Rate', datafield: 'totalholidayot', width: '7%', cellclassname:cellclassname  },
						
						/* { text: 'Account', datafield: 'acno', width: '6%'  , cellclassname:cellclassname },
						{ text: 'Account Name', datafield: 'acname', width: '14%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 , cellclassname:cellclassname},
						{ text: 'Amount', datafield: 'amount', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'Rental Sum', datafield: 'rent', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Acc Sum', datafield: 'accchg', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Salik Amt', datafield: 'salik', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname },
						{ text: 'Traffic Amt', datafield: 'traffic', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
					
			/* 			{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true}, */
						/* { text: 'Insurance Charges',datafield: 'inschg', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'VAT',datafield: 'vat', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'Other Charges',datafield: 'other', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						
						{ text: 'Salesman', datafield: 'sal_name', width: '15%'},
						
						{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
						{ text: 'CurId', datafield: 'curid', width: '17%',hidden:true},
						{ text: 'Invtype', datafield: 'invtype', width: '17%',hidden:true},,cellsformat:'d2'
						{ text: 'Salik Count', datafield: 'salikcount', width: '17%',hidden:true},
						{ text: 'Traffic Count', datafield: 'trafficcount', width: '17%',hidden:true},
						{ text: 'Salik Amount', datafield: 'salamount', width: '17%',hidden:true},
						{ text: 'Salik Rate', datafield: 'salrate', width: '17%',hidden:true} */
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */ 
					]

    });

    $("#overlay, #PleaseWait").hide(); 
    var rows=$("#rentalInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    }
	$('#rentalInvoiceGrid').on('rowdoubleclick', function (event) 
			{ 
				var args = event.args;
				// row's bound index.
				var boundIndex = event.args.rowindex;
				// row's visible index.
				var visibleIndex = event.args.visibleindex;
				// right click.
				var rightclick = event.args.rightclick; 
				// original event.
				var ev = event.args.originalEvent;
				$('#docno').val($('#rentalInvoiceGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				/* $('#cmbbranch').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				$('#date').jqxDateTimeInput('val',$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'date'));
				$('#client').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'client'));
				$('#hidclient').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
				$('#driver').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'driver'));
				$('#hiddriver').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'drvid'));
				$('#cmbcontracttype').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'contracttype'));
				$('#rate').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'rate'));
				$('#overrate').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'overrate'));
				$('#lpono').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'lpono'));
				$('#normalovertime').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'normalovertime'));
				$('#holidayovertime').val($('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'holidayovertime'));
				$('#fromdate').jqxDateTimeInput('val',$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'fromdate'));
				var invoicetype=$('#driverAgmtCreateGrid').jqxGrid('getcellvalue',boundIndex,'invtype');
				if(invoicetype=="Monthly"){
					$('#cmbinvoicetype').val("1");
				}
				else{
					$('#cmbinvoicetype').val("2");
				} */
	});
   
});

	
	
</script>
<div id="rentalInvoiceGrid"></div>