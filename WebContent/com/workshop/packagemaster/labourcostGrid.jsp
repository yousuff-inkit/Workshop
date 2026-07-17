<%@page import="com.workshop.packagemaster.*" %>
<%ClsWSPackageMasterDAO gatedao=new ClsWSPackageMasterDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var labourcostdata;
var id='<%=id%>';
if(id=="1"){
	labourcostdata='<%=gatedao.getLabourcostData(docno,id)%>';
}
$(document).ready(function () { 

	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'hrs', type: 'number'  },
				{name : 'jobdesc', type: 'string'},
				{name : 'jobid',type:'number'},
				{name : 'jobtype',type:'string'},
				{name : 'rate',type:'number'},
				{name : 'markuppercent',type:'number'},
				{name : 'total',type:'number'},
				{name : 'remarks',type:'string'},
				{name : 'seqno',type:'number'},
				{name : 'jobqty',type:'number'},
				{name : 'jobdiscount',type:'number'},
				{name : 'jobtotal',type:'number'},
				{name : 'jobvatpercent',type:'number'},
				{name : 'jobvatamount',type:'number'},
				{name : 'jobnetamount',type:'number'},
				{name : 'distservicediscount',type:'number'},
				{name : 'taxable',type:'number'}
          ],
          localdata: labourcostdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
        
                         
     };
    $("#labourcostGrid").on("bindingcomplete", function (event) {
    	 // your code here.
    	if($('#mode').val()=='A' || $('#mode').val()=='E'){
    		$("#labourcostGrid").jqxGrid('disabled',false);
    	}
     });
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
              alert(error);    
              }
        
       }		
     );

            
            
            $("#labourcostGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                disabled:true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
                showstatusbar:false,
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false,sortable:false,filterable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Job ID', datafield: 'jobid', width: '10%',hidden:true},
							{ text: 'Job Type', datafield: 'jobtype', width: '13%' },
							{ text: 'Job Desc',datafield:'jobdesc',width:'39%'},
							{ text: 'Qty', datafield: 'jobqty',hidden:true, width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Hrs', datafield: 'hrs', width: '5%' },
							{ text: 'Rate', datafield: 'rate', width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Markup %', hidden:true,datafield: 'markuppercent', width: '5%' ,hidden:true},
							{ text: 'Discount', datafield: 'jobdiscount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],hidden:true},
							{ text: 'Dist.Discount', datafield: 'distservicediscount', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],hidden:true},
							{ text: 'Taxable', datafield: 'taxable', width: '5%',hidden:true},
							
							{ text: 'Amount', datafield: 'total', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],hidden:true},
							
							{ text: 'Job Total', datafield: 'jobtotal', width: '5%'  ,hidden:true,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							
							{ text: 'VAT %', datafield: 'jobvatpercent', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'VAT Amount', datafield: 'jobvatamount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],hidden:true},
							{ text: 'Net Amount', datafield: 'jobnetamount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],hidden:true},
							
							{ text: 'Remarks', datafield: 'remarks',width:'34%'},
							{ text: 'Seq.No', datafield: 'seqno', width: '4%' }
							
			              ]
            });
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
            var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#labourcostGrid").on('contextmenu', function () {
            	return false;
            });
            
            $("#Menu").on('itemclick', function (event) {
         	   var args = event.args;
                var rowindex = $("#labourcostGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#labourcostGrid").offset();
                    $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#labourcostGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow").jqxWindow('show');
                }
                else {
                    var rowid = $("#labourcostGrid").jqxGrid('getrowid', rowindex);
                    $("#labourcostGrid").jqxGrid('deleterow', rowid);
                    
                }
            });
            
            $("#labourcostGrid").on('rowclick', function (event) {
                if (event.args.rightclick) {
     		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                    $("#labourcostGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                    return false;
                }
     		   }
            });
            
            
            $("#labourcostGrid").on("celldoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	//if(rawconfig.estJobtypeGridSearch.method=="1"){
            		if(dataField=="jobtype" || dataField=="jobdesc"){
	            		$('#labourindex').val(rowindex);
	            		$('#laboursearchwindow').jqxWindow('open');
	          			$('#laboursearchwindow').jqxWindow('focus');
	          			SearchContent('labourSearch.jsp?labourindex='+rowindex, 'laboursearchwindow');
	            	}	
            	//}
            	
            });
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#labourcostGrid").jqxGrid("addrow", null, {});	
            }
            
        });
        
        
    </script>
    
    <div id="labourcostGrid"></div>
	<input type="hidden" name="labourindex" id="labourindex">