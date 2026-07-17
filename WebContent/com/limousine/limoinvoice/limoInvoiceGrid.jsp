<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.limousine.limoinvoice.*" %>
<%
ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
String docno=request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>

 <script type="text/javascript">
        var id='<%=id%>';
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
        	var invoicedata;
        	if(document.getElementById("docno").value>0 && id=="1"){
        		invoicedata='<%=invoicedao.getInvoiceGridData(docno,id)%>';	
        	}
        
           // alert("Grid Data"+invoicedata); 
        	var num = 1; 
                var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
                }
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'guest',type:'string'},
     						{name : 'guestno', type: 'number'  },
     						{name : 'flname', type: 'string'    },
     						{name : 'fleet_no',type:'number'},
     						{name : 'reg_no',type:'number'},
     						{name : 'type',type:'string'},
     						{name : 'typeno',type:'number'},
     						{name : 'blockhrs',type:'number'},
     						{name : 'pickupdate',type:'date'},
     						{name : 'pickuptime',type:'string'},
     						{name : 'pickuplocationid',type:'number'},
     						{name : 'pickuplocation',type:'string'},
     						{name : 'dropofflocationid',type:'number'},
     						{name : 'dropofflocation',type:'string'},
     						{name : 'amount',type:'number'},
     						{name : 'discount',type:'number'},
     						{name : 'total',type:'number'}

                 ],               
               localdata:invoicedata,
               
               deleterow: function (rowid, commit) {
                   // synchronize with the server - send delete command
                   // call commit with parameter true if the synchronization with the server is successful 
                   // and with parameter false if the synchronization failed.
                   commit(true);
               },
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

            
            var typelist = new Array();
            $("#limoInvoiceGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                //pageable: true,
                scrollmode : 'logical',
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlecell',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#limoInvoiceGrid').jqxGrid('getselectedcell');
                  /*   if (cell != undefined && cell.datafield == 'total' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#jqxManualInvoice").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#jqxManualInvoice").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#jqxManualInvoice").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#limoInvoiceGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'guest') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("gridindex").value=cell1.rowindex;
                        	$('#limoInvoiceGrid').jqxGrid('clearselection'); 
                        	$('#limoInvoiceGrid').jqxGrid('render');
                        	$('#guestwindow').jqxWindow('open');
        					$('#guestwindow').jqxWindow('focus');
        					 guestSearchContent('guestSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#guestwindow'));
                          }
                        
                    }
                    else if (cell1 != undefined && cell1.datafield == 'flname') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("gridindex").value=cell1.rowindex;
                        	$('#limoInvoiceGrid').jqxGrid('clearselection'); 
                        	$('#limoInvoiceGrid').jqxGrid('render');
                        	$('#fleetwindow').jqxWindow('open');
        					$('#fleetwindow').jqxWindow('focus');
        					 fleetSearchContent('masterFleetSearch.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#fleetwindow'));
                          }
                        
                    }
                    else if (cell1 != undefined && (cell1.datafield == 'pickuplocation' || cell1.datafield == 'dropofflocation')) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("gridindex").value=cell1.rowindex;
                        	$('#limoInvoiceGrid').jqxGrid('clearselection'); 
                        	$('#limoInvoiceGrid').jqxGrid('render');
                        	$('#locationwindow').jqxWindow('open');
        					$('#locationwindow').jqxWindow('focus');
        					 locationSearchContent('locationSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value+'&datafield='+cell1.datafield, $('#locationwindow'));
                          }
                        
                    }
                    else if (cell1 != undefined && cell1.datafield == 'type') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("gridindex").value=cell1.rowindex;
                        	$('#limoInvoiceGrid').jqxGrid('clearselection'); 
                        	$('#limoInvoiceGrid').jqxGrid('render');
                        	$('#typewindow').jqxWindow('open');
        					$('#typewindow').jqxWindow('focus');
        					typeSearchContent('typeSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#typewindow'));
                          }
                        
                    }
},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '3%',editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            	}
                            },
                            {text: 'Guest',datafield:'guest',width:'10%',editable:false},					
							{ text: 'Guest No', datafield: 'guestno', width: '20%',hidden:true },
							{ text: 'Fleet', datafield: 'flname', width: '10%' ,editable:false},
							{ text: 'Fleet No', datafield: 'fleet_no', width: '15%' ,hidden:true},
							{ text: 'Reg No', datafield: 'reg_no', width: '5%',editable:false},
							{ text: 'Type',datafield:'type',width:'8%',editable:false},
							{ text: 'Type id',datafield:'typeno',width:'10',hidden:true},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'5%',editable:true},
							{ text: 'Pickup Date',datafield:'pickupdate',width:'8%',editable:true,cellsformat:'dd.MM.yyyy',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Pickup Time',datafield: 'pickuptime',width:'7%',editable:true,cellsformat:'HH:mm',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%',editable:false},
							{ text: 'Pickup Location ID',datafield:'pickuplocationid',width:'10%',hidden:true},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%',editable:false},
							{ text: 'Dropoff Location ID',datafield:'dropofflocationid',width:'10%',hidden:true},
							{ text: 'Amount',datafield:'amount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
							{ text: 'Discount',datafield:'discount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
							{ text: 'Total',datafield:'total',width:'8%',cellsformat:'d2',cellsalign:'right',editable:false,align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}
	              ]
            });
            
            $("#limoInvoiceGrid").on('cellvaluechanged', function (event) 
                    {
                 	   
                 	   
                 	   
                    	var datafield = event.args.datafield;
                		
            		    var rowindex = event.args.rowindex;
            		   
            		    if(datafield=="amount" || datafield=="discount"){
            		    	var amount=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'amount');
            		    	var discount=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'discount');
            		    	if(amount=="undefined" || typeof(amount)=="undefined" || amount==null || amount==""){
            		    		amount=0.0;
            		    	}
            		    	if(discount=="undefined" || typeof(discount)=="undefined" || discount==null || discount==""){
            		    		discount=0.0;
            		    	}
            		    	var total=amount-discount;
            		    	$('#limoInvoiceGrid').jqxGrid('setcellvalue',rowindex,'total',total);
            		    }
            		    
                    });    
            		    
            
            
       $('#limoInvoiceGrid').on('celldoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
				return false;
			}
    	   document.getElementById("gridindex").value=row1;
    	   $('#limoInvoiceGrid').jqxGrid('clearselection');
    	   $('#limoInvoiceGrid').jqxGrid('render');
			if(event.args.datafield=='guest'){
				$('#guestwindow').jqxWindow('open');
				$('#guestwindow').jqxWindow('focus');
				guestSearchContent('guestSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#guestwindow'));
			}
			else if(event.args.datafield=='flname'){
				$('#fleetwindow').jqxWindow('open');
				$('#fleetwindow').jqxWindow('focus');
				fleetSearchContent('masterFleetSearch.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#fleetwindow'));
			}
			else if(event.args.datafield=='type'){
				$('#typewindow').jqxWindow('open');
				$('#typewindow').jqxWindow('focus');
				typeSearchContent('typeSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value, $('#typewindow'));
			}
			else if(event.args.datafield=='pickuplocation' || event.args.datafield=='dropofflocation'){
				$('#locationwindow').jqxWindow('open');
				$('#locationwindow').jqxWindow('focus');
				locationSearchContent('locationSearchGrid.jsp?datafield='+event.args.datafield+'&gridrowindex='+document.getElementById("gridindex").value, $('#locationwindow'));
			}
				
		});
       $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#limoInvoiceGrid").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#limoInvoiceGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#limoInvoiceGrid").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#limoInvoiceGrid").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#limoInvoiceGrid").jqxGrid('getrowid', rowindex);
               $("#limoInvoiceGrid").jqxGrid('deleterow', rowid);
           }
       });
       $("#limoInvoiceGrid").on('rowclick', function (event) {
           if (event.args.rightclick) {
               $("#limoInvoiceGrid").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
       });
       
       var rows=$("#limoInvoiceGrid").jqxGrid("getrows");
       if(rows.length==0){
    	   $("#limoInvoiceGrid").jqxGrid("addrow", null, {});   
       }
       

        });
    </script>
    <div id='jqxWidget'>
    <div id="limoInvoiceGrid"></div>
    <div id="popupWindow">
 <input type="hidden" name="gridindex" id="gridindex">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
