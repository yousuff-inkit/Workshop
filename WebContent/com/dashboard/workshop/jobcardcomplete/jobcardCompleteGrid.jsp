<%@page import="com.dashboard.workshop.jobcardcomplete.*"%>
<%
ClsJobcardCompleteDAO gatedao=new ClsJobcardCompleteDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
// var gateexceldata;

if(id=='1'){
gatedata='<%=gatedao.getJobcardData(clientname,fromdate,todate)%>';

	

 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
gatedata=[];
// gateexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'reftype',type:'string'},
                  		{name : 'refno',type:'string'},
                  		{name : 'userdetails', type: 'string'},
                  		{name : 'vehicledetails',type:'number'},
                  		{name : 'btnview',type:'string'},
                  		{name : 'brhid', type: 'string'}
				
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
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
       sortable:false,
       columnsresize: true,
        columns: [
               
       				{ text: 'Doc No',datafield:'doc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Ref Type',datafield:'reftype',width:'6%'},
       				{ text: 'Ref No', datafield: 'refno', width:"10%"},
       				
       				{ text: 'User Details',datafield:'userdetails',width:'32%',cellsformat: 'd2', align: 'right', cellsalign: 'right'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'30%',cellsformat: 'd2', align: 'right', cellsalign: 'right'},
       				{ text: 'View',datafield:'btnview',width:'10%',columntype:'button'},
       				{ text: 'brhid', datafiels: 'brhid', width:'0%', hidden: true }


					]
    });
    $('#jqxJobcardCompleteGrid').on('rowdoubleclick', function (event) 
      		{ 
			  	var rowindex1=event.args.rowindex;
			  	document.getElementById("docno").value = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			  	document.getElementById("brhid").value = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
      		});	 
    $('#jqxJobcardCompleteGrid').on('cellclick', function (event) 
      		{ 
			  	var rowindex1=event.args.rowindex;
			  	if(event.args.datafield=="btnview"){
			  		var docno = $('#jqxJobcardCompleteGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			  		funView(docno);
			  	}
      		});
    });
    
    function funView(docno){
    	alert("function called"+docno);
    	
    	var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Job Card";
		window.parent.formCode.value="JC";
		
		var detName= "Job Card";
		var path= "com/workshop/jobcard/jobCardView.action?mode=view&docno="+docno;
		top.addTab( detName,reurl[0]+""+path);
    }

	
	
</script>
<div id="jqxJobcardCompleteGrid"></div>