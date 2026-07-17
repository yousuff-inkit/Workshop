<%@page import="com.dashboard.workshop.jobcardcompletenew.*" %>
<%ClsJobCardCompleteNewDAO gatedao=new ClsJobCardCompleteNewDAO();
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String savestatus=request.getParameter("savestatus")==null?"0":request.getParameter("savestatus");
%>
<script type="text/javascript">
var extradata;
var id='<%=id%>';
var savestatus='<%=savestatus%>';
if(id=="1" && savestatus=="1"){
	extradata='<%=gatedao.getExtraData(estdocno,id,savestatus)%>';
}
$(document).ready(function () { 
	
	
	var rendererextra=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined" || value==null || value==""){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 //$('#genuinetotal').val(value.replace(/\,/g,""));
     		var extratotal=parseFloat(value.replace(/\,/g,""));
     		$('#extratotal').val(extratotal);
     	}
     	var extratotal=parseFloat($('#extratotal').val());
     	var labourtotal=parseFloat($('#labourtotal').val());
 		var sparetotal=parseFloat($('#sparetotal').val());
 		var nettotal=extratotal+labourtotal+sparetotal;
 		$('#nettotal').val(nettotal);
 		funRoundAmt($('#nettotal').val(),'nettotal');
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'description', type: 'string'},
				{name : 'amount',type:'number'}
          ],
          localdata: extradata,
         
         
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

            
            
            $("#extraDetailGrid").jqxGrid(
            {
                width: '100%',
                height: 180,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
                showstatusbar:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /*  var cell = $('#extraDetailGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#extraDetailGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }  */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
							{ text: 'Description', datafield: 'description', width: '85%' },
							{ text: 'Amount', datafield: 'amount', width: '10%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererextra}
			              ]
            });
            $("#extraDetailGrid").jqxGrid('addrow', null, {});
            $("#extraDetailGrid").on('cellvaluechanged', function (event) 
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // column data field.
            		    var datafield = event.args.datafield;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // new cell value.
            		    var value = event.args.newvalue;
            		    // old cell value.
            		    var oldvalue = event.args.oldvalue;
            		    if(datafield=="amount"){
            		    	$("#extraDetailGrid").jqxGrid('addrow', null, {});
            		    }
            		});
        });
    </script>
    <div id="extraDetailGrid"></div>