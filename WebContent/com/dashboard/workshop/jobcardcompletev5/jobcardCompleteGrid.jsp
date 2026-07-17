<%@page import="com.dashboard.workshop.jobcardcompletev5.*"%>
<%
ClsJobCardCompleteV5DAO gatedao=new ClsJobCardCompleteV5DAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata=[];

if(id=='1'){
	gatedata='<%=gatedao.getJobcardData(clientname,fromdate,todate,id,brhid)%>';
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'voc_no',type:'string'},
                  		{name : 'date',type:'date'},
                  		{name : 'reftype',type:'string'},
                  		{name : 'refno',type:'string'},
                  		{name : 'estdocno',type:'string'},
                  		{name : 'userdetails', type: 'string'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'btnview',type:'string'},
                  		{name : 'brhid', type: 'string'},
                  		{name : 'savestatus',type:'string'},
                  		{name : 'claimno',type:'string'},
                  		{name : 'lpono',type:'string'},
                  		{name : 'lpoamount',type:'number'},
						{name : 'planstatus',type:'number'},
						{name : 'branch',type:'string'}
				
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#jqxJobcardCompleteGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jqxJobcardCompleteGrid").jqxGrid(
    {
        width: '100%',
        height: 200,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow : true,
       sortable:false,
       columnsresize: true,
        columns: [
               
               		{ text: 'Branch',datafield:'branch',width:'10%'},
       				{ text: 'Job Card No',datafield:'doc_no',width:'6%',hidden:true},
       				{ text: 'Job Card No',datafield:'voc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Ref Type',datafield:'reftype',width:'6%'},
       				{ text: 'Ref No', datafield: 'refno', width:"6%"},
       				{ text: 'Est No', datafield: 'estdocno', width:"10%",hidden:true},
       				{ text: 'User Details',datafield:'userdetails'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'35%'},
       				{ text: 'View',datafield:'btnview',width:'10%',columntype:'button',hidden:true},
       				{ text: 'brhid', datafield: 'brhid', width:'0%', hidden: true },
       				{ text: 'Save Status', datafield: 'savestatus', width:'0%', hidden: true },
       				{ text: 'Claim No',datafield:'claimno',width:'10%',hidden:true},
       				{ text: 'LPO No', datafield: 'lpono', width:'10%', hidden: true },
					{ text: 'Plan Status', datafield: 'planstatus', width:'10%', hidden: true },
       				{ text: 'LPO Amount', datafield: 'lpoamount', width:'10%', hidden: true,cellsformat:'d2' }

					]
    });
    $('#jqxJobcardCompleteGrid').on('rowdoubleclick', function (event) 
      		{ 
			  	var rowindex=event.args.rowindex;
				var planstatus=$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex, "planstatus");
				if(planstatus!=1){
					$.messager.alert('Warning','Job Planning not done');
					return false;
				}
			  	document.getElementById("docno").value = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
			  	document.getElementById("jobvocno").value = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex, "voc_no");
			  	
			  	checkMaterialReqPending(document.getElementById("docno").value);
			  	checkAdditionsPending(document.getElementById("docno").value);
			  	document.getElementById("brhid").value = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex, "brhid");
      			var reftype=$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'reftype');
      			var refno=$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'refno');
      			var savestatus=$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'savestatus');
      			$('#savestatus').val(savestatus);
      			$('#claimno').val($('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'claimno'));
      			$('#lpono').val($('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'lpono'));
      			$('#lpoamount').val($('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'lpoamount'));
      			funRoundAmt($('#lpoamount').val(),'lpoamount');
      			if(reftype=="EST"){
      				$('#estdocno').val($('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'estdocno'));
      				$('#sparediv').load('spareGrid.jsp?estdocno='+$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'doc_no')+'&id=1&savestatus='+savestatus);
      				$('#labourdiv').load('labourGrid.jsp?estdocno='+$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'estdocno')+'&id=1&savestatus='+savestatus);
      				$('#extradiv').load('extraDetailGrid.jsp?estdocno='+$('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue',rowindex,'estdocno')+'&id=1&savestatus='+savestatus);
      				var estdocno=$('#estdocno').val();
      				$('#esttotalgriddiv').load('estTotalGrid.jsp?id=1&estdocno='+estdocno);
      			}
      			$('#nettotal').val('0.0');
      			
      		});	 
    });
 
	
</script>
<div id="jqxJobcardCompleteGrid"></div>
<input type="hidden" id="jobvocno">