<%@page import="com.dashboard.workshop.invoiceprocessingpal.*"%>
<%
ClsInvProcessingDAO jobsdao=new ClsInvProcessingDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
%>
<style>
.redClass
   		{
   		   background:#FFEBEB;
   		}
</style>
<script type="text/javascript">

var id='<%=id%>';
var jobdata=[];
var exceldata=[];

 if(id=='1'){
	  jobdata='<%=jobsdao.getJobcardWithoutInvoiceData(fromdate, todate, id, branch, jobcard)%>';
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
                  		{name : 'insurcompname',type:'string'}
                  	
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
		if(data.processstatus=="10"){
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
       				{ text: 'Job Card No',datafield:'doc_no',width:'6%',hidden:true},
       				{ text: 'Job Card No',datafield:'voc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Ref Type',datafield:'reftype',width:'6%'},
       				{ text: 'Ref No', datafield: 'refno', width:"6%"},
       				{ text: 'Est No', datafield: 'estdocno', width:"6%",hidden:true},
       				{ text: 'Est No', datafield: 'estvocno', width:"6%"},
       				{ text: 'User Details',datafield:'userdetails',width:'20%'},
       				{ text: 'Insurance Company',datafield:'insurcompname',width:'13%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'32%'},
       				{ text: 'View',datafield:'btnview',width:'10%',columntype:'button',hidden:true},
       				{ text: 'brhid', datafield: 'brhid', width:'0%', hidden: true },
       				{ text: 'Save Status', datafield: 'savestatus', width:'0%', hidden: true },
       				{ text: 'Claim No',datafield:'claimno',width:'10%',hidden:true},
       				{ text: 'LPO No', datafield: 'lpono', width:'10%', hidden: true },
       				{ text: 'LPO Amount', datafield: 'lpoamount', width:'10%', hidden: true,cellsformat:'d2' },
       				{ text: 'Insurance Company', datafield: 'insurcomp', width:'10%', hidden: true },
       				{ text: 'Insurance', datafield: 'insurcldocno', width:'10%', hidden: true },
					]
    });
    $('#invoiceProcessingGrid').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
	  	  		$('#btninvsave').attr("disabled", false);;
		    	$('#btninvcalculate').attr("disabled", false);;
  	  			$('#jobcarddocno').val($('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
  	  			$('#estimationgriddiv').load('estimationGrid.jsp?id=1&jobcard='+$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				$('#amountgriddiv').load('amountGrid.jsp?id=1&jobdocno='+$('#invoiceProcessingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
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
				
      		});	 
     
  
    });

	
	
</script>
<div id="invoiceProcessingGrid"></div>
<input type="hidden" name="insurcldocno" id="insurcldocno">