<%@page import="com.dashboard.workshop.gipmatrequest.*" %>
<%ClsGIPMatRequestDAO reqdao=new ClsGIPMatRequestDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");%>

<script type="text/javascript">
var id='<%=id%>';  
var reqdata=[];
if(id=="1"){
	reqdata='<%=reqdao.getMaterialData(id,gatedocno)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
            			{name : 'gatedocno',type:'number'},
            			{name : 'docno',type:'number'},
                      	{name : 'reqdesc' , type: 'string'},
 						{name : 'qty', type: 'number'},
 						{name : 'price', type:'number'},
 						{name : 'btndelete',type:'string'}
                      	
             ],
             localdata: reqdata,
             deleterow: function (rowid, commit) {
                 // synchronize with the server - send delete command
                 // call commit with parameter true if the synchronization with the server is successful 
                 // and with parameter false if the synchronization failed.
                 commit(true);
             },
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#materialGrid").on("bindingcomplete", function (event) {
        	$('#materialGrid').jqxGrid('addrow', null, {});
        	$('.page-loader').hide();
        });                       
        	 
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );
		
        


        $("#materialGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlecell',
                  	editable:true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Gate Doc No',datafield: 'gatedocno', width: '10%',hidden:true},
    					{ text: 'Doc No',datafield: 'docno', width: '10%',hidden:true},
    					{ text: 'Description',datafield: 'reqdesc', width: '71%'},
    					{ text: 'Qty',datafield: 'qty', width: '10%',cellsformat:'d0'},
    					{ text: 'Price',datafield: 'price', width: '10%',cellsalign:'right',align:'right',cellsformat:'d2'},
    					{ text: 'Action',datafield: 'btndelete', width: '5%',columntype:'button',cellsrenderer: function (row, column, value) {
						    return "Delete";
						}   },      
    					
    	              ]
                });

        	$("#materialGrid").on('cellendedit', function (event) 
        		{
        		    // event arguments.
        		    var args = event.args;
        		    // column data field.
        		    var dataField = event.args.datafield;
        		    // row's bound index.
        		    var rowBoundIndex = event.args.rowindex;
        		    // cell value
        		    var value = args.value;
        		    // cell old value.
        		    var oldvalue = args.oldvalue;
        		    // row's data.
        		    var rowData = args.row;
        		   	if(dataField=="reqdesc"){
        		   		var rows=$('#materialGrid').jqxGrid('getrows');
            		    if(rows.length-1==rowBoundIndex){
            		    	$('#materialGrid').jqxGrid('addrow', null, {});
            		    }
        		   	}
        		    
        		});
        	
        	
        	$("#materialGrid").on("cellclick", function (event) 
        			{
        			    // event arguments.
        			    var args = event.args;
        			    // row's bound index.
        			    var rowBoundIndex = args.rowindex;
        			    // row's visible index.
        			    var rowVisibleIndex = args.visibleindex;
        			    // right click.
        			    var rightclick = args.rightclick; 
        			    // original event.
        			    var ev = args.originalEvent;
        			    // column index.
        			    var columnindex = args.columnindex;
        			    // column data field.
        			    var dataField = args.datafield;
        			    // cell value
        			    var value = args.value;
        			    
        			    if(dataField=="btndelete"){
        			    	var rowid = $("#materialGrid").jqxGrid('getrowid', rowBoundIndex);
                            $("#materialGrid").jqxGrid('deleterow', rowid);
        			    }
        			});    
	});
</script>
<div id="materialGrid"></div>