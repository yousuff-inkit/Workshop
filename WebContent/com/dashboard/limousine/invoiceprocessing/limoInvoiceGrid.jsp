<%@page import="com.dashboard.limousine.invoiceprocessing.*" %>
<%
ClsInvoiceProcessDAO processdao=new ClsInvoiceProcessDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String guest=request.getParameter("guest")==null?"":request.getParameter("guest");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String jobtype=request.getParameter("jobtype")==null?"":request.getParameter("jobtype");
String invoicetype=request.getParameter("invoicetype")==null?"":request.getParameter("invoicetype");
%>

<script type="text/javascript">
var invoicedata;
var id='<%=id%>';
if(id=="1"){
	invoicedata='<%=processdao.getInvoiceData(client, guest, fromdate,todate, id, branch,bookdocno,jobtype,invoicetype)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name:'client',type:'string'},
                  		{name:'cldocno',type:'int'},
                  		{name:'guest',type:'string'},
                  		{name:'guestno',type:'int'},
                  		{name:'jobname',type:'string'},
                  		{name:'jobnametemp',type:'string'},
                  		{name:'jobdocno',type:'number'},
                  		{name:'bookdocno',type:'number'},
                  		{name:'jobtype',type:'string'},
                  		{name:'pickuplocation',type:'string'},
                  		{name:'pickuplocid',type:'int'},
                  		{name:'dropofflocation',type:'string'},
                  		{name:'dropofflocid',type:'int'},
                  		{name:'blockhrs',type:'int'},
                  		{name:'total',type:'number'},
                  		{name:'tarif',type:'number'},
                  		{name:'exkmchg',type:'number'},
                  		{name:'exhrchg',type:'number'},
                  		{name:'fuelchg',type:'number'},
                  		{name:'otherchg',type:'number'},
                  		{name:'nighttarif',type:'number'},
                  		{name:'nightextrahrchg',type:'number'},
                  		{name:'parkingchg',type:'number'},
                  		{name:'vipchg',type:'number'},
                  		{name:'greetchg',type:'number'},
                  		{name:'boquechg',type:'number'}
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#limoInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    
    });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
 
    $("#limoInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       	sortable:false,
        columns: [
               
						{text:'Client',datafield:'client',width:'13%'},
						{text:'Cldocno',datafield:'cldocno',width:'10%',hidden:true},
						{text:'Guest',datafield:'guest',width:'10%'},
						{text:'Guestno',datafield:'guestno',width:'5%',hidden:true},
						{text:'Job Type',datafield:'jobtype',widyth:'8%'},
						{text:'Job Name',datafield:'jobname',width:'5%',hidden:true},
						{text:'Job Doc No',datafield:'jobdocno',width:'5%',hidden:true},
						{text:'Booking Doc No',datafield:'bookdocno',width:'5%',hidden:true},
						{text:'Job Name',datafield:'jobnametemp',width:'5%'},
						{text:'Pickup Location',datafield:'pickuplocation',width:'8%'},
						{text:'Pickup Loc Id',datafield:'pickuplocid',width:'5%',hidden:true},
						{text:'Dropoff Location',datafield:'dropofflocation',width:'8%'},
						{text:'Dropoff Loc Id',datafield:'dropofflocid',width:'5%',hidden:true},
						{text:'Block Hrs',datafield:'blockhrs',width:'4%'},
						{text:'Total',datafield:'total',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Tarif',datafield:'tarif',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Extra Km Chg',datafield:'exkmchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Extra Hr Chg',datafield:'exhrchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Fuel Chg',datafield:'fuelchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Other Chg',datafield:'otherchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Night Tarif',datafield:'nighttarif',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Night Hr Chg',datafield:'nightextrahrchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Parking Chg',datafield:'parkingchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'VIP Chg',datafield:'vipchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Greet Chg',datafield:'greetchg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{text:'Boque Chg',datafield:'boquechg',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						
					]

    });

});

	
	
</script>
<div id="limoInvoiceGrid"></div>