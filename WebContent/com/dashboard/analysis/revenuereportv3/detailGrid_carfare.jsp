<%@page import="com.dashboard.analysis.revenuereportv3.*"%>
<%
ClsRevenueReportV3DAO DAO=new ClsRevenueReportV3DAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
String hidrepairtype=request.getParameter("hidrepairtype")==null?"":request.getParameter("hidrepairtype");
String hidserviceadvisor=request.getParameter("hidserviceadvisor")==null?"":request.getParameter("hidserviceadvisor");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var rrdetaildata;
var clockexportdata;


if(id=='1'){
	rrdetaildata=<%=DAO.getDetailData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id,hidserviceadvisor)%>;
	rrexportdata=<%=DAO.getDetailExportData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id,hidserviceadvisor)%>;

}
else{
	rrdetaildata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		
                  		{name : 'date',type:'date'},
                  		{name : 'invoiceno',type:'string'},
                  		{name : 'client',type:'string'},
                  		{name : 'jobno',type:'string'},
                  		{name : 'regno',type:'string'},
                  		{name : 'totalinv',type:'number'},
                  		{name : 'clienttotal',type:'number'},
                  		{name : 'excesstotal',type:'number'},
                  		{name : 'labour',type:'number'},
                  		{name : 'spares',type:'number'},
                  		{name : 'lubricants',type:'number'},
                  		{name : 'consumables',type:'number'},
                  		{name : 'others',type:'number'},
                  		{name : 'salesman',type:'string'},
                  		{name : 'repairtype',type:'string'},
                  		{name : 'serviceadvisor',type:'string'},
                  		{name : 'user_name',type:'string'},
                  		{name : 'account',type:'string'},
                  		{name : 'clcategory',type:'string'},
                  		{name : 'estimator',type:'string'},
                  		{name : 'actualspare',type:'number'},
                		{name : 'estno',type:'string'},
                  		{name : 'esttotal',type:'number'},
                  		{name : 'esttotalvalue',type:'number'},
   						{name : 'estall',type:'string'},
   						{name : 'estapprvalue',type:'number'},
                  		],
				    localdata: rrdetaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     $("#rrDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#rrDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,

        selectionmode: 'singlerow',
        showaggregates: true,
        showstatusbar: true,
        columnsresize:true,
        statusbarheight: 25,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Invoice No',datafield:'invoiceno',width:'6%'},
       				{ text: 'Client Name',datafield:'client',width:'14%'},
       				{ text: 'Client Category',datafield:'clcategory',width:'10%',hidden:true},
				{ text: 'Job Advisor',datafield:'user_name',width:'10%'},
       				{ text: 'Estimator',datafield:'estimator',width:'14%'},
       				{ text: 'Service Advisor',datafield:'serviceadvisor',width:'14%'},
       				{ text: 'Account Name',datafield:'account',width:'12%'},
       				{ text: 'Job No',datafield:'jobno',width:'6%'},
       				{ text: 'EST No',datafield:'estno',width:'6%',hidden:true},
       				{ text: 'Reg No',datafield:'regno',width:'6%'},
       				{ text: 'Client',datafield:'clienttotal',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Est Doc No (Additions)', datafield: 'estall', width: '12%',hidden:true },
				{ text: 'EST Appr. Value',datafield:'estapprvalue',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
				{ text: 'Est Total', datafield: 'esttotalvalue', width: '8%' ,cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
       				{ text: 'Ins. Co.',datafield:'excesstotal',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Total Inv Value',datafield:'totalinv',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				
       				{ text: 'Actual Spare Parts',datafield:'actualspare',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
       				{ text: 'Labour',datafield:'labour',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Spares',datafield:'spares',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Lubricants',datafield:'lubricants',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Consumables',datafield:'consumables',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Others',datafield:'others',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Sales Man',datafield:'salesman',width:'10%'},
       				{ text: 'Repair Type',datafield:'repairtype',width:'10%'}
    
					]
    });
    $('#rrDetailGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		document.getElementById("clockDocno").value =$('#rrDetailGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
      		});	 
     
  
    });

	
	
</script>
<div id="rrDetailGrid"></div>