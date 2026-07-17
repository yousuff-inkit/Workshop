<%@page import="com.dashboard.workshop.jobcardcompletenewfancy.ClsJobCardCompleteNewFancyDAO"%>
<%@page import="com.dashboard.workshop.jobcardcompletenew.*" %>
<%ClsJobCardCompleteNewFancyDAO gatedao=new ClsJobCardCompleteNewFancyDAO();
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String savestatus=request.getParameter("savestatus")==null?"0":request.getParameter("savestatus");
%>
<script type="text/javascript">
var sparepartsdata;
var list;
var id='<%=id%>';
if(id=="1"){
	sparepartsdata='<%=gatedao.getSparepartsData(estdocno,id,savestatus)%>';
	var templist='<%=gatedao.getAddition(estdocno,id)%>';
	list=templist.split(",");
}
$(document).ready(function () { 
	var renderergenuine=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var renderermarket=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererused=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		var sparetotal=parseFloat(value.replace(/\,/g,""));
     		$('#sparetotal').val(sparetotal);
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
				{name : 'partno', type: 'string'  },
				{name : 'partname', type: 'string'  },
				{name : 'psrno', type: 'string'  },
				{name : 'description', type: 'string'   },
				{name : 'qty', type: 'number'   },
				{name : 'esttotal',type:'number'},
				{name : 'costtotal',type:'number'},
				{name : 'catprofitpercent', type: 'number'   },
				{name : 'invoiceamt',type:'number'},
				{name : 'customeramt',type:'number'},
				{name : 'addition',type:'string'}
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

            
            
            $("#sparePartsNewGrid").jqxGrid(
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
							{ text: 'Description', datafield: 'description', editable:false },	   	
							{ text: 'Part No', datafield: 'partno', width: '8%',editable:false  },
							{ text: 'PSR No', datafield: 'psrno', width: '8%',editable:false, hidden:true },
							{ text: 'Part Name', datafield: 'partname', width: '16%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2', hidden:true},		
							{ text: 'Qty',datafield: 'qty', width: '6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Est Total',datafield:'esttotal',width:'6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Cost Total', datafield: 'costtotal', width: '6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderergenuine, hidden:true},		
							{ text: 'Profit %', datafield: 'catprofitpercent', width: '6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2', hidden:true},
							{ text: 'To Be Invoiced',datafield:'invoiceamt',width:'8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererused, hidden:true},
							{ text: 'Charge to Customer', datafield: 'customeramt', width: '8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Est.Addition', datafield: 'addition',width:'8%',columntype:'dropdownlist',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								} },
							
			              ]
            });
           
        });
    </script>
<div id="sparePartsNewGrid"></div>
