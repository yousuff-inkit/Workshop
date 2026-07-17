<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String processstatus=request.getParameter("processstatus")==null?"":request.getParameter("processstatus");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var complaintdata;

if(id=='1'){
 complaintdata='<%=servicedao.getComplaintData(brhid,docno,id,processstatus)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
complaintdata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'complaintdocno',type:'number'},
                  		{name : 'complaint',type:'string'}
				
                  		],
				    localdata: complaintdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#complaintsGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#complaintsGrid").jqxGrid(
    {
        width: '98%',
        height: 250,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '20%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Complaints',datafield:'complaint',width:'80%'},
       				{ text: 'Complaint Doc No',datafield:'complaintdocno',width:'12%',hidden:true}


					]
    });
    $('#complaintsGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      
      		});	 
     
  
    });

	
	
</script>
<div id="complaintsGrid"></div>