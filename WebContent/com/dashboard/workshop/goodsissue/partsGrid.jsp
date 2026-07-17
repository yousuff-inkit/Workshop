<%@page import="com.dashboard.workshop.goodsissue.ClsGoodsIssueDAO"%>
<%ClsGoodsIssueDAO goodsdao=new ClsGoodsIssueDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String srvcadvisor=request.getParameter("srvcadvisor")==null?"":request.getParameter("srvcadvisor");
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

if(id=='1'){
  partsdata='<%=goodsdao.getPartsData(id,fromdate,todate,srvcadvisor)%>';
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
						{name : 'srvcdocno',type:'number'},
                     	{name : 'partdocno',type:'number'},
                  		{name : 'partno',type:'string'},
                  		{name : 'productname',type:'string'},
                  		{name : 'unit',type:'string'},
                  		{name : 'balqty',type:'number'},
						{name : 'qty',type:'number'},
						{name : 'psrno',type:'number'},
						{name : 'prodoc',type:'number'},
						{name : 'unitdocno',type:'number'},
						{name : 'specid',type:'number'},
						{name : 'cost_price',type:'number'},
						{name : 'savecost_price',type:'number'}

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
        height: 250,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        editable:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Service Advisor No',datafield:'srvcdocno',width:'10%',editable:false},
       				{ text: 'Part Doc No',datafield:'partdocno',width:'9%', cellclassname:cellclassname, editable: false,hidden:true},
       				{ text: 'Part No',datafield:'partno',width:'20%', cellclassname:cellclassname,editable:false},
       				{ text: 'Product Name',datafield:'productname',width:'35%', cellclassname:cellclassname,editable:false},
       				{ text: 'Unit',datafield:'unit',width:'9%', cellclassname:cellclassname,editable:false},
					{ text: 'Quantity',datafield:'qty',width:'9%', cellclassname:cellclassname,editable:true},
					{ text: 'Stock',datafield:'balqty',width:'9%', cellclassname:cellclassname,editable:false},
					{ text: 'PSR No',datafield:'psrno',width:'9%', cellclassname:cellclassname,hidden:true,editable:false},
					{ text: 'Product Doc No',datafield:'prodoc',width:'9%', cellclassname:cellclassname,hidden:true,editable:false},
					{ text: 'Unit Doc No',datafield:'unitdocno',width:'9%', cellclassname:cellclassname,hidden:true,editable:false},
					{ text: 'Spec Id',datafield:'specid',width:'9%', cellclassname:cellclassname,hidden:true,editable:false},
					{ text: 'Cost Price',datafield:'cost_price',width:'9%', cellclassname:cellclassname,hidden:true,editable:false},
					{ text: 'Save Cost Price',datafield:'savecost_price',width:'9%', cellclassname:cellclassname,hidden:true,editable:false}

					]
    });

    });

</script>
<div id="partsGrid"></div>