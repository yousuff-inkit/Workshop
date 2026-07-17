<%@page import="com.operations.marketing.servicemetrics.*" %>
<%ClsServiceMetricsDAO srvdao=new ClsServiceMetricsDAO(); %>
<%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var docno='<%=docno%>';
var id='<%=id%>';
var srvcdata;
if(docno!="" && id!=""){
	srvcdata='<%=srvdao.getSrvcMetricsGridData(docno,id)%>';
}
		
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'srvckm', type: 'number' }, 
     						{name : 'srvccost', type: 'number'},
     						{name : 'replacecost',type:'number'},
     						{name : 'tyrecost',type:'number'},
                        	],
                         localdata: srvcdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#serviceMetricsGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	/* var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }  */
                },
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
								groupable: false, draggable: false, resizable: false,datafield: '',
								columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
								cellsrenderer: function (row, column, value) {
									return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}
							},
							{ text: 'Service Interval(Km)', datafield: 'srvckm',  width: '24%',cellsformat:'d2'},	
							{ text: 'Service Cost', datafield: 'srvccost', width: '24%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Replacement Cost', datafield: 'replacecost', width: '24%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Tyre Cost', datafield: 'tyrecost', width: '24%',align:'right',cellsalign:'right',cellsformat:'d2'}
						]
            });
           
            var rows=$('#serviceMetricsGrid').jqxGrid('getrows');
            if(rows.length==0){
            	$("#serviceMetricsGrid").jqxGrid('addrow', null, {});	
            }
            $("#serviceMetricsGrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
            			if(datafield=="tyrecost")
            		   	{
            				$("#serviceMetricsGrid").jqxGrid('addrow', null, {});
            		   	}
                    });
        });
		 
    </script>
    <div id="serviceMetricsGrid"></div>
    
