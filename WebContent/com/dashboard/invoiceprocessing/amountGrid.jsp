<%@page import="com.dashboard.workshop.invoiceprocessing.*"%>
<%
ClsInvProcessingDAO jobsdao=new ClsInvProcessingDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");

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
	  amountdata='<%=jobsdao.getEstimateData(jobcard,id)%>';
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

                  		{name : 'billto',type:'string'},
                  		{name : 'claimno',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'amount',type:'number'},
                  		{name : 'discount',type:'number'},
                  		{name : 'net', type: 'number'},
                  		{name : 'vat',type:'number'},
                  		{name : 'total',type:'number'},
                  		{name : 'excess', type: 'number'},
                  		{name : 'roundoff',type:'number'},
                  		{name : 'netbill',type:'number'}
                  	
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
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Billed To',datafield:'billto',width:'11%', editable: false},
       				{ text: 'Claim #',datafield:'claimno',width:'6%', editable: false},
       				{ text: 'Description',datafield:'description',width:'19%'},
       				{ text: 'Amount', datafield: 'amount', width:"7%",cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Disocunt', datafield: 'discount', width:"7%",cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Net',datafield:'net',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'VAT',datafield:'vat',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Total',datafield:'total',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Excess', datafield: 'excess', width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Round Off', datafield: 'roundoff', width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'Net Bill', datafield: 'netbill', width:'7%',cellsformat:'d2',align:'right',cellsalign:'right'}
					]
    });
    $('#amountGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			//document.getElementById("Docno").value = $('#amountGrid').jqxGrid('getcellvalue', rowindex1, "gipdocno");
  	  			

      		});	 
     
  
    });

	
	
</script>
<div id="amountGrid"></div>