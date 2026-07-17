<%@page import="com.dashboard.operations.driveragmtcreate.*" %>
<%ClsDriverAgmtCreateDAO driverdao=new ClsDriverAgmtCreateDAO();
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
String clientmail=request.getParameter("clientmail")==null?"":request.getParameter("clientmail");
String clientdate=request.getParameter("clientdate")==null?"":request.getParameter("clientdate");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var clientdata;
var id='<%=id%>';
if(id=="1"){
	clientdata='<%=driverdao.getClient(cldocno,clientname,clientmobile,clientmail,id,clientdate)%>'; 
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

                  		{name : 'cldocno' , type: 'number' },
						{name : 'clientname', type: 'String'  },
						{name : 'clientmobile', type: 'String'    },
						{name : 'clientmail', type: 'String'  },
						{name : 'date',type:'date'}
						],
				    localdata: clientdata,
        
        
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
    
    
    $("#clientSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
	    sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'cldocno', width: '10%'},
						{ text: 'Date',datafield:'date',width:'15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Name', datafield: 'clientname', width: '40%'},
						{ text: 'Mobile', datafield: 'clientmobile', width: '15%'},
						{ text: 'Email', datafield: 'clientmail', width: '20%'},
						
					]

    });

	$('#clientSearchGrid').on('rowdoubleclick', function (event) 
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
		
		$('#client').val($('#clientSearchGrid').jqxGrid('getcellvalue',boundIndex,'clientname'));
		$('#hidclient').val($('#clientSearchGrid').jqxGrid('getcellvalue',boundIndex,'cldocno'));
		$('#clientwindow').jqxWindow('close');
	});
	
});
</script>
<div id="clientSearchGrid"></div>