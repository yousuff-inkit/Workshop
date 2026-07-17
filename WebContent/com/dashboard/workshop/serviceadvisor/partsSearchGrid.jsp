<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String partindex=request.getParameter("partindex")==null?"":request.getParameter("partindex");
String partno=request.getParameter("partno")==null?"":request.getParameter("partno");
 String prdctnme=request.getParameter("prdctnme")==null?"":request.getParameter("prdctnme");
String stock=request.getParameter("stock")==null?"":request.getParameter("stock"); 
String unit=request.getParameter("unit")==null?"":request.getParameter("unit"); 
String srvcadvisorconfig=request.getParameter("srvcadvisorconfig")==null?"0":request.getParameter("srvcadvisorconfig");
%>
<style>
.redClass
	{
		background-color:#FFEBEB;
	}
</style>
<script type="text/javascript">
var partindex='<%=partindex%>';
var id='<%=id%>';
var partssearchdata;
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
	partnamewidth='46%';
}
else{
	partnamewidth='36%';
}
if(id=="1"){
	partssearchdata='<%=servicedao.getPartsData(id,partno,prdctnme,stock,unit)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	partssearchdata=[];
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
                  		{name : 'balqty',type:'number'}
				
                  		],
				    localdata: partssearchdata,
        
				   
    
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
    $("#partsSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#partsSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 250,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        editable:true,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '9%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Part Doc No',datafield:'partdocno',width:'20%', cellclassname:cellclassname, editable: false,hidden:true},
       				{ text: 'Part No',datafield:'partno',width:partnamewidth, cellclassname:cellclassname, editable: false},
       				{ text: 'Product Name',datafield:'productname',width:'35%', cellclassname:cellclassname, editable: false},
       				{ text: 'Unit',datafield:'unit',width:'10%', cellclassname:cellclassname, editable: false},
       				{ text: 'Stock',datafield:'balqty',width:'10%', cellclassname:cellclassname, editable: false,hidden:stockqtyhidden}

					]
    });
    $('#partsSearchGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      $('#partsGrid').jqxGrid('setcellvalue',partindex,'partdocno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno'));
      $('#partsGrid').jqxGrid('setcellvalue',partindex,'partno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partno'));
      $('#partsGrid').jqxGrid('setcellvalue',partindex,'productname',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'productname'));
      $('#partsGrid').jqxGrid('setcellvalue',partindex,'unit',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'unit'));
      $('#partsGrid').jqxGrid('setcellvalue',partindex,'balqty',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'balqty'));
      $("#partsGrid").jqxGrid("addrow", null, {});
      $('#partssearchwindow').jqxWindow('close');
      /* $('#partsGrid').jqxGrid('setcellvalue',partindex,'partdocno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno')); */
      
      		});	 
     
    });

</script>
<div id="partsSearchGrid"></div>