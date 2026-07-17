<%@page import="com.dashboard.workshop.releasevehicle.*"%>
<%
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
String releasestatus = request.getParameter("releasestatus")==null?"":request.getParameter("releasestatus").trim();
ClsReleaseVehicleDAO releasedao= new ClsReleaseVehicleDAO();
%>
 <script type="text/javascript">
 var releasedata=[];
 var releaseexceldata=[];
 var id='<%=id%>';
 if(id=="1"){
	 releasedata='<%=releasedao.getReleaseData(branch,todate,id,releasestatus)%>';
	 releaseexceldata='<%=releasedao.getReleaseExcelData(branch,todate,id,releasestatus)%>';
 }
 var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
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
			{name : 'salname', type: 'string'  },
			{name : 'refname', type: 'string'    },
			{name : 'estvocno',type:'number'},
			{name : 'gatevocno',type:'number'},
			{name : 'gatedocno',type:'number'},
			{name : 'billto',type:'string'},
			{name : 'estimator',type:'string'},
			{name : 'promisedate', type: 'date'   },
			{name : 'extendate', type: 'date'   },
			{name : 'remarks', type: 'string'   },
			{name : 'esttotal',type:'number'}
	         				
	     ],
	     localdata: releasedata,
	     
	     pager: function (pagenum, pagesize, oldpagenum) {
	          // callback called when a page or page size is changed.
	     }
	  };
      
      var dataAdapter = new $.jqx.dataAdapter(source,{
      	loadError: function (xhr, status, error) {
        	alert(error);    
        }
     });
            
     $("#releaseVehicleGrid").jqxGrid(
     {
         width: '100%',
         height: 500,
         source: dataAdapter,
         filtermode:'excel',
         filterable: true,
         sortable: true,
         showfilterrow: true,
         showaggregates:true,
         showstatusbar:true,
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
					{ text: 'Job Card No', datafield: 'jobcardvocno', width: '8%' },
					{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Promise Date', datafield: 'promisedate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Extended date', datafield: 'extendate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Remarks', datafield: 'remarks', width: '8%' },
					{ text: 'Est No', datafield: 'estvocno', width: '8%' },
					{ text: 'GIP No', datafield: 'gatevocno', width: '8%' },
					{ text: 'Est.Total',datafield: 'esttotal',width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'GIP No', datafield: 'gatedocno', width: '8%',hidden:true },
					{ text: 'Reg No',datafield:'regno',width:'8%'},
					{ text: 'Make', datafield: 'flname', width: '20%' },  
					{ text: 'Party', datafield: 'refname', width: '25%' },
					{ text: 'Advisor', datafield: 'salname', width: '12%' },
					{ text: 'Estimator', datafield: 'estimator', width: '15%' },
					{ text: 'Billto Company', datafield: 'billto', width: '15%' }
					
        ]
     });
            
     $('#releaseVehicleGrid').on('rowdoubleclick', function (event) 
     { 
   		var rowindex=event.args.rowindex;
     	document.getElementById("jobcarddocno").value=$('#releaseVehicleGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno');
     	document.getElementById("gatedocno").value=$('#releaseVehicleGrid').jqxGrid('getcellvalue',rowindex,'gatedocno');
   		//$('#followupdiv').load('followupGrid.jsp?jobcarddocno='+$('#releaseVehicleGrid').jqxGrid('getcellvalue',rowindex,'jobcarddocno')+'&id=1');
     	
     });	 
            
});
</script>
<div id="releaseVehicleGrid"></div>