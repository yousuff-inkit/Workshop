<%@page import="com.workshop.estimationadditionv5.*" %>
<%ClsEstimationAdditionV5DAO gatedao=new ClsEstimationAdditionV5DAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String addition=request.getParameter("addition")==null?"":request.getParameter("addition");
%>
<script type="text/javascript">
var labourcostdata;
var id='<%=id%>';
if(id=="1"){
	labourcostdata='<%=gatedao.getLabourcostData(docno,id,addition)%>';
}
$(document).ready(function () { 
	
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value!="" && value!=null && value!="undefined"){
     		$('#servicestotal').val(value.replace(/\,/g,""));
     		var services=parseFloat($('#servicestotal').val());
     		var discount=parseFloat($('#servicesdiscount').val());
     		var total=services-discount;
     		$('#netservices').val(total);
     		var summaryServiceData = $("#labourcostGrid").jqxGrid('getcolumnaggregateddata', 'jobnetamount', ['sum']);
	     	var netestservicetotal=0.0;
	     	if(summaryServiceData.sum!="undefined" && typeof(summaryServiceData.sum)!="undefined"){
	     		netestservicetotal=parseFloat(summaryServiceData.sum);
	     	}
	     	$('#netestservicetotal').val(netestservicetotal).trigger("change");
	     	
     		var sparedesc=$("#sparePartsNewGrid").jqxGrid("getcellvalue",0,"description");
     		if(rawconfig.serviceConsumables.method=="1"  && sparedesc=="Consumables"){
				var percent=rawconfig.serviceConsumables.value;
				var consumablevalue=parseFloat(total*(parseFloat(percent)/100));
				$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"qty",1);
				$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"sprate",consumablevalue.toFixed(2));
				$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"approvedvalue",consumablevalue.toFixed(2));
			}
     	}
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
                showstatusbar:true,
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
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Job ID', datafield: 'jobid', width: '10%' ,hidden:true},
							{ text: 'Job Type', datafield: 'jobtype', width: '7%' },
							{ text: 'Job Desc',datafield:'jobdesc'},
							{ text: 'Qty', datafield: 'jobqty',hidden:true, width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Hrs', datafield: 'hrs', width: '5%' },
							{ text: 'Rate', datafield: 'rate', width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Markup %', hidden:true,datafield: 'markuppercent', width: '5%' },
							{ text: 'Discount', datafield: 'jobdiscount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum']},
							{ text: 'Dist.Discount', datafield: 'distservicediscount', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum']},
							{ text: 'Taxable', datafield: 'taxable', width: '5%',hidden:true},
							
							{ text: 'Amount', datafield: 'total', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum']},
							
							{ text: 'Job Total', datafield: 'jobtotal', width: '5%'  ,hidden:true,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'VAT %', datafield: 'jobvatpercent', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'VAT Amount', datafield: 'jobvatamount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum']},
							{ text: 'Net Amount', datafield: 'jobnetamount', width: '5%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum']},
							
							{ text: 'Remarks', datafield: 'remarks',hidden:true },
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
                if(rawconfig.estJobtypeGridSearch.method=="1"){
                	if(dataField=="jobtype" || dataField=="jobdesc"){
	            		$('#labourindex').val(rowindex);
	            		$('#laboursearchwindow').jqxWindow('open');
	          			$('#laboursearchwindow').jqxWindow('focus');
	          			SearchContent('labourSearch.jsp?labourindex='+rowindex, 'laboursearchwindow');
	            	}	
                }
            });
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#labourcostGrid").jqxGrid("addrow", null, {});	
            }
            
            $("#labourcostGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="jobdiscount" || dataField=="jobvatpercent" || dataField=="hrs" || dataField=="rate" || dataField=="jobqty"){
            		$('#sparePartsAmountGrid').jqxGrid('clear');
            		var jobqty=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'jobqty'));
            		var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'hrs'));
            		var amount=(rate*hrs);
            		amount=amount.toFixed(2);
            		
            		var jobdiscount=$('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'jobdiscount');
            		jobdiscount=(jobdiscount=="" || jobdiscount==null || jobdiscount=="undefined" || typeof(jobdiscount)=="undefined"?0.0:parseFloat(jobdiscount));
            		var jobvatpercent=$('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'jobvatpercent');
            		jobvatpercent=(jobvatpercent=="" || jobvatpercent==null || jobvatpercent=="undefined" || typeof(jobvatpercent)=="undefined"?0.0:parseFloat(jobvatpercent));
            		var subtotal=parseFloat(amount)-parseFloat(jobdiscount);
            		subtotal=subtotal.toFixed(2);
            		var vatamount=parseFloat(subtotal)*(parseFloat(jobvatpercent)/100);
            		vatamount=vatamount.toFixed(2);
            		var netamount=parseFloat(subtotal)+parseFloat(vatamount);
            		netamount=netamount.toFixed(2);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'total',subtotal);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'jobtotal',subtotal);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'jobdiscount',jobdiscount);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'jobvatpercent',jobvatpercent);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'jobvatamount',vatamount);
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'jobnetamount',netamount);
            		funSetDistJobDiscount();
            	}
            	if(dataField=="markuppercent"){
            		$('#sparePartsAmountGrid').jqxGrid('clear');
            		var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'hrs'));
            		var total=rate*hrs;
            		var markup=(parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'markuppercent')))/100;
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'total',total+(total*markup));
            	}
            });
        });
    </script>
   <div id="labourcostGrid"></div>

	<input type="hidden" name="labourindex" id="labourindex">