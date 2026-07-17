<%@page import="com.dashboard.workshop.partsplanning.*" %>
<%
ClsPartsPlanningDAO plandao=new ClsPartsPlanningDAO();
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
	partssearchdata='<%=plandao.getPartsSearchData(id,partno,prdctnme,stock,unit)%>';
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
                  		{name : 'stock',type:'number'},
                  		{name : 'brandname',type:'string'},
                  		{name : 'fixingprice',type:'number'},
                  		{name : 'prdid',type:'string'},
                  		{name : 'unitdocno',type:'string'},
                  		{name : 'specid',type:'string'}
				
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
    	$('.load-wrapp').hide();
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
       				{ text: 'Part No',datafield:'partno',width:partnamewidth,width:'25%', cellclassname:cellclassname, editable: false},
       				{ text: 'Product Name',datafield:'productname', cellclassname:cellclassname, editable: false},
       				{ text: 'Unit',datafield:'unit',width:'10%', cellclassname:cellclassname, editable: false},
       				{ text: 'Stock',datafield:'stock',width:'10%', cellclassname:cellclassname, editable: false,cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'Brand',datafield:'brandname',width:'10%',cellclassname:cellclassname,hidden:true},
       				{ text: 'Price',datafield:'fixingprice',width:'10%',cellclassname:cellclassname,hidden:true,cellsformat:'d2'},
					{ text: 'PRD Id',datafield:'prdid',width:'20%', cellclassname:cellclassname, editable: false,hidden:true},
					{ text: 'Unit Docno',datafield:'unitdocno',width:'20%', cellclassname:cellclassname, editable: false,hidden:true},
					{ text: 'Spec Id',datafield:'specid',width:'20%', cellclassname:cellclassname, editable: false,hidden:true},
					]
    });
    $('#partsSearchGrid').on('rowdoubleclick', function (event) 
    { 
	  	var rowindex1=event.args.rowindex;
	  	$('#partsGrid').jqxGrid('setcellvalue',partindex,'productname',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'productname'));
	  	$('#partsGrid').jqxGrid('setcellvalue',partindex,'brand',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'brandname'));
	  	$('#partsGrid').jqxGrid('setcellvalue',partindex,'partdocno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno'));
	  	$('#partsGrid').jqxGrid('setcellvalue',partindex,'psrno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno'));
	    //$('#partsGrid').jqxGrid('setcellvalue',partindex,'rate',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'fixingprice'));
	    $('#partsGrid').jqxGrid('setcellvalue',partindex,'stock',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'balqty'));
	    $('#partsGrid').jqxGrid('setcellvalue',partindex,'prdid',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'prdid'));
	    $('#partsGrid').jqxGrid('setcellvalue',partindex,'unitdocno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'unitdocno'));
	    $('#partsGrid').jqxGrid('setcellvalue',partindex,'specid',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'specid'));
	    $("#partsGrid").jqxGrid("addrow", null, {});
	    $('#partssearchwindow').jqxWindow('close');
      /* $('#partsGrid').jqxGrid('setcellvalue',partindex,'partdocno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno')); */
      
      		});	 
     
    });

</script>
<div id="partsSearchGrid"></div>