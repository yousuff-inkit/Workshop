<%@page import="com.dashboard.workshop.jobcardcompletenewpal.*"%>
<%
ClsJobCardCompleteNewPalDAO gatedao=new ClsJobCardCompleteNewPalDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var esttotaldata=[];

if(id=='1'){
	esttotaldata='<%=gatedao.getEstTotalData(id,estdocno)%>';
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'addition',type:'number'},
                  		{name : 'nettotal',type:'number'},
                  		{name : 'approved',type:'string'}
                  		],
				    localdata: esttotaldata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#estTotalGrid").on("bindingcomplete", function (event) {
    	//$("#overlay, #PleaseWait").hide();
    });        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#estTotalGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow : false,
       	sortable:false,
       	columnsresize: true,
        columns: [
               
               		{ text: 'Addition',datafield:'addition',width:'30%'},
       				{ text: 'Status',datafield:'approved',width:'40%'},
       				{ text: 'Total', datafield: 'nettotal', width:'30%',cellsformat:'d2',cellsalign:'right',align:'right' },
       				
       				

		]
    });
    
});
 
	
</script>
<div id="estTotalGrid"></div>