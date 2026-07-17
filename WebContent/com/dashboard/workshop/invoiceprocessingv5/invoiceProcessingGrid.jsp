<%@page import="com.dashboard.workshop.invoiceprocessingv5.*"%>
<%
ClsInvProcessingV5DAO jobsdao=new ClsInvProcessingV5DAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String invoicetype=request.getParameter("invoicetype")==null?"":request.getParameter("invoicetype");
%>
<style>
	.redClass{
   		background:#FFEBEB;
   	}
   	.purpleClass{
   		background:#E8DAEF;
   	}	
</style>
<script type="text/javascript">

var id='<%=id%>';
var jobdata=[];
var exceldata=[];

 if(id=='1'){
	  jobdata='<%=jobsdao.getJobcardWithoutInvoiceData(fromdate, todate, id, branch, jobcard,invoicetype)%>';
	  <%-- exceldata='<%=jobsdao.getJobcardWithoutInvoiceExcelData(fromdate, todate, id, branch, jobcard)%>'; --%>
} 
 else{
jobdata=[];
exceldata=[];
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
                  		{name : 'refvocno',type:'string'},
                  		{name : 'estdocno',type:'string'},
                  		{name : 'estvocno',type:'string'},
                  		{name : 'userdetails', type: 'string'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'btnview',type:'string'},
                  		{name : 'brhid', type: 'string'},
                  		{name : 'savestatus',type:'string'},
                  		{name : 'claimno',type:'string'},
                  		{name : 'lpono',type:'string'},
                  		{name : 'lpoamount',type:'number'},
                  		{name : 'insurcomp',type:'number'},
                  		{name : 'insurcldocno',type:'number'},
                  		{name : 'insurcompname',type:'string'},	
                  		{name : 'nontaxrow',type:'number'},
                  		{name : 'processstatus',type:'number'},
                  		{name : 'seccldocno',type:'number'},
                  		{name : 'clientinsurance',type:'number'},
                  		{name : 'faulttype',type:'number'},
                  		{name : 'ownfaultconfig',type:'number'}
                  		],
				    localdata: jobdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#invoiceProcessingGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var cellclassname = function (row, column, value, data) {
		if(parseInt(data.clientinsurance)==0){
	    	return "purpleClass";
	    }
	    if(parseInt(data.nontaxrow)>0){
	    	return "redClass";
	    }
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#invoiceProcessingGrid").jqxGrid(
    {
        width: '98%',
        height: 200,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
		showfilterrow:true ,
        sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Job Card No',datafield:'doc_no',width:'6%',hidden:true,cellclassname: cellclassname},
       				{ text: 'Job Card No',datafield:'voc_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'Ref Type',datafield:'reftype',width:'6%',cellclassname: cellclassname},
       				{ text: 'Ref No', datafield: 'refno', width:"6%",cellclassname: cellclassname},
       				{ text: 'Est No', datafield: 'estdocno', width:"6%",hidden:true,cellclassname: cellclassname},
       				{ text: 'Est No', datafield: 'estvocno', width:"6%",cellclassname: cellclassname},
       				{ text: 'User Details',datafield:'userdetails',width:'20%',cellclassname: cellclassname},
       				{ text: 'Insurance Company',datafield:'insurcompname',width:'13%',cellclassname: cellclassname},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'32%',cellclassname: cellclassname},
       				{ text: 'View',datafield:'btnview',width:'10%',columntype:'button',hidden:true,cellclassname: cellclassname},
       				{ text: 'brhid', datafield: 'brhid', width:'0%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Save Status', datafield: 'savestatus', width:'0%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Claim No',datafield:'claimno',width:'10%',hidden:true,cellclassname: cellclassname},
       				{ text: 'LPO No', datafield: 'lpono', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'LPO Amount', datafield: 'lpoamount', width:'10%', hidden: true,cellsformat:'d2' ,cellclassname: cellclassname},
       				{ text: 'Insurance Company', datafield: 'insurcomp', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Insurance', datafield: 'insurcldocno', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Non Tax Row Count', datafield: 'nontaxrow', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Process Status', datafield: 'processstatus', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'seccldocno', datafield: 'seccldocno', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Client Insurance', datafield: 'clientinsurance', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Fault Type', datafield: 'faulttype', width:'10%', hidden: true ,cellclassname: cellclassname},
       				{ text: 'Fault Config', datafield: 'ownfaultconfig', width:'10%', hidden: true ,cellclassname: cellclassname}
       				
					]
    });
    $('#invoiceProcessingGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			var jobvocno=$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
  	  			var jobdocno=$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	  			$('.helper-jobcard').text("Selected JobCard #"+jobvocno);
  	  			$('#amountGrid').jqxGrid('clear');
	  	  		$('#btninvsave').attr("disabled", false);;
		    	$('#btninvcalculate').attr("disabled", false);
		    	$('#faulttype').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "faulttype"));
		    	$('#ownfaultconfig').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "ownfaultconfig"));
		    	$('#clientinsurance').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "clientinsurance"));
  	  			
  	  			$('#jobcarddocno').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
  	  			var seccldocno=$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "seccldocno");
  	  			$('#seccldocno').val(seccldocno);
  	  			var clientinsurance=$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "clientinsurance");
  	  			$('#estimationgriddiv').load('estimationGrid.jsp?seccldocno='+seccldocno+'&id=1&jobcard='+jobdocno+'&clientinsurance='+clientinsurance);
				$('#amountgriddiv').load('amountGrid.jsp?seccldocno='+seccldocno+'&id=1&jobdocno='+$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				$('#jobcarddocno').val();
				/* $('#hidchkmultiple').val("0");
				var chkmultiple=$('#hidchkmultiple').val(); */
				$('#insurcldocno').val('');
				//$('#hidchkmultiple').val("0");
				$('#chkmultiple').val("0");
				$('#excess').val("0.0");
				$('#claimno').val("");
				$('#pono').val("");
				$('#cmbvattype').val("0");
				var insurcomp=$('#invoiceProcessingGrid').jqxGrid('getcellvalue',rowindex1,'insurcomp');
				if(insurcomp=="0"){
					$('#excess').attr('readonly',true);				
				}
				else{
					$('#excess').attr('readonly',false);
					var insurcldocno=$('#invoiceProcessingGrid').jqxGrid('getcellvalue',rowindex1,'insurcldocno');
					$('#insurcldocno').val(insurcldocno);
					if($('#insurtypeconfig').val()=='1'){
						$.get("getInsurType.jsp",{insurcldocno:insurcldocno}, function(data, status){
	    					data=JSON.parse(data);
	    					var htmldata='<option value="">--Select--</option>';
	    					$.each(data.typedata,function(index,value){
	    						htmldata+='<option value="'+value.docno+'">'+value.typename+'</option>';
	    					});
	    					$('#cmbinsurtype').html($.parseHTML(htmldata));
	  					});	
					}
					
				}
				var nontaxrow=parseInt($('#invoiceProcessingGrid').jqxGrid('getcellvalue',rowindex1,'nontaxrow'));
				$('#nonTaxGrid').jqxGrid('clear');
				$('#processstatus').val('');
				if(nontaxrow>0){
					//$('div[data-invoicing="normal"]').hide();
					//$('div[data-invoicing="nontax"]').show();
					var jobdocno=$('#jobcarddocno').val();
					$('#nontaxgriddiv').load('nonTaxGrid.jsp?jobdocno='+jobdocno+'&id=1');
					$('#processstatus').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue',rowindex1,'processstatus'));
					$.get('getNonTaxInvNo.jsp',{'jobdocno':$('#jobcarddocno').val()},function(data){
						data=JSON.parse(data);
						if(parseInt(data.invno)>0){
							$('#invno').val(data.invno);
							$('#invbrhid').val(data.invbrhid);
						}
						else{
							$('#invno').val('');
						}
					});
				}
				else{
					//$('div[data-invoicing="normal"]').show();
					//$('div[data-invoicing="nontax"]').hide();
					
					
				}
      		});	 
     
  
    });

	
	
</script>
<div id="invoiceProcessingGrid"></div>
<input type="hidden" name="insurcldocno" id="insurcldocno">
<input type="hidden" name="processstatus" id="processstatus">
<input type="hidden" name="ownfaultconfig" id="ownfaultconfig">
<input type="hidden" name="clientinsurance" id="clientinsurance">