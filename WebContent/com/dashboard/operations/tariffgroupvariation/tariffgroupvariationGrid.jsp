<%@page import="com.dashboard.operations.tariffgroupvariation.ClstariffGroupVariationDAO" %>
<%ClstariffGroupVariationDAO cuv=new ClstariffGroupVariationDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
var tariffgroupdata;
   if(id=='1'){
	tariffgroupdata='<%=cuv.gettariffgroupdata( branch,  fromdate,  todate,  agmtno, cldocno,  temp)%>';
   	//alert(tariffgroupdata);
   }
else{
	tariffgroupdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'refno',type:'number'},
                  		{name : 'reftype',type:'String'},
                  		{name : 'contractfleet',type:'number'},
                  		{name : 'contractfleetreg',type:'number'},
                  		{name : 'repno',type:'number'},
                  		{name :'repdate',type:'date'},
                  		{name : 'reptime',type:'String'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'fleetreg',type:'number'},
     					{name : 'voc_no',type:'number'},        		
                  		{name : 'contvehgrpid',type:'String'},
                  		{name : 'fleetgrpid',type:'String'},
                  		],
				    localdata: tariffgroupdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#tariffgroupGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#tariffgroupGrid").jqxGrid(
    {
        width: '99%',
        height: 525,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
       columnsresize:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Original Agmt Doc No',datafield:'refno',width:'10%',hidden:true},
       				{ text:'Agmt No',datafield:'voc_no',width:'7%'},
					{ text:'Ref Type',datafield:'reftype',width:'7%'},
       				{ text :'Contract Veh',datafield:'contractfleet',width:'10%'},
       				{ text :'Contract Veh Reg No',datafield:'contractfleetreg',width:'10%'},
       				{ text :'Contract Veh. Group-Id',datafield:'contvehgrpid',width:'12%'},
       				{ text :'Replace No',datafield:'repno',width:'8%'},
       				{ text :'Replace Date',datafield:'repdate',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text :'Replace Time',datafield:'reptime',width:'7%'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'10%'},
       				{ text: 'Vehicle Reg No',datafield:'fleetreg',width:'8%'},
       				{ text: 'Vehicle Group-Id',datafield:'fleetgrpid',width:'10%'}
       				
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
 
    
    });

	
	
</script>
<div id="tariffgroupGrid"></div>