<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO();
String airportid=request.getParameter("airportid")==null?"":request.getParameter("airportid");
%>
 <script type="text/javascript">
var  data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var srvctarifdata= '<%=bookdao.getSrvcTarifData(airportid)%>';
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'doc_no', type: 'int'},
     						{name : 'greet', type: 'number'},
     						{name : 'vip',type:'number'},
     						{name : 'boque',type:'number'}
     											
                 ],               
               localdata:srvctarifdata,
                
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

            
            
            $("#srvcTarifSearch").jqxGrid(
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
                           	{ text:'Doc No',datafield:'doc_no',width:'25%'},	
							{ text:'Greet & Meet', datafield: 'greet', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text:'VIP', datafield: 'vip', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text:'Boque', datafield: 'boque', width: '25%',align:'right',cellsalign:'right',cellsformat:'d2'}
												
	              		]
            });
       
            $('#srvcTarifSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	if(data=="greettarifdocno"){
                	$("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "greettarifdocno", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
                    $("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "greettarif", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "greet"));	
            	}
            	else if(data=="viptarifdocno"){
                	$("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "viptarifdocno", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
                    $("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "viptarif", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "vip"));	
            	}
            	else if(data=="boquetarifdocno"){
                	$("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "boquetarifdocno", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
                    $("#otherSrvcGrid").jqxGrid('setcellvalue', gridrowindex, "boquetarif", $('#srvcTarifSearch').jqxGrid('getcellvalue', rowindex, "boque"));	
            	}
                $('#srvctarifwindow').jqxWindow('close');
       		});
            
        });
    </script>
    <div id="srvcTarifSearch"></div>
 
