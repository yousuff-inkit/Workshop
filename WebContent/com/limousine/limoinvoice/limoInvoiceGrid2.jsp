 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.limousine.limoinvoice.*" %>
<%
ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
String docno=request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>

<script type="text/javascript">
var amountdata=[];
var id='<%=id%>';
if(id=="1"){
	amountdata='<%=invoicedao.getInvoiceGridData(docno,id)%>';	
}
        $(document).ready(function () { 	

                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name:'guest',type:'string'},
                            {name:'guestno',type:'number'},
                            {name:'jobtype',type:'string'},
                            {name:'jobname',type:'string'},
                            {name:'jobnametemp',type:'string'},
                            {name:'jobdocno',type:'string'},
                            {name:'bookdocno',type:'string'},
                            {name:'tarif',type:'number'},
                            {name:'nighttarif',type:'number'},
                            {name:'excesskmchg',type:'number'},
                            {name:'excesshrchg',type:'number'},
                            {name:'excessnighthrchg',type:'number'},
                            {name:'fuelchg',type:'number'},
                            {name:'parkingchg',type:'number'},
                            {name:'otherchg',type:'number'},
                            {name:'greetchg',type:'number'},
                            {name:'vipchg',type:'number'},
                            {name:'boquechg',type:'number'},
                            {name:'total',type:'number'}
                 ],               
               localdata:amountdata,
               
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

            
            var jobtypelist=["Transfer","Limo"];
            $("#limoInvoiceGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                //showaggregates:true,
                //showstatusbar:true,
                //statusbarheight:25,
                //pageable: true,
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
                         var commit = $("#amountGrid").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#amountGrid").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#amountGrid").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#limoInvoiceGrid').jqxGrid('getselectedcell');
                   
					},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
               
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Guest',datafield:'guest',width:'10%'},
                            { text:'Guest No',datafield:'guestno',hidden:true},
                            { text: 'Job Type',datafield:'jobtype',width:'8%',columntype:'dropdownlist',
								
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: jobtypelist });
 								}
							},
                            { text: 'Job Name',datafield:'jobname',width:'8%',hidden:true},
                            { text: 'Job Doc No',datafield:'jobdocno',width:'20%',hidden:true},
                            { text: 'Book Docno',datafield:'bookdocno',width:'10%',hidden:true},
                            { text: 'Job Name',datafield:'jobnametemp',width:'6%'},
                            { text: 'Total', datafield: 'total', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right',editable:false},
                            { text: 'Rental', datafield: 'tarif', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Night Tarif', datafield: 'nighttarif', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right',cellbeginedit: function(row){
                            var jobtype=$('#limoInvoiceGrid').jqxGrid('getcellvalue',row,'jobtype');
                            if(jobtype=="Transfer"){
                            	return false;
                            }
                            else{
                            	return true;
                            }
                            }
                            },
                            { text: 'Excess Km Chg', datafield: 'excesskmchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Excess Hr Chg', datafield: 'excesshrchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Excess Night Hr chg', datafield: 'excessnighthrchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right',cellbeginedit: function(row){
                                var jobtype=$('#limoInvoiceGrid').jqxGrid('getcellvalue',row,'jobtype');
                                if(jobtype=="Transfer"){
                                	return false;
                                }
                                else{
                                	return true;
                                }
                                }
                                },
                            { text: 'Fuel Chg', datafield: 'fuelchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Parking Chg', datafield: 'parkingchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Other Chg', datafield: 'otherchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Greet Chg', datafield: 'greetchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'VIP Chg', datafield: 'vipchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Boque Chg',datafield: 'boquechg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'}
                            
	              ]
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
     			else if(event.args.datafield=='jobnametemp'){
     				var client=$('#hidclient').val();
     				if($('#client').val()==""){
     					$.messager.alert('warning','Client is mandatory');
     					return false;
     				}
     				var guest=$('#limoInvoiceGrid').jqxGrid('getcellvalue',row1,'guestno');
     				var jobtype=$('#limoInvoiceGrid').jqxGrid('getcellvalue',row1,'jobtype');
     				if(jobtype==null || jobtype=="" || jobtype=="undefined" || typeof(jobtype)=="undefined"){
     					$.messager.alert('warning','Job Type is mandatory');
     					return false;
     				}
     				if(guest==null || guest=="" || guest=="undefined" || typeof(guest)=="undefined"){
     					$.messager.alert('warning','Guest is mandatory');
     					return false;
     				}
     				else{
         				$('#jobwindow').jqxWindow('open');
         				$('#jobwindow').jqxWindow('focus');
         				jobSearchContent('jobSearchGrid.jsp?gridrowindex='+document.getElementById("gridindex").value+'&client='+client+'&guest='+guest+'&jobtype='+jobtype+'&id=1', $('#jobwindow'));     					
     				}

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
               
               $("#limoInvoiceGrid").on('cellvaluechanged', function (event) 
                       {
               
                       	var datafield = event.args.datafield;
               		    var rowindex = event.args.rowindex;
               	       
               		    if(datafield=="tarif" || datafield=="nighttarif" || datafield=="excesskmchg" || datafield=="excesshrchg" || 
               		    datafield=="excessnighthrchg" || datafield=="fuelchg" || datafield=="parkingchg" || datafield=="otherchg" || datafield=="greetchg" || 
               		    datafield=="vipchg" || datafield=="boquechg"){
               		    	var tarif=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'tarif');
               		    	var nighttarif=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'nighttarif');
               		    	var excesskmchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'excesskmchg');
               		    	var excesshrchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'excesshrchg');
               		    	var excessnighthrchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'excessnighthrchg');
               		    	var fuelchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'fuelchg');
               		    	var parkingchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'parkingchg');
               		    	var otherchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'otherchg');
               		    	var greetchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'greetchg');
               		    	var vipchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'vipchg');
               		    	var boquechg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',rowindex,'boquechg');
               		    	tarif=tarif=="undefined" || typeof(tarif)=="undefined" || tarif==null || tarif==""?0.0:tarif;
               		    	nighttarif=nighttarif=="undefined" || typeof(nighttarif)=="undefined" || nighttarif==null || nighttarif==""?0.0:nighttarif;
               		    	excesskmchg=excesskmchg=="undefined" || typeof(excesskmchg)=="undefined" || excesskmchg==null || excesskmchg==""?0.0:excesskmchg;
               		    	excesshrchg=excesshrchg=="undefined" || typeof(excesshrchg)=="undefined" || excesshrchg==null || excesshrchg==""?0.0:excesshrchg;
               		    	excessnighthrchg=excessnighthrchg=="undefined" || typeof(excessnighthrchg)=="undefined" || excessnighthrchg==null || excessnighthrchg==""?0.0:excessnighthrchg;
               		    	fuelchg=fuelchg=="undefined" || typeof(fuelchg)=="undefined" || fuelchg==null || fuelchg==""?0.0:fuelchg;
               		    	parkingchg=parkingchg=="undefined" || typeof(parkingchg)=="undefined" || parkingchg==null || parkingchg==""?0.0:parkingchg;
               		    	otherchg=otherchg=="undefined" || typeof(otherchg)=="undefined" || otherchg==null || otherchg==""?0.0:otherchg;
               		    	greetchg=greetchg=="undefined" || typeof(greetchg)=="undefined" || greetchg==null || greetchg==""?0.0:greetchg;
               		    	vipchg=vipchg=="undefined" || typeof(vipchg)=="undefined" || vipchg==null || vipchg==""?0.0:vipchg;
               		    	boquechg=boquechg=="undefined" || typeof(boquechg)=="undefined" || boquechg==null || boquechg==""?0.0:boquechg;
               		    	
               		 	var total=parseFloat(tarif)+parseFloat(nighttarif)+parseFloat(excesskmchg)+parseFloat(excesshrchg)+parseFloat(excessnighthrchg)+parseFloat(fuelchg)+parseFloat(parkingchg)+parseFloat(otherchg)+parseFloat(greetchg)+parseFloat(vipchg)+parseFloat(boquechg);
               		    $('#limoInvoiceGrid').jqxGrid('setcellvalue',rowindex,'total',total);
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

   