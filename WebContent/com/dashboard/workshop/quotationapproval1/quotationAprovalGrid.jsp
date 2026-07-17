<%@page import="com.dashboard.workshop.quotationapproval.*"%>
<%
ClsQuotationApprovalDAO qadao=new ClsQuotationApprovalDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String approv=request.getParameter("aprv")==null?"":request.getParameter("aprv");
String docnos=request.getParameter("docnos")==null?"":request.getParameter("docnos");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var gateexceldata;

if(id=='1'){
	  gatedata='<%=qadao.getApprovalDetails(todate,approv,docnos,branch)%>';
	  
}
else{sVJJ
gatedata=[];
gateexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'gateinpassdocno',type:'string'},
                  		{name : 'discount',type:'number'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'btnshow',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'labouttot',type:'number'},
                  		{name : 'sparetot',type:'number'},
                  		{name : 'nettotal',type:'number'},
                  		{name : 'brhid',type:'string'},
                  		{name : 'gipno',type:'string'},
                  		{name : 'estvocno',type:'string'},
                  		{name : 'gatevocno',type:'string'}
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#quotationApprovalGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#quotationApprovalGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'estvocno',width:'5%'},
       				{ text: 'Doc No',datafield:'doc_no',width:'5%',hidden:true},
       				{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Gate In Pass Doc No',datafield:'gateinpassdocno',width:'10%',hidden:true},
       				{ text: 'Gate In Pass Doc No',datafield:'gatevocno',width:'10%'},
       				{ text: 'User Name', datafield:'refname',width:'17%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'27.5%'},
       				{ text: 'Labour Total',datafield:'labouttot',width:'14%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Spare Total',datafield:'sparetot',width:'14%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Discount',datafield:'discount',width:'14%',align:'right',cellsalign:'right',cellsformat:'d2' , hidden: true },
       				{ text: 'Net Total',datafield:'nettotal',width:'14%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Show Details',datafield:'btnshow',width:'10%',columntype:'button'},
       				{ text: 'Brhid', datafield:'brhid',hidden:true},
       				{ text: 'gipno', datafield:'gipno',hidden:true}

					]
    });
    $('#quotationApprovalGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			document.getElementById("estDocno").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	  			document.getElementById("brhid").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
  	  			document.getElementById("gipnos").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "gipno");

      		});	 
     
  
    });

	
	
</script>
<div id="quotationApprovalGrid"></div>