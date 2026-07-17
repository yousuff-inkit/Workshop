<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>

<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
	String check=request.getParameter("check")==null?"0":request.getParameter("check").trim();%>  

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
        
		var data1;
		var temp='<%=docNo%>';
		
		if(temp>0){
		   data1='<%=ca.vehStockCheckDetailAudit(docNo,check)%>'; 
		}
	$(document).ready(function () {
   
		$("#btnExcel").click(function() {
			$("#jqxVehStockDetailGrid").jqxGrid('exportdata', 'xls', 'StockCheckDetail');
		});
		
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
						],
				    localdata: data1,
        
        
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
    
    
    $("#jqxVehStockDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        editable: true,
       
        columns: [
               
					{ text: 'Avail. Br', datafield: 'branchname', editable: false, width: '10%' },
					{ text: 'Location', datafield: 'loc_name', editable: false, width: '10%'},
					{ text: 'Group', datafield: 'gname', editable: false, width: '8%' },
					{ text: 'Fleet', datafield: 'fleet_no', editable: false, width: '7%'  },
					{ text: 'Fleet Name', datafield: 'flname', editable: false, width: '15%' },
					{ text: 'YOM', datafield: 'yom', editable: false, width: '5%' },
					{ text: 'Reg No', datafield: 'regno', editable: false, width: '7%'   },
					{ text: 'Status', datafield: 'status', cellclassname: cellclassname, editable: false, width: '8%'  },
					{ text: 'Remarks', datafield: 'remarks', editable: true, width: '30%'   },
					{ text: 'Branch', datafield: 'brhid', hidden: true, width: '10%'  },
					{ text: 'Veh Status', datafield: 'tran_code', hidden: true, width: '10%'  },
			     ]
    
    });
    
    $("#overlay, #PleaseWait").hide();
    
});

</script>
<div id="jqxVehStockDetailGrid"></div>