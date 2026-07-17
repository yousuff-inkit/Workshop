<%@page import="com.dashboard.vehicle.readytorent.*" %>
<%ClsReadyToRentDAO rentdao=new ClsReadyToRentDAO();
String check=request.getParameter("check")==null?"":request.getParameter("check");

%>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style type="text/css">
       /* .headClass
        {
            background-color: #FFEBC2;
        }
        .openingClass
        {
            background-color: #FFFFD1;
        }
        .invoiceClass
  	    {	
	      background-color: #FBEFF5;
	    }
	    .receiptClass
	    {
	      background-color: #E0F8F1;
	    } */
</style>

 <script type="text/javascript">

 		var check='<%=check%>';
 	   
 	   $(document).ready(function () {
 	    var data;
 	    if(check=='1'){
 	          data = '<%=rentdao.getBranchwiseData(check)%>';  
 	          // alert(data);
 	    }else{
 	     data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","cellclassname":""},{"text":"Ref No.","datafield":"refno","cellsAlign":"center","align":"center","width":"10%","cellclassname":""},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":""},{"text":"Branch","datafield":"branch0","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2","cellclassname":""}]},{"rows":[{"id":"1","refno":"","description":"","branch0":""}]}]';

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
                    	{ name: 'branch0',type:'number'},
                    	{ name: 'branch1',type:'number'},
                    	{ name: 'branch2',type:'number'},
                    	{ name: 'branch3',type:'number'},
                    	{ name: 'branch4',type:'number'},
                    	{ name: 'branch5',type:'number'},
                    	{ name: 'branch6',type:'number'},
                    	{ name: 'branch7',type:'number'},
                    	{ name: 'branch8',type:'number'},
                    	{ name: 'branch9',type:'number'},
                    	{ name: 'brcount',type:'number' }
                    	
                ],
                id: 'id',
                localdata: rows
            };
            /*   var rendererstring=function (aggregates){
            	var value=aggregates['sum'];
            	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
            }  */ 
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#branchwiseGrid").jqxGrid(
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

<div id="branchwiseGrid"></div>
