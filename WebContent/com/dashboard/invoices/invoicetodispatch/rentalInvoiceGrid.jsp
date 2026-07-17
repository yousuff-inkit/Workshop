<%@page import="com.dashboard.invoices.invoicetodispatch.ClsInvoiceDispatchDAO" %>
<%ClsInvoiceDispatchDAO cid=new ClsInvoiceDispatchDAO(); %>
<% 
 String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
 String rentaltype = request.getParameter("rentaltype")==null?"":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"":request.getParameter("agmtno").trim();
 String clstatuss = request.getParameter("clstatuss")==null?"":request.getParameter("clstatuss").trim();
 String invtype=request.getParameter("invtype")==null?"":request.getParameter("invtype").trim(); 
  %>
 



<script type="text/javascript">
 var temp4='<%=branchval%>';
//alert(temp4);
var invoicedata;
if(temp4!='')
{ 
  invoicedata='<%= cid.invoicelist(branchval,fromDate,toDate,cldocno,rentaltype,agmtNo,clstatuss,invtype)%>';
}
else
{
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
                      	{name : 'doc_no' , type: 'int' },
                      	{name : 'voc_no',type:'int'},
                  		{name : 'rano' , type: 'int' },
                  		{name : 'refvocno',type: 'int'},
						{name : 'ratype', type: 'String'  },
						{name : 'dtype', type: 'string'    },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name : 'btndispatch', type: 'string'  },
						{name : 'btnprint',type:'String'},
						{name : 'branch',type:'String'},
						{name : 'mail1',type:'String'},
						{name : 'brhid',type:'String'}
						/* {name :'rent',type:'number'},
						{name :'accchg',type:'number'},
						{name :'salik',type:'number'},
						{name :'traffic',type:'number'}, 
						
						
						{name :'inschg',type:'number'},*/
						
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#rentalInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
 /*    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return "greyClass"; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          }; */
    
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
        selectionmode: 'checkbox',
        pagermode: 'default',
      	sortable:true,
        columns: [
                  
						{ text: 'SL#', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '5%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						},
                        { text: 'Original Doc No', datafield: 'doc_no', width: '7.5%',hidden:true  },
                        { text: 'Doc No', datafield: 'voc_no', width: '7.5%'},
                        { text: 'Branch',datafield:'branch',width:'10%'},
                        { text: 'Inv Type', datafield: 'dtype', width: '5%'},
                        { text: 'Original RA No', datafield: 'rano', width: '7.5%' ,hidden:true },
						{ text: 'RA No', datafield: 'refvocno', width: '10%'  },
						{ text: 'RA Type', datafield: 'ratype', width: '6%' },
						{ text: 'From Date', datafield: 'fromdate', width: '6%',cellsformat:'dd.MM.yyyy'  },
						{ text: 'To Date', datafield: 'todate', width: '6%',cellsformat:'dd.MM.yyyy'  },
						{ text: 'Account', datafield: 'acno', width: '5%'   },
						{ text: 'Account Name', datafield: 'acname', width: '27%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Amount', datafield: 'amount', width: '9.5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},	
{ text: 'email', datafield: 'mail1', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'branch id', datafield: 'brhid', width: '12%',cellsformat:'d2',hidden:true},

						/* { text: ' ', datafield: 'btnprint', width: '10%',columntype: 'button',editable:false, filterable: false,sortable:false}, 
						{ text: ' ', datafield: 'btndispatch', width: '10%',columntype: 'button',editable:false, filterable: false,sortable:false} */
						 
						/* 
						{ text: 'Rental Sum', datafield: 'rent', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Acc Sum', datafield: 'accchg', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Salik Amt', datafield: 'salik', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Traffic Amt', datafield: 'traffic', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true},
						{ text: 'Insurance Charges',datafield: 'inschg', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},

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
    
});

	
</script>
<div id="rentalInvoiceGrid"></div>