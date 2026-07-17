<%@page import="com.limousine.extraservicetarif.*" %>
<%ClsExtraSrvcTarifDAO extradao=new ClsExtraSrvcTarifDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
 <script type="text/javascript">
 var id='<%=id%>';
 var srvcdata;
 if(id=="1"){
	 srvcdata='<%=extradao.getGridData(docno,id)%>';
 }

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'airport', type: 'string'},
     						{name : 'airportid',type:'string'},
     						{name : 'viprate',type:'number'},
     						{name : 'greetrate',type:'number'},
     						{name : 'boquerate',type:'number'}
     											
                 ],               
               localdata:srvcdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#extraSrvcGrid").on("bindingcomplete", function (event) {
            	// your code here.
            var mode=document.getElementById("mode").value;
            if(mode=="view"){
            	var rows=$('#extraSrvcGrid').jqxGrid('getrows');
            	for(var i=0;i<rows.length;i++){
            		if(i==0){
            			document.getElementById("airportindex").value=$('#extraSrvcGrid').jqxGrid('getcellvalue', i, "airportid");
            		}
            		else{
            			document.getElementById("airportindex").value+=","+$('#extraSrvcGrid').jqxGrid('getcellvalue', i, "airportid");
            		}
            	}
            }
            	
            });
            
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

            
            
            $("#extraSrvcGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
             //   showfilterrow: true,
               // filterable: true, 
               // sortable: true,
               disabled:true,
               editable:true,
                selectionmode: 'singlecell',
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
							{ text: 'Airport', datafield: 'airport', width: '40%',editable:false },
							{ text: 'Airport Id', datafield: 'airportid', width: '80%',hidden:true },
							{ text: 'Greet & Meet', datafield: 'greetrate', width: '20%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true },
							{ text: 'VIP', datafield: 'viprate', width: '20%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true },
							{ text: 'Boque', datafield: 'boquerate', width: '20%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true }
	              		]
            });
       $('#extraSrvcGrid').on('celldoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	var dataField = event.args.datafield;
            	if(dataField=="airport"){
            		document.getElementById("gridrowindex").value=rowindex;
            		$('#airportwindow').jqxWindow('open');
					$('#airportwindow').jqxWindow('focus');
					airportSearchContent('airportSearchGrid.jsp?gridrowindex='+document.getElementById("gridrowindex").value+'&airportindex='+document.getElementById("airportindex").value, $('#airportwindow'));
   		
            	}
                });
            
        });
    </script>
    <div id="extraSrvcGrid"></div>
 <input type="hidden" name="gridrowindex" id="gridrowindex">
<input type="hidden" name="airportindex" id="airportindex">