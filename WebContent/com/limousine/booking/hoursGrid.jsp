<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var hoursdata;
var id='<%=id%>';
if(id=="1"){
	hoursdata='<%=bookdao.getHoursData(docno,id)%>';
}
$(document).ready(function () { 
	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         };

       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'docname' , type:'string'},
                       	{name : 'pickupdate' , type:'date'},
                       	{name : 'pickuptime' , type:'date'},
                       	{name : 'pickuplocation' , type:'string'},
                       	{name : 'pickuplocationid',type:'number'},
                       	{name : 'pickupaddress' , type:'string'},                       	
                       	{name : 'brand' , type:'string'},
                       	{name : 'brandid',type:'number'},
                       	{name : 'model',type:'string'},
                       	{name : 'modelid',type:'number'},
                       	{name : 'nos',type:'number'},
                       	{name : 'tarifdocno',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'exhrrate',type:'number'},
                       	{name : 'nighttarif',type:'date'},
                       	{name : 'tarif',type:'number'},
                       	{name : 'nightexhrrate',type:'number'},
                       	{name : 'chkothersrvc',type:'bool'},
                       	{name : 'btnappend',type:'string'},
                       	{name : 'gid',type:'string'},
                       	{name : 'tarifdetaildocno',type:'number'},
                       	{name : 'days',type:'number'},
                       	{name : 'errorstatus',type:'number'}
     				   ],
					localdata:hoursdata,
                
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
            
            $("#hoursGrid").jqxGrid(
            {
               width: '100%',
               height: 150,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
               enabletooltips:true,
               showaggregates:true,
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
				var cell=$('#hoursGrid').jqxGrid('getselectedcell');
				var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
				var rowBoundIndex=cell.rowindex;
				var dataField=cell.datafield;
				if(key==114){
					if(dataField=="pickuplocation"){
         		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
        		    	$('#locationwindow').jqxWindow('open');
    					$('#locationwindow').jqxWindow('focus');
    					locationSearchContent('locationSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value, $('#locationwindow'));
        		    }
        		    else if(dataField=="brand"){
        		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
                    	$('#hoursGrid').jqxGrid('clearselection'); 
                    	$('#hoursGrid').jqxGrid('render');
        		    	$('#brandwindow').jqxWindow('open');
    					$('#brandwindow').jqxWindow('focus');
    					brandSearchContent('brandSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value, $('#brandwindow'));
        		    }
        		    else if(dataField=="model"){
        		    	if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
        		    		document.getElementById("errormsg").innerText="";
        		    		document.getElementById("errormsg").innerText="Please select a valid brand";
        		    		return false;
        		    	}
        		    	else{
            		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
            		    	var brandid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
            		    	$('#modelwindow').jqxWindow('open');
        					$('#modelwindow').jqxWindow('focus');
        					modelSearchContent('modelSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value+'&brandid='+brandid, $('#modelwindow'));            		    		
        		    	}

        		    }
        		   else if(dataField=="tarifdocno"){
        			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs'))=="undefined"){
          		    		document.getElementById("errormsg").innerText="";
          		    		document.getElementById("errormsg").innerText="Block hours is mandatory";
          		    		return false;
          		    		}
           			   else{
           				   document.getElementById("errormsg").innerText="";
           			   }
        			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
       		    		document.getElementById("errormsg").innerText="";
       		    		document.getElementById("errormsg").innerText="Please select a valid brand";
       		    		return false;
       		    		}
        			   else{
        				   document.getElementById("errormsg").innerText="";
        			   }
        			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model'))=="undefined"){
          		    		document.getElementById("errormsg").innerText="";
          		    		document.getElementById("errormsg").innerText="Please select a valid brand";
          		    		return false;
          		    	}
        			   else{
        				   document.getElementById("errormsg").innerText="";
        			   }
        			   $('#hoursGrid').jqxGrid('clearselection'); 
                   	   $('#hoursGrid').jqxGrid('render');
                   	   var brandid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                   		var modelid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'modelid');
                   		var blockhrs=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs');
                   		$('#tarifwindow').jqxWindow('open');
						$('#tarifwindow').jqxWindow('focus');
						tarifSearchContent('tarifSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value+'&brandid='+brandid+'&modelid='+modelid+'&blockhrs='+blockhrs+'&client='+document.getElementById("hidclient").value, $('#tarifwindow'));            		   	   
        		   }
				}
                 },
            
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',editable:false,width:'20%',hidden:true},
							{ text: '',  datafield: 'docname',editable:false,width:'4%'},
							{ text: 'Block Hours', datafield: 'blockhrs',width:'6%',editable:true},
							{ text: 'Pickup Date',  datafield: 'pickupdate',editable:true ,width:'7%',cellsformat:'dd.MM.yyyy',cellclassname:'column',
								validation:function(cell,value){
									if(value==null){
										return true;
									}
									var currentdate=new Date();
									currentdate.setHours(0,0,0,0);
									value.setHours(0,0,0,0);
									var currenttextdate=currentdate.getDate()+"."+(currentdate.getMonth()+1)+"."+currentdate.getFullYear();
									if(value<currentdate){
										$('#hoursGrid').jqxGrid('setcellvalue',cell.row,'errorstatus',1);
										/* return { result: false, message: "Pickup Date should not be before "+currenttextdate }; */
										$("#hoursGrid").jqxGrid('showvalidationpopup', cell.row, "pickupdate", "Pickup Date should not be before "+currenttextdate);
										return false;
									}
									else{
										$('#hoursGrid').jqxGrid('setcellvalue',cell.row,'errorstatus',0);
										$('#hoursGrid').jqxGrid('hidevalidationpopups');
										return true;
									}
								}
								,columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Pickup Time',  datafield: 'pickuptime',width:'5%',editable:true,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Pickup Location',  datafield: 'pickuplocation',width:'8%',editable:false ,renderer: columnsrenderer},
							{ text: 'Pickup Location ID',  datafield: 'pickuplocationid',width:'12%',hidden:true,editable:false ,renderer: columnsrenderer},
							{ text: 'Pickup Address',  datafield: 'pickupaddress',width:'10%',editable:true,renderer: columnsrenderer},
							{ text: 'Brand', datafield: 'brand',width:'8%',editable:true,renderer: columnsrenderer},
							{ text: 'Brand ID', datafield: 'brandid',width:'12%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Model', datafield: 'model',width:'8%',editable:true,renderer: columnsrenderer},
							{ text: 'Model ID', datafield: 'modelid',width:'12%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Days',datafield:'days',width:'4%',editable:true,renderer: columnsrenderer},
							{ text: 'Nos', datafield: 'nos',width:'4%',editable:true,renderer: columnsrenderer},
							{ text: 'Tarif Doc No', datafield: 'tarifdocno',width:'4%',editable:false,renderer: columnsrenderer},
							{ text: 'Tarif', datafield: 'tarif',width:'8%',editable:false,renderer: columnsrenderer,cellsformat:'d2',cellsalign:'right'},
							{ text: 'Ex.Hour Rate', datafield: 'exhrrate',width:'8%',editable:false,renderer: columnsrenderer,cellsformat:'d2',cellsalign:'right'},
							{ text: 'Night Tarif', datafield: 'nighttarif',width:'8%',editable:false,renderer: columnsrenderer,cellsformat:'d2',cellsalign:'right'},
							{ text: 'Night Ex.Hour Rate', datafield: 'nightexhrrate',width:'8%',editable:false,renderer: columnsrenderer,cellsformat:'d2',cellsalign:'right'},
							{ text: 'Other Service', datafield: 'chkothersrvc',width:'4%',editable:true,renderer: columnsrenderer,columntype: 'checkbox'},
							{ text: '', datafield: 'btnappend',width:'5%',editable:true,renderer: columnsrenderer, columntype: 'button'},
							{ text: 'GID', datafield: 'gid',width:'5%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'tarifdetaildocno', datafield: 'tarifdetaildocno',width:'5%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Error Status',datafield:'errorstatus',aggregates: ['sum'],hidden:true}
         	              ]
           
            });
            
            
            $("#hoursGrid").on("cellclick", function (event)
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
            		    if(dataField=="btnappend"){
            		    	var rows=$('#hoursGrid').jqxGrid('getrows');
            		    	if(rows.length>rowBoundIndex+1){
            		    		appendDetails("hoursGrid",rowBoundIndex,rowBoundIndex+1);
            		    }
            		    else{
            		    		$("#hoursGrid").jqxGrid("addrow", null, {});
            		    		appendDetails("hoursGrid",rowBoundIndex,rowBoundIndex+1);
            		    	}
            		    }
            		});
            $("#hoursGrid").on("celldoubleclick", function (event)
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
            		    
            		    if(dataField=="pickuplocation"){
             		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
            		    	$('#locationwindow').jqxWindow('open');
        					$('#locationwindow').jqxWindow('focus');
        					locationSearchContent('locationSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value, $('#locationwindow'));
            		    }
            		    else if(dataField=="brand"){
            		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
                        	$('#hoursGrid').jqxGrid('clearselection'); 
                        	$('#hoursGrid').jqxGrid('render');
            		    	$('#brandwindow').jqxWindow('open');
        					$('#brandwindow').jqxWindow('focus');
        					brandSearchContent('brandSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value, $('#brandwindow'));
            		    }
            		    else if(dataField=="model"){
            		    	if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
            		    		document.getElementById("errormsg").innerText="";
            		    		document.getElementById("errormsg").innerText="Please select a valid brand";
            		    		return false;
            		    	}
            		    	else{
                		    	document.getElementById("hoursrowindex").value=rowBoundIndex;
                		    	var brandid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                		    	$('#modelwindow').jqxWindow('open');
            					$('#modelwindow').jqxWindow('focus');
            					modelSearchContent('modelSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value+'&brandid='+brandid, $('#modelwindow'));            		    		
            		    	}

            		    }
            		   else if(dataField=="tarifdocno"){
            			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs'))=="undefined"){
              		    		document.getElementById("errormsg").innerText="";
              		    		document.getElementById("errormsg").innerText="Block hours is mandatory";
              		    		return false;
              		    		}
               			   else{
               				   document.getElementById("errormsg").innerText="";
               			   }
            			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
           		    		document.getElementById("errormsg").innerText="";
           		    		document.getElementById("errormsg").innerText="Please select a valid brand";
           		    		return false;
           		    		}
            			   else{
            				   document.getElementById("errormsg").innerText="";
            			   }
            			   if($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="undefined" || $('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')==null || typeof($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'model'))=="undefined"){
              		    		document.getElementById("errormsg").innerText="";
              		    		document.getElementById("errormsg").innerText="Please select a valid brand";
              		    		return false;
              		    	}
            			   else{
            				   document.getElementById("errormsg").innerText="";
            			   }
            			   $('#hoursGrid').jqxGrid('clearselection'); 
                       	   $('#hoursGrid').jqxGrid('render');
                       	   var brandid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                       		var modelid=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'modelid');
                       		var blockhrs=$('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'blockhrs');
                       		$('#tarifwindow').jqxWindow('open');
    						$('#tarifwindow').jqxWindow('focus');
    						tarifSearchContent('tarifSearchGrid.jsp?datafield='+dataField+'&gridname=hoursGrid&gridrowindex='+document.getElementById("hoursrowindex").value+'&brandid='+brandid+'&modelid='+modelid+'&blockhrs='+blockhrs+'&client='+document.getElementById("hidclient").value, $('#tarifwindow'));            		   	   
            		   }
            		});
            		      
            $("#hoursGrid").on('cellvaluechanged', function (event) 
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
            		    //Clearing when Brand is changed
            		    if(datafield=="blockhrs"){
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'exhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nighttarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nightexhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="brand"){
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'model','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'modelid','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'exhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nighttarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nightexhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="model"){
            		    	
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'exhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nighttarif','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'nightexhrrate','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#hoursGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		});
           /*  $("#hoursGrid").on('cellendedit', function (event) 
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
            		    //Clearing when value is changed
            			var status=true;
            		    if(datafield=="pickupdate"){
            		    	var dateval=funBackDateChecking($('#hoursGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickupdate'));
            		    	if(parseInt(dateval)==0){
            		    		document.getElementById("errormsg").innerText="";
            					document.getElementById("errormsg").innerText="Back Date Not Allowed";
            					$('#hoursGrid').jqxGrid('selectcell', rowBoundIndex, 'pickupdate');
            					status=false;
            				}
            		    }
            		    return status;
            		}); */
});

	
            </script>
            <div id="hoursGrid"></div>
<input type="hidden" name="hoursrowindex" id="hoursrowindex">