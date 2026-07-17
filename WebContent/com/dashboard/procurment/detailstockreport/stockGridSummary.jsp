
 
 <%@page import="com.dashboard.procurment.detailstockreport.ClsdetailStockReportDAO"%>
 <% ClsdetailStockReportDAO searchDAO = new ClsdetailStockReportDAO(); 
 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	 
  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
   
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.stocklist(barchval,statusselect,psrno,load)%>'; 
	 
	 datass='<%=searchDAO.stockExcellistqty(barchval,statusselect,psrno,load)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
        
					 
						{name : 'qty', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'amount', type: 'number'  },
						{name : 'cost_price', type: 'number'  },
						{name : 'brandname', type: 'String'  },
						{name : 'category', type: 'String'  },
						
						
						
						{name : 'bin', type: 'String'  },
						{name : 'rack', type: 'String'  },
						{name : 'floor', type: 'String'  },
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#stocklistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        showfilterrow:true,
        enabletooltips:true,
        showstatusbar:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
 
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                 
           	        { text: 'Product Id', datafield: 'productid',  width: '15%' }, 
           	        { text: 'Product Name', datafield: 'productname',width: '15%'    },
           	   	   	{text: 'Brand Name', datafield: 'brandname', width: '15%' },
           	    	{text: 'Category', datafield: 'category', width: '15%' },
           	     {text: 'Floor', datafield: 'floor', width: '13%' },
     	    	 {text: 'Rack', datafield: 'rack', width: '6%' },
     	    	 {text: 'Bin', datafield: 'bin', width: '6%' },
           	    	{ text: ' Qty', datafield: 'qty',  width: '10%' ,cellsformat:'d2' },
           	    	{ text: 'Cost Price', datafield: 'cost_price',  width: '10%' ,cellsformat:'d2',cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
           	    	{ text: 'Total', datafield: 'amount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
		       
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    
});


</script>
<div id="stocklistgrid"></div>