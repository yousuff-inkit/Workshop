<%@page import="com.workshop.wsestimationpal.*" %>
<%ClsWSEstimationPalDAO gatedao=new ClsWSEstimationPalDAO();
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
     	
     	if(value!="" && value!=null && value!="undefined"){
     		$('#servicestotal').val(value.replace(/\,/g,""));
     		var services=parseFloat($('#servicestotal').val());
     		var discount=parseFloat($('#servicesdiscount').val());
     		var total=services-discount;
     		$('#netservices').val(total);
     		var sparedesc=$("#sparePartsNewGrid").jqxGrid("getcellvalue",0,"description");
     		if(rawconfig.serviceConsumables.method=="1" && sparedesc=="Consumables"){
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
				{name : 'seqno',type:'number'}
          ],
          localdata: labourcostdata,
         
         
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
							{ text: 'Job Desc',datafield:'jobdesc',width:'23%'},
							
							{ text: 'Hrs', datafield: 'hrs', width: '8%' },
							{ text: 'Rate', datafield: 'rate', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Markup %', datafield: 'markuppercent', width: '8%' },
							{ text: 'Total', datafield: 'total', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Remarks', datafield: 'remarks' },
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
            	if(dataField=="hrs" || dataField=="rate"){
            		$('#sparePartsAmountGrid').jqxGrid('clear');
            		var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',rowindex,'hrs'));
            		$('#labourcostGrid').jqxGrid('setcellvalue',rowindex,'total',(rate*hrs));
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