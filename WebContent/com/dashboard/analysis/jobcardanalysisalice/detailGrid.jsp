<%@page import="com.dashboard.analysis.jobcardanalysisalice.*"%>
<%
ClsJobCardAnalysisAliceDAO DAO=new ClsJobCardAnalysisAliceDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
String hidrepairtype=request.getParameter("hidrepairtype")==null?"":request.getParameter("hidrepairtype");
String hidinvoicestatus=request.getParameter("hidinvoicestatus")==null?"":request.getParameter("hidinvoicestatus");
String hidaccname=request.getParameter("hidaccname")==null?"":request.getParameter("hidaccname");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var rrdetaildata;
var clockexportdata;


if(id=='1'){
	rrdetaildata=<%=DAO.getDetailData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,hidinvoicestatus,hidaccname,id)%>;
	rrexportdata=<%=DAO.getDetailExportData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,hidinvoicestatus,hidaccname,id)%>;

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
	                 	{name : 'yom',type:'string'},
	                	{name : 'brand',type:'string'},
	                	{name : 'model',type:'string'},
                  		{name : 'date',type:'date'},
                  		{name : 'client',type:'string'},
                  		{name : 'jobno',type:'string'},
                  		{name : 'regno',type:'string'},
                  		{name : 'labour',type:'number'},
                  		//{name : 'spares',type:'number'},
                  		//{name : 'lubricants',type:'number'},
                  		//{name : 'consumables',type:'number'},
                  	//	{name : 'others',type:'number'},
                  		{name : 'salesman',type:'string'},
                  		{name : 'repairtype',type:'string'},
                  		{name : 'serviceadvisor',type:'string'},
                  		{name : 'account',type:'string'},
                  		{name : 'clcategory',type:'string'},
                  		{name : 'estimator',type:'string'},
                  		{name : 'actualspare',type:'number'},
                  		{name : 'totalinv',type:'number'},
                  		{name : 'excesstotal',type:'number'},
                  		{name : 'invstatus',type:'string'},
                  		{name : 'btnattach',type:'string'},
                  		{name : 'jobdocno',type:'number'},
                  		{name : 'brhid',type:'number'},
                  		{name : 'maintenanceremarks',type:'string'},
                  		{name : 'invoiceno',type:'string'}
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
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlecell',
        showaggregates: true,
        showstatusbar: true,
        statusbarheight: 25,
       sortable:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Job No',datafield:'jobno',width:'6%'},
       				{ text: 'Job Doc No',datafield:'jobdocno',width:'6%',hidden:true},
       				{ text: 'Client Name',datafield:'client',width:'14%'},
       				{ text: 'Client Category',datafield:'clcategory',width:'10%',hidden:true},
       				{ text: 'Estimator',datafield:'estimator',width:'14%'},
       				{ text: 'Service Advisor',datafield:'serviceadvisor',width:'14%'},
       				{ text: 'Account Name',datafield:'account',width:'12%'},
       				{ text: 'Reg No',datafield:'regno',width:'6%'},
       				{ text: 'EST Labour',datafield:'labour',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
       				{ text: 'Actual Spare Parts',datafield:'actualspare',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				//{ text: 'EST Spares',datafield:'spares',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				//{ text: 'Lubricants',datafield:'lubricants',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       			//	{ text: 'Consumables',datafield:'consumables',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				//{ text: 'Others',datafield:'others',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Sales Man',datafield:'salesman',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'10%'},
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Yom',datafield:'yom',width:'10%'},  
       				{ text: 'Repair Type',datafield:'repairtype',width:'10%'},
       				{ text: 'Maint Remarks',datafield:'maintenanceremarks',width:'15%'},
       				{ text: 'Attach',datafield:'btnattach',width:'10%',columntype:'button'},
       				{ text: 'Inv No',datafield:'invoiceno',width:'6%'},
       				{ text: 'Inv Value',datafield:'totalinv',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Excess Value',datafield:'excesstotal',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				
       				{ text: 'Inv Status',datafield:'invstatus',width:'14%'},
       				{ text: 'Branch',datafield:'brhid',width:'14%',hidden:true},
    
					]
    });
    $('#rrDetailGrid').on('cellclick', function (event) 
      		{ 
  	 	 // event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // row's visible index.
	    var rowVisibleIndex = event.args.visibleindex;
	    // right click.
	    var rightclick = event.args.rightclick; 
	    // original event.
	    var ev = event.args.originalEvent;
	    // column index.
	    var columnindex = event.args.columnindex;
	    // column data field.
	    var dataField = event.args.datafield;
	    // cell value
	    var value = event.args.value;
  		//document.getElementById("clockDocno").value =$('#rrDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');
  		if(dataField=="btnattach"){
  			var fcode="BWJA";
			var fname="Job Card Analysis";
			var jobdocno=$('#rrDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'jobdocno');
			var brhid=$('#rrDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'brhid');
			var myWindow= window.open("Attachmaster.jsp?formCode="+fcode+"&docno="+jobdocno+"&brchid="+brhid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
  		}
  		
  		
      		});	 
     
  
    });

	
	
</script>
<div id="rrDetailGrid"></div>