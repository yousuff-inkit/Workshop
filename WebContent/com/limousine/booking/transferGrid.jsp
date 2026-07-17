<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var transferdata;
var id='<%=id%>';
if(id=="1"){
	transferdata='<%=bookdao.getTransferData(docno,id)%>';
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
                       	{name : 'dropofflocation' , type:'string'},
                       	{name : 'dropofflocationid',type:'number'},
                       	{name : 'dropoffaddress' , type:'string'},
                       	{name : 'brand' , type:'string'},
                       	{name : 'brandid',type:'number'},
                       	{name : 'model',type:'string'},
                       	{name : 'modelid',type:'number'},
                       	{name : 'nos',type:'number'},
                       	{name : 'btntarif',type:'string'},
                       	{name : 'tarifdocno',type:'string'},
                       	{name : 'estdistance',type:'number'},
                       	{name : 'esttime',type:'date'},
                       	{name : 'tarif',type:'number'},
                       	{name : 'exdistancerate',type:'number'},
                       	{name : 'extimerate',type:'number'},
                       	{name : 'chkothersrvc',type:'bool'},
                       	{name : 'btnappend',type:'string'},
                       	{name : 'gid',type:'string'},
                       	{name : 'tarifdetaildocno',type:'number'},
                       	{name : 'errorstatus',type:'number'}
     				   ],
					localdata:transferdata,
                
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
            
            $("#transferGrid").jqxGrid(
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
				var cell=$('#transferGrid').jqxGrid('getselectedcell');
				var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
     		    var rowBoundIndex = cell.rowindex;
     		   	var dataField=cell.datafield;
				if(key==114){
					
					if(cell!="undefined" && (cell.datafield=="pickuplocation" || cell.datafield=="dropofflocation")){
						document.getElementById("transferrowindex").value=rowBoundIndex;
        		    	$('#locationwindow').jqxWindow('open');
    					$('#locationwindow').jqxWindow('focus');
    					locationSearchContent('locationSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value, $('#locationwindow'));
					}
					else if(dataField=="brand"){
        		    	document.getElementById("transferrowindex").value=rowBoundIndex;
                    	$('#transferGrid').jqxGrid('clearselection'); 
                    	$('#transferGrid').jqxGrid('render');
        		    	$('#brandwindow').jqxWindow('open');
    					$('#brandwindow').jqxWindow('focus');
    					brandSearchContent('brandSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value, $('#brandwindow'));
        		    }
        		    else if(dataField=="model"){
        		    	if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
        		    		document.getElementById("errormsg").innerText="";
        		    		document.getElementById("errormsg").innerText="Please select a valid brand";
        		    		return false;
        		    	}
        		    	else{
            		    	document.getElementById("transferrowindex").value=rowBoundIndex;
            		    	var brandid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
            		    	$('#modelwindow').jqxWindow('open');
        					$('#modelwindow').jqxWindow('focus');
        					modelSearchContent('modelSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value+'&brandid='+brandid, $('#modelwindow'));            		    		
        		    	}

        		    }
        		   else if(dataField=="tarifdocno"){
        			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation'))=="undefined"){
          		    		document.getElementById("errormsg").innerText="";
          		    		document.getElementById("errormsg").innerText="Pick up location is mandatory";
          		    		return false;
          		    		}
           			   else{
           				   document.getElementById("errormsg").innerText="";
           			   }
        			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation'))=="undefined"){
         		    		document.getElementById("errormsg").innerText="";
         		    		document.getElementById("errormsg").innerText="Drop off location is mandatory";
         		    		return false;
         		    		}
          			   else{
          				   document.getElementById("errormsg").innerText="";
          			   }
        			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
       		    		document.getElementById("errormsg").innerText="";
       		    		document.getElementById("errormsg").innerText="Please select a valid brand";
       		    		return false;
       		    		}
        			   else{
        				   document.getElementById("errormsg").innerText="";
        			   }
        			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model'))=="undefined"){
          		    		document.getElementById("errormsg").innerText="";
          		    		document.getElementById("errormsg").innerText="Please select a valid brand";
          		    		return false;
          		    	}
        			   else{
        				   document.getElementById("errormsg").innerText="";
        			   }
        			   $('#transferGrid').jqxGrid('clearselection'); 
                   	   $('#transferGrid').jqxGrid('render');
                   	   var brandid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                   		var modelid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'modelid');
                   		var pickuplocid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocationid');
                   		var dropofflocid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocationid');
                   		$('#tarifwindow').jqxWindow('open');
						$('#tarifwindow').jqxWindow('focus');
						tarifSearchContent('tarifSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value+'&brandid='+brandid+'&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&client='+document.getElementById("hidclient").value, $('#tarifwindow'));            		   	   
        		   }
				
				}
				
				
				
                 },
            
               
                columns: [
							
							{ text: 'Doc No', datafield: 'doc_no',editable:false,width:'20%',hidden:true},
							{ text: '',  datafield: 'docname',editable:false,width:'4%'},
		
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
										$('#transferGrid').jqxGrid('setcellvalue',cell.row,'errorstatus',1);
										/* return { result: false, message: "Pickup Date should not be before "+currenttextdate }; */
										$("#transferGrid").jqxGrid('showvalidationpopup', cell.row, "pickupdate", "Pickup Date should not be before "+currenttextdate);
										return false;
									}
									else{
										$('#transferGrid').jqxGrid('setcellvalue',cell.row,'errorstatus',0);
										$('#transferGrid').jqxGrid('hidevalidationpopups');
										return true;
									}
								},
								columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Pickup Time',  datafield: 'pickuptime',width:'5%',editable:true,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Pickup Location',  datafield: 'pickuplocation',width:'8%',editable:false ,renderer: columnsrenderer},
							{ text: 'Pickup Location ID',  datafield: 'pickuplocationid',width:'12%',hidden:true,editable:false ,renderer: columnsrenderer},
							{ text: 'Pickup Address',  datafield: 'pickupaddress',width:'10%',editable:true,renderer: columnsrenderer},
							{ text: 'Dropoff Location',  datafield: 'dropofflocation',editable:false,width:'8%',renderer: columnsrenderer},
							{ text: 'Dropoff Location ID',  datafield: 'dropofflocationid',editable:false,hidden:true,width:'12%',renderer: columnsrenderer},
							{ text: 'Dropoff Address', datafield: 'dropoffaddress',width:'10%',editable:true,renderer: columnsrenderer},
							{ text: 'Brand', datafield: 'brand',width:'8%',editable:true,renderer: columnsrenderer},
							{ text: 'Brand ID', datafield: 'brandid',width:'12%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Model', datafield: 'model',width:'8%',editable:true,renderer: columnsrenderer},
							{ text: 'Model ID', datafield: 'modelid',width:'12%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Nos', datafield: 'nos',width:'4%',editable:true,renderer: columnsrenderer},
							{ text: 'Tarif Doc No', datafield: 'tarifdocno',width:'4%',editable:false,renderer: columnsrenderer,cellsalign:'right'},
							{ text: 'Est.Distance', datafield: 'estdistance',width:'7%',editable:false,renderer: columnsrenderer,cellsalign:'right',cellsformat:'d2'},
							{ text: 'Est.Time', datafield: 'esttime',width:'6%',editable:false,renderer: columnsrenderer,cellsformat:'HH:mm',cellsalign:'right'},
							{ text: 'Tarif', datafield: 'tarif',width:'6%',editable:false,renderer: columnsrenderer,cellsalign:'right',cellsformat:'d2'},
							{ text: 'Ex.Distance Rate', datafield: 'exdistancerate',width:'6%',editable:false,renderer: columnsrenderer,cellsalign:'right',cellsformat:'d2'},
							{ text: 'Ex.Time Rate', datafield: 'extimerate',width:'6%',editable:false,renderer: columnsrenderer,cellsalign:'right'},
							{ text: 'Other Service', datafield: 'chkothersrvc',width:'4%',editable:true,renderer: columnsrenderer,columntype: 'checkbox'},
							{ text: '', datafield: 'btnappend',width:'5%',editable:true,renderer: columnsrenderer, columntype: 'button'},
							{ text: '', datafield: 'gid',width:'5%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'tarifdetaildocno', datafield: 'tarifdetaildocno',width:'5%',editable:true,renderer: columnsrenderer,hidden:true},
							{ text: 'Error Status',datafield:'errorstatus',aggregates: ['sum'],hidden:true}
         	              ]
           
            });
            
            $("#transferGrid").on("cellclick", function (event)
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
            		    	var rows=$('#transferGrid').jqxGrid('getrows');
            		    	if(rows.length>rowBoundIndex+1){
            		    		appendDetails("transferGrid",rowBoundIndex,rowBoundIndex+1);
            		    }
            		    else{
            		    		$("#transferGrid").jqxGrid("addrow", null, {});
            		    		appendDetails("transferGrid",rowBoundIndex,rowBoundIndex+1);
            		    	}
            		    }
            		});
            $("#transferGrid").on("celldoubleclick", function (event)
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
            		    
            		    if(dataField=="pickuplocation" || dataField=="dropofflocation"){
             		    	document.getElementById("transferrowindex").value=rowBoundIndex;
            		    	$('#locationwindow').jqxWindow('open');
        					$('#locationwindow').jqxWindow('focus');
        					locationSearchContent('locationSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value, $('#locationwindow'));
            		    }
            		    else if(dataField=="brand"){
            		    	document.getElementById("transferrowindex").value=rowBoundIndex;
                        	$('#transferGrid').jqxGrid('clearselection'); 
                        	$('#transferGrid').jqxGrid('render');
            		    	$('#brandwindow').jqxWindow('open');
        					$('#brandwindow').jqxWindow('focus');
        					brandSearchContent('brandSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value, $('#brandwindow'));
            		    }
            		    else if(dataField=="model"){
            		    	if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
            		    		document.getElementById("errormsg").innerText="";
            		    		document.getElementById("errormsg").innerText="Please select a valid brand";
            		    		return false;
            		    	}
            		    	else{
                		    	document.getElementById("transferrowindex").value=rowBoundIndex;
                		    	var brandid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                		    	$('#modelwindow').jqxWindow('open');
            					$('#modelwindow').jqxWindow('focus');
            					modelSearchContent('modelSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value+'&brandid='+brandid, $('#modelwindow'));            		    		
            		    	}

            		    }
            		   else if(dataField=="tarifdocno"){
            			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocation'))=="undefined"){
              		    		document.getElementById("errormsg").innerText="";
              		    		document.getElementById("errormsg").innerText="Pick up location is mandatory";
              		    		return false;
              		    		}
               			   else{
               				   document.getElementById("errormsg").innerText="";
               			   }
            			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocation'))=="undefined"){
             		    		document.getElementById("errormsg").innerText="";
             		    		document.getElementById("errormsg").innerText="Drop off location is mandatory";
             		    		return false;
             		    		}
              			   else{
              				   document.getElementById("errormsg").innerText="";
              			   }
            			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brand'))=="undefined"){
           		    		document.getElementById("errormsg").innerText="";
           		    		document.getElementById("errormsg").innerText="Please select a valid brand";
           		    		return false;
           		    		}
            			   else{
            				   document.getElementById("errormsg").innerText="";
            			   }
            			   if($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')=="undefined" || $('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model')==null || typeof($('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'model'))=="undefined"){
              		    		document.getElementById("errormsg").innerText="";
              		    		document.getElementById("errormsg").innerText="Please select a valid brand";
              		    		return false;
              		    	}
            			   else{
            				   document.getElementById("errormsg").innerText="";
            			   }
            			   $('#transferGrid').jqxGrid('clearselection'); 
                       	   $('#transferGrid').jqxGrid('render');
                       	   var brandid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
                       		var modelid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'modelid');
                       		var pickuplocid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'pickuplocationid');
                       		var dropofflocid=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'dropofflocationid');
                       		$('#tarifwindow').jqxWindow('open');
    						$('#tarifwindow').jqxWindow('focus');
    						tarifSearchContent('tarifSearchGrid.jsp?datafield='+dataField+'&gridname=transferGrid&gridrowindex='+document.getElementById("transferrowindex").value+'&brandid='+brandid+'&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&client='+document.getElementById("hidclient").value, $('#tarifwindow'));            		   	   
            		   }
            		});
            		      
            $("#transferGrid").on('cellvaluechanged', function (event) 
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
            		    if(datafield=="pickuplocation"){
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="dropofflocation"){
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="brand"){
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'model','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'modelid','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="model"){
            		    	
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdocno','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'estdistance','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'esttime','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarif','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'exdistancerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'extimerate','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'gid','');
            		    	$('#transferGrid').jqxGrid('setcellvalue',rowBoundIndex,'tarifdetaildocno','');
            		    }
            		    else if(datafield=="nos"){
            		    	var number=$('#transferGrid').jqxGrid('getcellvalue',rowBoundIndex,'nos');
            		    	if(number=="" || number=="undefined" || number==null || typeof(number)=="undefined"){
            		    		$.messager.alert('warning','Number is mandatory');
            		    		return false;
            		    	}
            		    	else if(parseInt(number)==0){
            		    		$.messager.alert('warning','Minimum 1 is required');
            		    		return false;
            		    	}
            		    	
            		    }
            		});

            
});

