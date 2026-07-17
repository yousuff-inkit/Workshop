<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.saleofvehicle.vehicledisposal.ClsVehicleDisposalDAO"%>
<%@page import="com.operations.saleofvehicle.*" %>
<%String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
ClsVehicleDisposalDAO disposaldao=new ClsVehicleDisposalDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">

var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';
var jvdata;
if(temp=="1"){
 	jvdata='<%=disposaldao.getJvData(trno,id)%>';
}
else if(temp=="2"){
	jvdata='<%=disposaldao.getTempJvData(trno,id)%>';  
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
                          	{name : 'type' , type: 'String' },
     						{name : 'acno', type: 'number'  },
     						{name : 'acname',type:'string'},
     						{name : 'debit',type:'number'},
     						{name : 'credit',type:'number'},
     						{name : 'baseamt',type:'number'},
     						{name : 'desc1',type:'string'}
     						
     					
                 ],
                localdata: jvdata,
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
            $("#jvGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                        handlekeyboardnavigation: function (event) {
                    var cell = $('#jvGrid').jqxGrid('getselectedcell');
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
    <div id="jvGrid"></div>
