<%@page import="com.dashboard.workshop.pendinginvoices.*"%>
<%
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
ClsPendingInvoicesDAO pendingdao= new ClsPendingInvoicesDAO();
%>
 <script type="text/javascript">
 var pendingdata=[];
 var pendingexceldata=[];
 var id='<%=id%>';
 if(id=="1"){
	 pendingdata='<%=pendingdao.getPendingData(branch,todate,id)%>';
 }
 $(document).ready(function () { 
	  // prepare the data
	  var source =
	  {
	      datatype: "json",
	      datafields: [
	      	{name : 'jobcarddocno', type: 'number'   },
			{name : 'jobcardvocno', type: 'number'   },	
			{name : 'date', type: 'date'   },
			{name : 'regno', type: 'string'  },
			{name : 'flname', type: 'string'  },
			{name : 'sal_name', type: 'string'  },
			{name : 'refname', type: 'string'    },
			{name : 'age', type: 'number'    },
			{name : 'total', type: 'number'    },
			{name : 'remarks', type: 'String'    },
			{name : 'serviceadvisor',type : 'String'}
	         				
	     ],
	     localdata: pendingdata,
	     
	     pager: function (pagenum, pagesize, oldpagenum) {
	          // callback called when a page or page size is changed.
	     }
	  };
      
      var dataAdapter = new $.jqx.dataAdapter(source,{
      	loadError: function (xhr, status, error) {
        	alert(error);    
        }
     });
      $("#pendingInvoicesGrid").on('bindingcomplete', function (event) {
    	  $("#overlay, #PleaseWait").hide();			
    	});
            
     $("#pendingInvoicesGrid").jqxGrid(
     {
         width: '100%',
         height: 350,
         source: dataAdapter,
         filtermode:'excel',
         filterable: true,
         sortable: true,
         showfilterrow: true,
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
					{ text: 'Job Card No', datafield: 'jobcarddocno', width: '8%',hidden:true },
					{ text: 'Job Card No', datafield: 'jobcardvocno', width: '6%' },
					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Reg No',datafield:'regno',width:'8%'},
					{ text: 'Make', datafield: 'flname', width: '15%' }, 
					{ text: 'Job Advisor', datafield: 'sal_name', width: '12%' },  
					{ text: 'Service Advisor', datafield: 'serviceadvisor', width: '12%' },  
					{ text: 'Customer', datafield: 'refname', width: '15%' },
					{ text: 'Age', datafield: 'age', width: '4%' },
					{ text: 'Amount Total', datafield: 'total', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right' },
					{ text: 'Status', datafield: 'remarks', width: '10%' }
        ]
     });
            
     $('#pendingInvoicesGrid').on('rowdoubleclick', function (event) 
     { 
   		var rowindex=event.args.rowindex;
     	document.getElementById("jobcarddocno").value=$('#pendingInvoicesGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno');
   		$('#followupdiv').load('followupGrid.jsp?jobcarddocno='+$('#pendingInvoicesGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno')+'&id=1');
     	
     });	 
            
});
</script>
<div id="pendingInvoicesGrid"></div>