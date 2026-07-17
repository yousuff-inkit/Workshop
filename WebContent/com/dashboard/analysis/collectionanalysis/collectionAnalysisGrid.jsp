<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String group=request.getParameter("group")==null?"":request.getParameter("group");
     String distribution=request.getParameter("distribution")==null?"":request.getParameter("distribution");
     String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
     String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
     String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
     String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
     String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
     String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
     String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom"); 
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
       .headClass
        {
            background-color: #FFEBC2;
        }
        .yellowClass
  	    {
	      background-color: #FBEFF5;
	    }
		.cashClass
	    {
	      background-color: #FBEFF5;
	    }
	    .cardClass
	    {
	      background-color: #E0F8F1;
	    }
	    .chequeClass
	    {
	      background-color: #ECE0F8;
	    }
	  
</style>

 <script type="text/javascript">
 
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		var check='<%=check%>';
 		
 		$(document).ready(function () {
 			var data2 ="";
 			
 			if(check=='1'){
 		   	   data2 = '<%=DAO.collectionGroupGridLoading(branchval, fromDate, toDate, group, hidclientcat, hidclient, hidsalesman, hidbrand, hidmodel, hidgroup, hidyom, check)%>';
 			}else if(check=='2'){
 		   	   data2 = '<%=DAO.collectionDistributionGridLoading(branchval, fromDate, toDate, group, distribution, hidclientcat, hidclient, hidsalesman, hidbrand, hidmodel, hidgroup, hidyom, check)%>';
 			}else{
 			   data2 = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","hidden":"true"},{"text":"Ref No.","datafield":"refno","cellsAlign":"left","align":"left","width":"10%","cellclassname":"whiteClass"},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":"whiteClass"},{"text":"Cash Total","datafield":"amount0","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"12%","cellclassname":"whiteClass"},{"text":"Card Total","datafield":"amount1","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"12%","cellclassname":"whiteClass"},{"text":"Cheque Total","datafield":"amount2","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"12%","cellclassname":"whiteClass"}]},{"rows":[{"id":"1","refno":"","description":"","amount0":"","amount1":"","amount2":""}]}]';
 			}
 			
            var obj = $.parseJSON(data2);
            var columns = obj[0].columns;
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'id', type: "int" },
						{ name: 'refno', type: "int" },
	                    { name: 'description', type: "string" },
	                    { name: 'amount0', type: "number" },
	                    { name: 'amount1', type: "number" },
	                    { name: 'amount2', type: "number" },
	                    { name: 'amount3', type: "number" },
	                    { name: 'amount4', type: "number" },
	                    { name: 'amount5', type: "number" },
	                    { name: 'amount6', type: "number" },
	                    { name: 'amount7', type: "number" },
	                    { name: 'amount8', type: "number" },
	                    { name: 'amount9', type: "number" },
	                    { name: 'amount10', type: "number" },
	                    { name: 'amount11', type: "number" },
	                    { name: 'amount12', type: "number" },
	                    { name: 'amount13', type: "number" },
	                    { name: 'amount14', type: "number" },
	                    { name: 'amount15', type: "number" },
	                    { name: 'amount16', type: "number" },
	                    { name: 'amount17', type: "number" },
	                    { name: 'amount18', type: "number" },
	                    { name: 'amount19', type: "number" },
	                    { name: 'amount20', type: "number" },
	                    { name: 'amount21', type: "number" },
	                    { name: 'amount22', type: "number" },
	                    { name: 'amount23', type: "number" },
	                    { name: 'amount24', type: "number" },
	                    { name: 'amount25', type: "number" },
	                    { name: 'amount26', type: "number" },
	                    { name: 'amount27', type: "number" },
	                    { name: 'amount28', type: "number" },
	                    { name: 'amount29', type: "number" },
	                    { name: 'amount30', type: "number" }
                ],
                id: 'id',
                localdata: rows
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#collectionAnalysisGrid").jqxGrid(
            {
                width: '99.5%',
                height: 480,
                source: dataAdapter,
                columnsresize: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                columns: columns
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="collectionAnalysisGrid"></div>
