<%@page import="com.dashboard.workshop.pendinginvoicespal.*"%>
<%
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String jobcarddocno = request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno").trim();
ClsPendingInvoicesPALDAO pendingdao= new ClsPendingInvoicesPALDAO();
%>
 <script type="text/javascript">
 var followupdata=[];
 var id='<%=id%>';
 if(id=="1"){
	 followupdata='<%=pendingdao.getFollowupData(jobcarddocno,id)%>';
 }
 $(document).ready(function () { 
	  // prepare the data
	  var source =
	  {
	      datatype: "json",
	      datafields: [
	      	{name : 'followupdate', type: 'date'   },
			{name : 'user', type: 'string'   },	
			{name : 'remarks', type: 'string'   }
	         				
	     ],
	     localdata: followupdata,
	     
	     pager: function (pagenum, pagesize, oldpagenum) {
	          // callback called when a page or page size is changed.
	     }
	  };
      
      var dataAdapter = new $.jqx.dataAdapter(source,{
      	loadError: function (xhr, status, error) {
        	alert(error);    
        }
     });
            
     $("#followupGrid").jqxGrid(
     {
         width: '100%',
         height: 200,
         source: dataAdapter,
         filtermode:'excel',
         filterable: true,
         sortable: true,
         showfilterrow: false,
         showaggregates:true,
         selectionmode: 'singlerow',
         editable: false,
         
         columns: [
                   { text: 'SL#', sortable: false, filterable: false, editable: false,
    				groupable: false, draggable: false, resizable: false,
    				datafield: 'sl', columntype: 'number', width: '3%',
	    				cellsrenderer: function (row, column, value) {
	        				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
	    				}  
  					},
  					{ text: 'Follow Up Date', datafield: 'followupdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'User', datafield: 'user', width: '15%' },
					{ text: 'Remarks', datafield: 'remarks', width: '74%' }
        ]
     });
            
     $('#followupGrid').on('rowdoubleclick', function (event) 
     { 
   		var rowindex=event.args.rowindex;
     	
     });	 
            
});
</script>
<div id="followupGrid"></div>