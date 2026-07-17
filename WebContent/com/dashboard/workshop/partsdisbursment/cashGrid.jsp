<%@page import="com.dashboard.workshop.partsdisbursment.*" %>
<%ClsWSPartsDisbursmentDAO partsdao=new ClsWSPartsDisbursmentDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
%>
<style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
</style>
<script type="text/javascript">
var id='<%=id%>';
var cashdata=[];
if(id=="1"){  
	cashdata='<%=partsdao.getCashData(id,jobdocno)%>';
}else{
	cashdata=[];
}  
	$(document).ready(function(){
        var rendererstring=function (aggregates){
	     	var value=aggregates['sum'];
	     	if(value=="undefined" || value=="" || value==null || typeof(value)=="undefined"){
	     		value=0.0;
	     	}
	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'psrno' , type: 'number'},
 						{name : 'productname', type: 'string'},
 						{name : 'qty', type: 'number'},
 						{name : 'costprice', type:'number'},
 						{name : 'total',type:'number'},
 						{name : 'rowno',type:'number'},
 						{name : 'contrastatus',type:'number'}
						
                      	
             ],
             localdata: cashdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        var cellclassname = function (row, column, value, data) {
        	if(data.contrastatus==1){
            	return "greenClass";
            }
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#cashGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'checkbox',
                  	editable:true,
                    altrows:true,
                     columnsresize: true,
                    showaggregates:true,
                    showstatusbar:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '10%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Row No',datafield: 'rowno', width: '10%',hidden:true,cellclassname: cellclassname,editable:false},
    					{ text: 'Part Name',datafield: 'productname', width: '57%',cellclassname: cellclassname,editable:false},
    					{ text: 'Contra Status',datafield: 'contrastatus', width: '57%',hidden:true,cellclassname: cellclassname,editable:false},
    					{ text: 'Qty',datafield: 'qty', width: '10%',cellclassname: cellclassname,editable:false},
    					{ text: 'Cost Price',datafield: 'costprice', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,editable:false},
    					{ text: 'Total',datafield: 'total', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,editable:true}
    	              ]
                });
			$('#cashGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    var contrastatus=$('#cashGrid').jqxGrid('getcellvalue',rowBoundIndex, "contrastatus");
    		    if(contrastatus==1){
    		    	$('#cashGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		    var rowsCount = $('#cashGrid').jqxGrid('getrows').length;
    		    if (event.args.rowindex.length === rowsCount) {
    		    	for(var i=0;i<rowsCount;i++){
    		    		var contrastatus=parseInt($('#cashGrid').jqxGrid('getcellvalue',i,'contrastatus'));
    		    		if(contrastatus>0){
    				    	$('#cashGrid').jqxGrid('clearselection');
    				    }
    		    	}
    		    }
    		});
	});
</script>
<div id="cashGrid"></div>