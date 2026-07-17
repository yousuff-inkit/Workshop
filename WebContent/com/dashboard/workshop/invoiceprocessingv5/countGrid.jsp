<%@page import="com.dashboard.workshop.invoiceprocessingv5.*"%>
<%
ClsInvProcessingV5DAO jobsdao=new ClsInvProcessingV5DAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String uptodate=request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
%>
<script type="text/javascript">

var id='<%=id%>';
var countdata=[];
if(id=='1'){
	countdata='<%=jobsdao.getCountData(brhid,uptodate,id)%>';
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'description',type:'string'},
                  		{name : 'value',type:'number'}
                  		],
				    localdata: countdata,
        
				   
    
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
    
    
    
    $("#countGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable:false,
        enabletooltips:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '15%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Description',datafield:'description',width:'60%'},
       				{ text: 'Value',datafield:'value',width:'25%'},
					]
    });
    
    $('#countGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var args = event.args;
    		    // row's bound index.
    		    var boundIndex = args.rowindex;
    		    // row's visible index.
    		    var visibleIndex = args.visibleindex;
    		    // right click.
    		    var rightclick = args.rightclick; 
    		    // original event.
    		    var ev = args.originalEvent;
    		    
    		    var desc=$('#countGrid').jqxGrid('getcellvalue',boundIndex,'description');
    		    var brhid=$('#cmbbranch').val();
    			var date=$('#periodupto').jqxDateTimeInput('val');
    			$("#invoiceprocessinggriddiv").load("invoiceProcessingGrid.jsp?branch="+brhid+"&todate="+date+"&id=1&invoicetype="+boundIndex);
    		});
});
</script>
<div id="countGrid"></div>