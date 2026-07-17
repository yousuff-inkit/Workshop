<%@page import="com.dashboard.analysis.abcclient.*" %>
<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
ClsAbcClientDAO clientdao=new ClsAbcClientDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
var clientdata;
   if(id=='1'){
	  clientdata='<%=clientdao.getClientData(branch,fromdate,todate,hidbrand,hidmodel,hidgroup,hidyom,temp,hidfleet,hidclient)%>'; 
   }
else{
	clientdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						
						{name : 'branch',type:'String'},
						{name : 'doc_no',type:'number'},
						{name : 'renttype',type:'string'},
						{name : 'client',type:'string'},
						{name : 'useddays',type:'string'},
						{name : 'reg_no',type:'number'},
						{name : 'fleet_no',type:'number'},
						{name : 'brand',type:'string'},
						{name : 'model',type:'string'},
						{name : 'usedvalue',type:'number'}
                  		],
				    localdata: clientdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#abcClientGrid").on("bindingcomplete", function (event) {
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
    
    
    
    $("#abcClientGrid").jqxGrid(
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
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				
       				{ text: 'Branch',datafield:'branch',width:'10%'},
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text: 'Rent Type',datafield:'renttype',width:'7%'},
       				{ text: 'Client',datafield:'client',width:'24%'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'8%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'7%'},
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'10%'},
       				{ text: 'Used Days',datafield:'useddays',width:'7%',align:'right',cellsalign:'right',hidden:true},
       				{ text: 'Used Value',datafield:'usedvalue',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
       				]

    });
    
  
   
});

	
	
</script>
<div id="abcClientGrid"></div>