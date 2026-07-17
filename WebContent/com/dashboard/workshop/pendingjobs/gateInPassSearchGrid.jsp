<%@page import="com.dashboard.workshop.pendingjobs.*" %>
<%ClsWSPendingJobsDAO pendingdao=new ClsWSPendingJobsDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String check=request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
 
var id='<%=id%>';
 var check='<%=check%>'; 
var gateinpasssearchdata;
if(id=='1'){
	gateinpasssearchdata='<%=pendingdao.getGateInPassData(id,gatedocno,regno,clientname,date)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	gateinpasssearchdata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'voc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'regno',type:'number'},
                  		{name : 'refname',type:'string'}
				
                  		],
				    localdata: gateinpasssearchdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateInPassSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#gateInPassSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        showfilterrow:false,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Gate In Pass No',datafield:'voc_no',width:'16%'},
       				{ text: 'Gate In Pass No',datafield:'doc_no',width:'16%',hidden:true},
       				{ text: 'Reg No',datafield:'regno',width:'16%'},
       				{ text: 'Date',datafield:'date',width:'15%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Client Name',datafield:'refname',width:'50%'}

					]
    });
	    $('#gateInPassSearchGrid').on('rowdoubleclick', function (event) 
	    { 
  			var rowindex=event.args.rowindex;
   			$('#gipno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',rowindex,'voc_no'));
   			$('#gipwindow').jqxWindow('close');
	    });
   
	     
});
	
	
	
</script>
<div id="gateInPassSearchGrid"></div>