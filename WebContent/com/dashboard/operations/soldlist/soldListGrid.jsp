<%@page import="com.dashboard.operations.soldlist.*"%>
<%
ClsSoldListDAO solddao=new ClsSoldListDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
String client=request.getParameter("client")==null?"":request.getParameter("client");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
	var solddata;
	
   	if(id=='1'){
	  solddata='<%=solddao.getSoldList(fromdate,todate,branch,client,fleet,temp)%>';
	  <%--repexceldata='<%=repdao.getRepExcelData(fromdate,todate,agmttype,agmtno,rentaltype,agmtstatus,repstatus,repreason,reptype,agmtbranch,temp)%>'; --%>
   
   	}
	else{
		solddata;
	}
   	
   	var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	if(typeof(value)=="undefined"){
       		value="";
       	}
       	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
       }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'fleetno',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'reg_no',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'saledate',type:'date'},
                  		{name : 'salesprice',type:'number'},
                  		{name : 'dep_posted',type:'date'},
                  		{name : 'purcost',type:'number'},
                  		{name :'accdep',type:'number'},
                  		{name : 'curdep',type:'number'},
                  		{name : 'netpl',type:'number'},
                  		{name : 'netbook',type:'number'},
                  		{name : 'plate',type:'string'},
                  		],
				    localdata: solddata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#soldListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#soldListGrid").jqxGrid(
    {
        width: '98%',
        height: 535,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
      	sortable:false,
      	showaggregates:true,
      	showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}
       				},
       				{ text :'Fleet No',datafield:'fleetno',width:'8%'},
       				{ text :'Fleet Name',datafield:'flname',width:'15%'},
       				{ text :'Reg No',datafield:'reg_no',width:'5%'},
       				{ text : 'Plate Code',datafield:'plate',width:'7%'},
       				{ text :'Client',datafield:'refname',width:'15%'},
       				{ text :'Sold Date',datafield:'saledate',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text : 'Purchase Cost',datafield:'purcost',width:'7%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Sales Price',datafield:'salesprice',width:'8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Dep Posted',datafield:'dep_posted',width:'6%',cellsformat:'dd.MM.yyyy',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Acc Dep',datafield:'accdep',width:'7%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Curr Dep',datafield:'curdep',width:'7%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Net P/(L)',datafield:'netpl',width:'7%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text :'Net Book',datafield:'netbook',width:'7%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'}
					]
    });
    $('#soldListGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      
      		});	 
     
  
    });

	
	
</script>
<div id="soldListGrid"></div>