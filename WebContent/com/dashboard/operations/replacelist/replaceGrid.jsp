<%@page import="com.dashboard.operations.replacelist.*"%>
<%
ClsReplaceListDAO repdao=new ClsReplaceListDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String repstatus=request.getParameter("repstatus")==null?"":request.getParameter("repstatus");
String repreason=request.getParameter("repreason")==null?"":request.getParameter("repreason");
String reptype=request.getParameter("reptype")==null?"":request.getParameter("reptype");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtbranch=request.getParameter("agmtbranch")==null?"":request.getParameter("agmtbranch");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String rentaltype=request.getParameter("rentaltype")==null?"":request.getParameter("rentaltype");
String agmtstatus=request.getParameter("agmtstatus")==null?"":request.getParameter("agmtstatus");
%>

<script type="text/javascript">
 
var id='<%=temp%>';
var repdata;
var repexceldata;

if(id=='1'){
 repdata='<%=repdao.getRepData(fromdate,todate,agmttype,agmtno,rentaltype,agmtstatus,repstatus,repreason,reptype,agmtbranch,temp)%>';
 repexceldata='<%=repdao.getRepExcelData(fromdate,todate,agmttype,agmtno,rentaltype,agmtstatus,repstatus,repreason,reptype,agmtbranch,temp)%>';
}
else{
repdata;
repexceldata;
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'repno',type:'number'},
                  		{name : 'agmtno',type:'number'},
                  		{name : 'agmttype',type:'string'},
                  		{name : 'outfleetno',type:'number'},
                  		{name : 'outfleetreg',type:'number'},
                  		{name : 'outfleetname',type:'string'},
                  		{name : 'outdate',type:'string'},
                  		{name :'outtime',type:'string'},
                  		{name : 'outkm',type:'number'},
                  		{name : 'outfuel',type:'string'},
                  		{name : 'infleetno',type:'string'},
                  		{name : 'infleetreg',type:'string'},
                  		{name : 'infleetname',type:'string'},
                  		{name : 'indate',type:'string'},
                  		{name :'intime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		{name : 'infuel',type:'string'},
                  		{name : 'coldate',type:'string'},
                  		{name :'coltime',type:'string'},
                  		{name : 'colkm',type:'number'},
                  		{name : 'colfuel',type:'string'},
                  		{name : 'deldate',type:'string'},
                  		{name :'deltime',type:'string'},
                  		{name : 'delkm',type:'number'},
                  		{name : 'delfuel',type:'string'},            		
                  		{name : 'replacetype',type:'string'},
                  		{name : 'replacereason',type:'string'},
                  		{name : 'agmtbranch',type:'string'},
                  		{name : 'repbrch',type:'string'},

				{name : 'delconkm',type:'number'},
                  		{name : 'colconkm',type:'number'}
				
                  		],
				    localdata: repdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#replaceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#replaceGrid").jqxGrid(
    {
        width: '98%',
        height: 535,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Rep Branch',datafield:'repbrch',width:'12%'},
       				{ text: 'Rep No',datafield:'repno',width:'6%'},
       				{ text: 'Rep Reason',datafield:'replacereason',width:'10%'},
       				{ text: 'Rep Type',datafield:'replacetype',width:'7%'},
       				{ text: 'Agmt Branch',datafield:'agmtbranch',width:'7%'},
       				{ text:'Agmt No',datafield:'agmtno',width:'7%'},
       				{ text:'Agmt Type',datafield:'agmttype',width:'6%'},
				{ text: 'Del Cons KM',datafield:'delconkm',width:'7%',cellsalign: 'right', align:'right'},
       				{ text: 'Col Cons KM',datafield:'colconkm',width:'7%',cellsalign: 'right', align:'right'},
       				{ text :'Fleet',datafield:'outfleetno',width:'8%',columngroup:'outdetails'},
       				{ text :'Reg No',datafield:'outfleetreg',width:'8%',columngroup:'outdetails'},
       				{ text :'Fleet Name',datafield:'outfleetname',width:'8%',hidden:true,columngroup:'outdetails'},
       				{ text :'Date',datafield:'outdate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'outdetails'},
       				{ text :'Time',datafield:'outtime',width:'8%',cellsformat:'HH:mm',columngroup:'outdetails'},
       				{ text :'Km',datafield:'outkm',width:'8%',columngroup:'outdetails',cellsalign: 'right', align:'right'},
       				{ text :'Fuel',datafield:'outfuel',width:'8%',columngroup:'outdetails'},
       				{ text :'Fleet',datafield:'infleetno',width:'8%',columngroup:'indetails'},
       				{ text :'Reg No',datafield:'infleetreg',width:'8%',columngroup:'indetails'},
       				{ text :'Fleet Name',datafield:'infleetname',width:'8%',hidden:true,columngroup:'indetails'},
       				{ text :'Date',datafield:'indate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'indetails'},
       				{ text :'Time',datafield:'intime',width:'8%',cellsformat:'HH:mm',columngroup:'indetails'},
       				{ text: 'Km',datafield:'inkm',width:'8%',columngroup:'indetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'infuel',width:'8%',columngroup:'indetails'},
       				{ text :'Date',datafield:'coldate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'coldetails'},
       				{ text :'Time',datafield:'coltime',width:'8%',cellsformat:'HH:mm',columngroup:'coldetails'},
       				{ text: 'Km',datafield:'colkm',width:'8%',columngroup:'coldetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'colfuel',width:'8%',columngroup:'coldetails'},
       				{ text :'Date',datafield:'deldate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'deldetails'},
       				{ text :'Time',datafield:'deltime',width:'8%',cellsformat:'HH:mm',columngroup:'deldetails'},
       				{ text: 'Km',datafield:'delkm',width:'8%',columngroup:'deldetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'delfuel',width:'8%',columngroup:'deldetails'},
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */


					],columngroups: 
	                     [
	                       { text: 'Out Fleet Details', align: 'center', name: 'outdetails'},
	                       { text: 'In Fleet Details', align: 'center', name: 'indetails'},
	                       { text: 'Collection Details', align: 'center', name: 'coldetails'},
	                       { text: 'Delivery Details', align: 'center', name: 'deldetails'}
	                    
	                     ]

    });
    $('#replaceGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	/* document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="replaceGrid"></div>