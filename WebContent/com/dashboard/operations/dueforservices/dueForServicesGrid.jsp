<%@page import="com.dashboard.operations.dueforservices.*" %>
<% ClsDueForServicesDAO duedao=new ClsDueForServicesDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");

%>
<style>
	.redClass
	{
	   background:#FFEBEB;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var duedata;
if(id=="1"){
duedata='<%=duedao.getData(id)%>';
dueexceldata='<%=duedao.getExcelData(id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'currentstatus', type: 'string'},
						{name : 'fleet_no',type:'number'},
						{name : 'reg_no', type: 'number'},
						{name : 'flname',type:'string'},
						{name : 'refname', type: 'string'},
						{name : 'per_mob',type:'number'},
						{name : 'voc_no',type:'string'},
						{name : 'okm',type:'number'},
						{name : 'currentkm',type:'number'},
						{name : 'duestatus',type:'number'},
						{name : 'nextduekm',type:'number'},
						{name : 'dueinkm',type:'number'}

						],
				    localdata: duedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#dueForServicesGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    
    var cellclassname = function (row, column, value, data) {
	   	if(parseFloat(data.dueinkm)<=1000){
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

    $("#dueForServicesGrid").jqxGrid(
    {
        width: '99%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },	
                  	 { text: 'Fleet No', datafield: 'fleet_no', width: '5%',cellclassname: cellclassname},
				     { text: 'Reg No', datafield:'reg_no', width: '5%',cellclassname: cellclassname},
				     { text: 'Fleet Name',datafield:'flname',width:'14%',cellclassname: cellclassname},
				     { text: 'Current Status',datafield:'currentstatus',width:'8%',cellclassname: cellclassname},
				     { text: 'Client Name',datafield:'refname',width:'20%',cellclassname: cellclassname},
				     { text: 'Client Mobile',datafield:'per_mob',width:'14%',cellclassname: cellclassname},
				     { text: 'Agmt No',datafield:'voc_no',width:'6%',cellclassname: cellclassname},
				     { text: 'Out Km',datafield:'okm',width:'6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				     { text: 'Current Km',datafield:'currentkm',width:'6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				     { text: 'Next Due',datafield:'nextduekm',width:'6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				     { text: 'Due In',datafield:'dueinkm',width:'6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				     { text: 'Due Status',datafield:'duestatus',width:'6%',hidden:true,cellclassname: cellclassname}
					]
   
    });

    $('#dueForServicesGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	var duestatus=$('#dueForServicesGrid').jqxGrid('getcellvalue',rowindex,'duestatus');
    		$('#servicekm,#btnupdate').attr('disabled',false);
    		$('#servicekm').val($('#dueForServicesGrid').jqxGrid('getcellvalue',rowindex,'currentkm'));
    		$('#fleetno').val($('#dueForServicesGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
    }); 
});
    
</script>
<div id="dueForServicesGrid"></div>
