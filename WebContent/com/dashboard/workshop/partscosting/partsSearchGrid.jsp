<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>


<%@page import="com.dashboard.workshop.partscosting.*" %>
<%
ClsPartsCostingDAO partsdao=new ClsPartsCostingDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String index=request.getParameter("index")==null?"":request.getParameter("index");
String partno=request.getParameter("partno")==null?"":request.getParameter("partno");
String prdctnme=request.getParameter("prdctnme")==null?"":request.getParameter("prdctnme");
String stock=request.getParameter("stock")==null?"":request.getParameter("stock"); 
String unit=request.getParameter("unit")==null?"":request.getParameter("unit"); 
%>
<script type="text/javascript">
var index='<%=index%>';
var id='<%=id%>';
var partssearchdata;

if(id=="1"){
	partssearchdata='<%=partsdao.getPartsData(id,partno,prdctnme,stock,unit)%>';
}
else{
	partssearchdata=[];
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
                  		{name : 'brandname',type:'string'},
                  		{name : 'fixingprice',type:'number'},
                  		{name : 'stdprice',type:'number'}
                  		
				
                  		],
				    localdata: partssearchdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
 
    $("#partsSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	});
    
    
    
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
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Part Doc No',datafield:'partdocno',width:'0%', editable: false,hidden:true},
       				{ text: 'Part No',datafield:'partno',width:'15%', editable: false},
       				{ text: 'Product Name',datafield:'productname',width:'40%', editable: false},
       				{ text: 'Unit',datafield:'unit',width:'10%', editable: false},
       				{ text: 'Stock',datafield:'balqty',width:'10%', editable: false},
       				{ text: 'Brand',datafield:'brandname',width:'0%', hidden:true},
       				{ text: 'Price',datafield:'fixingprice',width:'0%', hidden:true,cellsformat:'d2'},
       				{ text: 'Standard Cost',datafield:'stdprice',width:'15%',align: 'right', cellsalign: 'right',cellsformat:'d2'}

					]
    });
     $('#partsSearchGrid').on('rowdoubleclick', function (event) 
    { 
 	  	
    	 var rowindex1=event.args.rowindex;
//     	 alert($('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'productname')+"index"+index);
    	 $('#partsGridId').jqxGrid('setcellvalue',index,'product',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'productname'));
    	 $('#partsGridId').jqxGrid('setcellvalue',index,'psrno',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'partdocno'));
 	  	$('#partsGridId').jqxGrid('setcellvalue',index,'stdcost',$('#partsSearchGrid').jqxGrid('getcellvalue',rowindex1,'stdprice'));
 	  	
 	    $('#productswindow').jqxWindow('close');
      
       		});	 
     
    });

</script>
<div id="partsSearchGrid"></div>