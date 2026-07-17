<%@page import="com.dashboard.analysis.cashflow.ClsCashFlowDAO"%>
<% ClsCashFlowDAO DAO= new ClsCashFlowDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String rptType = request.getParameter("rptType")==null?"1":request.getParameter("rptType").trim();
	 String summaryType = request.getParameter("summarytype")==null?"0":request.getParameter("summarytype").trim();
	 String hidcash=request.getParameter("cash")==null?"":request.getParameter("cash");
	 String hidbank=request.getParameter("bank")==null?"":request.getParameter("bank");
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
       .headClass
        {
            background-color: #FFEBC2;
        }
        .inflowamountClass
  	    {
	      background-color: #FBEFF5;
	    }
	    .outflowamountClass
	    {
	      background-color: #E0F8F1;
	    }
	    .netflowamountClass
        {
           background-color: #FFFFD1;
        }
        .amountClass
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
 		   	   data = '<%=DAO.cashFlowAnalysisGrid(branchval, fromDate, toDate, rptType, summaryType, hidcash, hidbank, check)%>';
 		   	   dataExcelExport = '<%=DAO.cashFlowExcelExport(branchval, fromDate, toDate, hidcash, hidbank, check)%>'; 
 		   	   
 			}else{
 			   data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%"},{"text":"Account","datafield":"account","cellsAlign":"center","align":"center","width":"10%"},{"text":"Account Name","datafield":"accountname","cellsAlign":"left","align":"left","width":"40%"},{"text":"In Flow","datafield":"monthamount0","cellsAlign":"right","align":"right","width":"15%","cellsFormat":"d2"},{"text":"Out Flow","datafield":"monthamount1","cellsAlign":"right","align":"right","width":"15%","cellsFormat":"d2"},{"text":"Net Flow","datafield":"monthamount2","cellsAlign":"right","align":"right","width":"15%","cellsFormat":"d2"}]},{"rows":[{"id":"1","account":"","accountname":"","monthamount0":"","monthamount1":"","monthamount2":""}]}]';
 			}
 			
            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'id', type: "int" },
						{ name: 'acno', type: "int" },
	                    { name: 'account', type: "string" },
	                    { name: 'accountname', type: "string" },
	                    { name: 'monthamount0', type: "number" },
	                    { name: 'monthamount1', type: "number" },
	                    { name: 'monthamount2', type: "number" },
	                    { name: 'monthamount3', type: "number" },
	                    { name: 'monthamount4', type: "number" },
	                    { name: 'monthamount5', type: "number" },
	                    { name: 'monthamount6', type: "number" },
	                    { name: 'monthamount7', type: "number" },
	                    { name: 'monthamount8', type: "number" },
	                    { name: 'monthamount9', type: "number" },
	                    { name: 'monthamount10', type: "number" },
	                    { name: 'monthamount11', type: "number" },
	                    { name: 'monthamount12', type: "number" },
	                    { name: 'monthamount13', type: "number" },
	                    { name: 'monthamount14', type: "number" },
	                    { name: 'monthamount15', type: "number" },
	                    { name: 'monthamount16', type: "number" },
	                    { name: 'monthamount17', type: "number" },
	                    { name: 'monthamount18', type: "number" },
	                    { name: 'monthamount19', type: "number" },
	                    { name: 'monthamount20', type: "number" },
	                    { name: 'monthamount21', type: "number" },
	                    { name: 'monthamount22', type: "number" },
	                    { name: 'monthamount23', type: "number" },
	                    { name: 'monthamount24', type: "number" },
	                    { name: 'monthamount25', type: "number" },
	                    { name: 'monthamount26', type: "number" },
	                    { name: 'monthamount27', type: "number" },
	                    { name: 'monthamount28', type: "number" },
	                    { name: 'monthamount29', type: "number" },
	                    { name: 'monthamount30', type: "number" }
                ],
                id: 'id',
                localdata: rows
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#cashFlowAnalysisGridID").jqxGrid(
            {
                width: '99.5%',
                height: 515,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="cashFlowAnalysisGridID"></div>
