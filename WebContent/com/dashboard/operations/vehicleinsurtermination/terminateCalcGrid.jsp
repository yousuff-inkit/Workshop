<%@page import="com.dashboard.operations.vehicleinsurancetermination.*" %>
<%
ClsVehicleInsuranceTerminationDAO termdao=new ClsVehicleInsuranceTerminationDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String expenseacno=request.getParameter("expenseacno")==null?"":request.getParameter("expenseacno");
/* String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String insurdocno=request.getParameter("insurdocno")==null?"":request.getParameter("insurdocno"); */
String reverseacno=request.getParameter("reverseacno")==null?"":request.getParameter("reverseacno");
String insurarray=request.getParameter("insurarray")==null?"":request.getParameter("insurarray");
%>
<script type="text/javascript">
var calcdata;
var id='<%=id%>';

if(id=="1"){
	calcdata='<%=termdao.getCalcData(insurarray,uptodate,expenseacno,reverseacno,id)%>';
	

}
else{
	calcdata=[];
}

$(document).ready(function () { 	

    //var url="demo.txt"; 
	var num = 0;
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'type' , type: 'String' },
						{name : 'acno', type: 'number'  },
						{name : 'acname',type:'string'},
						{name : 'debit',type:'number'},
						{name : 'credit',type:'number'},
						{name : 'baseamt',type:'number'},
						{name : 'desc1',type:'string'}
						
					
         ],
        localdata: calcdata,
        //url: url,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#terminateCalcGrid").on("bindingcomplete", function (event) {
    	// your code here.
    	$("#overlay, #PleaseWait").hide();
    	
    });     
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
            }		
    );
    $("#terminateCalcGrid").jqxGrid(
    {
        width: '99%',
        height: 200,
        source: dataAdapter,
        columnsresize: true,
        selectionmode: 'singlerow',
        //Add row method
                handlekeyboardnavigation: function (event) {
            var cell = $('#terminateCalcGrid').jqxGrid('getselectedcell');
            /* if (cell != undefined && cell.datafield == 'fleet_no' && cell.rowindex == num - 1) {
                var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                if (key == 13) {                                                        
                 var commit = $("#disposalGrid").jqxGrid('addrow', null, {});
                    num++;                           
                }
            } */
            
},
        columns: [
					{ text: 'Sr No',datafield: '',editable:false,columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
                           return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    } },
					{ text: 'Type', datafield: 'type',editable:false, width: '8%'},
					{ text: 'Account', datafield: 'acno',editable:false, width: '8%'},
					{ text: 'Account Name', datafield: 'acname', width: '25%'},
					{ text: 'Debit', datafield: 'debit', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Credit', datafield: 'credit', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Base Amount', datafield: 'baseamt', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Description',datafield:'desc1', width: '28%'}
					]
    });
            });
</script>
<div id="terminateCalcGrid"></div>