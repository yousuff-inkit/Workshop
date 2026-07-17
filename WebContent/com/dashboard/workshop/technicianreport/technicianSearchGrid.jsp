<%@page import="com.dashboard.workshop.technicianreport.*" %>
<% ClsTechnicianReportDAO DAO=new ClsTechnicianReportDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String techname = request.getParameter("technicianName")==null?"":request.getParameter("technicianName");
 String id = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
		var id='<%=id%>';
		var data4;
		if(id=='1'){
			 data4= '<%=DAO.technicianData(techname, id)%>';
		}else{
			data4=[];
		}
		
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'},
     						{name : 'name', type: 'string'}
                        ],
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#techSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
                          
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
							{ text: 'Doc No',  datafield: 'doc_no', width: '20%' },
							{ text: 'Technician', datafield: 'name', width: '75%' }
						]
            });
            
             $('#techSearchGrid').on('rowdoubleclick', function (event) {
            	var techindex=$('#techindex').val();
            	var rowindex1=event.args.rowindex;
            	document.getElementById("technician").value =$('#techSearchGrid').jqxGrid('getcellvalue',rowindex1,'name');
             	document.getElementById("techid").value =$('#techSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
            	$('#technicianToWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="techSearchGrid"></div>