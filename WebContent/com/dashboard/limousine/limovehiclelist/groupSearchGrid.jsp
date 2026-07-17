<%@page import="com.dashboard.limousine.limovehiclelist.*" %>
<%ClsLimoVehicleListDAO listdao=new ClsLimoVehicleListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var	groupdata;
if(id=="1"){
	groupdata='<%=listdao.getGroup(id)%>';
}
$(document).ready(function () {

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'doc_no' , type: 'string' },
                  		{name : 'gname' , type: 'string' }						
						],
				    localdata: groupdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
         
          $('#groupSearchGrid').on('bindingcomplete', function (event) {
        	  $('#overlay,#PleaseWait,#loadingImage').hide();
          });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#groupSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columns: [
                  
					/* { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '10%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }
					  }, */
                        { text: 'Doc No', datafield: 'doc_no', width: '30%'},  
      					{ text: 'Group', datafield: 'gname', width: '70%'}

					]

    });

    $('#groupSearchGrid').on('rowdoubleclick', function (event) 
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
    		    
    		    $('#group').val($('#groupSearchGrid').jqxGrid('getcellvalue',boundIndex,'gname'));
    		    $('#hidgroup').val($('#groupSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
    		    $('#groupwindow').jqxWindow('close');
    		});
});

	
	
</script>
<div id="groupSearchGrid"></div>