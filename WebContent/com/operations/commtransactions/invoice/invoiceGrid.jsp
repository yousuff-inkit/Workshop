<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
	String docno=request.getParameter("docno");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();
%>

 <script type="text/javascript">
        
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
        	var invoicedata;
        	if(document.getElementById("docno").value>0){
        		invoicedata='<%=invdao.getInvoiceGridData(branch,docno)%>';	
        	}
        
           // alert("Grid Data"+invoicedata); 
        	var num = 1; 
                var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + ': ' + value + '</div>';
                }
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                             {name :'idno',type:'number'},
     						{name : 'account', type: 'string'  },
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'String'    },
     						{name : 'rate', type: 'number'    },
     						{name : 'total', type: 'number'    }
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

            
            
            $("#jqxManualInvoice").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
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
                    var cell = $('#jqxManualInvoice').jqxGrid('getselectedcell');
                  /*   if (cell != undefined && cell.datafield == 'total' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#jqxManualInvoice").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#jqxManualInvoice").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#jqxManualInvoice").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#jqxManualInvoice').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'account') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("invoicerow").value=cell1.rowindex;
                        	$('#jqxManualInvoice').jqxGrid('clearselection'); 
                        	$('#jqxManualInvoice').jqxGrid('render');
                        	$('#accountwindow').jqxWindow('open');
        					$('#accountwindow').jqxWindow('focus');
        					 accountSearchContent('accountSearchGrid.jsp?', $('#accountwindow'));
                          }
                        
                    }
},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                             {text: 'ID',datafield:'idno',width:'20%',hidden:true},					
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Description', datafield: 'description', width: '40%' },
							{ text: 'Quantity', datafield: 'qty', width: '15%' },
							{ text: 'Rate', datafield: 'rate', width: '10%' ,cellsalign:'right',cellsformat:'D2'},
							{ text: 'Total', datafield: 'total', width: '10%',cellsalign:'right',cellsformat:'D2',aggregates: ['sum'],aggregatesrenderer:rendererstring
			                  }
	              ]
            });
       $('#jqxManualInvoice').on('celldoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   document.getElementById("invoicerow").value=row1;
    	   $('#jqxManualInvoice').jqxGrid('clearselection');
				if(event.args.datafield=='account'){
					if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
						return false;
					}
				
					$('#jqxManualInvoice').jqxGrid('render');
				    $('#accountwindow').jqxWindow('open');
					$('#accountwindow').jqxWindow('focus');
					
					accountSearchContent('accountSearchGrid.jsp?', $('#accountwindow'));
				}
				
                });
       $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#jqxManualInvoice").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#jqxManualInvoice").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#jqxManualInvoice").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#jqxManualInvoice").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#jqxManualInvoice").jqxGrid('getrowid', rowindex);
               $("#jqxManualInvoice").jqxGrid('deleterow', rowid);
           }
       });
       $("#jqxManualInvoice").on('rowclick', function (event) {
           if (event.args.rightclick) {
		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
               $("#jqxManualInvoice").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
		   }
       });
       
       var rows=$("#jqxManualInvoice").jqxGrid("getrows");
       if(rows.length==0){
    	   $("#jqxManualInvoice").jqxGrid("addrow", null, {});   
       }
       

        });
    </script>
    <div id='jqxWidget'>
    <div id="jqxManualInvoice"></div>
    <div id="popupWindow">
 <input type="hidden" name="invoicerow" id="invoicerow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
