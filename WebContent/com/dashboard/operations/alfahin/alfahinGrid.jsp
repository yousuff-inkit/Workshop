<%@ page import="com.dashboard.operations.alfahin.ClsalfahinDAO" %>
<% ClsalfahinDAO cod=new ClsalfahinDAO(); %>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String doc_no = request.getParameter("doc_no")==null?"NA":request.getParameter("doc_no").trim();%>

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
	  	if(temp!='NA'){ 
	  		   data1='<%=cod.alfahinGridLoading(branchval,fromDate, toDate,doc_no)%>';
			   var dataExcelExport='<%=cod.alfahinGridExcelExport(branchval,fromDate, toDate,doc_no)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'branch', type: 'String' },
					{ name: 'rdocno', type: 'int' },
					{ name : 'date', type: 'date' },
					{ name : 'user_name', type: 'String' },
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
            $("#alfahin").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Branch', datafield: 'branch', width: '8%' },
						{ text: 'Doc No', datafield: 'rdocno', width: '4%' },
						{ text:'User Name', datafield: 'user_name',width: '11%'},
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
						
						{ text: 'Doc Type', datafield: 'dtype', width: '5%' },
	                    { text: 'RRV No.', datafield: 'srno', width: '7%' },
	                    { text: 'Client', datafield: 'refname', width: '17%' },
	                    { text: 'Paid As', datafield: 'payas', width: '7%' },
	                    { text: 'Agreement', datafield: 'rano', width: '7%' , aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
	                    { text: 'Cash Total', datafield: 'cashtotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cashClass'  },
	                    { text: 'Card Total', datafield: 'cardtotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cardClass' },
	                    { text: 'Cheque Total', datafield: 'chequetotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass'  },
					 ]
            });
            
         //   if(temp=='NA'){
         //       $("#alfahin").jqxGrid("addrow", null, {});
        //    }
            
            $("#overlay, #PleaseWait").hide();
            
        //    var cashtotal1="";var cardtotal1="";var chequetotal1="";var netamount="";
        //    var cashtotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'cashtotal', ['sum'], true);
          //  cashtotal1=cashtotal.sum;
            //var cardtotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'cardtotal', ['sum'], true);
      //      cardtotal1=cardtotal.sum;
        //    var chequetotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'chequetotal', ['sum'], true);
          //  chequetotal1=chequetotal.sum;
            //if(!isNaN(cashtotal1 || cardtotal1 || chequetotal1)){
            	//netamount= parseFloat(cashtotal1) + parseFloat(cardtotal1) + parseFloat(chequetotal1);
      	//	    funRoundAmt(netamount,"txtnetamount");
      		//  }
      	//	else{
		  //  	 $('#txtnetamount').val(0.00);
		   // }

        });

</script>
<div id="alfahin"></div>
