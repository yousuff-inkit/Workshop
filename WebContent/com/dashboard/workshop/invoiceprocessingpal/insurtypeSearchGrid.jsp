<%@page import="com.dashboard.workshop.invoiceprocessingpal.*"%>
<%
	ClsInvProcessingDAO invdao=new ClsInvProcessingDAO();
	String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
	String estrowindex=request.getParameter("estrowindex")==null?"":request.getParameter("estrowindex").trim();
	String insurcldocno=request.getParameter("insurcldocno")==null?"":request.getParameter("insurcldocno").trim();
%>
<script type="text/javascript">
var id='<%=id%>';
var estrowindex='<%=estrowindex%>';
var insurtypedata=[];
if(id=="1"){
	insurtypedata='<%=invdao.getInsurTypeData(id,insurcldocno)%>';
}
	$(document).ready(function () { 	
		// prepare the data
        var source =
        {
        	datatype: "json",
            datafields: [                          	
     			{name : 'typename', type: 'string'  },
     			{name : 'docno', type: 'string'    }
			],               
            localdata:insurtypedata,
       	};
            
        var dataAdapter = new $.jqx.dataAdapter(source,
        {
        	loadError: function (xhr, status, error) {
	        	alert(error);    
	        }
			            
		});

        $("#insurtypeSearchGrid").jqxGrid(
        {
        	width: '100%',
            height: 350,
            source: dataAdapter,
            columnsresize: true,
            altRows: true,
			showfilterrow: true,
            filterable: true, 
			//sortable: true,
			selectionmode: 'singlerow',
  			columns: [
				{ text: 'Doc No', datafield: 'docno', width: '20%' },
				{ text: 'Insur Type Name', datafield: 'typename', width: '80%' },
			]
		});
       	
       	$('#insurtypeSearchGrid').on('rowdoubleclick', function (event) {
			var rowindex=event.args.rowindex;
            $('#estimationGrid').jqxGrid('setcellvalue',estrowindex,'insurtype',$('#insurtypeSearchGrid').jqxGrid('getcellvalue', rowindex, "typename"));
            $('#estimationGrid').jqxGrid('setcellvalue',estrowindex,'insurtypedocno',$('#insurtypeSearchGrid').jqxGrid('getcellvalue', rowindex, "docno"));
            $('#insurtypewindow').jqxWindow('close');
		});
	});
</script>
<div id="insurtypeSearchGrid"></div>
 
