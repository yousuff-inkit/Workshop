<%@page import="com.dashboard.workshop.invoiceprocessingv3.*"%>
<%
ClsInvProcessingV3DAO jobsdao=new ClsInvProcessingV3DAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String jobcard=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");

%>
<style>
.redClass
	{
	   background:#FFEBEB;
	}
</style>
<script type="text/javascript">

var id='<%=id%>';
var amountdata=[];
var list = ['Shared', 'Insur.Company'];
 if(id=='1'){
	  amountdata='<%=jobsdao.getAmountData(jobcard,id)%>';
	  <%-- exceldata='<%=jobsdao.getJobcardWithoutInvoiceExcelData(fromdate, todate, id, branch, jobcard)%>'; --%>
} 
 else{
jobdata=[];
} 
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
        
						{name : 'rowno',type:'number'},
						{name : 'insurstatus',type:'number'},
						{name : 'invno',type:'number'},
						{name : 'billtoacno',type:'number'},
                  		{name : 'acname',type:'string'},
                  		{name : 'claimno',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'amount',type:'number'},
                  		{name : 'discount',type:'number'},
                  		{name : 'net', type: 'number'},
                  		{name : 'vat',type:'number'},
                  		{name : 'total',type:'number'},
                  		{name : 'excess', type: 'number'},
                  		{name : 'roundoff',type:'number'},
                  		{name : 'netbill',type:'number'},
                  		{name : 'invbrhid',type:'number'},
                  		{name : 'remarks',type:'string'},
                  		{name : 'discountpercent',type:'number'},
                  		{name : 'nontaxamt',type:'number'},
                  		
                  	
                  		],
				    localdata: amountdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#amountGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	
    });        
    
    var cellclassname = function (row, column, value, data) {
		/*if(data.processstatus=="10"){
	    	return "redClass";
	    }*/
    };
	
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#amountGrid").jqxGrid(
    {
        width: '98%',
        height: 150,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        editable:true,
       	sortable:false,
       	showaggregates:true,
       	//showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Row No',datafield:'rowno',width:'11%', editable: false,hidden:true},
       				{ text: 'Insur Status',datafield:'insurstatus',width:'11%', editable: false,hidden:true},
       				{ text: 'Bill To Acno',datafield:'billtoacno',width:'6%', editable: false,hidden:false},
       				{ text: 'Inv No',datafield:'invno',width:'11%', editable: false,hidden:true},
       				{ text: 'Inv Branch',datafield:'invbrhid',width:'11%', editable: false,hidden:true},
       				{ text: 'Billed To',datafield:'acname',width:'12%', editable: false},
       				{ text: 'Claim #',datafield:'claimno',width:'6%', editable: false},
       				{ text: 'Description',datafield:'description',width:'16%'},
       				{ text: 'Remarks',datafield:'remarks',width:'6%'},
       				{ text: 'Amount', datafield: 'amount', width:"6%",cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'Disc.%', datafield: 'discountpercent', width:"6%",cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
       				{ text: 'Discount', datafield: 'discount', width:"6%",cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
       				{ text: 'Net',datafield:'net',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'VAT',datafield:'vat',width:'5%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'Total',datafield:'total',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'Excess', datafield: 'excess', width:'6%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'Round Off', datafield: 'roundoff', width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Non Taxable Amount', datafield: 'nontaxamt', width:'6%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false},
       				{ text: 'Net Bill', datafield: 'netbill', width:'6%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false}
					]
    });
    $('#amountGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			//document.getElementById("Docno").value = $('#amountGrid').jqxGrid('getcellvalue', rowindex1, "gipdocno");
  	  			$('#invno').val($('#amountGrid').jqxGrid('getcellvalue',rowindex1,'invno'));
				$('#invbrhid').val($('#amountGrid').jqxGrid('getcellvalue',rowindex1,'invbrhid'));
      		});	 
     
  	$("#amountGrid").on('cellvaluechanged', function (event) 
	{
	    // event arguments.
	    var args = event.args;
	    // column data field.
	    var datafield = event.args.datafield;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // new cell value.
	    var value = event.args.newvalue;
	    // old cell value.
	    var oldvalue = event.args.oldvalue;
	    if(datafield=="discountpercent"){
	    	var amount=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'amount'));
	    	var discountpercent=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'discountpercent'));
	    	var discount=amount*(discountpercent/100);
	    	discount=parseFloat(discount).toFixed(2);
	    	$('#amountGrid').jqxGrid('setcellvalue',rowBoundIndex,'discount',discount);
	    	
	    }
	    if(datafield=="discount" || datafield=="roundoff"){
	    	var amount=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'amount'));
	    	var discount=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'discount'));
			var net=amount-discount;
			net=parseFloat(net).toFixed(2);
			$('#amountGrid').jqxGrid('setcellvalue',rowBoundIndex,'net',net);
			//net=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'net'));
			var vat=net*0.05;
			vat=parseFloat(vat).toFixed(2);
			$('#amountGrid').jqxGrid('setcellvalue',rowBoundIndex,'vat',vat);
			//alert(net+"///"+vat);
			var total=parseFloat(net)+parseFloat(vat);
			//alert(total);
			total=parseFloat(total).toFixed(2);
			$('#amountGrid').jqxGrid('setcellvalue',rowBoundIndex,'total',total);
			//total=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'total'));
			var roundoff=parseFloat($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'roundoff'));
			var netbill=total-roundoff;
			netbill=parseFloat(netbill).toFixed(2);
			//alert(netbill);
			$('#amountGrid').jqxGrid('setcellvalue',rowBoundIndex,'netbill',netbill);
	    }
	    
	});
	
	
	$('#amountGrid').on('rowselect', function (event) 
	{
	    // event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
	    var rowData = event.args.row;
	    var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'invno'));
	    var acname=$('#amountGrid').jqxGrid('getcellvalue',rowBoundIndex,'acname');
	    acname.trim();
	    if(invno>0 || acname=='' || acname==null || acname=='undefined' || typeof(acname)=='undefined'){
	    	$('#amountGrid').jqxGrid('unselectrow', rowBoundIndex);
	    }
	    var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
	    if (event.args.rowindex.length === rowsCount) {
	    	for(var i=0;i<rowsCount;i++){
	    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
	    		if(invno>0){
			    	$('#amountGrid').jqxGrid('clearselection');
			    }
	    	}
	    }
	});
    });

	
	
</script>
<div id="amountGrid"></div>
<input type="hidden" name="invbrhid" id="invbrhid">