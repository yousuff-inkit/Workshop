<%@page import="com.workshop.estimationadditionv4.*" %>
<%ClsEstimationAdditionV4DAO gatedao=new ClsEstimationAdditionV4DAO();
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
	var renderertotal=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		$('#approvedtotal').val(value.replace(/\,/g,""));
	     	$('#sparetotal').val(value.replace(/\,/g,""));
	   		var spare=parseFloat($('#sparetotal').val());
	   		var discount=parseFloat($('#sparediscount').val());
	   		var total=spare-discount;
	   		$('#netspare').val(total.toFixed(2));
	   		var summarySpareData = $("#sparePartsNewGrid").jqxGrid('getcolumnaggregateddata', 'spnetamount', ['sum']);
	     	var netestsparetotal=0.0;
	     	if(summarySpareData.sum!="undefined" && typeof(summarySpareData.sum)!="undefined"){
	     		netestsparetotal=parseFloat(summarySpareData.sum);
	     	}
	     	$('#netestsparetotal').val(netestsparetotal).trigger("change");
	     	
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
          ],
          localdata: sparepartsdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     $("#sparePartsNewGrid").on("bindingcomplete", function (event) {
    	 // your code here.
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
							{ text: 'Description', datafield: 'description', width: '48%',editable:true },		
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:true },
							{ text: 'psrno', datafield: 'psrno', width: '6%',editable:true,hidden:true },
							{ text: 'Rate', datafield: 'sprate', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},		
							{ text: 'Discount', datafield: 'spdiscount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
							{ text: 'Dist.Discount', datafield: 'distsparediscount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
							
							{ text: 'Total', datafield: 'approvedvalue', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
			              	{ text: 'Sp.Total', datafield: 'sptotal',hidden:true, width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderertotal},
			              	{ text: 'VAT %', datafield: 'spvatpercent', width: '6%',align:'right',cellsalign:'right',cellsformat:'d2'},
			              	{ text: 'VAT Amount', datafield: 'spvatamount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
			              	{ text: 'Net Amount', datafield: 'spnetamount', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
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
            
            
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#sparePartsNewGrid").jqxGrid("addrow", null, {});	
            }
            
            $("#sparePartsNewGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var datafield = event.args.datafield;
                var value = event.args.newvalue;
            	if(datafield=="qty" || datafield=="sprate" || datafield=="spdiscount" || datafield=="spvatpercent"){
            		var qty=parseInt($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'qty'));
            		var rate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'sprate'));
            		var discount=$('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'spdiscount');
            		discount=(discount=="" || discount==null || discount=="undefined" || typeof(discount)=="undefined"?0.0:parseFloat(discount));
            		var vatpercent=$('#sparePartsNewGrid').jqxGrid('getcellvalue',rowindex,'spvatpercent');
            		vatpercent=(vatpercent=="" || vatpercent==null || vatpercent=="undefined" || typeof(vatpercent)=="undefined"?0.0:parseFloat(vatpercent));
            		var amount=qty*rate;
            		amount=parseFloat(amount).toFixed(2);
            		var subtotal=parseFloat(amount)-parseFloat(discount);
            		subtotal=subtotal.toFixed(2);
            		var vatamount=parseFloat(subtotal)*(parseFloat(vatpercent)/100);
            		vatamount=vatamount.toFixed(2);
            		var netamount=parseFloat(subtotal)+parseFloat(vatamount);
            		netamount=netamount.toFixed(2);
            		
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'approvedvalue',subtotal);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'sptotal',subtotal);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'spvatamount',vatamount);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',rowindex,'spnetamount',netamount);
            		funSetDistSpareDiscount();
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
