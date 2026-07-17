<%@page import="com.dashboard.workshop.jobprofitability.ClsJobProfitabilityDAO"%>
<%
ClsJobProfitabilityDAO DAO=new ClsJobProfitabilityDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
String hidrepairtype=request.getParameter("hidrepairtype")==null?"":request.getParameter("hidrepairtype");
String chkfollowup=request.getParameter("chkfollowup")==null?"":request.getParameter("chkfollowup");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var rrdetaildata;
var clockexportdata;


if(id=='1'){
	rrexportdata=<%=DAO.getDetailData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id,chkfollowup)%>;
<%-- 	rrexportdata=<%=DAO.getDetailExportData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id)%>; --%>

}
else{
	rrexportdata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		
                  		{name : 'date',type:'date'},
                  		{name : 'invoiceno',type:'string'},
                  		{name : 'invdate',type:'date'},
                  		{name : 'make',type:'string'},
                  		{name : 'party',type:'string'},
                  		{name : 'insurname',type:'string'},
                  		{name : 'jobno',type:'string'},
                  		{name : 'regno',type:'string'},
                  		{name : 'invamt',type:'number'},
                  		{name : 'labouramt',type:'number'},
                  		{name : 'spareamt',type:'number'},
                  		{name : 'consamt',type:'number'},
                  		{name : 'labourcost',type:'number'},
                  		{name : 'sparescost',type:'number'},
                  		{name : 'conscost',type:'number'},
                  		{name : 'totcost',type:'number'},
                  		{name : 'profit',type:'number'},
                  		
                  		],
				    localdata: rrexportdata,
        
				   
    
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
        width: '99%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        enabletooltips:true,
        columnsresize:true,
        selectionmode: 'singlerow',
        showaggregates: true,
        showstatusbar: true,
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
       				/*{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Invoice No',datafield:'invoiceno',width:'6%'},
       				{ text: 'Client Name',datafield:'client',width:'14%'},
       				{ text: 'Client Category',datafield:'clcategory',width:'10%'},
       				{ text: 'Estimator',datafield:'estimator',width:'14%'},
       				{ text: 'Service Advisor',datafield:'serviceadvisor',width:'14%'},
       				{ text: 'Account Name',datafield:'account',width:'12%'},
       				{ text: 'Job No',datafield:'jobno',width:'6%'},
       				{ text: 'Reg No',datafield:'regno',width:'6%'},
       				{ text: 'Client',datafield:'clienttotal',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Ins. Co.',datafield:'excesstotal',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Total Inv Value',datafield:'totalinv',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'EST Labour',datafield:'labour',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Actual Spare Parts',datafield:'actualspare',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
       				{ text: 'EST Spares',datafield:'spares',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Lubricants',datafield:'lubricants',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Consumables',datafield:'consumables',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Others',datafield:'others',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Sales Man',datafield:'salesman',width:'10%'},
       				{ text: 'Repair Type',datafield:'repairtype',width:'10%'}*/
       				{ text: 'Job Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Job No',datafield:'jobno',width:'6%'},
       				{ text: 'Inv No',datafield:'invoiceno',width:'5%'},
       				{ text: 'Inv Date',datafield:'invdate',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Reg No',datafield:'regno',width:'6%'},
       				{ text: 'Make',datafield:'make',width:'14%'},
       				{ text: 'Party',datafield:'party',width:'18%'},
       				{ text: 'Insur Name',datafield:'insurname',width:'18%'},
       				{ text: 'Inv. Amt.',datafield:'invamt',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Labour Amt',datafield:'labouramt',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Spares Amt',datafield:'spareamt',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Cons. Amt.',datafield:'consamt',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Labour Cost.',datafield:'labourcost',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Spares Cost.',datafield:'sparescost',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Cons. Cost',datafield:'conscost',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Tot. Cost.',datafield:'totcost',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Profit',datafield:'profit',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				
       				
    
					]
    });
   /* $('#rrDetailGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		document.getElementById("clockDocno").value =$('#rrDetailGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
      		});	 */
     
  
    });

	
	
</script>
<div id="rrDetailGrid"></div>