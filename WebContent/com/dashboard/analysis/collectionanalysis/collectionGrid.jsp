<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
     String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
	 String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
	 String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
	 String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
	 String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
	 String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
	 String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom"); 
	 String excelexport=request.getParameter("excelexport")==null?"0":request.getParameter("excelexport"); %>

<style type="text/css">
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
      var data1;
      var temp='<%=branchval%>';
	  var tempexcel='<%=excelexport%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=DAO.collectionGridLoading(branchval,fromDate,toDate,hidclientcat,hidclient,hidsalesman,hidbrand,hidmodel,hidgroup,hidyom)%>';
	  	}
		
		if(tempexcel=='EXCEL'){ 
	  		if(parseInt(window.parent.chkexportdata.value)=="1") {
	  			dataExcelExports='<%=DAO.collectionExcelExportLoading(branchval,fromDate,toDate,hidclientcat,hidclient,hidsalesman,hidbrand,hidmodel,hidgroup,hidyom)%>';
	   		  	JSONToCSVCon(dataExcelExports, 'Collection', true);
	   		 } else {
	   			$("#collection").jqxGrid('exportdata', 'xls', 'Collection');
	   		 }
	  	}
	  	
        $(document).ready(function () {
        	
        	/* $("#btnExcel").click(function() {
    			$("#collection").jqxGrid('exportdata', 'xls', 'Collection');
    		}); */
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               };
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               };
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'branch', type: 'String' },
					{ name: 'rdocno', type: 'int' },
					{name : 'date', type: 'date' },
					{ name: 'dtype', type: 'String' },
                    { name: 'srno', type: 'int' },
                    { name: 'refname', type: 'String' },
                    { name: 'payas', type: 'String' },
                    { name: 'rano', type: 'int' },
                    { name: 'cashtotal', type: 'number' },
                    { name: 'cardtotal', type: 'number' },
                    { name: 'chequetotal', type: 'number' }
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
		            }		
            );
            $("#collection").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Branch', datafield: 'branch', width: '8%' },
						{ text: 'Doc No', datafield: 'rdocno', width: '7%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
						{ text: 'Doc Type', datafield: 'dtype', width: '5%' },
	                    { text: 'RRV No.', datafield: 'srno', width: '7%' },
	                    { text: 'Client', datafield: 'refname', width: '24%' },
	                    { text: 'Paid As', datafield: 'payas', width: '9%' },
	                    { text: 'Agreement', datafield: 'rano', width: '7%' , aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
	                    { text: 'Cash Total', datafield: 'cashtotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cashClass'  },
	                    { text: 'Card Total', datafield: 'cardtotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cardClass' },
	                    { text: 'Cheque Total', datafield: 'chequetotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass'  },
					 ]
            });
            
            if(temp=='NA'){
                $("#collection").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

        });

</script>
<div id="collection"></div>
