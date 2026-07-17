<%@page import="com.dashboard.workshop.confirmestimationfancy.*"%>
<%
ClsConfirmEstimationDAO gatedao=new ClsConfirmEstimationDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");


%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var estexceldata;

if(id=='1'){
gatedata='<%=gatedao.getEstimationData(cldocno,fromdate,todate,id)%>';
estexceldata='<%=gatedao.getEstimationExcelData(cldocno,fromdate,todate,id)%>';
}
else{
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
                  		{name : 'gateinpassvocno',type:'string'},
                  		
                  		{name : 'gipvocno',type:'string'},
                  		{name : 'clientname',type:'string'},
                  		{name : 'vehicledetails', type: 'string'},
                  		{name : 'sparetot',type:'number'},
                  		{name : 'labouttot',type:'number'},
                  		{name : 'discount',type:'number'},
                  		{name : 'nettotal',type:'number'},
                  		{name : 'brhid', type: 'string'},
                  		{name : 'labaddition', type: 'string'},
                  		{name : 'spaddition', type: 'string'},
                  		{name : 'labmaddn', type: 'string'},
                  		{name : 'spmaddn', type: 'string'},
                  		{name : 'jobno', type: 'string'},
                  		{name : 'voc_no',type:'number'}
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#confirmEstimationGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#confirmEstimationGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
       columnsresize: true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%',hidden:true},
       				{ text: 'Doc No',datafield:'voc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Gate In Pass Doc No',datafield:'gateinpassdocno',width:'10%',hidden:true},
       				{ text: 'Gate In Pass Doc No',datafield:'gateinpassvocno',width:'10%'},
       				{ text: 'Client Name',datafield:'clientname',width:'20%'},
       				{ text: 'Vehicle Details', datafield: 'vehicledetails', width:"27%"},
       				{ text: 'Spare Total',datafield:'sparetot',width:'9%',cellsformat: 'd2', align: 'right', cellsalign: 'right'},
       				{ text: 'Labour Total',datafield:'labouttot',width:'9%',cellsformat: 'd2', align: 'right', cellsalign: 'right'},
       				{ text: 'Discount',datafield:'discount',width:'7%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , hidden: true },
       				{ text: 'Net Total',datafield:'nettotal',width:'9%',cellsformat: 'd2', align: 'right', cellsalign: 'right'},
       				
       				{ text: 'brhid',datafield:'brhid',width:'0%',hidden: true},
       				{ text: 'labaddition',datafield:'labaddition',width:'0%',hidden: false},
       				{ text: 'spaddition',datafield:'spaddition',width:'0%',hidden: true},
       				{ text: 'labmaxaddn',datafield:'labmaddn',width:'0%',hidden: true},
       				{ text: 'spmaxaddn',datafield:'spmaddn',width:'0%',hidden: true},
       				{ text: 'jocardno',datafield:'jobno',width:'0%',hidden: true}
       				
       				]
    });
    $('#confirmEstimationGrid').on('rowdoubleclick', function (event) 
      		{ 
			  	var rowindex1=event.args.rowindex;
			  	document.getElementById("docno").value = $('#confirmEstimationGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			  	document.getElementById("brhid").value = $('#confirmEstimationGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
			  	document.getElementById("hidgipno").value = $('#confirmEstimationGrid').jqxGrid('getcellvalue', rowindex1, "gateinpassdocno");
			  	document.getElementById("hidjobno").value = $('#confirmEstimationGrid').jqxGrid('getcellvalue', rowindex1, "jobno");
			  	document.getElementById("hidlabaddition").value = $('#confirmEstimationGrid').jqxGrid('getcellvalue', rowindex1, "labaddition");
			  	
				getAddition(document.getElementById("docno").value);
      			$("#overlay, #PleaseWait").show();
      		});	 
     
  
    });
		
	function getAddition(value){
		var docno=$('#docno').val();
		var brhid=$('#brhid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		 }
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim().split("::");
				
				document.getElementById("hidlabaddition").value = items[0];
			  	document.getElementById("hidspaddition").value = items[2];
			  	document.getElementById("hidlabadditionmax").value = items[1];
			  	document.getElementById("hidspadditionmax").value = items[3];
				$("#overlay, #PleaseWait").hide();
			}
			else{
				}
			}
		
		x.open("GET", "getAddition.jsp?docno="+value, true);
		x.send();
	}	
		
		
		

	
	
</script>
<div id="confirmEstimationGrid"></div>