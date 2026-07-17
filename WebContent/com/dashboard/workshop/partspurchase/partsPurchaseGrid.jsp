<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%ClsPartsPurchaseDAO plandao=new ClsPartsPurchaseDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String filter=request.getParameter("filter")==null?"":request.getParameter("filter");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var plandata=[];
if(id=="1"){
	plandata='<%=plandao.getPartsPlanData(id, brhid, filter)%>';
}
/*var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}*/
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'branch' , type: 'string'},
 						{name : 'jobdocno', type: 'number'},
						{name : 'jobvocno', type: 'number'},
 						{name : 'date', type:'date'},
 						{name : 'vehicledetails',type:'string'},
 						{name : 'userdetails',type:'string'},
                      	{name : 'estdocno', type: 'number'  },
                      	{name : 'estvocno',type:'number'},
                      	{name : 'gatedocno',type:'number'},
                      	{name : 'gatevocno',type:'number'},
                      	{name : 'brhid',type:'string'},
                      	{name : 'cldocno',type:'string'},
                      	{name : 'regno',type:'string'},
                      	{name : 'gistatus',type:'string'},
                    	{name : 'qty',type:'number'},
                      	{name : 'issueqty',type:'number'},
                      	{name : 'cotqty',type:'number'},
                      	{name : 'nipoqty',type:'number'},
                      	{name : 'balqty',type:'number'},
                      	{name : 'niqty',type:'number'},
                      	{name : 'nibalqty',type:'number'},
                      	{name : 'processstatus',type:'number'},
                      	
             ],
             localdata: plandata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        $("#partsPurchaseGrid").on("bindingcomplete", function (event) { 
        	$('.load-wrapp').hide();
    	}); 
        
        var cellclassname = function (row, column, value, data) {
        	if(data.gistatus=="1"){
            	return "greenClass";
            }
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#partsPurchaseGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                  	enabletooltips:true,
                    altrows:true,
                    sortable:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:false,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '3%',pinned:true,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Branch',datafield: 'branch', width: '8%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobvocno', width: '5%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobdocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Job Date',datafield: 'date', width: '5%' ,pinned:true,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
    					{ text: 'Est.No',datafield: 'estvocno', width: '5%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Est.No',datafield: 'estdocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'GIP No',datafield: 'gatevocno', width: '5%',pinned:true,cellclassname: cellclassname},
    					{ text: 'GIP No',datafield: 'gatedocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Vehicle Details',datafield: 'vehicledetails',pinned:true ,cellclassname: cellclassname},
    					{ text: 'User Details',datafield: 'userdetails',width:'20%',pinned:true ,cellclassname: cellclassname},
						{ text: 'Branch ID',datafield: 'brhid', width: '11%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Client ID',datafield: 'cldocno', width: '11%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Reg No',datafield: 'regno', width: '11%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Qty',datafield: 'qty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'Issue Qty',datafield: 'issueqty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'CD Qty',datafield: 'cotqty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'PO Qty',datafield: 'nipoqty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'Bal Qty',datafield: 'balqty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'NI Qty',datafield: 'niqty', width: '5%',pinned:true,cellclassname: cellclassname},
						{ text: 'NI Bal Qty',datafield: 'nibalqty', width: '5%',pinned:true,cellclassname: cellclassname},
						
    	              ]
                });

				$('#partsPurchaseGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = event.args.rowindex;
				    // row's visible index.
				    var visibleIndex = event.args.visibleindex;
				    // right click.
				    var rightclick = event.args.rightclick; 
				    // original event.
				    var ev = event.args.originalEvent;
				    $('#gridrowindex').val(boundIndex);
				    $('#jobcarddocno').val($('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'jobdocno'));
				    $('#jobcardvocno').val($('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'jobvocno'));
				    var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'estdocno');
				    $('#partsgriddiv').load('partsGrid.jsp?estdocno='+estdocno+'&id=1&brhid='+$('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				    $('#txtcomment').val('');
				    getComments();
				   	$('.textpanel p').text('Job Card '+$('#jobcardvocno').val()+' with Reg No '+$('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'regno'));
					$("#hidremarks").val('Job Card '+$('#jobcardvocno').val()+' with Reg No '+$('#partsPurchaseGrid').jqxGrid('getcellvalue',boundIndex,'regno'))
				});
	});
	
</script>
<div id="partsPurchaseGrid"></div>
<input type="hidden" name="gridrowindex" id="gridrowindex">