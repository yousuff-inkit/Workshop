<%@page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO"%>
<%ClsServiceAndMaintenanceDAO DAO= new ClsServiceAndMaintenanceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
     %>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      var temp1='<%=type%>';
      var id='<%=id%>';
      if(id=="1"){
    	  if(temp!='NA'){ 
	  		   data1='<%=DAO.serviceHistory(branchval,fromDate, toDate, fleetno,id)%>';
	  	}  
      }
	  	
	  	
  	
        $(document).ready(function () {
        	
        	/*if(temp1=='2'){
	        	$("#btnExcel").click(function() {
	    			$("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
	    		});
        	}*/
        	
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + '' + value + '</div>';
               }
        	 
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'fleet_no' , type: 'int' },
					{name : 'reg_no' , type: 'int' },
					{name : 'date' , type: 'date' },
				    {name : 'mtype' , type: 'string' },
				    {name : 'servicekm', type: 'number'  },
				    {name : 'nextkm', type: 'number'  },
				    {name : 'garage' , type: 'string' },
				    {name : 'type' , type: 'string' },
					{name : 'description' , type: 'string' },
					{name : 'remarks', type: 'string'  },
					{name : 'lbrcost', type: 'number'  },
					{name : 'partscost', type: 'number'  },
					{name : 'total', type: 'number'  }
	            ],
                localdata: data1,
               
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
            $("#serviceHistory").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Fleet No', datafield: 'fleet_no', width: '5%' },
						{ text: 'Reg No.', datafield: 'reg_no', width: '5%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Type', datafield: 'mtype', width: '7%' },
					
						{ text: 'Service KM', datafield: 'servicekm', width: '7%' },
						{ text: 'Next KM', datafield: 'nextkm', width: '7%' },
						{ text: 'Garage', datafield: 'garage', width: '10%' },
						{ text: 'Type', datafield: 'type', width: '7%' },
						{ text: 'Description', datafield: 'description', width: '14%' },
						{ text: 'Remarks', datafield: 'remarks' ,width: '14%'},
						{ text: 'Labor Cost', datafield: 'lbrcost',width: '8%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts Cost', datafield: 'partscost',width: '8%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Total', datafield: 'total',width:"8%",cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 ]
            });
            
            if(temp=='NA'){
                $("#serviceHistory").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            <%-- var vehicle = $('#txtcldocno').val();
    		
    		if(vehicle==''){
    			 $.messager.alert('Message','Choose a Vehicle.','warning');
    			 return 0;
    		 }
    		
    		 $('#inspectionWindow').jqxWindow('setContent', '');
    		 $('#inspectionWindow').jqxWindow('open'); 
    		 inspectionSearchContent("<%=contextPath%>/com/operations/clientrelations/client/clientAudit.action?mode=view&txtclientdocno="+document.getElementById("txtcldocno").value); --%>

        });

</script>
<div id="serviceHistory"></div>
