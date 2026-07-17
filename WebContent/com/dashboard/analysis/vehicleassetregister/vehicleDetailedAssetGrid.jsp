<%@page import="com.dashboard.analysis.vehicleassetregister.ClsVehicleAssetRegister" %>
<%ClsVehicleAssetRegister cva=new ClsVehicleAssetRegister(); %>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();%>

<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
    
    .textbox {
	    border: 0;
	    height: 25px;
	    width: 20%;
	    border-radius: 5px;
	    -moz-border-radius: 5px;
	    -webkit-border-radius: 5px;
	    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-background-clip: padding-box;
	    outline: 0;
    }
        
</style>

<script type="text/javascript">
    
       var data1='<%=cva.vehicleDetailedAsssetGridLoading(branchval, fromDate, toDate, fleetno)%>';
       var name='<%=name%>';
	  	
        $(document).ready(function (){ 
        	 
    		 $("#excelExport").click(function () {
                 $("#detailedAsset").jqxDataTable('exportData', 'xls');
             });

        	
            // prepare the data
        	 var source =
             {
             	datatype: "json",
                 dataFields: [
                      {name : 'fleet_no', type: 'int' },
                      {name : 'reg_no', type: 'int' },
                      {name : 'code_name', type: 'string' },
                      {name : 'flname', type: 'string' },
      				  {name : 'acno', type: 'string' },
      				  {name : 'date', type: 'date' },
      				  {name : 'description', type: 'string' },
      				  {name : 'debit', type: 'number' },
      				  {name : 'credit', type: 'number' },
      				  {name : 'ttype', type: 'string' },
      				  {name : 'bookvalue', type: 'number' }
                 ],
                 localdata: data1,  
             };
             var dataAdapter = new $.jqx.dataAdapter(source, {
                 loadComplete: function () {
                     // data is loaded.
                 }
             });
             
             // create jqxDataTable.
             $("#detailedAsset").jqxDataTable(
             {
                 source: dataAdapter,
                 altRows: true,
                 sortable: true,
                 groups: ['fleet_no'],
                 width: '99.5%',
                 height: 400,
                 groupsRenderer: function(value, rowData, level)
                 {
                     return "Fleet No : " + value;
                 },
                 columns: [
                   { text: 'Fleet ID', hidden: true, cellsAlign: 'left', align: 'left', dataField: 'fleet_no', width: '10%'},
                   { text: 'Reg No', cellsAlign: 'left', align: 'left', dataField: 'reg_no', width: '5%'},
                   { text: 'Plate', cellsAlign: 'left', align: 'left', dataField: 'code_name', width: '5%'},
                   { text: 'Fleet Name', cellsAlign: 'left', align: 'left', dataField: 'flname', width: '20%'},
                   { text: 'Account No', cellsAlign: 'left', align: 'left', dataField: 'acno', width: '5%' },
                   { text: 'Date', dataField: 'date', cellsformat:'dd.MM.yyyy', width: '15%' },
                   { text: 'Acc. Head', datafield: 'description', width: '25%' },
                   { text: 'Debit', dataField: 'debit', cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                   { text: 'Credit', dataField: 'credit', cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                   { text: 'TR. Type', dataField: 'ttype', cellsAlign: 'center', align: 'center', width: '5%' },
                   { text: 'Book Value', dataField: 'bookvalue', hidden: true, cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                 ]
             });
             
             var result=$("#detailedAsset").jqxDataTable('getCellValue', 0, 'bookvalue');
             document.getElementById("txtbookvalue").value=result;
         });

</script>
    
    </head>
<body class='default'>
 <button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button> 
        <div id="detailedAsset"></div>
        
        <table width="100%">
		<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Book Value :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtbookvalue" name="txtbookvalue" style="width:80%;text-align: right;" value='<s:property value="txtbookvalue"/>'/></td>
		</tr>
		</table>
	
	</body>
</html>
 