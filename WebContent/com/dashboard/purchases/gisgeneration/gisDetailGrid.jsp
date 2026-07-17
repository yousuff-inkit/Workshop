<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.purchases.gisgeneration.*"%>
<%
ClsGISGenerationDAO purchaseDAO = new ClsGISGenerationDAO();
String pivdocno=request.getParameter("pivdocno")==null?"0":request.getParameter("pivdocno").trim();
String id=request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>
<style type="text/css">
.advanceClass
{
	color: #FF0000;
}
.yellowClass
{
	background-color: #ffc0cb; 
}
</style>
<script type="text/javascript">
var detaildata=[];
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=purchaseDAO.getDetailData(pivdocno, id)%>';
}
$(document).ready(function () { 	
	var rendererstring2=function (aggregates){
    	var value=aggregates['sum2'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
	}    
    var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
	}    
    var rendererstring=function (aggregates) {
    	var value=aggregates['sum'];
    	if(value=="" || value=="undefined" || typeof(value)=="undefined" || value==null){
    		value=0.0;
    	}
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
    var cellclassname =  function (row, column, value, data) {
		var ss= $('#gisDetailGrid').jqxGrid('getcellvalue', row, "qty");
        if(parseFloat(ss)<=0){
        	return "yellowClass";
        }
	}
         
    // prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [     
     		{name : 'jobcarddocno',type:'number'},
     		{name : 'jobcardvocno',type:'number'},
            {name : 'productid', type: 'string'    },
            {name : 'productname', type: 'string'    },
           	{name : 'unit', type: 'String'    },
			{name : 'qty', type: 'number'    },
			{name : 'unitprice', type: 'number'    },
			{name : 'total', type: 'number'    },
			{name : 'discount', type: 'number'    },       
			{name : 'nettotal', type: 'number'    },
			{name : 'prodoc', type: 'number'    },
			{name : 'unitdocno', type: 'number'    },
			{name : 'psrno', type: 'number'    },
			{name : 'qutval', type: 'number'    },
			{name : 'saveqty', type: 'number'    },
			{name : 'discper', type: 'number'    },
			{name : 'checktype', type: 'number'    },   //no use
			{name : 'pqty', type: 'number'    },
	     	{name : 'proid', type: 'string'    },
           	{name : 'proname', type: 'string'    },
           	{name : 'specid', type: 'string'  },
           	{name : 'foc', type: 'number'    },  
           	{name : 'stockid', type: 'number'  },
           	{name : 'oldqty', type: 'number'  },
           	{name : 'cost_price', type: 'number'  },
           	{name : 'orderdiscper', type: 'string'    },
			{name : 'orderamount', type: 'string'    },
			{name : 'brandname', type: 'string'    },
			{name : 'taxper', type: 'number'  },  
			{name : 'taxamount', type: 'number'  },
			{name : 'taxperamt', type: 'number'  },
           		//  orderdiscper,orderamount
           		
			{name : 'exp_date', type: 'date'    },
			{name : 'batch_no', type: 'string'    },
			{name : 'taxdocno', type: 'string'    },
		],
        localdata: detaildata,
        pager: function (pagenum, pagesize, oldpagenum) {
        	// callback called when a page or page size is changed.
        }
	};
    $("#gisDetailGrid").on("bindingcomplete", function (event) { 
    
    }); 
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
    	loadError: function (xhr, status, error) {
	    	alert(error);    
	    }
	});
    
    $("#gisDetailGrid").jqxGrid(
    {
    	width: '100%',
    	height: 250,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        editable: false,
        disabled:false,
        statusbarheight: 21,
        editmode: 'selectedcell',
        selectionmode: 'checkbox',
        pagermode: 'default',
        columns: [
			{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',cellclassname: cellclassname,
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
			{text:'Job Card',datafield:'jobcarddocno',width: '8%',cellclassname: cellclassname,hidden:true},
			{text:'Job Card',datafield:'jobcardvocno',width: '8%',cellclassname: cellclassname},
            { text: 'Product', datafield: 'productid', width: '8%',cellclassname: cellclassname}, 
			{ text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname}, 
			{ text: 'Brand Name', datafield: 'brandname', width: '10%',cellclassname: cellclassname,  editable: false },
			{ text: 'Unit', datafield: 'unit', width: '5%',cellclassname: cellclassname,  editable: false },
			{ text: 'oldqty', datafield: 'oldqty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
			{ text: 'Quantity', datafield: 'qty',cellsalign: 'left', width: '4%' ,align:'left',cellclassname: cellclassname,cellsformat:'d2'},
			{ text: 'FOC', datafield: 'foc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
			{ text: 'Unit Price', datafield: 'unitprice', width: '7%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname},
			{ text: 'Total', datafield: 'total', width: '7%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
			{text: 'Discount %', datafield: 'discper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname},
			{ text: 'Discount', datafield: 'discount', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
			{ text: 'Net Amount', datafield: 'nettotal', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
			{ text: 'Cost Price', datafield: 'cost_price', width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname},
			{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
			{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
			{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
			{text: 'stockid', datafield: 'stockid', width: '10%' ,hidden:true },
			{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2',hidden:true   },
			{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2' ,hidden:true  },
			{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2',hidden:true     },
			{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true   }, 
  			{text: 'pname', datafield: 'proname', width: '10%'   ,hidden:true}, 
			{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
			{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
							
			//  orderdiscper,orderamount		
            {text: 'orderdiscper', datafield: 'orderdiscper', width: '10%'  ,hidden:true  },
			{text: 'orderamount', datafield: 'orderamount', width: '10%'   ,hidden:true },
			{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
			{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
			{text: 'taxdocno', datafield: 'taxdocno', width: '10%'   ,hidden:true  },
			{text: 'Batch No', datafield: 'batch_no', width: '8%'  },
			{text: 'Exp Date', datafield: 'exp_date', width: '7%' ,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},	   
		]  
	});
});    
</script>
<div id="gisDetailGrid"></div>
