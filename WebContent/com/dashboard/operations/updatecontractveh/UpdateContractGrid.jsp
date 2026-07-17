<%@page import="com.dashboard.operations.updatecontractveh.ClsContractUpdateVehDAO" %>
<%ClsContractUpdateVehDAO cuv=new ClsContractUpdateVehDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
%>

<script type="text/javascript">
var id='<%=temp%>';
var updatedata=null;
   if(id=='1'){
	 updatedata='<%=cuv.getVehUtilize( branch,  fromdate,  todate,  agmtno,  agmttype,  cldocno,  temp)%>';
   	//alert(updatedata);
   }
else{
	
}
$(document).ready(function () {

  /*  $('#btnExcel').click(function(){
	   if(parseInt(window.parent.chkexportdata.value.trim())=="1") {
			JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
		}
		else{
		   // $("#jqxRefund").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
		}
		
		}); */
/*    function funExportBtn(){
		
	} */

   
   
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
     					{name : 'voc_no',type:'number'}             		
                  		
                  		],
				    localdata: updatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#updateContractGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#updateContractGrid").jqxGrid(
    {
        width: '98%',
        height: 525,
        source: dataAdapter,
        filtermode:'excel',
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
       				{ text: 'Original Agmt Doc No',datafield:'refno',width:'10%',hidden:true},
       				{ text:'Agmt No',datafield:'voc_no',width:'10%'},
					{ text:'Ref Type',datafield:'reftype',width:'10%'},
       				{ text :'Contract Veh',datafield:'contractfleet',width:'10%'},
       				{ text :'Contract Veh Reg No',datafield:'contractfleetreg',width:'10%'},
       				{ text :'Replace No',datafield:'repno',width:'10%'},
       				{ text :'Replace Date',datafield:'repdate',width:'10%',cellsformat:'dd.MM.yyyy'},
       				{ text :'Replace Time',datafield:'reptime',width:'10%'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'10%'},
       				{ text: 'Vehicle Reg No',datafield:'fleetreg',width:'10%'}
       				
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    
    
    $('#updateContractGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	
      	document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");
      		});	 
     
    
    });

	
	
</script>
<div id="updateContractGrid"></div>