<%@page import="com.dashboard.operations.vehicleinsurance.*" %>
<%
ClsVehicleInsuranceDAO vehdao=new ClsVehicleInsuranceDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String type=request.getParameter("type")==null?"":request.getParameter("type");
System.out.println(id+"::"+desc);
%> 
<script type="text/javascript">
var type='<%=type%>';
var insurmultipledata;
var insurmultipleexceldata;
var id='<%=id%>';
if(id=="1"){
	insurmultipledata='<%=vehdao.getInsurData(uptodate,branch,desc,id)%>';
	insurmultipleexceldata='<%=vehdao.getInsurDataExcel(uptodate,branch,desc,id)%>';
}
else{
	insurmultipledata=[];
}
var selectmode='';
if($('#desc').val()=='Insured'){
	selectmode='singlerow';
}
else if($('#desc').val()=='Not Insured'){
	selectmode='checkbox';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'voc_no', type: 'string'  },
                 	{name : 'doc_no',type:'string'},
                 	{name : 'branchname',type:'string'},
                 	{name : 'refname',type:'string'},
                 	{name : 'date',type:'date'},
                 	{name : 'outdate',type:'date'},
                 	{name : 'enddate',type:'date'},
                 	{name : 'fleet_no',type:'string'},
                 	{name : 'reg_no',type:'string'},
                 	{name : 'flname',type:'string'},
                 	{name : 'ch_no',type:'string'},
                 	{name : 'prch_cost',type:'string'},
                 	{name : 'insuramount',type:'number'},
                 	{name : 'insurfromdate',type:'date'},
                 	{name : 'insurtodate',type:'date'}
					
                 			
						],
				    localdata: insurmultipledata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#multipleVehicleInsurGrid").on("bindingcomplete", function (event) {
    	// your code here.
    	$("#overlay, #PleaseWait").hide();
    	
    });         
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#multipleVehicleInsurGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        source: dataAdapter,
        rowsheight:23,
        scrollmode : 'logical',
       // showaggregates:true,
       // filtermode:'excel',
       /* 	filterable: true,
        showfilterrow:true, */
       	selectionmode: selectmode,
        pagermode: 'default',
       
        columns: [

						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Agmt No', datafield: 'voc_no', width: '7%' },
						{ text: 'Agmt Original',datafield:'doc_no',width:'7%',hidden:true},
						{ text: 'Branch',datafield:'branchname',width:'15%'},
						{ text: 'Client',datafield:'refname',width:'23%'},
						{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Out Date',datafield:'outdate',width:'6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'End Date',datafield:'enddate',width:'6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Fleet No',datafield:'fleet_no',width:'6%'},
						{ text: 'Reg No',datafield:'reg_no',width:'6%'},
						{ text: 'Fleet Name',datafield:'flname',width:'13%'},
						{ text: 'Chassis No',datafield:'ch_no',width:'15%'},
						{ text: 'Purchase Cost',datafield:'prch_cost',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Insur Amount',datafield:'insuramount',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Insur From Date',datafield:'insurfromdate',width:'8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Insur To Date',datafield:'insurtodate',width:'8%',cellsformat:'dd.MM.yyyy'}
						
					
					]
    
    });
    if($('#desc').val()=='Insured'){
    	if(type=="1"){
    		$('#vehicleInsurGrid').jqxGrid({height:300});
        	$('#insurhistorydiv').show();
    	}
    	else{
    		$('#multipleVehicleInsurGrid').jqxGrid({height:300});
        	$('#insurhistorydiv').show();
    	}
    	
    }
    else{
    	if(type=="1"){
    		$('#vehicleInsurGrid').jqxGrid({height:500});
    		$('#insurhistorydiv').hide();
    	}
    	else{
    		$('#multipleVehicleInsurGrid').jqxGrid({height:500});
        	$('#insurhistorydiv').hide();
    	}
    	
    }

    if($('#desc').val()=='' && type==""){
    	$('#vehicleInsurGrid').jqxGrid({height:500});
    	$('#multipleVehicleInsurGrid').jqxGrid({height:500});
    }
    
    $('#multipleVehicleInsurGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    
    		    var todate=$('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',rowBoundIndex, "outdate");
    		    if(todate=="" || todate==null || typeof(todate)=="undefined" || todate=="undefined"){
    		    	$('#multipleVehicleInsurGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		});
    $('#multipleVehicleInsurGrid').on('rowdoubleclick', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    
    		    /* var todate=$('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',rowBoundIndex, "outdate");
    		    if(todate=="" || todate==null || typeof(todate)=="undefined" || todate=="undefined"){
    		    	$('#multipleVehicleInsurGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    } */
    		    if(type=="2"){
    			    $('#agmtno').val($('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',rowBoundIndex,'voc_no'));
    			    $('#hidagmtno').val($('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
    			    if($('#desc').val()=='Insured'){
    			    	$('#insurhistorydiv').load('insurHistoryGrid.jsp?agmtno='+$('#hidagmtno').val()+'&id=1');
    			    }	    	
    		    }
    		});
});

	
	
</script>
<div id="multipleVehicleInsurGrid"></div>
