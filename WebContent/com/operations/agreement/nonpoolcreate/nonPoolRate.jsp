<%@page import="com.operations.agreement.nonpoolcreate.ClsNonPoolCreateDAO"%>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String closestatus=request.getParameter("closestatus")==null?"0":request.getParameter("closestatus").trim();
ClsNonPoolCreateDAO nonpooldao=new ClsNonPoolCreateDAO();
%>
<script type="text/javascript">
        $(document).ready(function () { 
        	var nonpoolratedata;

        	var num = 0; 
        	nonpoolratedata='<%=nonpooldao.getNonPoolAmounts(docno,closestatus)%>'; 
               
            // prepare the data
            
                   var rendererstring=function (aggregates){
                   	var value=aggregates['sum'];
                   	
                   	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
                   }
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'idno', type: 'string'  },
     						{name :'acno',type:'string'},
     						{name : 'description', type: 'string'   },
     						{name : 'qty',type:'String'},
     						{name :'amount',type:'number'}
                 ],
                 localdata: nonpoolratedata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            
            
            
            $("#nonPoolRateGrid").on("bindingcomplete", function (event) {
            	//var rowindex1=event.args.rowindex;
            	var defaultrow=$('#nonPoolRateGrid').jqxGrid('getcellvalue',0, "idno"); 
            	 if(document.getElementById("closestatus").value=="1" && (defaultrow=="undefined" || defaultrow=="" || defaultrow==null )){
            		 document.getElementById("btnGridEdit").disabled=false;
            		$('#nonPoolRateGrid').jqxGrid('disabled',true); 
            	 }
            	 else{
            		document.getElementById("btnGridEdit").disabled=true;
            		 $('#nonPoolRateGrid').jqxGrid('disabled',true); 
            	 }
            	});  
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#nonPoolRateGrid").jqxGrid(
            {
                width: '85%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                
                sortable: true,
                localization: {thousandsSeparator: ""},
                selectionmode: 'singlecell',
                pagermode: 'default',
                showaggregates:true,
                showstatusbar:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#nonPoolRateGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {                                                        
                        	document.getElementById("invmoderow").value=cell.rowindex;;              
                        	$('#invmodewindow').jqxWindow('open');
                      		$('#invmodewindow').jqxWindow('focus');
                       	  invmodeSearchContent('invmodeSearch.jsp?', $('#invmodewindow'));                    
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'ID',datafield:'idno',width:'10%',hidden:true},
							{ text: 'Ac No', datafield: 'acno', width: '25%',hidden:true},
							{ text: 'Description', datafield: 'description', width: '55%',editable:false},
							{ text: 'Quantity',datafield:'qty',width:'20%'},
							{ text: 'Amount',datafield:'amount',width:'20%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
			              ]
            });
            $("#nonPoolRateGrid").on("celldoubleclick", function (event) {
            	//alert("here");
                var row1=event.args.rowindex;
                //alert(row1);
                if(event.args.datafield=="description"){
					document.getElementById("invmoderow").value=row1;              
                	$('#invmodewindow').jqxWindow('open');
              		$('#invmodewindow').jqxWindow('focus');
               	  invmodeSearchContent('invmodeSearch.jsp?', $('#invmodewindow'));
                }
                });
            var rows=$("#nonPoolRateGrid").jqxGrid("getrows");
            if(rows.length==0){
            	$("#nonPoolRateGrid").jqxGrid("addrow", null, {});	
            }
            

        });
    </script>
    <div id="nonPoolRateGrid"></div>
    <input type="hidden" name="invmoderow" id="invmoderow">
