<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO(); 
String airportindex=request.getParameter("airportindex")==null?"":request.getParameter("airportindex");
%>
 <script type="text/javascript">
var airportindex='<%=airportindex%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var airportdata= '<%=bookdao.getAirportData(airportindex)%>';
        $(document).ready(function () {
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'airport', type: 'string'},
     						{name : 'doc_no', type: 'int'}
     											
                 ],               
               localdata:airportdata,
                
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

            
            
            $("#airportSearch").jqxGrid(
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
							{ text: 'Airport', datafield: 'airport', width: '80%' }
	              		]
            });
       $('#airportSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	airportindex=document.getElementById("airportindex").value;
            	if(airportindex==""){
            		document.getElementById("airportindex").value=$('#airportSearch').jqxGrid('getcellvalue', rowindex, "doc_no");
            	}
            	else{
            		document.getElementById("airportindex").value+=","+$('#airportSearch').jqxGrid('getcellvalue', rowindex, "doc_no");
            	}
            		$("#extraSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "airport", $('#airportSearch').jqxGrid('getcellvalue', rowindex, "airport"));
            		$("#extraSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "airportid", $('#airportSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));		
            		$("#extraSrvcGrid").jqxGrid("addrow", null, {});
            		$('#airportwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="airportSearch"></div>
	 
