<%@ page import="com.dashboard.integration.autoline.ClsAutolineDAO" %>
<% ClsAutolineDAO cmud=new ClsAutolineDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

 <%
  
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
  	String check = request.getParameter("check")==null?"0":request.getParameter("check");
  	System.out.println("fromdate ="+fromdate+"todate = "+todate);
 %> 
           	  
 <style type="text/css">
        .redClass
        {
            color: red;
        }
        .yellowClass
        {
            color: green;
        }
       </style>
<script type="text/javascript">


 
 var temp4='<%=check%>';
var dataautoline1;

 if(temp4=='1')
{ 
	 
	  dataautoline1='<%=cmud.autolineGridload(fromdate,todate)%>'; 
	 dataexcelautoline='<%=cmud.autolineExcel(fromdate,todate)%>';  
	 
	 
} 
else
{ 
	
	dataautoline1;

	
	}  
 
$(document).ready(function () {
 
    var source =
    {
        datatype: "json",
        datafields: [  
                        {name : 'trans_date', type: 'date'},
                        
                        {name : 'chassis', type: 'string'  },
						{name : 'vin_no', type: 'string'  },
						{name : 'reg_no', type: 'String'  },
						{name : 'invo_no', type: 'String'  },
						{name : 'wip_no', type: 'String'},
						{name : 'line_no', type: 'String'  },
						{name : 'line_type', type: 'string'  },
						{name : 'line_desc', type: 'String'},
						{name : 'selling_price', type: 'String'},
						{name : 'discount_amt', type: 'String'  },
						{name : 'net_price', type: 'String'},
						{name : 'pos_company', type: 'String'  },
						{name : 'mkmagic', type: 'String'  },
						{name : 'customer_name', type: 'String'  },
						{name : 'acc_no', type: 'String'  },
						{name : 'veh_magic', type: 'String'  },
						 
						
						],
				    localdata: dataautoline1,
        
        
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
    
    
    $("#autolinegrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        columns: [   
                  
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
					
              	 { text: 'CHASSIS NUMBER', datafield: 'chassis',  width: '11%' }, 
              	 { text: 'VIN NUMBER', datafield: 'vin_no',  width: '11%' }, 
           	         { text: 'REG NUMBER', datafield: 'reg_no',  width: '8%' }, 
					 { text: 'TRANS DATE', datafield: 'trans_date', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'CUSTOMER NAME', datafield: 'customer_name', width: '10%'},
					 
					 { text: 'INVOICE NO', datafield: 'invo_no', width: '7%'},
				     { text: 'WIP NO',datafield: 'wip_no', width: '5%' },
				     { text: 'LINE NO',datafield: 'line_no', width: '5%' },
 					 { text: 'LINE TYPE', datafield: 'line_type', width: '5%'},
					 { text: 'LINE DESCRIPTION', datafield: 'line_desc', width: '20%'},
					 { text: 'SELLING PRICE', datafield: 'selling_price', width: '6%'},
					 { text: 'DISCOUNT', datafield: 'discount_amt', width: '6%'},
			    	 { text: 'NET PRICE', datafield: 'net_price', width: '6%'},
					 { text: 'POS COMPANY', datafield: 'pos_company', width: '12%'},
					 { text: 'MKMAGIC', datafield: 'mkmagic', width: '6%'},
					 
					 { text: 'ACCOUNT NO', datafield: 'acc_no', width: '8%'},
					 
					 { text: 'VEHICLE MAGIC', datafield: 'veh_magic', width: '6%'},
					 
					 
					]
   
    });
    
/*     dateout timeout outkm outfuel datein timeout inkm infuel */
    $("#overlay, #PleaseWait").hide();
    
  
    
  
});


</script>
<div id="autolinegrid"></div>