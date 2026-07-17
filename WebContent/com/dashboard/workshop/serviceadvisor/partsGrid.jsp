<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String processstatus=request.getParameter("processstatus")==null?"":request.getParameter("processstatus");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String srvcadvisorconfig=request.getParameter("srvcadvisorconfig")==null?"0":request.getParameter("srvcadvisorconfig");
%>
<style>
.redClass
	{
		background-color:#FFEBEB;
	}
</style>
<script type="text/javascript">

var id='<%=id%>';
var partsdata;
var processstatus='<%=processstatus%>';
var srvcadvisorconfig='<%=srvcadvisorconfig%>';
var stockqtyhidden=false;
if(parseInt(srvcadvisorconfig)==0){
	stockqtyhidden=true;
}
else{
	stockqtyhidden=false;
}
var partnamewidth='';
if(stockqtyhidden==true){
	partnamewidth='30%';
}
else{
	partnamewidth='20%';
}
if(id=='1'){
	if(processstatus=='2'){
		partsdata='<%=servicedao.getPartsData(id,processstatus,docno)%>';
	}
 <%-- partsdata='<%=servicedao.getPartsData(id)%>'; --%>
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	partsdata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                     	{name : 'partdocno',type:'number'},
                  		{name : 'partno',type:'string'},
                  		{name : 'productname',type:'string'},
                  		{name : 'unit',type:'string'},
                  		{name : 'balqty',type:'number'},
                  		{name : 'qty',type:'number'}
				
                  		],
				    localdata: partsdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var cellclassname = function (row, column, value, data) {
        if(parseInt(data.balqty)==0){
        	return "redClass"; 
        }
        else{
        	
        };
          }; 
    $("#partsGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#partsGrid").jqxGrid(
    {
        width: '98%',
        height: 220,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        editable:true,
        filterable: true,
        selectionmode: 'singlecell',
        enableAnimations: true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Part Doc No',datafield:'partdocno',width:'20%', cellclassname:cellclassname, editable: false,hidden:true},
       				{ text: 'Part No',datafield:'partno',width:partnamewidth, cellclassname:cellclassname, editable: false},
       				{ text: 'Product Name',datafield:'productname',width:'35%', cellclassname:cellclassname, editable: false},
       				{ text: 'Unit',datafield:'unit',width:'15%', cellclassname:cellclassname, editable: false},
					{ text: 'Quantity',datafield:'qty',width:'10%', cellclassname:cellclassname,editable:true,
       					validation:function (cell,value){
       						var stock=parseInt($('#partsGrid').jqxGrid('getcellvalue',cell.row,'balqty'));
       	    		    	var qty=parseInt(value);
       	    		    	if(stockqtyhidden==false){
       	    		    		if(qty>stock){
           	    		    		$('#partsGrid').jqxGrid('setcellvalue',cell.row,'qty',0);
           	    		    		return { result: false, message: "Stock Not Available" };
           	    		    	}
                		 		else{
                			 		return true;
                		 		}	
       	    		    	}
       	    		    	else{
       	    		    		return true;
       	    		    	}
       	    		    	
            	 }},
					{ text: 'Stock',datafield:'balqty',width:'10%', cellclassname:cellclassname,editable:true,hidden:stockqtyhidden},

					]
    });
    $("#partsGrid").jqxGrid("addrow", null, {});
    $('#partsGrid').on('celldoubleclick', function (event) 
    	{ 
  	  	var rowindex=event.args.rowindex;
  	  	var datafield=event.args.datafield;
  	  	if(datafield!="qty"){
  	  	  	$('#partsindex').val(rowindex);
  	  	  	$('#partssearchwindow').jqxWindow('open');
  			$('#partssearchwindow').jqxWindow('focus');
  		 	searchContent('prodectnamesearch.jsp?partindex='+rowindex+'&srvcadvisorconfig='+srvcadvisorconfig, 'partssearchwindow');	
  	  	}
   });	 
    /* $("#partsGrid").on('cellvaluechanged', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // column data field.
    		    var datafield = event.args.datafield;
    		    // row's bound index.
    		    var rowindex = event.args.rowindex;
    		    // new cell value.
    		    var value = event.args.newvalue;
    		    // old cell value.
    		    var oldvalue = event.args.oldvalue;
    		    if(datafield=="qty"){
    		    	var stock=parseInt($('#partsGrid').jqxGrid('getcellvalue',rowindex,'balqty'));
    		    	var qty=parseInt(value);
    		    	if(qty>stock){
    		    		//$.messager.alert('Warning','Stock Not Available');
    		    		$('#partsGrid').jqxGrid('setcellvalue',rowindex,'qty',0);
    		    		return false;
    		    	}
    		    }
    		}); */
    });

</script>
<div id="partsGrid"></div>
<input type="hidden" name="partsindex" id="partsindex">