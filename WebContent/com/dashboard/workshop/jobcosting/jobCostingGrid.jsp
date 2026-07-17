<%@page import="com.dashboard.workshop.jobcosting.*" %>
<%ClsWSJobCostingDAO floordao=new ClsWSJobCostingDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%>

<script type="text/javascript">
var id='<%=id%>';
var costdata=[];
var costexceldata=[];
if(id=="1"){
	costdata='<%=floordao.getJobCostingData(id, type)%>';
	costexceldata='<%=floordao.getJobCostingExcelData(id, type)%>';
}
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'service' , type: 'string'},
 						{name : 'jobdocno', type: 'number'},
						{name : 'rowno', type: 'number'},
 						{name : 'jobvocno', type:'number'},
 						{name : 'vehicledetails',type:'string'},
 						{name : 'regno',type:'number'},
                      	{name : 'billto', type: 'string'  },
                      	{name : 'refname',type:'string'},
                      	{name : 'jobdate',type:'date'},
                      	{name : 'age',type:'string'},
                      	{name : 'priority',type:'string'},
                      	{name : 'partsstatus',type:'string'},
                      	{name : 'partsexpdate',type:'date'},
                      	{name : 'promiseddate',type:'date'},
                      	{name : 'extdate',type:'date'},
                      	{name : 'esthrs',type:'number'},
                      	{name : 'actualhrs',type:'number'},
                      	{name : 'hrsdiff',type:'number'},
                      	{name : 'grpname',type:'string'},
                      	{name : 'estimator',type:'string'},
                      	{name : 'srvcadvisor',type:'string'},
                      	{name : 'salesman',type:'string'},
                      	{name : 'insursurvivor',type:'string'},
                      	{name : 'referedby',type:'string'},
                      	{name : 'unattendedstatus',type:'number'},
                      	{name : 'esttotal',type:'number'},
                      	{name : 'sellingparts',type:'number'},
                      	{name : 'sellinglabour',type:'number'},
                      	{name : 'sellingtotal',type:'number'},
                      	{name : 'estparts',type:'number'},
                      	{name : 'estlabour',type:'number'},
                      	{name : 'estlabourhrs',type:'number'},
                      	{name : 'actualparts',type:'number'},
                      	{name : 'actuallabourhrs',type:'number'},
                      	{name : 'actuallabourcost',type:'number'},
                      	{name : 'varianceparts',type:'number'},
                      	{name : 'variancelabourhrs',type:'number'},
                      	{name : 'variancelabourcost',type:'number'},
                      	{name : 'contributionparts',type:'number'},
                      	{name : 'contributionlabour',type:'number'},
                      	{name : 'contributiontotal',type:'number'}
                      	
             ],
             localdata: costdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        
        $("#jobCostingGrid").on("bindingcomplete", function (event) {
    		$("#overlay, #PleaseWait").hide();
    	});
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#jobCostingGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%',pinned:true,cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Job No',datafield: 'jobvocno', width: '4%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobdocno', width: '5%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Job Date',datafield: 'jobdate', width: '7%' ,pinned:true,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Vehicle Details',datafield: 'vehicledetails', width: '15%',pinned:true ,cellclassname: cellclassname},
    					{ text: 'Bill To',datafield: 'billto', width: '12%',pinned:true ,cellclassname: cellclassname},
    					{ text: 'Client',datafield: 'refname', width: '12%' ,pinned:true,cellclassname: cellclassname},
    					{ text: 'Age', datafield: 'age', width: '4%',pinned:true,cellclassname: cellclassname},
						{ text: 'Priority', datafield: 'priority', width: '5%',cellclassname: cellclassname},
						{ text: 'Service',datafield:'service',width: '6%',cellclassname: cellclassname},
						{ text: 'Parts',datafield:'sellingparts',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'sellingprice',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour',datafield:'sellinglabour',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'sellingprice',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Total',datafield:'sellingtotal',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'sellingprice',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts',datafield:'estparts',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'estimated',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Hrs',datafield:'estlabourhrs',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'estimated',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour',datafield:'estlabour',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'estimated',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts',datafield:'actualparts',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'actual',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Hrs',datafield:'actuallabourhrs',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'actual',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Cost',datafield:'actuallabourcost',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'actual',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts',datafield:'varianceparts',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'variance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Hrs',datafield:'variancelabourhrs',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'variance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Cost',datafield:'variancelabourcost',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'variance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts',datafield:'contributionparts',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'contribution',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour',datafield:'contributionlabour',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'contribution',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Total',datafield:'contributiontotal',width:'6%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'contribution',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
						{ text: 'rowno', datafield: 'rowno', width: '4%',hidden:true,cellclassname: cellclassname},
						
						/*{ text: 'Parts Status', datafield: 'partsstatus', width: '8%',cellclassname: cellclassname},
						{ text: 'Parts Exp.Date', datafield: 'partsexpdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Promised Date', datafield: 'promiseddate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Extended Date', datafield: 'extdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Est.Hrs', datafield: 'esthrs', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Actual Hrs', datafield: 'actualhrs', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Hrs Diff', datafield: 'hrsdiff', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Est.Total', datafield: 'esttotal', width: '5%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						*/
						{ text: 'Group', datafield: 'grpname', width: '8%',cellclassname: cellclassname},
						{ text: 'Estimator', datafield: 'estimator', width: '8%',cellclassname: cellclassname},
						{ text: 'Service Advisor', datafield: 'srvcadvisor', width: '8%',cellclassname: cellclassname},
						{ text: 'Salesman', datafield: 'salesman', width: '8%',cellclassname: cellclassname},
						{ text: 'Insurance Survivor', datafield: 'insursurvivor', width: '8%',cellclassname: cellclassname},
						{ text: 'Referred By', datafield: 'referedby', width: '8%',cellclassname: cellclassname},
						{ text: 'Un Attended Status', datafield: 'unattendedstatus', width: '5%',cellclassname: cellclassname,cellsformat:'d2',hidden:true},,
						{ text: 'Reg No', datafield: 'regno', width: '5%',cellclassname: cellclassname,cellsformat:'d',hidden:true},
						
						
    	              ],
    	              columngroups: 
					    [
					        { text: 'Selling Price', align: 'center', name: 'sellingprice' },
					        { text: 'Estimated', align: 'center', name: 'estimated' },
					        { text: 'Actual', align: 'center', name: 'actual' },
					        { text: 'Variance', align: 'center', name: 'variance' },
					        { text: 'Contribution', align: 'center', name: 'contribution' },
					    ]
                });

				$('#jobCostingGrid').on('rowdoubleclick', function (event) 
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
				    
				});
	});
</script>
<div id="jobCostingGrid"></div>