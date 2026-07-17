<%@page import="com.dashboard.employee.workdetails.ClsWorkDetails" %>
<%ClsWorkDetails cwd=new ClsWorkDetails(); %>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String project = request.getParameter("project")==null?"0":request.getParameter("project");
 %> 

 <script type="text/javascript">
 
	var data1='<%=cwd.empNameLoading(project)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'name', type: 'string'   }
                    ],
            		localdata: data1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#employeeSearch").jqxGrid(
        {
        	width: '100%',
        	height: 357,
            source: dataAdapter,
            selectionmode: 'singlerow',
            showfilterrow: true, 
            filterable: true, 
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{  text: 'No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						   }  
						},  
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Name', datafield: 'name', width: '90%' },
					]
        });
        
	        $('#employeeSearch').on('rowdoubleclick', function (event) {
	            var rowindex1 = event.args.rowindex;
	        	document.getElementById("txtemployee").value = $('#employeeSearch').jqxGrid('getcellvalue', rowindex1, "name");
	        	
	            $('#employeeDetailsWindow').jqxWindow('close');  
	        });  
    });
</script>

<div id="employeeSearch"></div>
    