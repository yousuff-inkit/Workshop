<%@page import="com.workshop.wsjobcard_fancy.*" %>
<%ClsWSJobCardDAO gatedao=new ClsWSJobCardDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var sparepartsdata;
var id='<%=id%>';
if(id=="1"){
	sparepartsdata='<%=gatedao.getSparepartsData(docno,id)%>';
}
$(document).ready(function () { 
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value!="" && value!=null && value!="undefined"){
     		$('#sparepartstotal').val(value.replace(/\,/g,""));
     		var parts=parseFloat($('#sparepartstotal').val());
   		  var labour=parseFloat($('#labourtotal').val());
   		  var discount=parseFloat($('#discount').val());
   		  var total=(parts+labour)-discount;
   		  $('#esttotal').val(total);
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'qty', type: 'number'  },
				{name : 'description', type: 'string'   },
				{name : 'partdocno', type: 'string'   },
				{name : 'rate',type:'number'},
				{name : 'markuppercent',type:'number'},
				{name : 'total',type:'number'},
				{name : 'remarks',type:'string'},
				{name : 'brand',type:'string'},
				{name : 'brdid',type:'number'},
				{name : 'stock',type:'number'}
          ],
          localdata: sparepartsdata,
         
         
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

            
            
            $("#sparepartsGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                disabled:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
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
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Description', datafield: 'description', width: '40%',editable:false },		
							{ text: 'Part Doc No', datafield: 'partdocno', width: '26%',editable:false,hidden:true },		
							{ text: 'Brand', datafield: 'brand', width: '12%',editable:false,hidden:true },
							{ text: 'Brand Id',datafield:'brdid',width:'10%',hidden:true},
							{ text: 'Qty', datafield: 'qty', width: '5%',editable:true },
							{ text: 'Stock', datafield: 'stock', width: '6%',editable:false ,hidden:true},
							{ text: 'Rate', datafield: 'rate', width: '6%' ,cellsformat:'d2',editable:false,cellsalign:'right',align:'right',hidden:true},
							{ text: 'Markup %', datafield: 'markuppercent', width: '6%',editable:true,hidden:true },
							{ text: 'Total', datafield: 'total', width: '6%' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'Remarks', datafield: 'remarks', width: '50%',editable:true }
			              ]
            });
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
            var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#sparepartsGrid").on('contextmenu', function () {
            	return false;
            });
            
            $("#Menu").on('itemclick', function (event) {
         	   var args = event.args;
                var rowindex = $("#sparepartsGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#sparepartsGrid").offset();
                    $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#sparepartsGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow").jqxWindow('show');
                }
                else {
                    var rowid = $("#sparepartsGrid").jqxGrid('getrowid', rowindex);
                    $("#sparepartsGrid").jqxGrid('deleterow', rowid);
                }
            });
            
            $("#sparepartsGrid").on('rowclick', function (event) {
                if (event.args.rightclick) {
     		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                    $("#sparepartsGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                    return false;
                }
     		   }
            });
            
            $("#sparepartsGrid").on("celldoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="description"){
            		$('#partsindex').val(rowindex);
          	  	  	$('#partssearchwindow').jqxWindow('open');
          			$('#partssearchwindow').jqxWindow('focus');
          			SearchContent('prodectnamesearch.jsp?partindex='+rowindex, 'partssearchwindow');
            	}  
            });
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#sparepartsGrid").jqxGrid("addrow", null, {});	
            }
            
            $("#sparepartsGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="qty"){
            		var rate=parseFloat($('#sparepartsGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var qty=parseInt($('#sparepartsGrid').jqxGrid('getcellvalue',rowindex,'qty'));
            		$('#sparepartsGrid').jqxGrid('setcellvalue',rowindex,'total',(rate*qty));
            	}
            	if(dataField=="markuppercent"){
            		var rate=parseFloat($('#sparepartsGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var qty=parseInt($('#sparepartsGrid').jqxGrid('getcellvalue',rowindex,'qty'));
            		var total=rate*qty;
            		var markup=(parseFloat($('#sparepartsGrid').jqxGrid('getcellvalue',rowindex,'markuppercent')))/100;
            		$('#sparepartsGrid').jqxGrid('setcellvalue',rowindex,'total',total+(total*markup));
            	}
            });
        });
    </script>
    <div id='jqxWidget'>
    	<div id="sparepartsGrid"></div>
    	<div id="popupWindow">
 			<div id='Menu'>
        		<ul>
            		<li>Delete Selected Row</li>
        		</ul>
       		</div>
       	</div>
   </div>
   <input type="hidden" name="partsindex" id="partsindex">
