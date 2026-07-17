<%@page import="com.dashboard.analysis.rawisebal.*" %>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String category=request.getParameter("category")==null?"":request.getParameter("category");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String agmtstatus=request.getParameter("agmtstatus")==null?"":request.getParameter("agmtstatus");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String chkrecievable=request.getParameter("chkrecieve")==null?"0":request.getParameter("chkrecieve");
String chkrefund=request.getParameter("chkrefund")==null?"0":request.getParameter("chkrefund");
String chkcurramt=request.getParameter("chkcurramt")==null?"0":request.getParameter("chkcurramt");
String rcvfromamt=request.getParameter("rcvfromamt")==null?"":request.getParameter("rcvfromamt");
String rcvtoamt=request.getParameter("rcvtoamt")==null?"":request.getParameter("rcvtoamt");
String refundfromamt=request.getParameter("refundfromamt")==null?"":request.getParameter("refundfromamt");
String refundtoamt=request.getParameter("refundtoamt")==null?"":request.getParameter("refundtoamt");
String currfromamt=request.getParameter("currfromamt")==null?"":request.getParameter("currfromamt");
String currtoamt=request.getParameter("currtoamt")==null?"":request.getParameter("currtoamt");
ClsRawiseBalanceDAO balancedao=new ClsRawiseBalanceDAO();
%>
<script type="text/javascript">
$(document).ready(function () {
   var id='<%=id%>';
	var baldata;
	
   if(id=='1'){
	  
	  baldata='<%=balancedao.getBalanceData(id,branch,uptodate,category,client,agmttype,agmtno,agmtstatus,fromdate,todate,chkrecievable,chkrefund,chkcurramt,
	  rcvfromamt,rcvtoamt,refundfromamt,refundtoamt,currfromamt,currtoamt)%>';
	  //alert(baldata);
	 <%-- repexceldata='<%=repdao.getRepExcelData(fromdate,todate,agmttype,agmtno,rentaltype,agmtstatus,repstatus,repreason,reptype,agmtbranch,temp)%>'; --%>
   }
else{
	baldata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'balance',type:'number'},
                  		{name : 'creditamt',type:'string'},
                  		{name : 'collectamt',type:'string'},
                  		{name : 'refundamt',type:'string'},
                  		{name : 'curramt',type:'string'},
                  		{name : 'salikamt',type:'string'},
                  		{name : 'trafficamt',type:'string'},
                  		{name :'srno',type:'number'},
                  		{name : 'agmttype',type:'string'},
                  		{name : 'agmtno',type:'string'},
                  		{name : 'cldocno',type:'number'},
                  		{name : 'refname',type:'string'},
                  		{name : 'dateout',type:'date'},
                  		{name : 'invdate',type:'date'}
                  		],
				    localdata: baldata,

        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#rawiseBalanceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#rawiseBalanceGrid").jqxGrid(
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
       				{ text: 'Agmt Type',datafield:'agmttype',width:'6%'},
       				{ text: 'Agmt No',datafield:'agmtno',width:'7%'},
       				{ text: 'Client ID',datafield:'cldocno',width:'7%',hidden:true},
       				{ text: 'Name',datafield:'refname',width:'22%'},
       				{ text:'Date Out',datafield:'dateout',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text :'Invoice Date',datafield:'invdate',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Balance',datafield:'balance',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text :'Credit Amt',datafield:'creditamt',width:'8%',align:'right',cellsalign:'right'},
       				{ text :'Collection Amt',datafield:'collectamt',width:'8%',align:'right',cellsalign:'right',cellsformat:'right'},
       				{ text :'Refund',datafield:'refundamt',width:'8%',align:'right',cellsalign:'right'},
       				{ text :'Current Amt',datafield:'curramt',width:'8%',align:'right',cellsalign:'right',hidden:true},
       				{ text :'Salik Amt',datafield:'salikamt',width:'8%',align:'right',cellsalign:'right'},
       				{ text :'Traffic Amt',datafield:'trafficamt',width:'8%',align:'right',cellsalign:'right'}
					]

    });
    $('#rawiseBalanceGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	
      		});	 
    if(document.getElementById("chkcurramt").checked==true){
    	$('#rawiseBalanceGrid').jqxGrid('showcolumn', 'curramt');
	}
	else{
    	$('#rawiseBalanceGrid').jqxGrid('hidecolumn', 'curramt');
	}
  
    });

</script>
<div id="rawiseBalanceGrid"></div>