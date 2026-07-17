<%
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

 	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
 	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
%>
 <%@page import="com.dashboard.procurment.detailstocklist.ClsDetailStockListDAO"%>
 <% ClsDetailStockListDAO searchDAO = new ClsDetailStockListDAO(); %>
       
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
 var temp4='<%=psrno%>';
var datas11;

 if(temp4!='NA')
{ 
	
	 
	 datas11='<%=searchDAO.orderlistsearch(barchval,fromdate,todate,psrno,load)%>'; 
} 
else
{ 
	
	datas11;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'refno', type: 'String'  },
						
						
						{name : 'dtype', type: 'String'  },
						
						{name : 'out_qty', type: 'number'  },
						
						{name : 'balqty', type: 'number'  },
						
						{name : 'amount', type: 'number'  },
						
						{name : 'total', type: 'number'  },
						
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						
						{name : 'foc', type: 'number'  },
						
						
						{name : 'clstatus', type: 'Int'  }, 
						
						
						
						{name : 'taxper', type: 'number'  }, 
						{name : 'taxamount', type: 'number'  }, 
						{name : 'nettaxamount', type: 'number'  }, 
						{name : 'sp', type: 'number'  }, 
						
						
						  
						 
					 
						
						],
				    localdata: datas11,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname =  function (row, column, value, data) {


   	  var ss= $('#orderlistgrid').jqxGrid('getcellvalue', row, "clstatus");
   		          if(parseInt(ss)>0)
   		  		{
   		  		
   		  		return "yellowClass";
   		  	
   		  		}
   	    
   	    	/* return "greyClass";
   	    	
   		        var element = $(defaultHtml);
   		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
   		        return element[0].outerHTML;
   	*/

   		}

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'Doc No',datafield: 'voc_no', width: '8%' ,cellclassname: cellclassname},
         			 { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
         		/* 	 { text: 'Ref No',datafield: 'refno', width: '10%',cellclassname: cellclassname },
         			 { text: 'Type',datafield: 'dtype', width: '15%',cellclassname: cellclassname },
         		     { text: 'Account', datafield: 'account',  width: '5%' ,cellclassname: cellclassname }, */
                     { text: 'Account Name', datafield: 'acname'  ,cellclassname: cellclassname },
           	       /*   { text: 'Product Id', datafield: 'productid',  width: '13%',cellclassname: cellclassname }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '25%',cellclassname: cellclassname },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' ,cellclassname: cellclassname}, */
           	         { text: ' Qty', datafield: 'qty',  width: '9%' ,cellsformat:'d2',cellclassname: cellclassname},
           	         { text: ' FOC', datafield: 'foc',  width: '9%' ,cellsformat:'d2',cellclassname: cellclassname,hidden:true},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '9%' ,cellsformat:'d2',cellclassname: cellclassname,hidden:true},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '9%' ,cellsformat:'d2',cellclassname: cellclassname,hidden:true},
		           	{ text: 'Pur Price', datafield: 'sp',  width: '9%' ,cellsformat:'d2',cellclassname: cellclassname},
		          /*  	 { text: 'Unit Price', datafield: 'amount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Total', datafield: 'total',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount %', datafield: 'disper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount', datafield: 'discount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		             { text: 'Net Total', datafield: 'nettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		             
		             
		             { text: 'Tax %', datafield: 'taxper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname,hidden:true},
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',hidden:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname}, 
		             { text: ' Total Amount', datafield: 'nettaxamount',  width: '14%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},*/
 
					
					]
   
    });
   
    
    if(temp4!='NA')
    { 
    	
    }
    else
    	{
    $("#orderlistgrid").jqxGrid('addrow', null, {});
    	}
});


</script>
<div id="orderlistgrid"></div>