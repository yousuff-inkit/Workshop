<%@page import="com.dashboard.workshop.pendinginvoicesv2.*"%>
<%
	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
ClsPendingInvoicesv2DAO pendingdao= new ClsPendingInvoicesv2DAO();
%>
<style>
	.greenClass
    {
        background-color: #ACF6CB;
    }
</style>
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
			{name : 'gateprocess',type:'string'},
			{name : 'regno', type: 'string'  },
			{name : 'flname', type: 'string'  },
			{name : 'refname', type: 'string'    },
			{name : 'age', type: 'number'    },
			{name : 'total', type: 'number'    },
			{name : 'remarks', type: 'String'    },
			{name : 'serviceadvisor',type : 'String'},
			{name : 'estimator',type : 'String'},
			{name : 'sal_name', type: 'string'  },
			{name : 'clientname',type:'string'},
			{name : 'insurcompname',type:'string'},
			{name : 'partstotal',type:'number'},
			{name : 'labourtotal',type:'number'},
			{name : 'nettotal',type:'number'},
			{name : 'processstatus',type:'string'}
			
			
	         				
	     ],
	     localdata: pendingdata,
	     
	     pager: function (pagenum, pagesize, oldpagenum) {
	          // callback called when a page or page size is changed.
	     }
	  };
     var cellclassname = function (row, column, value, data) {
     	if(data.processstatus=="6"){
            return "greenClass";
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
    				groupable: false, draggable: false, resizable: false,cellclassname: cellclassname,
    				datafield: 'sl', columntype: 'number', width: '3%',
	    				cellsrenderer: function (row, column, value) {
	        				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
	    				}  
  					},
					{ text: 'Job Card No', datafield: 'jobcarddocno', width: '8%',hidden:true,cellclassname: cellclassname },
					{ text: 'Job Card No', datafield: 'jobcardvocno', width: '6%',cellclassname: cellclassname },
					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname },
					{ text: 'Process', datafield: 'gateprocess', width: '8%' ,cellclassname: cellclassname,},
					{ text: 'Client Name', datafield: 'clientname', width: '10%',cellclassname: cellclassname},
					{ text: 'Insurance Company', datafield: 'insurcompname', width: '12%',cellclassname: cellclassname},
					{ text: 'Make', datafield: 'flname', width: '14%',cellclassname: cellclassname },
					{ text: 'Reg No',datafield:'regno',width:'8%',cellclassname: cellclassname},
					{ text: 'Spare Total', datafield: 'partstotal', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname: cellclassname },
					{ text: 'Labour Total', datafield: 'labourtotal', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname: cellclassname },
					{ text: 'Net Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname: cellclassname },
					{ text: 'Service Advisor', datafield: 'serviceadvisor', width: '10%',cellclassname: cellclassname },  
					{ text: 'Estimator', datafield: 'estimator', width: '8%',cellclassname: cellclassname },  
					{ text: 'Job Advisor', datafield: 'sal_name', width: '10%',cellclassname: cellclassname },  
					{ text: 'Customer', datafield: 'refname', width: '15%',cellclassname: cellclassname,hidden:true },
					{ text: 'Age', datafield: 'age', width: '4%',cellclassname: cellclassname },
					{ text: 'Amount Total', datafield: 'total', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true,cellclassname: cellclassname},
					{ text: 'Status', datafield: 'remarks', width: '10%' ,cellclassname: cellclassname},
					{ text: 'Status', datafield: 'processstatus', width: '4%' ,cellclassname: cellclassname}
					
        ]
     });
            
     $('#pendingInvoicesGrid').on('rowdoubleclick', function (event) 
     { 
   		var rowindex=event.args.rowindex;
     	document.getElementById("jobcarddocno").value=$('#pendingInvoicesGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno');
     	document.getElementById("lblname").innerHTML="Job Card No - "+$('#pendingInvoicesGrid').jqxGrid('getcellvalue',rowindex,'jobcardvocno');
   		$('#followupdiv').load('followupGrid.jsp?jobcarddocno='+$('#pendingInvoicesGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno')+'&id=1');
     	
     });	 
            
});
</script>
<div id="pendingInvoicesGrid"></div>