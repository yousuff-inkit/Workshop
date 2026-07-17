<%@page import="com.dashboard.workshop.materialissue.ClsMaterialIssueDAO"%>
<%
ClsMaterialIssueDAO searchDAO = new ClsMaterialIssueDAO();
String id = request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var techsearchdata=[];
if(id=="1"){
	techsearchdata='<%=searchDAO.getTechnician(id)%>';
}
$(document).ready(function () { 

            // prepare the data
            var source =
            {                            
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'   },
                            {name : 'name', type: 'string'   }
                        ],
                		localdata: techsearchdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#technicianSearchGrid").jqxGrid(
            {
            	  width: '99.5%',
                height: '390',
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                sortable:true,
                filterable:true,
                showfilterrow:true,
                columns: [
                          
                            { text: 'Doc No', datafield: 'doc_no', width: '15%'},
                            { text: 'Name', datafield: 'name', width: '85%' }
							 
						]
            });
           
             $('#technicianSearchGrid').on('rowdoubleclick', function (event) {
             	var rowindex1 = event.args.rowindex;
           	 	$('#technician').val($('#technicianSearchGrid').jqxGrid('getcellvalue', rowindex1, "name"));
        	 	$('#hidtechnician').val($('#technicianSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        	 	$('#techniciansearchwindow').jqxWindow('close');
            }); 
             
             
             $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="technicianSearchGrid"></div>
    </body>
</html>
