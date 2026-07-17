<%@page import="com.dashboard.workshop.invoiceprocessingpal.*"%>
<%
ClsInvProcessingDAO jobsdao=new ClsInvProcessingDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
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
var estimatedata=[];
var list = ['Shared', 'Insur.Company'];
 if(id=='1'){
	  estimatedata='<%=jobsdao.getEstimateData(jobcard,id)%>';
	  <%-- exceldata='<%=jobsdao.getJobcardWithoutInvoiceExcelData(fromdate, todate, id, branch, jobcard)%>'; --%>
} 
 else{
jobdata=[];
} 
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'estno',type:'string'},
                  		{name : 'labourtotal',type:'number'},
                  		{name : 'sparetotal',type:'number'},
                  		{name : 'nettotal',type:'number'},
                  		{name : 'chkclaim',type:'bool'},
                  		{name : 'claimno', type: 'string'},
                  		{name : 'excess',type:'number'},
                  		{name : 'pono',type:'string'},
                  		{name : 'podate', type: 'date'},
                  		{name : 'vattype',type:'string'},
                  		{name : 'downclaimno', type: 'string'},
                  		{name : 'downexcess',type:'number'},
                  		{name : 'downpono',type:'string'},
                  		{name : 'downpodate', type: 'date'},
                  		{name : 'downvattype',type:'string'},
                  		{name : 'chkmultiple',type:'string'},
                  		{name : 'addition',type:'string'},
                  		{name : 'insurtype',type:'string'},
                  		{name : 'insurtypedocno',type:'string'}
                  		
                  		],
				    localdata: estimatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    var rendererstring=function (aggregates) {
         	var value=aggregates['sum'];
         	if(value=="undefined" || value=="" || value==null || typeof(value)=="undefined"){
	         	value="0.0";	
         	}
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
    
    $("#estimationGrid").on("bindingcomplete", function (event) {
		var rows=$('#estimationGrid').jqxGrid('getrows');
    	for(var i=0;i<rows.length;i++){
    		var chkmultiple=$('#estimationGrid').jqxGrid('getcellvalue',i,'chkmultiple');
    		if(chkmultiple=='0'){
    			$('#excess').val($('#estimationGrid').jqxGrid('getcellvalue',i,'downexcess'));
    			$('#claimno').val($('#estimationGrid').jqxGrid('getcellvalue',i,'downclaimno'));
    			$('#pono').val($('#estimationGrid').jqxGrid('getcellvalue',i,'downpono'));
    			$('#podate').jqxDateTimeInput('setDate',$('#estimationGrid').jqxGrid('getcellvalue',i,'downpodate'));
    			$('#cmbvattype').val($('#estimationGrid').jqxGrid('getcellvalue',i,'downvattype'));
    		}
    	}
    	$("#overlay, #PleaseWait").hide();
    });        
    
    var cellclassname = function (row, column, value, data) {
		/*if(data.processstatus=="10"){
	    	return "redClass";
	    }*/
    };
	var isEditable = function (row) {
    	var value = $('#estimationGrid').jqxGrid('getcellvalue', row, "chkclaim");
    	if(!value)
        	return false;
		}
		var isEditableMain = function (row) {
    	var value = document.getElementById("chkmultiple").checked;
    	if(!value)
        	return false;
		}
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#estimationGrid").jqxGrid(
    {
        width: '98%',
        height: 150,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
        editable:true,
       	sortable:false,
       	showaggregates:true,
       	showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Est No',datafield:'estno',width:'8%', editable: false},
       				{ text: 'addn',datafield:'addn',width:'8%', editable: false,hidden:true},
       				{ text: 'Labour Total',datafield:'labourtotal',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Parts Total',datafield:'sparetotal',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right', editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Net Total', datafield: 'nettotal', width:"7%",cellsformat:'d2',align:'right',cellsalign:'right', editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Claim', datafield: 'chkclaim', width:"6%",columntype:'checkbox',cellbeginedit:isEditableMain},
       				{ text: 'Claim No',datafield:'claimno',width:'13%',cellbeginedit:isEditable},
       				{ text: 'Excess',datafield:'excess',width:'7%',cellbeginedit:isEditable,cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'PO No',datafield:'pono',width:'10%',cellbeginedit:isEditable},
       				{ text: 'PO Date', datafield: 'podate', width:'10%',columntype:'datetimeinput',cellbeginedit:isEditable,cellsformat:'dd.MM.yyyy'},
       				{ text: 'VAT Type', datafield: 'vattype', width:'10%',cellbeginedit:isEditable,columntype:'dropdownlist',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								}
 					},
 					{ text: 'Insur Type',datafield:'insurtype',width:'10%',cellbeginedit:isEditable},
 					{ text: 'Insur Type',datafield:'insurtypedocno',hidden:true,width:'10%',cellbeginedit:isEditable},
 					{ text: 'Claim No Down',datafield:'downclaimno',width:'14%',hidden:true},
       				{ text: 'Excess Down',datafield:'downexcess',width:'10%',cellbeginedit:isEditable,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
       				{ text: 'PO No Down',datafield:'downpono',width:'10%',cellbeginedit:isEditable,hidden:true},
       				{ text: 'PO Date Down', datafield: 'downpodate', width:'10%',columntype:'datetimeinput',cellbeginedit:isEditable,cellsformat:'dd.MM.yyyy',hidden:true},
					{ text: 'VAT Type Down',datafield:'downvattype',width:'10%',cellbeginedit:isEditable,hidden:true},
					{ text: 'Multiple',datafield:'chkmultiple',width:'10%',cellbeginedit:isEditable,hidden:true},
					{ text: 'addition',datafield:'addition',width:'10%',cellbeginedit:isEditable,hidden:true}
					
					]
    });
    $('#estimationGrid').on('celldoubleclick', function (event) 
    { 
    	// event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // row's visible index.
	    var rowVisibleIndex = event.args.visibleindex;
	    // right click.
	    var rightClick = event.args.rightclick; 
	    // original event.
	    var ev = event.args.originalEvent;
	    // column index.
	    var columnIndex = event.args.columnindex;
	    // column data field.
	    var dataField = event.args.datafield;
	    // cell value
	    var value = event.args.value;
		
		if(dataField=="insurtype"){
			$('#insurtypewindow').jqxWindow('open');
			$('#insurtypewindow').jqxWindow('focus');
			var insurcldocno=$('#insurcldocno').val();
			insurtypeSearchContent('insurtypeSearchGrid.jsp?id=1&estrowindex='+rowBoundIndex+'&insurcldocno='+insurcldocno);
		}					    
	});	 
});
</script>
<div id="estimationGrid"></div>