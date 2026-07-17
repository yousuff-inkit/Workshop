<%@page import="com.dashboard.operations.insplist.*"%>
<%
ClsInspListDAO inspdao=new ClsInspListDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype");
String agmtbranch=request.getParameter("agmtbranch")==null?"":request.getParameter("agmtbranch");
String refdocno=request.getParameter("refdocno")==null?"":request.getParameter("refdocno");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String invoicetype=request.getParameter("invoicetype")==null?"":request.getParameter("invoicetype");
%>
<style>

.ragClass{
	background-color: #c8ccd2;
}
.lagClass{
	background-color: #bbf0f4;
}
.rplClass{
	background-color: #89eecd;
}
.stfClass{
	background-color: 	#a9ff96;
}
.drvClass{
	background-color: #53a695;
}
</style>
<script type="text/javascript">
var id='<%=temp%>';
var insplistdata;

	if(id=='1'){
  insplistdata='<%=inspdao.getInspList(branch,fromdate,todate,reftype,agmtbranch,refdocno,client,type,invoicetype,temp)%>'; 
  <%--repexceldata='<%=repdao.getRepExcelData(fromdate,todate,agmttype,agmtno,rentaltype,agmtstatus,repstatus,repreason,reptype,agmtbranch,temp)%>'; --%>

	}
else{
	insplistdata;
}
$(document).ready(function () {
  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'reftype',type:'string'},
                  		{name : 'refvocno',type:'number'},
                  		{name : 'fleet',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'client',type:'string'},
                  		{name : 'amount',type:'number'},
                  		{name : 'accdate',type:'date'},
                  		{name : 'policereport',type:'string'},
                  		{name : 'insurexcess',type:'number'},
                  		{name : 'clienttype',type:'string'},
                  		{name : 'invno',type:'string'},
                  		{name : 'invtype',type:'string'},
                  		{name : 'type',type:'string'},
                  		{name : 'invvocno',type:'string'}
                  		],
				    localdata: insplistdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#InspListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var cellclassname = function (row, column, value, data) {
        
          if(data.clienttype=="RAG"){
        	  return "ragClass";
          }
          else if(data.clienttype=="LAG"){
        	  return "lagClass";
          }
          else if(data.clienttype=="RPL"){
        	  return "rplClass";
          }
          else if(data.clienttype=="DRV"){
        	  return "drvClass";
          }
          else if(data.clienttype=="STF"){
        	  return "stfClass";
          }
          else{
        	  
          }
             };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#InspListGrid").jqxGrid(
    {
        width: '98%',
        height: 525,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
      	sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}
       				},
       				{ text :'Doc No',datafield:'doc_no',width:'6%',cellclassname: cellclassname},
       				{ text :'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text :'Type',datafield:'type',width:'8%',cellclassname: cellclassname},
       				{ text :'Ref Type',datafield:'reftype',width:'7%',cellclassname: cellclassname},
       				{ text :'Ref Doc No',datafield:'refvocno',width:'7%',cellclassname: cellclassname},
       				{ text :'Fleet',datafield:'fleet',width:'15%',cellclassname: cellclassname},
       				{ text :'Reg No',datafield:'reg_no',width:'7%',cellclassname: cellclassname},
       				{ text :'Client/Driver/Staff',datafield:'client',width:'18%',cellclassname: cellclassname},
       				{ text :'Amount',datafield:'amount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname: cellclassname},
       				{ text :'Inv No Original',datafield:'invno',width:'8%',cellclassname: cellclassname,hidden:true},
       				{ text :'Inv No',datafield:'invvocno',width:'8%',cellclassname: cellclassname},
       				{ text :'Inv Type',datafield:'invtype',width:'8%',cellclassname: cellclassname},
       				{ text :'Acc Date',datafield:'accdate',width:'6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text :'Police Report',datafield:'policereport',width:'8%',cellclassname: cellclassname},
       				{ text :'Insur Excess',datafield:'insurexcess',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',cellclassname: cellclassname},
       				{ text :'Client Type',datafield:'clienttype',width:'8%',hidden:true,cellclassname: cellclassname}
					]
    });
    });

	
	
</script>
<div id="InspListGrid"></div>