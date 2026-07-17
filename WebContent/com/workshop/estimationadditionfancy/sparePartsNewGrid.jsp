<%@page import="com.workshop.estimationaddition.*" %>
<%ClsEstimationAdditionDAO gatedao=new ClsEstimationAdditionDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String addition=request.getParameter("addition")==null?"":request.getParameter("addition");
%>
<script type="text/javascript">
var sparepartsdata;
var id='<%=id%>';
if(id=="1"){
	sparepartsdata='<%=gatedao.getSparepartsData(docno,id,addition)%>';
}
$(document).ready(function () { 
	var renderergenuine=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || value=="NaN" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	var value1=$('#sparemarkup').val();
     	if(value1=="undefined" || value1=="NaN" || value1=="" || typeof(value1)=="undefined"){
     		$('#sparemarkup').val("0.00");
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 $('#genuinetotal').val(value.replace(/\,/g,""));
     	}
     	if($('#genuinetotal').val()!='' && $('#sparemarkup').val()!=''){
	     	var genuinetotal=parseFloat($('#genuinetotal').val());
	     	var sparemarkup=parseFloat($('#sparemarkup').val())/100;
	     	genuinetotal=genuinetotal+(genuinetotal*sparemarkup);
	     	$('#sparetotal').val(genuinetotal.toFixed(2));
	     	$('#genuinetotal').val(genuinetotal.toFixed(2));
	     	var sparetotal=parseFloat($('#sparetotal').val());
	     	var discount=parseFloat($('#sparediscount').val());
	     	var sparenettotal=sparetotal-discount;
	     	$('#sparenettotal').val(sparenettotal.toFixed(2));
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var renderermarket=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || value=="NaN" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 $('#markettotal').val(value.replace(/\,/g,""));
     	}
     	if($('#markettotal').val()!='' && $('#sparemarkup').val()!=''){
	     	var markettotal=parseFloat($('#markettotal').val());
	     	var sparemarkup=parseFloat($('#sparemarkup').val())/100;
	     	markettotal=markettotal+(markettotal*sparemarkup);
	     	var discount=parseFloat($('#sparediscount').val());
	     	var marketnettotal=markettotal-discount;
	     	$('#markettotal').val(marketnettotal.toFixed(2));
	     }
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererused=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || value=="NaN" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 $('#usedtotal').val(value.replace(/\,/g,""));
     	}
     	if($('#usedtotal').val()!='' && $('#sparemarkup').val()!=''){
	     	var usedtotal=parseFloat($('#usedtotal').val());
	     	var sparemarkup=parseFloat($('#sparemarkup').val())/100;
	     	usedtotal=usedtotal+(usedtotal*sparemarkup);
	     	var discount=parseFloat($('#sparediscount').val());
	     	var usednettotal=usedtotal-discount;
	     	$('#usedtotal').val(usednettotal.toFixed(2));
	     }
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererapproved=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || value=="NaN" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 $('#approvedtotal').val(value.replace(/\,/g,""));
     	}
     	if($('#approvedtotal').val()!='' && $('#sparemarkup').val()!=''){
	     	var approvedtotal=parseFloat($('#approvedtotal').val());
	     	var sparemarkup=parseFloat($('#sparemarkup').val())/100;
	     	approvedtotal=approvedtotal+(approvedtotal*sparemarkup);
	     	var discount=parseFloat($('#sparediscount').val());
	     	var approvednettotal=approvedtotal-discount;
	     	$('#approvedtotal').val(approvednettotal.toFixed(2));
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'qty', type: 'number'  },
				{name : 'description', type: 'string'   },
				{name : 'genuinerate', type: 'number'   },
				{name : 'marketrate',type:'number'},
				{name : 'usedrate',type:'number'},
				{name : 'genuinetotal', type: 'number'   },
				{name : 'markettotal',type:'number'},
				{name : 'usedtotal',type:'number'},
				{name : 'approval',type:'string'},
				{name : 'approvedvalue',type:'number'},
				{name : 'chkexcess',type:'boolean'},
          ],
          localdata: sparepartsdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
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
                sortable: true,
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
                            $("#sparePartsNewGrid").jqxGrid('addrow', null, {});
                            return true;                         
                        }
                    }
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text: 'Excess', datafield: 'chkexcess', width: '4%',editable:true,columntype:'checkbox' },
							{ text: 'Description', datafield: 'description', width: '22%',editable:true },		
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:true },
							{ text: 'Genuine',columngroup: 'Rate', datafield: 'genuinerate', width: '8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},		
							{ text: 'Market',columngroup: 'Rate', datafield: 'marketrate', width: '8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Used',columngroup: 'Rate',datafield:'usedrate',width:'8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Genuine',columngroup: 'Total', datafield: 'genuinetotal', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderergenuine},		
							{ text: 'Market',columngroup: 'Total', datafield: 'markettotal', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderermarket},
							{ text: 'Used',columngroup: 'Total',datafield:'usedtotal',width:'8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererused},
							{ text: 'Type',columntype: 'dropdownlist',columngroup: 'Approval', datafield: 'approval', width: '8%',editable:true,
								initeditor: function (row, cellvalue, editor) {
			                          editor.jqxDropDownList({ source: dropdownListSource});
			                      }},
							{ text: 'Value',columngroup: 'Approval', datafield: 'approvedvalue', width: '8%' ,cellsformat:'d2',editable:false,cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererapproved},
							
			              ],
			              columngroups: 
			            	    [
			            	        { text: 'Rate', align: 'center', name: 'Rate' },
			            	        { text: 'Total',  align: 'center', name: 'Total' },
			            	        { text: 'Approval', align: 'center', name: 'Approval' }
			            	    ]
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
            
            
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#sparePartsNewGrid").jqxGrid("addrow", null, {});	
            }
            
            $("#sparePartsNewGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var datafield = event.args.datafield;
                var value = event.args.newvalue;
            	if(datafield=="qty" || datafield=="genuinerate" || datafield=="marketrate" || datafield=="usedrate"){
            		$('#sparePartsAmountGrid').jqxGrid('clear');
            		var qty=parseInt($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'qty'));
            		if($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'genuinerate')!=""){
            			var genuinerate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'genuinerate'));
            			
            			$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'genuinetotal',(genuinerate*qty));
            		}
            		
            		var marketrate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'marketrate'));
            		var usedrate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'usedrate'));
            		
            		
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'markettotal',(marketrate*qty));
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'usedtotal',(usedrate*qty));
            	}
            	if($('#mode').val()=='E' && datafield=="approval"){
            		if(value=="Genuine"){
            			$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'approvedvalue',$('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'genuinetotal'));
            		}
            		else if(value=="Market"){
            			$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'approvedvalue',$('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'markettotal'));
            		}
            		else if(value=="Used"){
            			$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'approvedvalue',$('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'usedtotal'));
            		}
            	}
            });
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
