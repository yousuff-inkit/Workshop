<%@ page import="com.dashboard.invoices.detailinvoicelist.ClsdetailinvoicelistDAO" %>
<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentaltype = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 
  String clstatuss = request.getParameter("clstatuss")==null?"0":request.getParameter("clstatuss").trim();
 // System.out.println(fromDate+"   "+toDate);
  ClsdetailinvoicelistDAO cild=new ClsdetailinvoicelistDAO();
  
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var temp4='<%=branchval%>';
//alert(temp4);
var invoicedata;
var invoiceexceldata;
if(temp4!='NA')
{ 

  	invoiceexceldata='<%=cild.invoicelistExcel(branchval,fromDate,toDate,cldocno,rentaltype,agmtNo,clstatuss)%>';   
	  invoicedata='<%=cild.invoicelist(branchval,fromDate,toDate,cldocno,rentaltype,agmtNo,clstatuss)%>';


}
else
{
     invoiceexceldata;
	invoicedata;
	
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
                      {name : 'doc_no' , type: 'string' },
                  		{name : 'rano' , type: 'int' },
						{name : 'ratype', type: 'String'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'mrano', type: 'String'  },
						
						{name : 'date', type: 'date'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name :'rent',type:'number'},
						{name :'accchg',type:'number'},
						{name :'salik',type:'number'},
						{name :'traffic',type:'number'},
						{name :'other',type:'number'},
						
						
						{name : 'collection', type: 'string'  },
						{name : 'balance', type: 'string'  },
						{name : 'sal_name', type: 'string'  },
						
						
						{name :'vat',type:'number'},
						{name :'inschg',type:'number'},
						{name :'chk',type:'string'},
						{name :'status',type:'string'},
						
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
          
          
          
          $('#detailInvoiceGrid').on('bindingcomplete', function (event) {
        	  
        	  
        var chk= $('#detailInvoiceGrid').jqxGrid('getcellvalue', 0,"chk") ;
        
        if(parseInt(chk)==1)
        	{
        	 $('#detailInvoiceGrid').jqxGrid('hidecolumn', 'vat');
        	}
        	  
        	  
        	    
                	 
        	  
        	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailInvoiceGrid").jqxGrid(
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
                          { text: 'Doc No', datafield: 'doc_no', width: '10%' , cellclassname:cellclassname},  
      					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
						{ text: 'RA No', datafield: 'rano', width: '5%' , cellclassname:cellclassname },
						{ text: 'RA Type', datafield: 'ratype', width: '6%' , cellclassname:cellclassname},
						{ text: 'MRA NO', datafield: 'mrano', width: '8%' , cellclassname:cellclassname},
						{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
						{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy', cellclassname:cellclassname  },
						{ text: 'Account', datafield: 'acno', width: '6%'  , cellclassname:cellclassname },
						{ text: 'Account Name', datafield: 'acname', width: '14%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 , cellclassname:cellclassname},
						{ text: 'Amount', datafield: 'amount', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'Rental Sum', datafield: 'rent', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Acc Sum', datafield: 'accchg', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Salik Amt', datafield: 'salik', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname },
						{ text: 'Traffic Amt', datafield: 'traffic', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
					
			/* 			{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true}, */
						{ text: 'Insurance Charges',datafield: 'inschg', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'VAT',datafield: 'vat', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'Other Charges',datafield: 'other', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						
						{ text: 'Collection', datafield: 'collection', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'Balance', datafield: 'balance', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						{ text: 'Salesman', datafield: 'sal_name', width: '15%',cellsformat:'d2',cellsalign:'right',align:'right',}
			/* 			{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
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
    var rows=$("#detailInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#detailInvoiceGrid").jqxGrid("addrow", null, {});	
    }
   
});

	
	
</script>
<div id="detailInvoiceGrid"></div>