<%@page import="com.dashboard.analysis.maintenanceanalysis.ClsmaintenanceanalysisDAO" %>
<% ClsmaintenanceanalysisDAO cmd=new ClsmaintenanceanalysisDAO();%>

        <%          
           String temp=request.getParameter("id")==null?"0":request.getParameter("id");
           String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
           String fromdate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
           String todate=request.getParameter("todate")==null?"0":request.getParameter("todate");
           String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
           String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
           String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
           String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
           String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
           String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
           String hidmtype=request.getParameter("hidmtype")==null?"":request.getParameter("hidmtype");
           String radiotype=request.getParameter("radiotype")==null?"":request.getParameter("radiotype");
 
           
           
       
       %> 
           	  
 <script type="text/javascript"> 
 var radtype='<%=radiotype%>';
 var temp4='<%=temp%>';
var expdata;
var mainexceldata;

if(temp4=='1'){
 
  	   expdata='<%=cmd.getmasterdatas(branch,fromdate,todate,hidfleet,hidbrand,hidmodel,hidyom,hidmtype,radiotype) %>'; 
  	 mainexceldata='<%=cmd.excelmasterdatas(branch,fromdate,todate,hidfleet,hidbrand,hidmodel,hidyom,hidmtype,radiotype) %>';
 
} 
else
{ 
	
	expdata;

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
                         {name : 'fleet_no', type: 'String'  },
						 {name : 'reg_no', type: 'String'  },
						 {name : 'brand', type: 'String'  }, 
						 {name : 'model', type: 'String'  }, 
						 {name : 'yom', type: 'string'  },
						 {name : 'dtype', type: 'string'  }, 
						 {name : 'docno', type: 'string'  },
						 {name : 'partscost', type: 'number'  },  
						 {name : 'labcost', type: 'number'  },
						 {name : 'totalcost', type: 'number'  },
						 {name : 'type', type: 'String'  },				
		        		 {name : 'current_km', type: 'string'  },
						 {name : 'nxtser_km', type: 'string'  },
						 {name : 'mtype', type: 'string'  },
						 {name : 'mdesc', type: 'string'  },
						 
						],
				    localdata: expdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            
        }
    };
  
 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#alllistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:true,
        statusbarheight:25,
    	showstatusbar:true,
        columns: [   
 

                     { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                     },
				     { text: 'Fleet', datafield: 'fleet_no', editable:false, width: '6%' },
				     { text: 'Reg NO', datafield: 'reg_no', editable:false, width: '6%' },
				     { text: 'Brand', datafield: 'brand', editable:false, width: '12%' }, 
				     { text: 'Model',datafield: 'model',editable:false, width: '12%' },
				     { text: 'YOM',datafield: 'yom',editable:false, width: '4%' },
					 { text: 'Dtype',datafield: 'dtype', editable:false,width: '4%' },    
					 { text: 'Doc No',datafield: 'docno',editable:false, width: '6%' },
					
					 { text: 'Maintenance Type',datafield: 'mtype', editable:false,width: '10%' },
					 { text: 'Description',datafield: 'mdesc', editable:false,width: '12%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					 
					 { text: 'Labour Cost', datafield: 'labcost',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}, 
					 { text: 'Parts Cost', datafield: 'partscost',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 { text: 'Total Cost', datafield: 'totalcost',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}, 
					 { text: 'Type', datafield: 'type',editable:false, width: '7%'},
					 { text: 'Current Km', datafield: 'current_km',editable:false, width: '7%'},
				 	 { text: 'Next Service Km', datafield: 'nxtser_km',editable:false, width: '8%'},
					
						
					]
   
    });
    
    if(radtype=="RD")
    {
       $('#alllistgrid').jqxGrid('showcolumn', 'mtype');
       $('#alllistgrid').jqxGrid('showcolumn', 'mdesc');
      
    }
    else
    {
    $('#alllistgrid').jqxGrid('hidecolumn', 'mtype');
    $('#alllistgrid').jqxGrid('hidecolumn', 'mdesc');

    }

});


$("#overlay, #PleaseWait").hide();
  
 



 
</script>
<div id="alllistgrid"></div>