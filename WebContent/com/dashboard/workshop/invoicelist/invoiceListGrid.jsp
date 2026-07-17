<%@ page import="com.dashboard.workshop.invoicelist.*" %>
<% 
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String acno = request.getParameter("acno")==null?"":request.getParameter("acno").trim();
String regno = request.getParameter("regno")==null?"":request.getParameter("regno").trim();
ClsWSInvoiceListDAO invoicedao=new ClsWSInvoiceListDAO();
  
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var id='<%=id%>';
var invoicedata=[];
var invoiceexceldata=[];
if(id=='1')
{ 
	invoiceexceldata='<%=invoicedao.getInvoiceExcelData(branch,fromdate,todate,id,acno,regno)%>';
	invoicedata='<%=invoicedao.getInvoiceData(branch,fromdate,todate,id,acno,regno)%>';


}
else
{
    invoiceexceldata=[];
	invoicedata=[];
	
	} 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || value=="" || value==null || typeof(value)=="undefined"){
     		value=0.0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'invdocno' , type: 'number' },
                  		{name : 'invvocno' , type: 'number' },
						{name : 'invdate', type: 'date'  },
						{name : 'jobvocno', type: 'number'    },
						{name : 'estvocno', type: 'number'  },
						{name : 'gatevocno', type: 'number'  },
						{name : 'account', type: 'number'  },
						{name : 'invtoacno', type: 'number'  },
						{name : 'invtoacname', type: 'string'  },
						{name : 'total', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'excess',type:'number'},
						{name :'nettotal',type:'number'},
						{name :'taxamount',type:'number'},
						{name :'taxtotal',type:'number'},
						{name :'roundamt',type:'number'},
						{name : 'regno',type:'number'},
						{name : 'outamount',type:'number'},
						{name : 'balance',type:'number'},
						{name : 'category',type:'string'},
						{name : 'salesman',type:'string'},
						{name : 'serviceadvisor',type:'string'},
						{name : 'per_mob',type:'string'},
						{name : 'estimator',type:'string'},
						{name : 'insurveyor',type:'string'},
						{name : 'refered',type:'string'},
						{name : 'repairtype',type:'string'},
						{name : 'brand',type:'string'},
						{name : 'model',type:'string'},
						{name : 'yom',type:'string'},
						{name : 'color',type:'string'},
						
						
						
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     var cellclassname = function (row, column, value, data) {
     	
     }; 
          
     $('#invoiceListGrid').on('bindingcomplete', function (event) {
     	 $("#overlay, #PleaseWait").hide(); 
     });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#invoiceListGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
	columnsresize: true,
	enabletooltips: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       	sortable:true,
		showfilterrow:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                        { text: 'Inv No', datafield: 'invdocno', width: '10%' , cellclassname:cellclassname,hidden:true},
                        { text: 'Inv No', datafield: 'invvocno', width: '4%' , cellclassname:cellclassname},  
      					{ text: 'Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
						{ text: 'Job No', datafield: 'jobvocno', width: '4%' , cellclassname:cellclassname },
						{ text: 'Reg No', datafield: 'regno', width: '4%' , cellclassname:cellclassname },
						{ text: 'Brand', datafield: 'brand', width: '8%' , cellclassname:cellclassname },
						{ text: 'Model', datafield: 'model', width: '10%' , cellclassname:cellclassname },
						{ text: 'YOM', datafield: 'yom', width: '4%' , cellclassname:cellclassname },
						{ text: 'Color', datafield: 'color', width: '6%' , cellclassname:cellclassname },
						{ text: 'Repair Type', datafield: 'repairtype', width: '10%' , cellclassname:cellclassname },
						{ text: 'Est No', datafield: 'estvocno', width: '4%' , cellclassname:cellclassname,hidden:true },
						{ text: 'Gate No', datafield: 'gatevocno', width: '4%' , cellclassname:cellclassname,hidden:true },
						{ text: 'Ac No', datafield: 'account', width: '4%' , cellclassname:cellclassname},
						{ text: 'Ac No Original', datafield: 'invtoacno', width: '6%' , cellclassname:cellclassname,hidden:true},
						{ text: 'Ac Name', datafield: 'invtoacname', width: '29%' , cellclassname:cellclassname},
						{ text: 'Mobile', datafield: 'per_mob', width: '7%' , cellclassname:cellclassname},
						{ text: 'Total', datafield: 'total', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Discount', datafield: 'discount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Net Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Tax Amount', datafield: 'taxamount', width: '7%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Round Amount', datafield: 'roundamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Net Bill', datafield: 'taxtotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Out Amount', datafield: 'outamount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Balance', datafield: 'balance', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Category', datafield: 'category', width: '13%' , cellclassname:cellclassname},
						{ text: 'Salesman', datafield: 'salesman', width: '13%' , cellclassname:cellclassname},
						{ text: 'Service Advisor', datafield: 'serviceadvisor', width: '20%' , cellclassname:cellclassname},
						{ text: 'Estimator', datafield: 'estimator', width: '20%' , cellclassname:cellclassname},
						{ text: 'Ins.Surveyor', datafield: 'insurveyor', width: '20%' , cellclassname:cellclassname},
						{ text: 'Refered', datafield: 'refered', width: '20%' , cellclassname:cellclassname},
					
					]

    });

});

</script>
<div id="invoiceListGrid"></div>