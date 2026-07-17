<%@page import="com.dashboard.analysis.vehprofit.ClsVehProfitDAO" %>
<% ClsVehProfitDAO cvd=new ClsVehProfitDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
String gridtype=request.getParameter("gridtype")==null?"":request.getParameter("gridtype");
String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
%>

<script type="text/javascript">
 
$(document).ready(function() {
   var id='<%=temp%>';
var vehdetaildata;
   if(id=='1'){
	   vehdetaildata='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>'; 
	   detailExcelExport='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>';
   }
else{
	
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'fleetno',type:'number'},
                  		{name : 'flname',type:'String'},
                  		{name : 'income',type:'number'},
                  		{name : 'expenses',type:'number'},
                  		{name : 'netamount',type:'number'},
                  		{name : 'brand',type:'string'},
                  		{name : 'model',type:'string'},
                  		{name : 'gname',type:'string'},
                  		{name : 'yom',type:'string'},
                  		{name : 'acno',type:'number'},
                  		{name : 'description',type:'string'}
                  		/* {name : 'salesman',type:'string'},
                  		{name : 'rentalagent',type:'string'},
                  		{name : 'yom',type:'string'}
                  		 */
                  		],
				    localdata: vehdetaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vehDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#vehDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        //localization: {thousandsSeparator: ""},
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Fleet No',datafield:'fleetno',width:'10%'},
       				{ text:'Fleet Name',datafield:'flname',width:'15%'},
       				{ text: 'Account',datafield:'description',width:'15%'},
       				{ text: 'Income',datafield:'income',width:'10%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Expense',datafield:'expenses',width:'10%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				/* { text: 'Net Amount',datafield:'netamount',width:'10%',cellsalign:'right',cellsformat:'d2'}, */
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'10%'},
       				{ text: 'Group',datafield:'gname',width:'10%'},
       				{ text: 'YOM',datafield:'yom',width:'5%'},
       				{ text: 'A/c No',datafield:'acno',width:'10%',hidden:true}
       				
					]

    });
    
  
   
});

	
	
</script>
<div id="vehDetailGrid"></div>