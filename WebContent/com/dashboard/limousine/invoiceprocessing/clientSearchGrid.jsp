<%@page import="com.dashboard.limousine.invoiceprocessing.*" %>
<%
ClsInvoiceProcessDAO processdao=new ClsInvoiceProcessDAO();
String clientdocno=request.getParameter("clientdocno")==null?"":request.getParameter("clientdocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var clientdata;
var id='<%=id%>';
if(id=="1"){
	clientdata='<%=processdao.getClientData(clientdocno,clientname,id)%>';
}
else{
	clientdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		
                  		{name:'cldocno',type:'int'},
                  		{name:'refname',type:'string'},
                  		{name:'address',type:'string'},
                  		{name:'per_mob',type:'string'}
						],
				    localdata: clientdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#clientSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    
    });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#clientSearchGrid").jqxGrid(
    {
        width: '98%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       	sortable:false,
        columns: [
               
						
						{text:'Doc No',datafield:'cldocno',width:'10%'},
						{text:'Name',datafield:'refname',width:'30%'},
						{text:'Address',datafield:'address',width:'40%'},
						{text:'Mobile',datafield:'per_mob',widyth:'20%'}
						
					]

    });
    
    $('#clientSearchGrid').on('rowdoubleclick', function (event) 
    		{
	    // event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // row's data. The row's data object or null(when all rows are being sele cted or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
	    $('#client').val($('#clientSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'refname'));
	    $('#hidclient').val($('#clientSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno'));
	    $('#clientwindow').jqxWindow('close');
    });
    
    
});

	
	
</script>
<div id="clientSearchGrid"></div>