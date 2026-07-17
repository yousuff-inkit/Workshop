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
           
           

           
           
       
       %> 
           	  
 <script type="text/javascript"> 
 var temp4='<%=temp%>';
var expdata1;
var groupingexceldata;
if(temp4=='1'){
 
  	   expdata1='<%=cmd.getmastergrouping(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidyom,hidfleet,hidmtype) %>'; 
  	 groupingexceldata='<%=cmd.excelmastergrouping(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidyom,hidfleet,hidmtype) %>';
  	 
 
} 
else
{ 
	
	expdata1;

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
                         {name : 'desc1', type: 'String'  },
						 {name : 'refno', type: 'String'  },
						  
						 {name : 'partscost', type: 'number'  },  
						 {name : 'labcost', type: 'number'  },
						 {name : 'totalcost', type: 'number'  },
					 
						 
						 
						  
						 
						
						],
				    localdata: expdata1,
        
        
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
    
    
   
   
    
    $("#groupgrid").jqxGrid(
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
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                     },
				     { text: 'Ref No', datafield: 'refno', editable:false, width: '15%' },
				     { text: 'Description', datafield:'desc1', editable:false, width: '35%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
				     
					 { text: 'Labour Cost', datafield: 'labcost',editable:false, width: '15%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}, 
					 { text: 'Parts Cost', datafield: 'partscost',editable:false, width: '15%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 { text: 'Total Cost', datafield: 'totalcost',editable:false, width: '15%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}, 
					 
						
					]
   
    });

});


$("#overlay, #PleaseWait").hide();
  
 



 
</script>
<div id="groupgrid"></div>