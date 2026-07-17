<%@page import="com.dashboard.workshop.partsplanning.*" %>
<%ClsPartsPlanningDAO plandao=new ClsPartsPlanningDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
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
	plandata='<%=plandao.getPartsPlanData(id, brhid)%>';
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
                      	
                      	
                      	
             ],
             localdata: plandata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#partsPlanningGrid").on("bindingcomplete", function (event) {
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



        $("#partsPlanningGrid").jqxGrid(
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
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '4%',pinned:true,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Branch',datafield: 'branch', width: '8%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobvocno', width: '6%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobdocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Job Date',datafield: 'date', width: '8%' ,pinned:true,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
    					{ text: 'Est.No',datafield: 'estvocno', width: '6%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Est.No',datafield: 'estdocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'GIP No',datafield: 'gatevocno', width: '6%',pinned:true,cellclassname: cellclassname},
    					{ text: 'GIP No',datafield: 'gatedocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Vehicle Details',datafield: 'vehicledetails',pinned:true ,cellclassname: cellclassname},
    					{ text: 'User Details',datafield: 'userdetails',width:'35%',pinned:true ,cellclassname: cellclassname},
						{ text: 'Branch ID',datafield: 'brhid', width: '11%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Client ID',datafield: 'cldocno', width: '11%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Reg No',datafield: 'regno', width: '11%',hidden:true ,cellclassname: cellclassname},
						
    	              ]
                });

				$('#partsPlanningGrid').on('rowdoubleclick', function (event) 
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
				    $('#jobcarddocno').val($('#partsPlanningGrid').jqxGrid('getcellvalue',boundIndex,'jobdocno'));
				    $('#jobcardvocno').val($('#partsPlanningGrid').jqxGrid('getcellvalue',boundIndex,'jobvocno'));
				    var estdocno=$('#partsPlanningGrid').jqxGrid('getcellvalue',boundIndex,'estdocno');
				    $('#partsgriddiv').load('partsGrid.jsp?estdocno='+estdocno+'&id=1&brhid='+$('#partsPlanningGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				    $('#txtcomment').val('');
				    getComments();
				   	$('.textpanel p').text('Job Card '+$('#jobcardvocno').val()+' with Reg No '+$('#partsPlanningGrid').jqxGrid('getcellvalue',boundIndex,'regno'));
				
				});
	});
</script>
<div id="partsPlanningGrid"></div>
<input type="hidden" name="gridrowindex" id="gridrowindex">