<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var baydata;
if(id=='1'){
	baydata='<%=servicedao.getBayData(id)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	baydata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'baydocno',type:'number'},
                  		{name : 'bayname',type:'string'},
                  		{name : 'baycode',type:'string'}
				
                  		],
				    localdata: baydata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#baySearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#baySearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Code',datafield:'baycode',width:'20%'},
       				{ text: 'Bay Docno',datafield:'baydocno',width:'40%',hidden:true},
       				{ text: 'Bay',datafield:'bayname',width:'70%'}

					]
    });
    $('#baySearchGrid').on('rowdoubleclick', function (event) 
      		{ 
			var rowindex1=event.args.rowindex;
  			$('#bay').val($('#baySearchGrid').jqxGrid('getcellvalue',rowindex1,'bayname'));
  			$('#hidbay').val($('#baySearchGrid').jqxGrid('getcellvalue',rowindex1,'baydocno'));
  			$('#baywindow').jqxWindow('close');
      		});	 
     
    });

	
</script>
<div id="baySearchGrid"></div>