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
String grpby=request.getParameter("grpby")==null?"":request.getParameter("grpby");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
var clientgroupdata;
   if(id=='1'){
	 clientgroupdata='<%=clientdao.getClientGroupData(branch,fromdate,todate,hidbrand,hidmodel,hidgroup,hidyom,temp,hidfleet,grpby,hidclient)%>';
   }
else{
	clientgroupdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'refno',type:'number'},
						{name : 'description',type:'String'},
						{name : 'countno',type:'number'},
						{name : 'netamount',type:'number'},
						{name : 'average',type:'number'}
                  		],
				    localdata: clientgroupdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#abcClientGroupGrid").on("bindingcomplete", function (event) {
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
    
    
    
    $("#abcClientGroupGrid").jqxGrid(
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
       				
       				{ text: 'Ref No',datafield:'refno',width:'10%'},
       				{ text: 'Description',datafield:'description',width:'56%'},
       				{ text: 'Count',datafield:'countno',width:'10%'},
       				{ text: 'Net Amount',datafield:'netamount',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Avg Amount',datafield:'average',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
       				
       				]

    });
    
  
   
});

	
	
</script>
<div id="abcClientGroupGrid"></div>