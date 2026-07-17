<%@page import="com.dashboard.purchases.gisgeneration.*"%>
<%
	ClsGISGenerationDAO searchDAO = new ClsGISGenerationDAO(); 
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%> 
<script type="text/javascript">
var masterdata=[];
var id='<%=id%>';
if(id=="1"){
	masterdata='<%=searchDAO.getMasterData(uptodate,branch,id)%>';
}
$(document).ready(function () { 
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'pivdocno', type: 'number'},
        	{name : 'pivvocno', type: 'number'},
     		{name : 'refname', type: 'string'   },
     		{name : 'date', type: 'date'   },
     		{name : 'invno', type: 'string'  },
     		{name : 'invdate', type: 'string'  },
     		{name : 'total', type: 'number'  },
     		{name : 'jobwisetotal', type: 'number'},
     		{name : 'stocktotal', type: 'number'},
     	],
		localdata:masterdata, 
		pager: function (pagenum, pagesize, oldpagenum) {
        	// callback called when a page or page size is changed.
		}
	};
    $("#gisMasterGrid").on("bindingcomplete", function (event) { 
    	$("#overlay, #PleaseWait").hide();
    });
    var dataAdapter = new $.jqx.dataAdapter(source);
	
	$("#gisMasterGrid").jqxGrid(
    {
    	width: '100%',
        height: 250,
        source: dataAdapter,
        selectionmode: 'singlerow',
		columns: [
        	{ text: 'Sr No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
					return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				}   
			},
			{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
			{ text: 'PIV No', datafield: 'pivvocno',width:'8%'},
			{ text: 'PIV No', datafield: 'pivdocno',width:'8%',hidden:true},
			{ text: 'Vendor Name', datafield: 'refname', width: '40%' },
			{ text: 'Inv No',datafield: 'invno', width: '8%'},
			{ text: 'Inv Date',datafield: 'invdate', width: '8%'},
			{ text: 'Total',datafield: 'total', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '8%'},
			{ text: 'Jobwise',datafield: 'jobwisetotal', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '8%'},
			{ text: 'Stock',datafield: 'stocktotal', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '8%'}
		]
	});
    
    $('#gisMasterGrid').on('rowdoubleclick', function (event) {
    	var rowindex=event.args.rowindex;
    	var pivdocno=$('#gisMasterGrid').jqxGrid('getcellvalue',rowindex,'pivdocno');
    	$('#pivdocno').val(pivdocno);
    	$('#gisdetaildiv').load('gisDetailGrid.jsp?pivdocno='+pivdocno+'&id=1');
    });
});
</script>
<div id="gisMasterGrid"></div>
