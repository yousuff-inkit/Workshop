<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="com.operations.saleofvehicle.vehicledisposal.ClsVehicleDisposalDAO"%>
<style>
.column{
background-color: #FFA375;
}
</style>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
ClsVehicleDisposalDAO disposaldao=new ClsVehicleDisposalDAO();
%>
<script type="text/javascript">

var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';
var datafleet;
if(temp=="1"){
	datafleet='<%=disposaldao.disposalgridSearch(branch,docno)%>';
}
else{

}

        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no',type:'string'},
     						{name : 'salesprice',type:'number'},
     						{name : 'dep_posted',type:'date'},
     						{name : 'pur_value',type:'number'},
     						{name : 'acc_dep',type:'number'},
     						{name : 'cur_dep',type:'number'},
     						{name : 'netbook',type:'number'},
     						{name : 'net_pl',type:'number'}
     						
     					
                 ],
                localdata: datafleet,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#disposalGrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                disabled: true,
                altRows: true,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                //Add row method
                        handlekeyboardnavigation: function (event) {
                    var cell = $('#disposalGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fleet_no' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#disposalGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                    var cell1 = $('#disposalGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'fleet_no') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	document.getElementById("disposalrow").value=cell1.rowindex;
                        	$('#fleetwindow').jqxWindow('open');
        					$('#fleetwindow').jqxWindow('focus');
        					 fleetnoSearchContent('fleetSearch.jsp?branch='+document.getElementById("brchName").value, $('#fleetwindow'));
        					 
                          }
                        
                    }
},
                columns: [
							{ text: 'Sr No',datafield: '',editable:false,columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            } },
							{ text: 'Fleet', datafield: 'fleet_no',editable:false, width: '7%'},
							{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '14%'},
							{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '7%'},
							{ text: 'Sales Price', datafield: 'salesprice', width: '9.71%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Dep Posted', datafield: 'dep_posted', width: '9.71%',cellclassname:'column',editable:false ,cellsformat:'dd.MM.yyyy',cellsalign:'right',align:'right'},
							{ text: 'Purchase Value', datafield: 'pur_value', width: '9.71%',cellclassname:'column',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Acc.Dep', datafield: 'acc_dep', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Current Dep',datafield:'cur_dep', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net Book',datafield:'netbook', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net P /(L)',  datafield:'net_pl',width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'}
							
							]
            });
            $('#disposalGrid').on('celldoubleclick', function (event) {
         	   var row1=event.args.rowindex;
     				document.getElementById("disposalrow").value=row1;
     				if(event.args.datafield=='fleet_no'){
     				    $('#fleetwindow').jqxWindow('open');
     					$('#fleetwindow').jqxWindow('focus');
     					fleetnoSearchContent('fleetSearch.jsp?branch='+document.getElementById("brchName").value, $('#fleetwindow'));
     				}
     				
                     });
            if(document.getElementById("docno").value==''){
            	  $("#disposalGrid").jqxGrid('addrow', null, {});
                }
          var rows=$("#disposalGrid").jqxGrid('getrows');
          var rowlength=rows.length;
          if(rowlength==0){
        	  $("#disposalGrid").jqxGrid('addrow', null, {});

          }
        });
    </script>
    <div id="disposalGrid"></div>
<input type="hidden" name="disposalrow" id="disposalrow">