function appendDetails(gridname,row1,row2){
	
	if(gridname=="transferGrid"){
		$('#'+gridname).jqxGrid('setcellvalue',row2,'docname','T'+(parseInt(row2)+1));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickupdate',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickupdate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuptime',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuptime'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuplocation',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuplocation'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuplocationid',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuplocationid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickupaddress',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickupaddress'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'dropofflocation',$('#'+gridname).jqxGrid('getcellvalue',row1,'dropofflocation'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'dropofflocationid',$('#'+gridname).jqxGrid('getcellvalue',row1,'dropofflocationid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'dropoffaddress',$('#'+gridname).jqxGrid('getcellvalue',row1,'dropoffaddress'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'brand',$('#'+gridname).jqxGrid('getcellvalue',row1,'brand'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'brandid',$('#'+gridname).jqxGrid('getcellvalue',row1,'brandid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'model',$('#'+gridname).jqxGrid('getcellvalue',row1,'model'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'modelid',$('#'+gridname).jqxGrid('getcellvalue',row1,'modelid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'nos',$('#'+gridname).jqxGrid('getcellvalue',row1,'nos'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarifdocno',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarifdocno'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'estdistance',$('#'+gridname).jqxGrid('getcellvalue',row1,'estdistance'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'esttime',$('#'+gridname).jqxGrid('getcellvalue',row1,'esttime'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarif',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarif'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'exdistancerate',$('#'+gridname).jqxGrid('getcellvalue',row1,'exdistancerate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'extimerate',$('#'+gridname).jqxGrid('getcellvalue',row1,'extimerate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'btnappend',$('#'+gridname).jqxGrid('getcellvalue',row1,'btnappend'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'chkothersrvc',$('#'+gridname).jqxGrid('getcellvalue',row1,'chkothersrvc'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'gid',$('#'+gridname).jqxGrid('getcellvalue',row1,'gid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarifdetaildocno',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarifdetaildocno'));
	
	}
	else if(gridname=="hoursGrid"){
		$('#'+gridname).jqxGrid('setcellvalue',row2,'docname','L'+(parseInt(row2)+1));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'blockhrs',$('#'+gridname).jqxGrid('getcellvalue',row1,'blockhrs'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickupdate',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickupdate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuptime',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuptime'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuplocation',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuplocation'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickuplocationid',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickuplocationid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'pickupaddress',$('#'+gridname).jqxGrid('getcellvalue',row1,'pickupaddress'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'brand',$('#'+gridname).jqxGrid('getcellvalue',row1,'brand'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'brandid',$('#'+gridname).jqxGrid('getcellvalue',row1,'brandid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'model',$('#'+gridname).jqxGrid('getcellvalue',row1,'model'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'modelid',$('#'+gridname).jqxGrid('getcellvalue',row1,'modelid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'nos',$('#'+gridname).jqxGrid('getcellvalue',row1,'nos'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarifdocno',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarifdocno'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'exhrrate',$('#'+gridname).jqxGrid('getcellvalue',row1,'exhrrate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'nighttarif',$('#'+gridname).jqxGrid('getcellvalue',row1,'nighttarif'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarif',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarif'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'nightexhrrate',$('#'+gridname).jqxGrid('getcellvalue',row1,'nightexhrrate'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'btnappend',$('#'+gridname).jqxGrid('getcellvalue',row1,'btnappend'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'chkothersrvc',$('#'+gridname).jqxGrid('getcellvalue',row1,'chkothersrvc'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'gid',$('#'+gridname).jqxGrid('getcellvalue',row1,'gid'));
		$('#'+gridname).jqxGrid('setcellvalue',row2,'tarifdetaildocno',$('#'+gridname).jqxGrid('getcellvalue',row1,'tarifdetaildocno'));
	}
}
	
            </script>
            <div id="transferGrid"></div>
            <input type="hidden" name="transferrowindex" id="transferrowindex">