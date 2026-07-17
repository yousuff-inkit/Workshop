
 <%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.dashboard.procurment.purchaseordercreate.*"%>
 <% ClsPurhaseOrderCreateDAO searchDAO = new ClsPurhaseOrderCreateDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	String chk = request.getParameter("chk")==null?"0":request.getParameter("chk").trim();
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
 var temp4='<%=barchval%>';
var datas=null;

  if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.purchaseorderGridLoad(session,fromdate,barchval,chk)%>'; 
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
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
        	            {name : 'doc_no', type: 'int'  },
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'unitdoc', type: 'String'  },
						{name : 'specid', type: 'String'  },
						{name : 'taxdocno', type: 'String'  },
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
						
						 
						
						
						{name : 'clstatus', type: 'Int'  }, 
						
						
						
						{name : 'hidtax', type: 'number'  },
						{name : 'taxper', type: 'number'  },
						{name : 'taxamount', type: 'number'  }, 
						{name : 'nettaxamount', type: 'number'  }, 
						{name : 'psrno', type: 'number'  }, 
						
						  
						 
					 
						
						],
				    localdata: datas,
        
        
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
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        enabletooltips:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     
                     { text: 'PR No', datafield: 'voc_no',  width: '5%',cellclassname: cellclassname, editable: false },
                     { text: 'docno', datafield: 'doc_no',  width: '5%',cellclassname: cellclassname, editable: false,hidden:true },
           	         { text: 'Product Id', datafield: 'productid',  width: '10%',cellclassname: cellclassname, editable: false }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '25%',cellclassname: cellclassname, editable: false },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' ,cellclassname: cellclassname, editable: false},
           	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname, editable: true},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname, editable: true},
		           	 { text: 'Total', datafield: 'total',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname, editable: false},
		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname, editable: false},
		             
		             
		             { text: 'Tax %', datafield: 'taxper',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname, editable: false},
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname, editable: false},
		             { text: ' Total Amount', datafield: 'nettaxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname, editable: false},
		             { text: 'Tax %', datafield: 'hidtax',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname, editable: false,hidden:true},
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#orderlistgrid').on('rowselect', function (event) {
        var rowindex1 = event.args.rowindex;
       // alert("in row select");
       	$('#fromdate').jqxDateTimeInput({disabled: false});
        $('#acno').attr('disabled', false);
        $('#accname').attr('disabled', false);
        $('#txtpaydetails').attr('disabled', false);
        $('#txtdeldetails').attr('disabled', false);
        $('#create').attr('disabled', false);
       
    });
    $("#orderlistgrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
           	 if(datafield=="amount")
       		  {
           		 var acno=$('#acno').val();
           		 if(acno==""){
           		  $.messager.alert('Message','Please Select a Vendor  ','warning');  
           		  $('#orderlistgrid').jqxGrid('setcellvalue', rowBoundIndex, "amount",0);
           		 
           		 return 0;
           		 }
           		var qty= $('#orderlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	var unitprice=	$('#orderlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");	
               	var total=parseFloat(qty)*parseFloat(unitprice);
              		
       		    $('#orderlistgrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
       		  $('#orderlistgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
       		  
       		var netotal=$('#orderlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
    		
    		  var taxper= $('#orderlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
    		  
    		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
    		  
    		  
    		  $('#orderlistgrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxempamount);
    		  
    		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
    		  
    		  $('#orderlistgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettaxamount",taxtotalamount);
       		  }
            });
});


</script>
<div id="orderlistgrid"></div>