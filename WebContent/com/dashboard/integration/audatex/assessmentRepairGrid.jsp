<%@page import="com.dashboard.integration.audatex.*" %>
<%ClsAudattexDAO gatedao=new ClsAudattexDAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var assessmentrepairdata=[];
var id='<%=id%>';
if(id=="1"){
	assessmentrepairdata='<%=gatedao.getAssessmentRepairData(gatedocno,id)%>';
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
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'hrs', type: 'number'  },
				{name : 'workunit', type: 'number'  },
				{name : 'jobdesc', type: 'string'},
				{name : 'jobid',type:'string'},
				{name : 'code',type:'number'},
				{name : 'jobtype',type:'string'},
				{name : 'rate',type:'number'},
				{name : 'markuppercent',type:'number'},
				{name : 'total',type:'number'},
				{name : 'remarks',type:'string'},
				{name : 'chkexcess',type:'boolean'},
          ],
          localdata: assessmentrepairdata,
         
         
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

            
            
            $("#assessmentRepairGrid").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                //disabled:true,
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
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Excess', datafield: 'chkexcess', width: '4%',columntype:'checkbox' },
							{ text: 'Job Type', datafield: 'jobtype', width: '7%' },
							{ text: 'Job Desc',datafield:'jobdesc',width:'23%'},
							{ text: 'Job ID', datafield: 'jobid', width: '10%' ,hidden:true},
							{ text: 'WU', datafield: 'workunit', width: '4%' },
							{ text: 'Hrs', datafield: 'hrs', width: '4%' },
							{ text: 'Rate', datafield: 'rate', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Markup %', datafield: 'markuppercent', width: '8%',cellsalign:'right',align:'right' },
							{ text: 'Total', datafield: 'total', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Remarks', datafield: 'remarks', width: '29%' }
			              ]
            });
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
            var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#assessmentRepairGrid").on('contextmenu', function () {
            	return false;
            });
            
            $("#Menu").on('itemclick', function (event) {
         	   var args = event.args;
                var rowindex = $("#assessmentRepairGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#assessmentRepairGrid").offset();
                    $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#assessmentRepairGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow").jqxWindow('show');
                }
                else {
                    var rowid = $("#assessmentRepairGrid").jqxGrid('getrowid', rowindex);
                    $("#assessmentRepairGrid").jqxGrid('deleterow', rowid);
                }
            });
            
            $("#assessmentRepairGrid").on('rowclick', function (event) {
                if (event.args.rightclick) {
     		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                    $("#assessmentRepairGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                    return false;
                }
     		   }
            });
            
            
            $("#assessmentRepairGrid").on("celldoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="jobtype" || dataField=="jobdesc"){
            		$('#labourindex').val(rowindex);
            		$('#laboursearchwindow').jqxWindow('open');
          			$('#laboursearchwindow').jqxWindow('focus');
          			SearchContent('labourSearch.jsp?labourindex='+rowindex, 'laboursearchwindow');
            	}  
            });
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#assessmentRepairGrid").jqxGrid("addrow", null, {});	
            }
            
            $("#assessmentRepairGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="workunit" || dataField=="rate"){
            		//$('#sparePartsAmountGrid').jqxGrid('clear');
            		var rate=parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var workunit=parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'workunit'));
            		$('#assessmentRepairGrid').jqxGrid('setcellvalue',rowindex,'total',(rate*workunit));
            		var total=rate*workunit;
            		var markup=(parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'markuppercent')))/100;
            		$('#assessmentRepairGrid').jqxGrid('setcellvalue',rowindex,'total',total+(total*markup));
            	}
            	if(dataField=="markuppercent"){
            		//$('#sparePartsAmountGrid').jqxGrid('clear');
            		var rate=parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var workunit=parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'workunit'));
            		var total=rate*workunit;
            		var markup=(parseFloat($('#assessmentRepairGrid').jqxGrid('getcellvalue',rowindex,'markuppercent')))/100;
            		$('#assessmentRepairGrid').jqxGrid('setcellvalue',rowindex,'total',total+(total*markup));
            	}
            });
            var gridrows=$('#assessmentRepairGrid').jqxGrid('getrows');
            for(var i=0;i<gridrows.length;i++){
            	var workunit=$('#assessmentRepairGrid').jqxGrid('getcellvalue',i,'workunit');
            	var amount=$('#assessmentRepairGrid').jqxGrid('getcellvalue',i,'rate');
            	$('#assessmentRepairGrid').jqxGrid('setcellvalue',i,'total',workunit*amount);
            }
        });
    </script>
      <div id='jqxWidget'>
     <div id="assessmentRepairGrid"></div>
    <div id="popupWindow">
 <input type="hidden" name="invoicerow" id="invoicerow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
   