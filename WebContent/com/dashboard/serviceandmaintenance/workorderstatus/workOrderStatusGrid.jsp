<%@page import="com.dashboard.serviceandmaintenance.workorderstatus.ClsWorkOrderStatus"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsWorkOrderStatus DAO= new ClsWorkOrderStatus(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");%> 
          	  
<style type="text/css">

 .redClass
        {
            background-color: #FFEBEB;
        }
.blueClass
        {
            background-color: #E0F8F1;
        }
.greenClass
        {
            background-color: #E3F6CE;
        }
.yellowClass
        {
            background-color: #FFFFD1;
        }        
.whiteClass
        {
           background-color: #FFF;
        }
</style>

<script type="text/javascript">
	var temp2='<%=branch%>';
	var data1;
	
	if(temp2!='NA')
	{
		 data1= '<%=DAO.workOrderStatusGridLoading(branch,fromDate,toDate,dtype)%>';
		 var dataExcelExport='<%=DAO.workOrderStatusExcelExport(branch,fromDate,toDate,dtype)%>';
	}

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'status' , type: 'string' },
						{name : 'branchname' , type: 'string' },
						{name : 'docno', type: 'int'  },
						{name : 'date', type: 'date'  },
						{name : 'fleetno', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'type', type: 'string'  },
						{name : 'garage', type: 'string'  },
						{name : 'checks', type: 'string'  }
						],
				    localdata: data1,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	 });
   
    var cellclassname = function (row, column, value, data) {
		if (data.checks == '000') {
            return "redClass"; 
        } else if (data.checks == '100') {
            return "blueClass";
        }else if (data.checks == '110') {
            return "greenClass";
        }else if (data.checks == '111') {
            return "yellowClass";
        }else{
        	return "whiteClass";
        };
    };    	        
    
    $("#jqxWorkOrderStatusGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
               
						{ text: 'Status', datafield: 'status',cellclassname: cellclassname , width: '16%' },
						{ text: 'Branch', datafield: 'branchname',cellclassname: cellclassname , width: '10%' },
						{ text: 'Doc No', datafield: 'docno' ,cellclassname: cellclassname, width: '7%' },
						{ text: 'Date', datafield: 'date' , cellsformat: 'dd.MM.yyyy' , cellclassname: cellclassname, width: '8%' },
						{ text: 'Fleet', datafield: 'fleetno' ,cellclassname: cellclassname, width: '8%' },
						{ text: 'Reg No', datafield: 'reg_no' ,cellclassname: cellclassname, width: '8%' },
						{ text: 'Fleet Name', datafield: 'flname' ,cellclassname: cellclassname, width: '18%' },
						{ text: 'Type', datafield: 'type' ,cellclassname: cellclassname, width: '8%' },
						{ text: 'Garage', datafield: 'garage' ,cellclassname: cellclassname, width: '17%' },
						{ text: 'Check', datafield: 'checks', width: '10%', hidden: true },
						]
    
    });

	$("#overlay, #PleaseWait").hide();
	
});

</script>
<div id="jqxWorkOrderStatusGrid"></div>