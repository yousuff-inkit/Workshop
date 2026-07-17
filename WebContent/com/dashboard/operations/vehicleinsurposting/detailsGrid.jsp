<%@page import="com.dashboard.operations.vehicleinsurposting.*" %>
<%
ClsVehicleInsurPostingDAO postdao=new ClsVehicleInsurPostingDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
System.out.println(id+"::"+desc);
%> 
<script type="text/javascript">
var detaildata;
var detailexceldata;
var desc='<%=desc%>';
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=postdao.getDetailsData(uptodate, branch, desc, id)%>';
	detailexceldata='<%=postdao.getDetailsExcelData(uptodate, branch, desc, id)%>';
}
else{
	detaildata=[];
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
                 	{name : 'insurdocno',type:'string'},
                 	{name : 'postdate',type:'date'}
					
						
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#detailsGrid").on("bindingcomplete", function (event) {
    	// your code here.
    	$("#overlay, #PleaseWait").hide();
    	/* if($('#desc').val()=='Insured'){
    		$('#vehicleInsurGrid').jqxGrid({height:300});
    		$('#insurhistorydiv').show();
    	}
    	else{
    		$('#vehicleInsurGrid').jqxGrid({height:500});
    		$('#insurhistorydiv').hide();
    	} */
    });         
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailsGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       filterable: true,
        showfilterrow:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       
        columns: [

						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Agmt No', datafield: 'voc_no', width: '7%' },
						{ text: 'Agmt Original',datafield:'doc_no',width:'7%',hidden:true},
						{ text: 'Branch',datafield:'branchname',width:'11%'},
						{ text: 'Client',datafield:'refname',width:'17%'},
						{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Out Date',datafield:'outdate',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'End Date',datafield:'enddate',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Post Date',datafield:'postdate',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Fleet No',datafield:'fleet_no',width:'7%'},
						{ text: 'Reg No',datafield:'reg_no',width:'7%'},
						{ text: 'Fleet Name',datafield:'flname',width:'15%'},
						{ text: 'Insur Docno',datafield:'insurdocno',width:'10%',hidden:true}
						
					
					]
    
    });

    $('#detailsGrid').on('rowdoubleclick', function (event) 
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
	    /* $("#overlay, #PleaseWait").show();
	    var expenseacno=$('#expenseacno').val();
	    var agmtno=$('#detailsGrid').jqxGrid('getcellvalue',boundIndex,'doc_no');
	    var insurdocno=$('#detailsGrid').jqxGrid('getcellvalue',boundIndex,'insurdocno');
	    var uptodate=$('#uptodate').jqxDateTimeInput('val');
	    var branch=$('#cmbbranch').val();
	    $('#calcdiv').load('postingCalcGrid.jsp?expenseacno='+expenseacno+'&agmtno='+agmtno+'&insurdocno='+insurdocno+'&uptodate='+uptodate+'&branch='+branch+'&id=1');
	     */
	   /*  $('#agmtno').val($('#vehicleInsurGrid').jqxGrid('getcellvalue',boundIndex,'voc_no'));
	    $('#hidagmtno').val($('#vehicleInsurGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
	    if($('#desc').val()=='Insured'){
	    	$('#insurhistorydiv').load('insurHistoryGrid.jsp?agmtno='+$('#hidagmtno').val()+'&id=1');
	    } */
    });
	 if(desc=="Posted"){
    	$('#calcdiv').hide();
    	$('#detailsGrid').jqxGrid({ height: 500 }); 
    }
    else{
    	$('#calcdiv').show();
    	$('#detailsGrid').jqxGrid({ height: 300 });
    }
});

	
	
</script>
<div id="detailsGrid"></div>
