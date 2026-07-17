<%@page import="com.limousine.limotarifmgmt.*" %>
<%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String gid=request.getParameter("gid")==null?"0":request.getParameter("gid");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
%>
<div id="commondiv"><jsp:include page="limoCommonGrid.jsp"></jsp:include></div>
<script type="text/javascript">
var datatransfer;
var id='<%=id%>';
$(document).ready(function () { 
	
	if(id=="1"){
		datatransfer='<%=tarifdao.getTarifTransfer(id,gid,docno)%>';  
	}
	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         }

         var num = 1; 
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'pickuploc' , type: 'string' },
                       	{name : 'dropoffloc' , type:'string'},
                       	{name : 'estdistance' , type:'number'},
                       	{name : 'esttime' , type:'date'},
                       	{name : 'tarif' , type:'number'},
                       	{name : 'exdistancerate' , type:'number'},
                       	{name : 'extimerate' , type:'number'},
                       	{name : 'pickuplocid' , type:'number'},
                       	{name : 'dropofflocid' , type:'number'}
     				   ],
					localdata:datatransfer,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
           
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
            
            $("#gridTarifTransfer").jqxGrid(
            {
               width: '100%',
               height: 250,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [

							{ text: ''+document.getElementById("mainpickuploc").value, datafield: 'pickuploc',editable:false,width:'20%'},
							{ text: ''+document.getElementById("maindropoffloc").value,  datafield: 'dropoffloc',editable:false,width:'20%'},
							{ text: ''+document.getElementById("mainestdistance").value,  datafield: 'estdistance',editable:true ,width:'12%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainesttime").value,  datafield: 'esttime',width:'12%',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: ''+document.getElementById("maintarif").value,  datafield: 'tarif',width:'12%',editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainexdistancerate").value,  datafield: 'exdistancerate',width:'12%',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainextimerate").value,  datafield: 'extimerate', editable:true,width:'12%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: 'Pick up location id', datafield: 'pickuplocid',hidden:true,width:'12%'},
							{ text: 'Dropoff location id', datafield: 'dropofflocid',hidden:true,width:'12%'}
         	              ]
           
            });
             
            if(document.getElementById("subpickuploc").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subpickuploc").value);	
            }
            if(document.getElementById("subdropoffloc").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subdropoffloc").value);	
            }
            if(document.getElementById("subestdistance").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subestdistance").value);	
            }
            if(document.getElementById("subesttime").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subesttime").value);	
            }
            if(document.getElementById("subtarif").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subtarif").value);	
            }
            if(document.getElementById("subexdistancerate").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subexdistancerate").value);	
            }
            if(document.getElementById("subextimerate").value!=""){
            	$('#gridTarifTransfer').jqxGrid('hidecolumn', ''+document.getElementById("subextimerate").value);	
            }
            
            
            $("#gridTarifTransfer").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		    
            		    if(dataField=="pickuploc" || dataField=="dropoffloc"){
            		    	document.getElementById("transferrowindex").value=rowBoundIndex;
            		    	$('#locationwindow').jqxWindow('open');
        					$('#locationwindow').jqxWindow('focus');
        					locationSearchContent('locationSearchGrid.jsp?datafield='+dataField, $('#locationwindow'));
            		    }
            		});                       
            		      
            
            
});

	
            </script>
            <div id="gridTarifTransfer"></div>
            <input type="hidden" name="transferrowindex" id="transferrowindex">