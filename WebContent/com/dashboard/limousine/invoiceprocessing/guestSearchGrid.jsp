<%@page import="com.dashboard.limousine.invoiceprocessing.*" %>
<%
ClsInvoiceProcessDAO processdao=new ClsInvoiceProcessDAO();
String guestdocno=request.getParameter("guestdocno")==null?"":request.getParameter("guestdocno");
String guestname=request.getParameter("guestname")==null?"":request.getParameter("guestname");
String guestmobile=request.getParameter("guestmobile")==null?"":request.getParameter("guestmobile");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var guestdata;
var id='<%=id%>';
if(id=="1"){
	guestdata='<%=processdao.getGuestData(guestdocno,guestname,guestmobile,id)%>';
}
else{
	guestdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		
                  		{name:'doc_no',type:'int'},
                  		{name:'guest',type:'string'},
                  		{name:'guestcontactno',type:'string'}
						],
				    localdata: guestdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#guestSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    
    });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#guestSearchGrid").jqxGrid(
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
               
						
						{text:'Doc No',datafield:'doc_no',width:'20%'},
						{text:'Name',datafield:'guest',width:'50%'},
						{text:'Contact No',datafield:'guestcontactno',widyth:'30%'}
						
					]

    });
    
    $('#guestSearchGrid').on('rowdoubleclick', function (event) 
    		{
	    // event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // row's data. The row's data object or null(when all rows are being sele cted or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
	    $('#guest').val($('#guestSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'guest'));
	    $('#hidguest').val($('#guestSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
	    $('#guestwindow').jqxWindow('close');
    });
    
    
});

	
	
</script>
<div id="guestSearchGrid"></div>