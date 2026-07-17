<%@page import="com.dashboard.leaseagreement.depreciationcostrecognization.ClsDepreciationCostRecognizationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsDepreciationCostRecognizationDAO DAO= new ClsDepreciationCostRecognizationDAO(); %>
<% String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
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
	var temp3='<%=dtype%>';
	var data1;
	
	if(temp2!='NA')
	{
		 data1= '<%=DAO.depreciationCostRecognizationGridLoading(branch,upToDate,dtype)%>';
		 var dataExcelExport='<%=DAO.depreciationCostRecognizationExcelExport(branch,upToDate,dtype)%>';
	}

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'agreement' , type: 'string' },
						{name : 'type' , type: 'string' },
						{name : 'client', type: 'string'  },
						{name : 'fleetno', type: 'string'  },
						{name : 'regno', type: 'string'  },
						{name : 'platecode', type: 'string'  },
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'leasefromdate', type: 'date'  },
						{name : 'leasetodate', type: 'date'  },
						{name : 'posteddate', type: 'date'  },
						{name : 'vehiclecost', type: 'number'  },
						{name : 'residual', type: 'number'  },
						{name : 'balance', type: 'number'  },
						{name : 'numberofdays', type: 'number'  },
						{name : 'onedaycharge', type: 'number'  },
						{name : 'tobedeprdays', type: 'number'  },
						{name : 'depramount', type: 'number'  }
						],
				    localdata: data1,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    if(temp3=='NO') {
  		$('#depreciationCostRecognizationGridID').jqxGrid({ selectionmode: 'checkbox'}); 
    } else{
   	    $('#depreciationCostRecognizationGridID').jqxGrid({ selectionmode: 'singlerow'});
   }
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	 });
   
    var cellclassname = function (row, column, value, data) {
		if (data.balance == '000') {
            return "redClass"; 
        } else if (data.balance == '100') {
            return "blueClass";
        }else if (data.balance == '110') {
            return "greenClass";
        }else if (data.balance == '111') {
            return "yellowClass";
        }else{
        	return "whiteClass";
        };
    };    	        
    
    $("#depreciationCostRecognizationGridID").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        pagermode: 'default',
        editable: true,
        columnsresize: true,
        localization: {thousandsSeparator: ""},
       
        columns: [
					    { text: 'Sl#', sortable: false, filterable: false, editable: false,
					        groupable: false, draggable: false, resizable: false,datafield: '',
					        columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
					        cellsrenderer: function (row, column, value) {
					             return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					        }    
						},
						{ text: 'Agreement', datafield: 'agreement',cellclassname: cellclassname , editable: false, width: '6%' },
						{ text: 'Type', datafield: 'type' ,cellclassname: cellclassname, editable: false, width: '9%' },
						{ text: 'Client', datafield: 'client' ,cellclassname: cellclassname, editable: false },
						{ text: 'Fleet', datafield: 'fleetno' ,cellclassname: cellclassname, editable: false, width: '6%' },
						{ text: 'Reg No', datafield: 'regno' ,cellclassname: cellclassname, editable: false, width: '5%' },
						{ text: 'Plate Code', datafield: 'platecode',cellclassname: cellclassname , editable: false, width: '5%' },
						{ text: 'Brand', datafield: 'brand',cellclassname: cellclassname , editable: false, width: '6%' },
						{ text: 'Model', datafield: 'model',cellclassname: cellclassname , editable: false, width: '7%' },
						{ text: 'From', datafield: 'leasefromdate' , cellsformat: 'dd.MM.yyyy' , editable: false, cellclassname: cellclassname, width: '6%' },
						{ text: 'To', datafield: 'leasetodate' , cellsformat: 'dd.MM.yyyy' , editable: false, cellclassname: cellclassname, width: '6%' },
						{ text: 'Posted Till', datafield: 'posteddate' , cellsformat: 'dd.MM.yyyy' , editable: false, cellclassname: cellclassname, width: '6%' },
						{ text: 'Vehicle Cost', datafield: 'vehiclecost' ,cellclassname: cellclassname, cellsformat: 'd2', width: '9%', cellsalign: 'right', align: 'right' },
						{ text: 'Residual Value', datafield: 'residual' ,cellclassname: cellclassname, cellsformat: 'd2', width: '9%', cellsalign: 'right', align: 'right' },
						{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', hidden: true },
						{ text: 'No. of Days', datafield: 'numberofdays', cellsformat: 'd2', width: '10%', hidden: true },
						{ text: 'One Day Charge', datafield: 'onedaycharge', cellsformat: 'd2', width: '10%', hidden: true },
						{ text: 'Depr. Days', datafield: 'tobedeprdays', cellsformat: 'd2', width: '10%', hidden: true },
						{ text: 'Depr. Amount', datafield: 'depramount', cellsformat: 'd2', width: '9%' },
						]
    
    });

	$("#overlay, #PleaseWait").hide();
	
});

</script>
<div id="depreciationCostRecognizationGridID"></div>