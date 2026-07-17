<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO limodao=new ClsLimoBookingDAO(); %>
 <script type="text/javascript">
var  data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var branddata= '<%=limodao.getBrandData()%>';

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'brand', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:branddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage").css("display", "none"); 
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#brandSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'doc_no',width:'20%'},	
							{ text: 'Brand', datafield: 'brand', width: '80%' }
												
	              		]
            });
       $('#brandSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "brand", $('#brandSearch').jqxGrid('getcellvalue', rowindex, "brand"));
                	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "brandid", $('#brandSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));	
            	
                $('#brandwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="brandSearch"></div>
 
