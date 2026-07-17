<%@page import="com.dashboard.workshop.nipurchasecreate.ClsNiPurchaseCreateDAO"%>
<%
ClsNiPurchaseCreateDAO DAO=new ClsNiPurchaseCreateDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String vendorid=request.getParameter("vendorid")==null?"":request.getParameter("vendorid");
String podocno=request.getParameter("podocno")==null?"":request.getParameter("podocno");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var podata;
var poexportdata;


if(id=='1'){
	podata='<%=DAO.getPurchaseOrderData(fromdate,todate,vendorid,podocno,id)%>';
	poexportdata=<%=DAO.getPurchaseOrderExcelData(fromdate,todate,vendorid,podocno,id)%>

}
else{
	podata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
                  		{name : 'voc_no',type:'number'},
                  		{name : 'refname',type:'string'},
                  		{name : 'date',type:'date'},
                  		{name : 'crdate',type:'date'},
                  		{name : 'refno',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'amount',type:'number'},
                  		{name : 'atype',type:'string'},
                  		{name : 'acno',type:'string'},
                  		{name : 'acname',type:'string'},
                  		{name : 'curid',type:'string'},
                  		{name : 'rate',type:'string'},
                  		{name : 'orderdocno',type:'string'},
                  		{name : 'accdocno',type:'string'},
                  		],
				    localdata: podata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#nipurchaseCreateGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#nipurchaseCreateGrid").jqxGrid(
    {
        width: '98%',
        height: 260,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'10%',hidden:true},
       				{ text: 'Voc No',datafield:'voc_no',width:'10%'},
       				{ text: 'Date',datafield:'date',width:'15%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Dates',datafield:'crdate',width:'15%',cellsformat:'dd.MM.yyyy',hidden:true},
       				{ text: 'Vendor',datafield:'refname',width:'20%'},
       				{ text: 'Ref No',datafield:'refno',width:'10%'},
       				{ text: 'Description',datafield:'description',width:'25%'},
       				{ text: 'Amount',datafield:'amount',width:'15%',cellsformat:'d2',cellsalign:'right',align:'right'}
					]
    });
    $('#nipurchaseCreateGrid').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
  		 document.getElementById("hdocno").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
  		document.getElementById("atype").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'atype');
  		document.getElementById("acno").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'acno');
  		document.getElementById("acname").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'acname');
  		document.getElementById("curid").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'curid');
  		document.getElementById("rate").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'rate');
  		document.getElementById("orderdate").value =$('#nipurchaseCreateGrid').jqxGrid('getcelltext',rowindex1,'date');
  		document.getElementById("amount").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'amount');
  		document.getElementById("vendorname").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'refname'); 
  		document.getElementById("costcode").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'orderdocno');
  		document.getElementById("headdoc").value =$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'accdocno');
  		document.getElementById("curntdate").value =$('#nipurchaseCreateGrid').jqxGrid('getcelltext',rowindex1,'crdate');
  		
  		$("#overlay, #PleaseWait").show(); 
   	   	$("#detaildiv").load("detailGrid.jsp?docno="+$('#nipurchaseCreateGrid').jqxGrid('getcellvalue',rowindex1,'doc_no')+"&id=1");
   	   	
      	});	 
     
  
    });

	
	
</script>
<div id="nipurchaseCreateGrid"></div>