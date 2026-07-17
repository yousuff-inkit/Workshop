<%@page import="com.dashboard.workshop.pendingjobs.*"%>
<%
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
String gipno = request.getParameter("gipno")==null?"":request.getParameter("gipno").trim();
ClsWSPendingJobsDAO pendingdao= new ClsWSPendingJobsDAO();
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>  
 <script type="text/javascript">
 var pendingdata=[];
 var pendingexceldata=[];
 var id='<%=id%>';
 if(id=="1"){
	 pendingdata='<%=pendingdao.getPendingJobs(todate,branch,gipno,id)%>';
	<%--  pendingexceldata='<%=pendingdao.getPendingExcelData(branch,todate,id)%>'; --%>
 }
 else{
 	pendingdata=[];
 	pendingexceldata=[];
 }
 $(document).ready(function () { 
	  // prepare the data
	  var source =
	  {
	      datatype: "json",
	      datafields: [
	      	{name : 'gatedocno', type: 'number'   },
			{name : 'gatevocno', type: 'number'   },	
			{name : 'date', type: 'date'   },
			{name : 'regno', type: 'number'  },
			{name : 'vehicledetails', type: 'string'  },
			{name : 'brhid', type: 'string'  },
			{name : 'branch',type:'string'},
			{name : 'refname', type: 'string'    },
			{name : 'cldocno',type:'string'},
			{name : 'sparetotal', type: 'number'    },
			{name : 'labourtotal', type: 'number'    },
			{name : 'nettotal', type: 'number'    },
			{name : 'estdocno', type: 'number'    },
	         				
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
      $("#pendingJobsGrid").on('bindingcomplete', function (event) {
    	  $("#overlay, #PleaseWait").hide();			
    	});
            
     $("#pendingJobsGrid").jqxGrid(
     {
         width: '100%',
         height: 500,
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
					{ text: 'GIP No', datafield: 'gatevocno', width: '8%'},
					{ text: 'GIP No', datafield: 'gatedocno', width: '8%',hidden:true  },
					{ text: 'EST No', datafield: 'estdocno', width: '8%',hidden:true  },
					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Branch', datafield: 'branch', width: '12%'},
					{ text: 'Reg No',datafield:'regno',width:'8%'},
					{ text: 'Veh Details', datafield: 'vehicledetails', width: '20%' }, 
					{ text: 'Client', datafield: 'refname', width: '20%' },  
					{ text: 'Spare Total', datafield: 'sparetotal',width: '7%',cellsformat:'d2',align:'right',cellsalign:'right' },
					{ text: 'Labour Total', datafield: 'labourtotal', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right' },
					{ text: 'Net Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right' },
        ]
     });
            
     $('#pendingJobsGrid').on('rowdoubleclick', function (event) 
     { 
   		var rowindex=event.args.rowindex;
     	$('#hidgipno').val($('#pendingJobsGrid').jqxGrid('getcellvalue',rowindex,'gatedocno'));
     	$('#gipno').val($('#pendingJobsGrid').jqxGrid('getcellvalue',rowindex,'gatevocno'));
     	$('#hidestno').val($('#pendingJobsGrid').jqxGrid('getcellvalue',rowindex,'estdocno'));
     });	 
            
});
</script>
<div id="pendingJobsGrid"></div>