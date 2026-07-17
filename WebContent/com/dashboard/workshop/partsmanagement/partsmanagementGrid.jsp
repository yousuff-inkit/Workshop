<%@page import="com.dashboard.workshop.partsmanagement.*" %>
<%CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();
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
<%-- var id='<%=id%>'; --%>
var floordata=[];
var check='<%=id%>';
//alert(check);
 if(check!=0){  
	floordata='<%=partsdao.getPartsMgmtData(brhid)%>';
	floordataexcel='<%=partsdao.getPartsMgmtDataexcel()%>';

 }else{
	floordata;
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
 						{name : 'partremarks',type:'string'},
                      	{name : 'billto', type: 'string'  },
                      	{name : 'refname',type:'string'},
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
						{name : 'refno',type:'string'},
						{name : 'jobdate',type:'date'},
						{name : 'entrydate',type:'date'},
						{name : 'branchname',type:'string'},
						{name : 'brhid',type:'string'}
						
                      	
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
       /*  var cellclassname = function (row, column, value, data) {
        	if(data.z1.includes("P")){
            	return "redClass";
            }
        };
        var cellclassname1 = function (row, column, value, data) {
        	if(data.z1.includes("P")){
            	return "yellowClass";
            }
            else if(data.z1.includes("C")){
            	return "greenClass";
            }
            else if(data.z1.includes("S")){
            	return "blueClass";
            }
            else if(data.z1.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname2 = function (row, column, value, data) {
        	if(data.z2.includes("P")){
            	return "yellowClass";
            }
            else if(data.z2.includes("C")){
            	return "greenClass";
            }
            else if(data.z2.includes("S")){
            	return "blueClass";
            }
            else if(data.z2.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname3 = function (row, column, value, data) {
        	if(data.z3.includes("P")){
            	return "yellowClass";
            }
            else if(data.z3.includes("C")){
            	return "greenClass";
            }
            else if(data.z3.includes("S")){
            	return "blueClass";
            }
            else if(data.z3.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname4 = function (row, column, value, data) {
        	if(data.z4.includes("P")){
            	return "yellowClass";
            }
            else if(data.z4.includes("C")){
            	return "greenClass";
            }
            else if(data.z4.includes("S")){
            	return "blueClass";
            }
            else if(data.z4.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname5 = function (row, column, value, data) {
        	if(data.z5.includes("P")){
            	return "yellowClass";
            }
            else if(data.z5.includes("C")){
            	return "greenClass";
            }
            else if(data.z5.includes("S")){
            	return "blueClass";
            }
            else if(data.z5.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname6 = function (row, column, value, data) {
        	if(data.z6.includes("P")){
            	return "yellowClass";
            }
            else if(data.z6.includes("C")){
            	return "greenClass";
            }
            else if(data.z6.includes("S")){
            	return "blueClass";
            }
            else if(data.z6.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname7 = function (row, column, value, data) {
        	if(data.z7.includes("P")){
            	return "yellowClass";
            }
            else if(data.z7.includes("C")){
            	return "greenClass";
            }
            else if(data.z7.includes("S")){
            	return "blueClass";
            }
            else if(data.z7.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname8 = function (row, column, value, data) {
        	if(data.z8.includes("P")){
            	return "yellowClass";
            }
            else if(data.z8.includes("C")){
            	return "greenClass";
            }
            else if(data.z8.includes("S")){
            	return "blueClass";
            }
            else if(data.z8.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname9 = function (row, column, value, data) {
        	if(data.z9.includes("P")){
            	return "yellowClass";
            }
            else if(data.z9.includes("C")){
            	return "greenClass";
            }
            else if(data.z9.includes("S")){
            	return "blueClass";
            }
            else if(data.z9.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname10 = function (row, column, value, data) {
        	if(data.z10.includes("P")){
            	return "yellowClass";
            }
            else if(data.z10.includes("C")){
            	return "greenClass";
            }
            else if(data.z10.includes("S")){
            	return "blueClass";
            }
            else if(data.z10.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname11 = function (row, column, value, data) {
        	if(data.z11.includes("P")){
            	return "yellowClass";
            }
            else if(data.z11.includes("C")){
            	return "greenClass";
            }
            else if(data.z11.includes("S")){
            	return "blueClass";
            }
            else if(data.z11.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname12 = function (row, column, value, data) {
        	if(data.z12.includes("P")){
            	return "yellowClass";
            }
            else if(data.z12.includes("C")){
            	return "greenClass";
            }
            else if(data.z12.includes("S")){
            	return "blueClass";
            }
            else if(data.z12.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname13 = function (row, column, value, data) {
        	if(data.z13.includes("P")){
            	return "yellowClass";
            }
            else if(data.z13.includes("C")){
            	return "greenClass";
            }
            else if(data.z13.includes("S")){
            	return "blueClass";
            }
            else if(data.z13.includes("N")){
            	return "redClass";
            }
        };
        var cellclassname14 = function (row, column, value, data) {
        	if(data.z14.includes("P")){
            	return "yellowClass";
            }
            else if(data.z14.includes("C")){
            	return "greenClass";
            }
            else if(data.z14.includes("S")){
            	return "blueClass";
            }
            else if(data.z14.includes("N")){
            	return "redClass";
            }
        }; */
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',pinned:true,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						
						{ text: 'Job Date',datafield: 'jobdate', width: '6%',pinned:true,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Job No',datafield: 'jobvocno', width: '5%',pinned:true},
    					{ text: 'Row No',datafield: 'rowno', width: '5%',pinned:true,hidden:true},
    					{ text: 'Job No',datafield: 'jobdocno', width: '6%',hidden:true},
    					{ text: 'Branch',datafield: 'branchname', width: '7%',pinned:true},
    					{ text: 'Vehicle Details',datafield: 'vehicledetails', width: '24%',pinned:true},
    					{ text: 'Bill To',datafield: 'billto', width: '15%',pinned:true},
    					{ text: 'Client',datafield: 'refname', width: '15%' ,pinned:true},
    					{ text: 'Service',datafield:'service',width: '7%',pinned:true},
    					{ text: 'Age', datafield: 'age', width: '4%',pinned:true},
    					{ text: 'Priority', datafield: 'priority', width: '6%'},
						{ text: 'Parts Status', datafield: 'partsstatus', width: '8%'},
						{ text: 'Parts Exp.Date', datafield: 'partsexpdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Promised Date', datafield: 'promiseddate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Extended Date', datafield: 'extdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Est.Hrs', datafield: 'esthrs', width: '5%'},
						{ text: 'Actual Hrs', datafield: 'actualhrs', width: '5%'},
						{ text: 'Hrs Diff', datafield: 'hrsdiff', width: '5%'},
						{ text: 'Group', datafield: 'grpname', width: '8%'},
						{ text: 'Estimator', datafield: 'estimator', width: '8%'},
						{ text: 'Service Advisor', datafield: 'srvcadvisor', width: '8%'},
						{ text: 'Salesman', datafield: 'salesman', width: '8%'},
						{ text: 'Part Remarks', datafield: 'partremarks', width: '8%'},
						{ text: 'Insurance Survivor', datafield: 'insursurvivor', width: '8%'},
						{ text: 'Referred By', datafield: 'referedby', width: '8%'},
						{ text: 'refno', datafield: 'refno', width: '8%'},
						{ text: 'Entry Date',datafield: 'entrydate', width: '10%',pinned:true,cellsformat:'dd.MM.yyyy:hh.mm.ss',hidden:true},
						
    	              ]
                });

				$('#floorMgmtGrid').on('rowdoubleclick', function (event) 
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
				    
				    $('#jobcarddocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'jobdocno'));
				    $('#jobcardvocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'jobvocno'));
				    $('#rowsno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'rowno'));
				    var rowsno=$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, 'rowno');
				    var jobno=$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, 'jobdocno');
				    //alert(jobno);
				    $("#partsgrid3div").load("partsGrid.jsp?rowno="+$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, 'jobdocno')+"&check="+1);
				    $("#partflwupgrid").load("partsfllwup.jsp?docno="+jobno+"");
				    $("#nidescdetailsGrid").jqxGrid('clear');
				});
	});
</script>
<div id="floorMgmtGrid"></div>