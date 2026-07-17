<%@page import="com.dashboard.analysis.abcanalysis.ClsAbcAnalysis"%>
<%ClsAbcAnalysis DAO= new ClsAbcAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String rptType = request.getParameter("rptType")==null?"1":request.getParameter("rptType").trim();
	 String summaryType = request.getParameter("summarytype")==null?"0":request.getParameter("summarytype").trim();
	 String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
	 String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
	 String hidclientstatus=request.getParameter("hidclientstatus")==null?"":request.getParameter("hidclientstatus");
	 String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
       .headClass
        {
            background-color: #FFEBC2;
        }
        .openingClass
        {
            background-color: #EBD6FF;
        }
        .invoiceClass
  	    {
	      background-color: #FBEFF5;
	    }
	    .receiptClass
	    {
	      background-color: #E0F8F1;
	    }
	    .totalClass
        {
           background-color: #FFFFD1;
        }
        .balanceClass
        {
            background-color: #FFEBEB;
        }
        .averageClass
        {
            background-color: #E1F5A9;
        }
</style>

 <script type="text/javascript">
 
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		var check='<%=check%>';
 		
 		$(document).ready(function () {
 			var data ="";
 			 
 			if(check=='1'){
 		   	   data = '<%=DAO.abcAnalysisGrid(branchval, fromDate, toDate, rptType, summaryType, hidclientcat, hidclient, hidclientslm, hidclientstatus, check)%>';
 		   	   <%-- dataExcelExport = '<%=DAO.abcAnalysisExcelExport(branchval, fromDate, toDate, rptType, summaryType, hidclientcat, hidclient, hidclientslm, hidclientstatus, check)%>'; --%>
 		   	   
 			}else{
 			   data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%"},{"text":"Ref No.","datafield":"refno","cellsAlign":"center","align":"center","width":"10%"},{"text":"Client Name","datafield":"refname","cellsAlign":"left","align":"left","width":"37%"},{"text":"Opening","datafield":"opn","cellsAlign":"right","align":"right","width":"12%","cellsFormat":"d2"},{"text":"","datafield":"invoice0","cellsAlign":"right","align":"right","width":"12%","cellsFormat":"d2","columngroup":"invoicegroup"},{"text":"","datafield":"receipt0","cellsAlign":"right","align":"right","width":"12%","cellsFormat":"d2","columngroup":"receiptgroup"},{"text":"Balance","datafield":"balance","cellsAlign":"right","align":"right","width":"12%","cellsFormat":"d2"}]},{"columngroups":[{"text":"Sales","align":"center","width":"30%","name":"invoicegroup"},{"text":"Collection","align":"center","width":"20%","name":"receiptgroup"}]},{"rows":[{"id":"1","refno":"","refname":"","opn":"","invoice0":"","receipt0":"","balance":""}]}]';
 			}
 			
            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var columngroups = obj[1].columngroups;
            var rows = obj[2].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'id', type: "int" },
						{ name: 'refno', type: "int" },
	                    { name: 'refname', type: "string" },
	                    { name: 'opn', type: "number" },
	                    { name: 'invoice0', type: "number" },
	                    { name: 'invoice1', type: "number" },
	                    { name: 'invoice2', type: "number" },
	                    { name: 'invoice3', type: "number" },
	                    { name: 'invoice4', type: "number" },
	                    { name: 'invoice5', type: "number" },
	                    { name: 'invoice6', type: "number" },
	                    { name: 'invoice7', type: "number" },
	                    { name: 'invoice8', type: "number" },
	                    { name: 'invoice9', type: "number" },
	                    { name: 'invoice10', type: "number" },
	                    { name: 'invoice11', type: "number" },
	                    { name: 'invoice12', type: "number" },
	                    { name: 'invoice13', type: "number" },
	                    { name: 'invoice14', type: "number" },
	                    { name: 'invoice15', type: "number" },
	                    { name: 'invoice16', type: "number" },
	                    { name: 'invoice17', type: "number" },
	                    { name: 'invoice18', type: "number" },
	                    { name: 'invoice19', type: "number" },
	                    { name: 'invoice20', type: "number" },
	                    { name: 'invoice21', type: "number" },
	                    { name: 'invoice22', type: "number" },
	                    { name: 'invoice23', type: "number" },
	                    { name: 'invoice24', type: "number" },
	                    { name: 'invoice25', type: "number" },
	                    { name: 'invoice26', type: "number" },
	                    { name: 'invoice27', type: "number" },
	                    { name: 'invoice28', type: "number" },
	                    { name: 'invoice29', type: "number" },
	                    { name: 'invoice30', type: "number" },
	                    { name: 'totalinvoice', type: "number" },
	                    { name: 'receipt0', type: "number" },
	                    { name: 'receipt1', type: "number" },
	                    { name: 'receipt2', type: "number" },
	                    { name: 'receipt3', type: "number" },
	                    { name: 'receipt4', type: "number" },
	                    { name: 'receipt5', type: "number" },
	                    { name: 'receipt6', type: "number" },
	                    { name: 'receipt7', type: "number" }, 
	                    { name: 'receipt8', type: "number" },
	                    { name: 'receipt9', type: "number" },
	                    { name: 'receipt10', type: "number" },
	                    { name: 'receipt11', type: "number" },
	                    { name: 'receipt12', type: "number" },
	                    { name: 'receipt13', type: "number" },
	                    { name: 'receipt14', type: "number" },
	                    { name: 'receipt15', type: "number" },
	                    { name: 'receipt16', type: "number" },
	                    { name: 'receipt17', type: "number" },
	                    { name: 'receipt18', type: "number" },
	                    { name: 'receipt19', type: "number" },
	                    { name: 'receipt20', type: "number" },
	                    { name: 'receipt21', type: "number" },
	                    { name: 'receipt22', type: "number" },
	                    { name: 'receipt23', type: "number" },
	                    { name: 'receipt24', type: "number" },
	                    { name: 'receipt25', type: "number" },
	                    { name: 'receipt26', type: "number" },
	                    { name: 'receipt27', type: "number" },
	                    { name: 'receipt28', type: "number" },
	                    { name: 'receipt29', type: "number" },
	                    { name: 'receipt30', type: "number" },
	                    { name: 'totalreceipt', type: "number" },
	                    { name: 'balance', type: "number" },
	                    { name: 'salesaverage', type: "number" },
	                    { name: 'collectionaverage', type: "number" },
	                    { name: 'creditaverage', type: "number" }
                ],
                id: 'id',
                localdata: rows
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#abcAnalysisGrid").jqxGrid(
            {
                width: '99.5%',
                height: 515,
                source: dataAdapter,
                columnsresize: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                columns: columns,
                columngroups: columngroups
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="abcAnalysisGrid"></div>
