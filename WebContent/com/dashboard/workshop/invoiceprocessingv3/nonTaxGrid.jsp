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
var nontaxdata=[];
var list = ['Shared', 'Insur.Company'];
if(id=='1'){
	nontaxdata='<%=jobsdao.getNonTaxGridData(jobcard,id)%>';
	  <%-- exceldata='<%=jobsdao.getJobcardWithoutInvoiceExcelData(fromdate, todate, id, branch, jobcard)%>'; --%>
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
        
						{name : 'description',type:'string'},
						{name : 'qty',type:'number'},
						{name : 'rate',type:'number'},
						{name : 'amount',type:'number'},
						{name : 'discount',type:'number'},
                  		{name : 'vatpercent',type:'number'},
                  		{name : 'vatamount',type:'number'},
                  		{name : 'netamount',type:'number'}
                  		],
				    localdata: nontaxdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#nonTaxGrid").on("bindingcomplete", function (event) {
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
    
    
    
    $("#nonTaxGrid").jqxGrid(
    {
        width: '98%',
        height: 320,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        editable:true,
       	sortable:false,
       	showaggregates:true,
       	showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Description',datafield:'description'},
       				{ text: 'Qty',datafield:'qty',width:'8%', editable: false},
       				{ text: 'Rate',datafield:'rate',width:'8%', editable: false,cellsformat:'d2',align:'right',cellsalign:'right',aggregates:['sum']},
       				{ text: 'Discount',datafield:'discount',width:'8%', editable: false,cellsformat:'d2',align:'right',cellsalign:'right',aggregates:['sum']},
       				{ text: 'Amount',datafield:'amount',width:'8%', editable: false,cellsformat:'d2',align:'right',cellsalign:'right',aggregates:['sum']},
       				{ text: 'VAT %',datafield:'vatpercent',width:'8%', editable: false,cellsformat:'d2',align:'right',cellsalign:'right'},
       				{ text: 'VAT Amount',datafield:'vatamount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',aggregates:['sum'],editable:false},
       				{ text: 'Net Amount',datafield:'netamount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',aggregates:['sum']},
       				
					]
    });
    
    });

	
	
</script>
<div id="nonTaxGrid"></div>
