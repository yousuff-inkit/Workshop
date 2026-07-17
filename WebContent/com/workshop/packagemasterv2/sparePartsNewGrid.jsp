<%@page import="com.workshop.packagemasterv2.*" %>
<%
ClsWSPackageMasterV2DAO gatedao=new ClsWSPackageMasterV2DAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var sparepartsdata=[];
var id='<%=id%>';
if(id=="1"){
	sparepartsdata='<%=gatedao.getSparepartsData(docno,id)%>';
}
$(document).ready(function () { 
	var renderertotal=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'qty', type: 'number'  },
				{name : 'description', type: 'string'   },
				{name : 'sprate', type: 'number'   },
				{name : 'approvedvalue',type:'number'},
				{name : 'spdiscount',type:'number'},
				{name : 'sptotal',type:'number'},
				{name : 'spvatpercent',type:'number'},
				{name : 'spvatamount',type:'number'},
				{name : 'spnetamount',type:'number'},
				{name : 'psrno',type:'number'},
				{name : 'distsparediscount',type:'number'},
				{name : 'seqno',type:'number'},
				
          ],
          localdata: sparepartsdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     $("#sparePartsNewGrid").on("bindingcomplete", function (event) {
    	 // your code here.
    	if($('#mode').val()=='A'){
    		$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"description","Consumables");
    	}
    	if($('#mode').val()=='A' || $('#mode').val()=='E'){
    		$("#sparePartsNewGrid").jqxGrid('disabled',false);
    	}
     });              
     var dropdownListSource=['Genuine','Market','Used'];
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
              alert(error);    
              }
        
       }		
     );

            
            
            $("#sparePartsNewGrid").jqxGrid(
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
                showstatusbar:true,
                //Add row method
               handlekeyboardnavigation: function (event) {
                    var cell = $('#sparePartsNewGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'approvedvalue') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            //$("#sparePartsNewGrid").jqxGrid('addrow', null, {});
                            return true;                         
                        }
                    }
                    
                }, 
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Description', datafield: 'description', width: '86%',editable:true },		
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:true },
							{ text: 'psrno', datafield: 'psrno', width: '6%',editable:true,hidden:true},
							{ text: 'Rate', datafield: 'sprate', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},		
							{ text: 'Discount', datafield: 'spdiscount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
							{ text: 'Dist.Discount', datafield: 'distsparediscount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
							
							{ text: 'Total', datafield: 'approvedvalue', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
			              	{ text: 'Sp.Total', datafield: 'sptotal',hidden:true, width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderertotal},
			              	{ text: 'VAT %', datafield: 'spvatpercent', width: '6%',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
			              	{ text: 'VAT Amount', datafield: 'spvatamount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
			              	{ text: 'Net Amount', datafield: 'spnetamount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],hidden:true},
			              	{ text: 'Seq.No', datafield: 'seqno', width: '4%',editable:true }
			              ],
			              
            });
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
            var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#sparePartsNewGrid").on('contextmenu', function () {
            	return false;
            });
            
            $("#Menu").on('itemclick', function (event) {
         	   var args = event.args;
                var rowindex = $("#sparePartsNewGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#sparePartsNewGrid").offset();
                    $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#sparePartsNewGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow").jqxWindow('show');
                }
                else {
                    var rowid = $("#sparePartsNewGrid").jqxGrid('getrowid', rowindex);
                    $("#sparePartsNewGrid").jqxGrid('deleterow', rowid);
                }
            });
            
            $("#sparePartsNewGrid").on('rowclick', function (event) {
                if (event.args.rightclick) {
     		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                    $("#sparePartsNewGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                    return false;
                }
     		   }
            });
            $("#sparePartsNewGrid").on('celldoubleclick', function (event) {
     		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                    var rowindex=event.args.rowindex;
                	var dataField = event.args.datafield;
            		if(dataField=="description"){
            			$('#partsindex').val(rowindex);
          	  	  		$('#partssearchwindow').jqxWindow('open');
          				$('#partssearchwindow').jqxWindow('focus');
          				SearchContent('prodectnamesearch.jsp?partindex='+rowindex, 'partssearchwindow');
            		} 
                }
            });
            
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#sparePartsNewGrid").jqxGrid("addrow", null, {});	
            }
            
            if($('#mode').val()=='A'){
            	$('#sparePartsNewGrid,#labourcostGrid').jqxGrid('clear');
        		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
        		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
        		$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"description","Consumables");
        	}
        });
    </script>
    <div id='jqxWidget'>
    	<div id="sparePartsNewGrid"></div>
    	<div id="popupWindow">
 			<div id='Menu'>
        		<ul>
            		<li>Delete Selected Row</li>
        		</ul>
       		</div>
       	</div>
   </div>
   <input type="hidden" name="partsindex" id="partsindex">
