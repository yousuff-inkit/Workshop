 <%@page import="com.dashboard.procurment.detailstocklist.ClsDetailStockListDAO"%>
 <% ClsDetailStockListDAO searchDAO = new ClsDetailStockListDAO();  
 
  	
  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=psrno%>';
var datas211;

 if(temp4!='NA')
{ 
	
   datas211='<%=searchDAO.batchlistgridsearch(psrno,load)%>';  
		 
} 
else
{ 
	
	datas211;
	
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
        datafields: [   //  tr_no voc_no  accname
                     
 
                      
						 
	 
						{name : 'exp_date', type: 'string'  },
						{name : 'batch_no', type: 'string'  },
						{name : 'qty', type: 'number'  },
					 
						
						  
				 
			 
						
						],
				    localdata: datas211,
        
        
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
    
    
   
   
    
    $("#batchlistgrid").jqxGrid(
    {
        width: '100%',
        height: 130,
        source: dataAdapter,
        rowsheight:20,
        columnsresize:true,
         selectionmode: 'singlerow',
        pagermode: 'default',
          editable: false,
        columns: [   
                
                  
                  
              	 
				
			     { text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false , resizable: false ,
                    datafield: 'sl', columntype: 'number', width: '9%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }  
                  },	
                 
         
                     
                     { text: 'Expiry Date', datafield: 'exp_date',  width: '20%' },
                     
                     { text: 'Batch No', datafield: 'batch_no'    }, 
                     
                     { text: 'Qty', datafield: 'qty',  width: '20%',cellsformat:'d2'  }, 
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
 
    
 
    
    if(temp4!='NA')
    { 
    	
    }
    else
    	{

   	  $("#batchlistgrid").jqxGrid('addrow', null, {});
    	}
   
     	 
     	 
    
   
});


</script>
<div id="batchlistgrid"></div>