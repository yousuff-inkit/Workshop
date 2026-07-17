<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.controlcentre.masters.client.ClsClientDAO" %> 
<%
	ClsClientDAO DAO=new ClsClientDAO();
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
	String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
%>
<script type="text/javascript">
var insurtypedata=[];
var id='<%=id%>';
if(id=="1"){
	insurtypedata='<%=DAO.getInsurTypeData(id,cldocno)%>';
}
$(document).ready(function () { 
	var source = 
    {
    	datatype: "json",
        datafields: [
			{name : 'srno', type: 'number'  },
     		{name : 'typename', type: 'String'  },
     		{name : 'rowno', type: 'String'  }
		],
        localdata: insurtypedata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
                   
        },
        handlekeyboardnavigation: function (event) {
        
        }
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
    	loadError: function (xhr, status, error) {
		    alert(error);    
		}
	});
    
    $("#insurTypeGrid").jqxGrid(
    {
    	width: '100%',
        height: 250,
        source: dataAdapter,
        columnsresize: true,
        selectionmode: 'singlecell',
        editable:true,
        
		columns: [
			{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'srno', columntype: 'number', width: '10%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }
			},
			{ text: 'Type Name', datafield: 'typename', width: '90%' },
			{ text: 'Row No', datafield: 'rowno', width: '10%',hidden:true},
		]
	});
    
    var contextMenuClient = $("#MenuClient").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
	$("#insurTypeGrid").on('contextmenu', function () {
    	return false;
	});
	
	$("#insurTypeGrid").on('rowclick', function (event) {
		if(event.args.rightclick) {
			if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
            	$("#insurTypeGrid").jqxGrid('selectrow', event.args.rowindex);
               	var scrollTop = $(window).scrollTop();
               	var scrollLeft = $(window).scrollLeft();
               	contextMenuClient.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               	return false;
           	}
		}
	});
	
	$("#MenuClient").on('itemclick', function (event) {
    	var args = event.args;
        var rowindex = $("#insurTypeGrid").jqxGrid('getselectedrowindex');
		console.log($.trim($(args).text())+"::"+rowindex);
		if ($.trim($(args).text()) == "Delete Selected Row") {
            var rowid = $("#insurTypeGrid").jqxGrid('getrowid', rowindex);
            var rowno1=$('#insurTypeGrid').jqxGrid('getcellvalue',rowindex,'rowno');
            if(rowno1!="" && rowno1!="undefined" && rowno1!=null && typeof(rowno1)!="undefined"){
            	var deleterowval=$('#insurtypedeleterow').val();
				if(deleterowval!=''){
					deleterowval+=','+rowno1;
				}
				else{
					deleterowval=rowno1;
				}
				$('#insurtypedeleterow').val(deleterowval);	
            }
            
            var commit=$("#insurTypeGrid").jqxGrid('deleterow', rowid);
		}
	});
	
	
	
	$("#insurTypeGrid").on('cellendedit', function (event) 
	{
	    // event arguments.
	    var args = event.args;
	    // column data field.
	    var dataField = event.args.datafield;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // cell value
	    var value = event.args.value;
	    // cell old value.
	    var oldvalue = event.args.oldvalue;
	    // row's data.
	    var rowData = event.args.row;
		var rows=$("#insurTypeGrid").jqxGrid('getrows');
		
		if(dataField=="typename" && rowBoundIndex==rows.length-1){
			$('#insurTypeGrid').jqxGrid('addrow', null, {});
		}
	});
});
</script>
<div id='jqxWidget'>
	<div id="insurTypeGrid"></div>
	<div id='MenuClient'>
    	<ul>
            <li>Delete Selected Row</li>
        </ul>
	</div>
</div>
<input type="hidden" name="insurtypedeleterow" id="insurtypedeleterow">
<!-- <input type="hidden" name="mode" id="mode" value="E"> -->

