<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.vehicletransactions.quickserviceupdate.ClsQuickServiceUpdateDAO"%>
<%String docno=request.getParameter("docno");
ClsQuickServiceUpdateDAO updatedao=new ClsQuickServiceUpdateDAO();
%>
<script type="text/javascript">

$(document).ready(function () { 
	var temp2='<%=docno%>';
	var dataservice;
	if(temp2>0){
		
		 dataservice='<%=updatedao.loadServiceData(docno)%>';
}
	//else{
		<%-- datatarif='<%=com.controlcentre.masters.tarifmgmt.ClsTarifDAO.getNewRegular()%>'; --%>
//	}

	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         }

         var num = 1; 
         var rendererstring=function (aggregates){
            	var value=aggregates['sum'];
            	
            	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
            }
        var source =
           {
           datatype: "json",
           datafields: [
                       	{name : 'fleetno' , type: 'string' },
                       	{name : 'flname' , type:'number'},
                       	{name : 'washing' , type:'string'},
                       	{name : 'currentkm' , type:'string'},
                       	{name : 'nextduekm' , type:'number'},
                       	{name : 'servicedate' , type:'date'},
                       	{name : 'partscost' , type:'number'},
                       	{name : 'labourcost' , type:'number'},
                       	{name : 'total' , type:'number'} 
                       	
     				   ],
					localdata:dataservice,
                
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
            
            $("#gridService").jqxGrid(
            {
               width: '100%',
               height: 250,
               source: dataAdapter,
               columnsresize: true,
               rowsheight:20,
               //disabled:true,
               pagesize: 25,
               pagesizeoptions: ['20', '25', '50'],
               pageable: false,
               editable:false,
               //sortable: true,
               localization: {thousandsSeparator: ""},
               selectionmode: 'singlecell',
               pagermode: 'default',
               showaggregates:true,
               showstatusbar:true,
               statusbarheight:25,
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
                 },
            
               
                columns: [
                      		{ text: 'Fleet No', datafield: 'fleetno', width:'10%'},
							{ text: 'Fleet Name',  datafield: 'flname',width:'20%'},
							{ text: 'Washing',  datafield: 'washing',width:'10%'},
							{ text: 'KM',  datafield: 'currentkm',renderer: columnsrenderer,cellsalign:'right',width:'10%'},
							{ text: 'Next Due KM',  datafield: 'nextduekm',renderer: columnsrenderer,cellsalign:'right',width:'10%'},
							{ text: 'Service Date',  datafield: 'servicedate',renderer: columnsrenderer,cellsformat: 'dd.MM.yyyy',cellsalign:'right',width:'10%'},
							{ text: 'Parts',  datafield: 'partscost',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,width:'10%'},
							{ text: 'Labour',  datafield: 'labourcost',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,width:'10%'},
							{ text: 'Total',  datafield: 'total',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,width:'10%'}
						
         	              ]
           
            });
            var rows=$("#gridService").jqxGrid("getrows");
            var rowlength=rows.length;
            if(rowlength==0){
                 $("#gridService").jqxGrid("addrow", null, {});
            }
});
            </script>
            <div id="gridService"></div>