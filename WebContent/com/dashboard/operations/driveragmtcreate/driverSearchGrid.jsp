<%@page import="com.dashboard.operations.driveragmtcreate.*" %>
<%ClsDriverAgmtCreateDAO driverdao=new ClsDriverAgmtCreateDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var driverdata;
var id='<%=id%>';
if(id=="1"){
	driverdata='<%=driverdao.getDriver(id)%>';
}
else{
	driverdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'code', type: 'String'  },
						{name : 'name', type: 'String'    },
						{name : 'license', type: 'String'  },
						{name : 'licenseexpdate',type:'date'},
						{name : 'mobile',type:'string'}
						],
				    localdata: driverdata,
        
        
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
    
    
    $("#driverSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
	    sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'Code',datafield:'code',width:'10%'},
						{ text: 'Name', datafield: 'name', width: '50%'},
						{ text: 'License No',datafield:'license',width:'10%'},
						{ text: 'License Exp Date',datafield:'licenseexpdate',width:'10%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Mobile', datafield: 'mobile', width: '20%'}
					]

    });

	$('#driverSearchGrid').on('rowdoubleclick', function (event) 
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
		
		$('#driver').val($('#driverSearchGrid').jqxGrid('getcellvalue',boundIndex,'name'));
		$('#hiddriver').val($('#driverSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		$('#driverwindow').jqxWindow('close');
	});
	
});
</script>
<div id="driverSearchGrid"></div>