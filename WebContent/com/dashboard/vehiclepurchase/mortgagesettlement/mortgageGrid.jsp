<%@page import="com.dashboard.vehiclepurchase.mortgagesettlement.*" %>
<%ClsMortgageSettlementDAO mortgagedao=new ClsMortgageSettlementDAO(); 
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String purchasedocno=request.getParameter("purchasedocno")==null?"":request.getParameter("purchasedocno");
%>

<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
 <script type="text/javascript">
 var id='<%=id%>';
 var mortgagedata;
 if(id=="1"){
	 mortgagedata='<%=mortgagedao.getMortgageData(fromdate, todate, id, purchasedocno)%>'
 }
 
 function getBalance(){
	 var rows=$('#mortgageGrid').jqxGrid('getrows');
     var principal=0.0;
     for(var i=0;i<rows.length;i++){
     	principal+=$('#mortgageGrid').jqxGrid('getcellvalue',i,'principalamt');
     }
     var totalloanamount=$('#total').val();
     var balance=principal-totalloanamount;
 	funRoundAmt(balance,"balanceloanamt");
 }
        
$(document).ready(function () { 	

    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	if(value=="undefined" || typeof(value)=="undefined"){
    		value=0.00;
    	}
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'purchasedocno',type:'int'},
                            {name : 'ucrdocno',type:'int'},
                            {name : 'detaildocno',type:'int'},
                            {name : 'date',type:'date'},
     						{name : 'chequeno', type: 'string'  },
     						{name : 'principalamt', type: 'number'    },
     						{name : 'interestamt', type: 'number'    },
     						{name : 'amount', type: 'number'    },
     						{name : 'bpvno', type: 'number'    },
     						{name : 'defaultrow',type:'number'},
     						{name : 'editstatus',type:'number'},
     						{name : 'poststatus',type:'number'}
                 ],               
               localdata:mortgagedata,
               
               deleterow: function (rowid, commit) {
            	   var rowindex = $('#mortgageGrid').jqxGrid('getrowboundindexbyid', rowid);
            	   $("#deleteGrid").jqxGrid("addrow", null, {});   
            	   var deleterows=$('#deleteGrid').jqxGrid('getrows');
            	   var deleterowindex=(deleterows.length)-1;
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'purchasedocno',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'purchasedocno'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'ucrdocno',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'ucrdocno'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'detaildocno',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'detaildocno'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'date',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'date'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'chequeno',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'chequeno'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'principalamt',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'principalamt'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'interestamt',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'interestamt'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'amount',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'amount'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'bpvno',$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'bpvno'));
            	   $('#deleteGrid').jqxGrid('setcellvalue',deleterowindex,'defaultdeleterow',0);
                   // synchronize with the server - send delete command
                   // call commit with parameter true if the synchronization with the server is successful 
                   // and with parameter false if the synchronization failed.
                   commit(true);
               },
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                  
            };
            var cellbeginedit = function (row, datafield, columntype, value) {
                var rowindexestemp = event.args.rowindex;
                var value = $('#mortgageGrid').jqxGrid('getcellvalue', rowindexestemp, "poststatus"); 
                if(value>0)
        		return false;
            } 
            var cellclassname = function (row, column, value, data) {
                if (data.poststatus > 0) {
                    return "disableClass";
                };
            };
            $("#mortgageGrid").on("bindingcomplete", function (event) {
            	getBalance();
            	$("#overlay, #PleaseWait").hide();
            	});                 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#mortgageGrid").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',
               // localization: {thousandsSeparator: ""},
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#mortgageGrid').jqxGrid('getselectedcell');
                  /*   if (cell != undefined && cell.datafield == 'total' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#mortgageGrid").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#mortgageGrid").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#mortgageGrid").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#mortgageGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'account') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("invoicerow").value=cell1.rowindex;
                /*         	$('#mortgageGrid').jqxGrid('clearselection'); 
                        	$('#mortgageGrid').jqxGrid('render');
                        	$('#accountwindow').jqxWindow('open');
        					$('#accountwindow').jqxWindow('focus');
        					 accountSearchContent('accountSearchGrid.jsp?', $('#accountwindow')); */
                          }
                        
                    }
},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '5%',cellbeginedit: cellbeginedit,editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text:'Purchase Docno',datafield:'purchasedocno',cellclassname: cellclassname,cellbeginedit: cellbeginedit,width:'13.5%'},
                            { text:'UCR Docno',datafield:'ucrdocno',cellclassname: cellclassname,cellbeginedit: cellbeginedit,width:'13.5%',hidden:true},
                            { text:'Detail Docno',datafield:'detaildocno',cellclassname: cellclassname,cellbeginedit: cellbeginedit,width:'13.5%',hidden:true},
                            {text: 'Date',datafield:'date',width:'13.5%',cellclassname: cellclassname,cellbeginedit: cellbeginedit,cellsformat:'dd.MM.yyyy',columntype:'datetimeinput'},					
							{ text: 'Cheque No', datafield: 'chequeno',cellclassname: cellclassname,cellbeginedit: cellbeginedit, width: '13.5%' },
							{ text: 'Principal Amount', datafield: 'principalamt',cellclassname: cellclassname,cellbeginedit: cellbeginedit, width: '13.5%' ,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Interest Amount', datafield: 'interestamt',cellclassname: cellclassname,cellbeginedit: cellbeginedit, width: '13.5%' ,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Amount', datafield: 'amount', width: '13.5%' ,cellclassname: cellclassname,cellbeginedit: cellbeginedit,align:'right',cellsformat:'d2',
								/* cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
								var principalamount=parseFloat($('#mortgageGrid').jqxGrid('getcellvalue',row,'principalamt'));
								var interestamount=parseFloat($('#mortgageGrid').jqxGrid('getcellvalue',row,'interestamt'));
								var sum=0.0;
								if(principalamount!="undefined" && interestamount!="undefined"){
									sum=principalamount+interestamount;
								}
								else{
									sum=0.0;
								}
								if(isNaN(sum)){
									sum=0.00;
								}
								var column = $("#mortgageGrid").jqxGrid('getcolumn', columnfield);
		                          if (column.cellsformat != '') {
		                              if ($.jqx.dataFormat) {
		                                  if ($.jqx.dataFormat.isDate(sum)) {
		                                	  sum = $.jqx.dataFormat.formatdate(sum, column.cellsformat);
		                                  }
		                                  else if ($.jqx.dataFormat.isNumber(sum)) {
		                                	  sum = $.jqx.dataFormat.formatnumber(sum, column.cellsformat);
		                                  }
		                              }
		                          }
					        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:right;margin-right:2px;margin-left:4px;margin-top:4px;'>" + sum + "</div>";
					    	}, */
								
								cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							{ text: 'BPV No', datafield: 'bpvno',cellclassname: cellclassname,cellbeginedit: cellbeginedit, width: '14%',editable:false},
							{ text: 'Default Row Status', datafield: 'defaultrow',cellclassname: cellclassname,cellbeginedit: cellbeginedit, width: '14%',hidden:true,editable:false},
							{ text: 'Edit Row Status', datafield: 'editstatus', cellclassname: cellclassname,cellbeginedit: cellbeginedit,width: '14%',hidden:true,editable:false},
							{ text: 'Post Status', datafield: 'poststatus', cellclassname: cellclassname,cellbeginedit: cellbeginedit,width: '14%',hidden:true,editable:false}
							
	              ]
            });
       $('#mortgageGrid').on('celldoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   document.getElementById("invoicerow").value=row1;
    	   $('#mortgageGrid').jqxGrid('clearselection');
				
                });
       $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 50, autoOpenPopup: false, mode: 'popup'});
       $("#mortgageGrid").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#mortgageGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#mortgageGrid").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#mortgageGrid").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else if($.trim($(args).text()) == "Delete Selected Row"){
        	   if($('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'poststatus')=="1"){
        		   $.messager.alert('warning','Cannot Delete Posted Data');
        		   return false;
        	   }
        	   var deleteucrdocno=document.getElementById("deleteucrdocno").value;
        	   if(deleteucrdocno==""){
        		   deleteucrdocno+=$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'ucrdocno');
        	   }
        	   else{
        		   deleteucrdocno+=","+$('#mortgageGrid').jqxGrid('getcellvalue',rowindex,'ucrdocno');
        	   }
        	   document.getElementById("deleteucrdocno").value=deleteucrdocno;
        	  
               var rowid = $("#mortgageGrid").jqxGrid('getrowid', rowindex);
               $("#mortgageGrid").jqxGrid('deleterow', rowid);
               getBalance();
           }
           else if($.trim($(args).text()) == "Add Row"){
        	   var rows=$('#mortgageGrid').jqxGrid('getrows');
        	   var rowlength=rows.length;
        	   var temppurchasedocno=$('#mortgageGrid').jqxGrid('getcellvalue',rowlength-1,'purchasedocno');
        	   if(typeof(temppurchasedocno)!="undefined"){
        		   $("#mortgageGrid").jqxGrid("addrow", null, {});
        		   rows=$('#mortgageGrid').jqxGrid('getrows');
            	   rowlength=rows.length;
        		   $('#mortgageGrid').jqxGrid('setcellvalue',rowlength-1,'defaultrow','0');
        	   }
           }
           
       });
       $("#mortgageGrid").on('rowclick', function (event) {
           if (event.args.rightclick) {
		  
               $("#mortgageGrid").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
          
		   }
       });
       
