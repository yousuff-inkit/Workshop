<%@page import="com.dashboard.analysis.insuranceanalysis.*" %>
<%
ClsInsuranceAnalysisDAO postdao=new ClsInsuranceAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
//String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%> 
<script type="text/javascript">
var detaildata;
var insuranceanalysisexcel;
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=postdao.getDetailsData(fromdate,todate) %>';
	insuranceanalysisexcel='<%=postdao.excelDetailsData(fromdate,todate)%>';
	
	 
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
                 	{name : 'postdate',type:'date'},
                 	
                 	{name : 'nodays',type:'string'},
                 	{name : 'totinsur',type:'string'},
                 	{name : 'openpost',type:'string'},
                 	{name : 'posted',type:'string'},
                 	{name : 'balance',type:'string'},
                 	
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
        height: 520,
        source: dataAdapter,
        rowsheight:22,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
       columnsresize:true,
        selectionmode: 'singlecell',
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
						{ text: 'No. of Days',datafield:'nodays',width:'7%'},
						{ text: 'Total Insured',datafield:'totinsur',width:'9%',align:'right',cellsalign:'right'},
						{ text: 'Opening Posted',datafield:'openpost',width:'9%',align:'right',cellsalign:'right'},
						{ text: 'Posted',datafield:'posted',width:'9%',align:'right',cellsalign:'right'},
						{ text: 'Balance',datafield:'balance',width:'9%',align:'right',cellsalign:'right'},
						{ text: 'Insur Docno',datafield:'insurdocno',width:'10%',hidden:true}
					
					]
    
    });

});

	
	
</script>
<div id="detailsGrid"></div>
