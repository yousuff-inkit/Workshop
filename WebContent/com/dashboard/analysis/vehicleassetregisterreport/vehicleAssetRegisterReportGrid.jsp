<%@page import="com.dashboard.analysis.vehicleassetregisterreport.ClsVehicleAssetRegisterReport" %>
<% ClsVehicleAssetRegisterReport cva=new ClsVehicleAssetRegisterReport(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetNo = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String group = request.getParameter("group")==null?"0":request.getParameter("group").trim();
     String model = request.getParameter("model")==null?"0":request.getParameter("model").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<style type="text/css">
  .opnClass
  {
      color: #298A08;
  }
  .additionClass
  {
      color: #0101DF;
  }
  .deletionClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var temp1='<%=fromDate%>';
	  var temp2='<%=toDate%>';
	  
	  	if(temp!='NA'){ 
	  		data='<%=cva.vehicleAsssetGridLoading(branchval, fromDate, toDate, fleetNo, group, model, check)%>';
	  		var dataExcelExport='<%=cva.vehicleAsssetExcelExport(branchval, fromDate, toDate, fleetNo, group, model, check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'age',type:'int'},
							{name : 'deprper',type:'number'},
     						{name : 'purdate',type:'date'},
     						{name : 'reg_no',type:'String'},
     						{name : 'plate',type:'String'},
     						{name : 'residualvalue',type:'number'},
     						{name : 'startdate',type:'date'},
     						{name : 'enddate',type:'date'},
     						{name : 'contractno',type:'String'},
     						{name : 'assetopn',type:'number'},
     						{name : 'assetadd',type:'number'},
     						{name : 'assetdel',type:'number'},
     						{name : 'assettotal',type:'number'},
     						{name : 'depropn',type:'number'},
     						{name : 'depradd',type:'number'},
     						{name : 'deprdel',type:'number'},
     						{name : 'deprtotal',type:'number'},
     						{name : 'nettotal',type:'number'},
     						{name : 'prevyear',type:'number'}
	                      ],
                          localdata: data,
               
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
            $("#vehicleAssetGrid").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'Fleet', datafield: 'fleet_no',editable:false, width: '6%'},
							{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '14%'},
							{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '6%'},
							{ text: 'Plate', datafield: 'plate',editable:false, width: '4%'},
							{ text: 'Age(M)', datafield: 'age', width: '4%', editable:false},
							{ text: 'Depr(%)', datafield: 'deprper', width: '5%', cellsformat:'d2', editable:false},
							{ text: 'Pur Date', datafield: 'purdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Residual Value', datafield: 'residualvalue', width: '7%', editable:false, cellsformat:'d2', cellsalign:'right', align:'right'},
							{ text: 'Start Date', datafield: 'startdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Contract No', datafield: 'contractno', width: '6%', editable:false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'OPN', datafield: 'assetopn', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Addition', datafield: 'assetadd', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Deletion',datafield:'assetdel', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							{ text: 'Total',  datafield:'assettotal',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'OPN', datafield: 'depropn', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Addition', datafield: 'depradd', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Deletion',datafield:'deprdel', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'deletionClass' },
							{ text: 'Total',  datafield:'deprtotal',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Net Total',  datafield:'nettotal',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Prevoius Year',  datafield:'prevyear',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							],
							columngroups: 
							  [
							    { text: 'Asset', align: 'center', name: 'Asset',width: '20%' },
							    { text: 'Depreciation', align: 'center', name: 'Depreciation',width: '20%' }
							 
							  ]
            });
            
            if(temp=='NA'){
                $("#vehicleAssetGrid").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			
			
			 $('#vehicleAssetGrid').on('rowdoubleclick', function (event) {
				    var rowindex=event.args.rowindex;
	                var desc= "Vehicle Asset Register"; 
	                var fleetno=$('#vehicleAssetGrid').jqxGrid('getcellvalue', rowindex, "fleet_no");
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					var detName=$('#vehicleAssetGrid').jqxGrid('getcellvalue', rowindex, "flname");
					var path="com/dashboard/analysis/vehicleassetregisterreport/vehicleDetailedAssetGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&fleetno='+fleetno+'&fromdate='+temp1+'&todate='+temp2);
	          	    
	              });
            
        });

</script>
<div id="vehicleAssetGrid"></div>
