<%@page import="com.dashboard.marketing.residualvaluemaster.*" %>
<%ClsResidualValueMasterDAO masterdao=new ClsResidualValueMasterDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var yomdata;
var id='<%=id%>';
if(id=="1"){
	yomdata='<%=masterdao.getYom(id)%>';
}
else{
	yomdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'yom', type: 'String'  }
						],
				    localdata: yomdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
  
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#yomSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
	    sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'doc_no', width: '30%'},
						{ text: 'Yom',datafield:'yom',width:'70%'}
					]

    });

	$('#yomSearchGrid').on('rowdoubleclick', function (event) 
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
		
		$('#yom').val($('#yomSearchGrid').jqxGrid('getcellvalue',boundIndex,'yom'));
		$('#hidyom').val($('#yomSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		$('#yomwindow').jqxWindow('close');
	});
	
});
</script>
<div id="yomSearchGrid"></div>