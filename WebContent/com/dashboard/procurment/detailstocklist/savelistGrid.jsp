 <%@page import="com.dashboard.procurment.detailstocklist.ClsDetailStockListDAO"%>
 <% ClsDetailStockListDAO searchDAO = new ClsDetailStockListDAO();  
 String load = request.getParameter("load")==null?"NA":request.getParameter("load").trim();
  	
  	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=psrno%>';
var datas2333;

 if(temp4!='NA')
{ 
	
	 datas2333='<%=searchDAO.foclistgridsearch(psrno,load)%>';  
 
} 
else
{ 
	
	datas2333;
	
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
                     
 
                      
						 
	 
						{name : 'qty', type: 'number'  },
						{name : 'foc', type: 'number'  },
					 
						
						  
				 
			 
						
						],
				    localdata: datas2333,
        
        
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
    
    
   
   
    
    $("#savelistgrid").jqxGrid(
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
                    datafield: 'sl', columntype: 'number', width: '10%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }  
                  },	
                 
         
                     
                     { text: 'Qty', datafield: 'qty',  width: '45%' ,cellsformat:'d2' },
                     
                     { text: 'FOC', datafield: 'foc',  width: '40%',cellsformat:'d2'  }, 
					
					]
   
    });
    
 
    
 
    
    if(temp4!='NA')
    { 
    	
    }
    else
    	{
   
     	  $("#savelistgrid").jqxGrid('addrow', null, {});
    	}
     	 
     	 
    
   
});


</script>
<div id="savelistgrid"></div>