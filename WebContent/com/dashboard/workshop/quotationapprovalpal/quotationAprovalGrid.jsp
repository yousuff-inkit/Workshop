<%@page import="com.dashboard.workshop.quotationapprovalpal.*"%>
<%
ClsQuotationApprovalDAO qadao=new ClsQuotationApprovalDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
/* String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate"); */
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String approv=request.getParameter("aprv")==null?"":request.getParameter("aprv");
String docnos=request.getParameter("docnos")==null?"":request.getParameter("docnos");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var exceldata; 

if(id=='1'){
	  gatedata='<%=qadao.getApprovalDetails(todate,approv,docnos,branch)%>';   
	 <%--  exceldata='<%=qadao.getApprovalExportData(todate,approv,docnos,branch)%>';   --%>    
}
else{
gatedata=[];
exceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'estvocno',type:'number'},
                  		{name : 'gatevocno',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'gateinpassdocno',type:'string'},
                  		{name : 'discount',type:'number'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'view',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'labouttot',type:'number'},
                  		{name : 'sparetot',type:'number'},
                  		{name : 'nettotal',type:'number'},
                  		{name : 'brhid',type:'string'},
                  		{name : 'gipno',type:'number'},
                  		{name : 'vehno',type:'string'},
                  		{name : 'labaddition',type:'number'},
                  		{name : 'spaddition',type:'number'},
                  		{name : 'voc_no',type:'number'},
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
        showfilterrow:true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: true, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'estvocno',width:'5%'},
       				{ text: 'Addition', datafield:'labaddition',width:'5%'},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'GIP No',datafield:'gatevocno',width:'6%'},
       				{ text: 'User Name', datafield:'refname',width:'15%'},
       				{ text: 'Vehicle Number', datafield:'vehno',width:'10%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails'},
       				{ text: 'Labour Total',datafield:'labouttot',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Spare Total',datafield:'sparetot',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Discount',datafield:'discount',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Net Total',datafield:'nettotal',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Show Details',datafield:'view',width:'7%',columntype:'button'},
       				{ text: 'Brhid', datafield:'brhid',hidden:true},
       				{ text: 'gipno', datafield:'gipno',hidden:true},
       				
       				{ text: 'spaddition', datafield:'spaddition',hidden:true},
       				{ text: 'doc_no', datafield:'doc_no',hidden:true},
       				{ text: 'gateinpassdocno', datafield:'gateinpassdocno',hidden:true},
       				{ text: 'jcno', datafield:'voc_no',hidden:true}

					]
    });
    $('#quotationApprovalGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			document.getElementById("estDocno").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	  			document.getElementById("brhid").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
  	  			document.getElementById("gipnos").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "gipno");
  	  		    document.getElementById("estvocno").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "estvocno");
  	  		    document.getElementById("gipdocno").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "gateinpassdocno");
  	  		    document.getElementById("addition").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "labaddition");
  	  		    getEstPrintConfig();
      		});	 

    var labadd;
    var spadd;
     $('#quotationApprovalGrid').on('cellclick', function (event) 
    		{ 
    	 	var add;
    		var rowindex1=event.args.rowindex;
    			 if(event.args.datafield=="view"){
    				document.getElementById("brhid").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
  	  				document.getElementById("gipdocno").value = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "gateinpassdocno");
    				var docno = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    				var gipno1 = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "gipno");
    				var jcno = $('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
    				 labadd=$('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "labaddition");
    				 spadd=$('#quotationApprovalGrid').jqxGrid('getcellvalue', rowindex1, "spaddition");
    				 
    				/* alert("lab="+labadd+" sp="+spadd); */
    				
    				if(labadd==0 && spadd==0){
    				 	funEstmView(docno,gipno1); 
    				}
    				else{
    					if(spadd>labadd){
    						add=spadd;
    					}
    					else{
    						add=labadd;
    					}
    					funAdditionEstmView(docno,jcno,add)				
    				}
    			}
    		});
     
     function funEstmView(docno,gipno1){

    	  if(docno==''){
    	    $.messager.alert('Message','Choose a document','warning');
    	    return 0;
    	   }
    	  
    	  var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Estimation";
			window.parent.formCode.value="EST";
			
			var detName= "Estimation";
			var gipdocno=$('#gipdocno').val();
			var path= "com/workshop/estimationpal/estimationPalView.action?id=2&mode=view&docno="+docno+"&gipnoo="+gipdocno;
			top.addTab( detName,reurl[0]+""+path);
			
    	 }
     
     function funAdditionEstmView(docno,jcno,add){

   	  if(docno==''){
   	    $.messager.alert('Message','Choose a document','warning');
   	    return 0;
   	   }
   	  
   	  var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Addition Estimation";
			window.parent.formCode.value="WAE";
			
			var detName= "Addition Estimation";
			var gipdocno=$('#gipdocno').val();
			var brhid=$('#brhid').val();
			var path= "com/workshop/estimationadditionpal/estimationAdditionPalView.action?id=2&mode=view&docno="+docno+"&gipnoo="+gipdocno+"&addition="+add+"&brhid="+brhid+"&jcno="+jcno;
			top.addTab( detName,reurl[0]+""+path);
   	 }
     
    });

	
	
</script>
<div id="quotationApprovalGrid"></div>
