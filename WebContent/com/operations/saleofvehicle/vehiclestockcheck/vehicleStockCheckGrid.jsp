<%@page import="com.operations.saleofvehicle.vehiclestockcheck.ClsVehicleStockCheckDAO" %>
<%ClsVehicleStockCheckDAO vsd=new ClsVehicleStockCheckDAO(); %>


<% String docNo = request.getParameter("txtvehstockcheckdocno2")==null?"0":request.getParameter("txtvehstockcheckdocno2");
String check = request.getParameter("check")==null?"0":request.getParameter("check"); 

String brnch = request.getParameter("branch")==null?"0":request.getParameter("branch"); %>


<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .greenClass
        {
            background-color: #7FFF00;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">
        
		var data;
		
		var temp='<%=docNo%>';
		var temp1='<%=check%>';
		
		if(temp>0){
		   data='<%=vsd.vehStockCheckGridReloading(docNo,brnch)%>'; 
		   var vehstchkexcel='<%=vsd.excelvehStockCheck(docNo,brnch)%>';
		}else if(temp1==1){
			data='<%=vsd.vehStockCheckGridLoading(brnch)%>';
			
		}
			
	$(document).ready(function () {
   
	
		
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'branchname' , type: 'string' },
						{name : 'loc_name', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'fleet_no', type: 'int'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  },
						{name : 'regno', type: 'string'  },
						{name : 'status', type: 'string'  },
						{name : 'remarks', type: 'string'  },
						{name : 'brhid', type: 'int'  },
						{name : 'tran_code', type: 'string'  },
						{name : 'ready' , type:'number'},
						{name : 'unrent' , type:'number'},
						{name : 'total' , type:'number'}
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		if (data.tran_code == 'UR') {
            return "redClass";
        } else if (data.tran_code == 'RR') {
            return "greenClass";
        }
        else{
        	return "whiteClass";
        };
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            });
    
    
    $("#jqxVehStockGrid").jqxGrid(
    {
        width: '98%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        editable: true,
       
        columns: [
					{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,datafield: '',
					    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
					    cellsrenderer: function (row, column, value) {
					  	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					   }  
					},
					{ text: 'Avail. Br', datafield: 'branchname', editable: false, width: '10%' },
					{ text: 'Location', datafield: 'loc_name', editable: false, width: '10%'},
					{ text: 'Group', datafield: 'gname', editable: false, width: '7%' },
					{ text: 'Fleet', datafield: 'fleet_no', editable: false, width: '6%'  },
					{ text: 'Fleet Name', datafield: 'flname', editable: false, width: '15%' },
					{ text: 'YOM', datafield: 'yom', editable: false, width: '4%' },
					{ text: 'Reg No', datafield: 'regno', editable: false, width: '6%'   },
					{ text: 'Status', datafield: 'status', cellclassname: cellclassname, editable: false, width: '7%'  },
					{ text: 'Remarks', datafield: 'remarks', editable: true, width: '30%'   },
					{ text: 'Branch', datafield: 'brhid', hidden: true, width: '10%'  },
					{ text: 'Veh Status', datafield: 'tran_code', hidden: true, width: '10%'  },
					{ text: 'Ready',  datafield: 'ready', width: '10%', cellsalign:'right',align:'right',hidden: true },
					{ text: 'Unrent',  datafield: 'unrent', width: '10%', cellsalign:'right',align:'right',hidden: true },
					{ text: 'Total',  datafield: 'total', width: '10%', cellsalign:'right',align:'right',hidden: true },
			     ]
    });

    if(temp>0){
    	$("#jqxVehStockGrid").jqxGrid('disabled', true);
    }
    
    var ready=$('#jqxVehStockGrid').jqxGrid('getcellvalue', 0, "ready");
    if(!isNaN(ready)){
		    document.getElementById("txtreadytorent").value=ready;
		  }
		else{
    	 $('#txtreadytorent').val(0);
    }
    
    var unrent=$('#jqxVehStockGrid').jqxGrid('getcellvalue', 0, "unrent");
    if(!isNaN(unrent)){
		    document.getElementById("txtunrentable").value=unrent;
		  }
		else{
    	 $('#txtunrentable').val(0);
    }
    
    var total=$('#jqxVehStockGrid').jqxGrid('getcellvalue', 0, "total");
    if(!isNaN(total)){
		    document.getElementById("txttotal").value=total;
		  }
		else{
    	 $('#txttotal').val(0);
    }
});

</script>
<div id="jqxVehStockGrid"></div>