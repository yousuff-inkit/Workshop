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
   
        String cmbfrequency=request.getParameter("cmbfrequency")==null?"":request.getParameter("cmbfrequency");
        
        String hidmtype=request.getParameter("hidmtype")==null?"":request.getParameter("hidmtype");
        
       %> 
     <style type="text/css">
       .headClass
        {
            background-color: #FFEBC2;
        }
        .openingClass
        {
            background-color: #FFFFD1;
        }
        .yellowClass
  	    {	
	      background-color: #FBEFF5;
	    }
	    .receiptClass
	    {
	      background-color: #E0F8F1;
	    }
</style> 	  
 <script type="text/javascript"> 
 var temp4='<%=temp%>';
 var data;
 var distexceldata;
 $(document).ready(function () {
    
	    if(temp4=='1'){
	          data  ='<%=cmd.monthwise(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidyom,hidfleet,cmbfrequency,temp,hidmtype)%>'; 
	          // alert(data);
	        
	        
	    }else{  
	    data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","cellclassname":""},{"text":"Ref No.","datafield":"refno","cellsAlign":"center","align":"center","width":"10%","cellclassname":""},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":""},{"text":"Total","datafield":"amount","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2","cellclassname":""}]},{"rows":[{"id":"1","refno":"","description":"","amount":""}]}]';
	    
	  }          
	    	var obj = $.parseJSON(data);
         var columns = obj[0].columns;
        // var columngroups = obj[1].columngroups; 
         var rows = obj[1].rows;
			
         var source =
         {
             datatype: "json",
             datafields: [
                 	{name : 'id',type:'number'},
                 	{ name: 'refno',type:'number'},
                 	{ name: 'description',type:'string'},
                 	{ name: 'amount0',type:'number'},
                 	{ name: 'amount1',type:'number'},
                 	{ name: 'amount2',type:'number'},
                 	{ name: 'amount3',type:'number'},
                 	{ name: 'amount4',type:'number'},
                 	{ name: 'amount5',type:'number'},
                 	{ name: 'amount6',type:'number'},
                 	{ name: 'amount7',type:'number'},
                 	{ name: 'amount8',type:'number'},
                 	{ name: 'amount9',type:'number'},
                 	{ name: 'amount10',type:'number'},
                 	{ name: 'amount11',type:'number'},
                 	{ name: 'amount12',type:'number'},
                 	{ name: 'amount13',type:'number'},
                 	{ name: 'amount14',type:'number'},
                 	{ name: 'amount15',type:'number'},
                 	{ name: 'amount16',type:'number'},
                 	{ name: 'amount17',type:'number'},
                 	{ name: 'amount18',type:'number'},
                 	{ name: 'amount19',type:'number'},
                 	{ name: 'amount20',type:'number'},
                 	{ name: 'amount21',type:'number'},
                 	{ name: 'amount22',type:'number'},
                 	{ name: 'amount23',type:'number'},
                 	{ name: 'amount24',type:'number'},
                 	{ name: 'amount25',type:'number'},
                 	{ name: 'amount26',type:'number'},
                 	{ name: 'amount27',type:'number'},
                 	{ name: 'amount28',type:'number'},
                 	{ name: 'amount29',type:'number'},
                 	{ name: 'amount30',type:'number'}
                 	
             ],
             id: 'id',
             localdata: rows
         };
         /*  var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
         } */ 
         var dataAdapter = new $.jqx.dataAdapter(source);
         
         $("#distributionGrid").jqxGrid(
         {
             width: '99.5%',
             height: 515,
             source: dataAdapter,
             columnsresize: true,
             columns: columns,
             showstatusbar:true,
             showaggregates:true,
             //columngroups: columngroups
         });
         
			$("#overlay, #PleaseWait").hide();
          
     });
		
</script>
  
<div id="distributionGrid"></div>