/*        var rows=$("#mortgageGrid").jqxGrid("getrows");
       if(rows.length==0){
    	   $("#mortgageGrid").jqxGrid("addrow", null, {});   
       }
       */

       $("#mortgageGrid").on('cellvaluechanged', function (event) 
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
    		       if(datafield=="principalamt" || datafield=="interestamt"){
    		    	   var principal=0.0;
    		    	   var interest=0.0;
    		    	   if($('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'principalamt')!="undefined" && $('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'principalamt')!="" && $('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'principalamt')!=null){
    		    		   principal=$('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'principalamt');
    		    	   }
    		    	   if($('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'interestamt')!="undefined" && $('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'interestamt')!="" && $('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'interestamt')!=null){
    		    		   interest=$('#mortgageGrid').jqxGrid('getcellvalue',rowBoundIndex,'interestamt');
    		    	   }
    		    	   var sum=principal+interest;
    		    	   $('#mortgageGrid').jqxGrid('setcellvalue',rowBoundIndex,'amount',sum);
    		    	   $('#mortgageGrid').jqxGrid('setcellvalue',rowBoundIndex,'editstatus','1');
    		    	   getBalance();
    		       }
    		       
    		   });
       
        });
    </script>
 <input type="hidden" name="invoicerow" id="invoicerow">
 <input type="hidden" name="deleteucrdocno" id="deleteucrdocno">
    <div id='jqxWidget'>
    <div id="mortgageGrid"></div>
    <div id="popupWindow">

 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
            <li>Add Row</li>
        </ul>
       </div>
       </div>
       </div>
