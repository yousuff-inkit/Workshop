<%@page import="com.dashboard.employee.workdetails.ClsWorkDetails" %>
<%ClsWorkDetails cwd=new ClsWorkDetails(); %>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String project = request.getParameter("project")==null?"0":request.getParameter("project").trim();
String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
			 
<style type="text/css">
        .salesManClass
        {
            background-color: #FFEBEB;
        }
        .salesAgentClass
        {
            background-color: #FFFFD1;
        }
        .rentalAgentClass
        {
           background-color: #FFFAFA;
        }
         .driverClass
        {
           background-color: #F0FFFF;
        }
         .staffClass
        {
           background-color: #F8E0F7;
        }
         .checkInClass
        {
           background-color: #F7F2E0;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">
	  	var data;  
	  	var temp='<%=check%>';
	  	
	  	if(temp=='1'){
	  		data='<%=cwd.workDetailsGridLoading(branchval, fromdate, todate, project, employee, type)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	$("#btnExcel").click(function() {
    			$("#workDetails").jqxGrid('exportdata', 'xls', 'workDetails');
    		});
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'date' , type: 'date' },
					{ name: 'form_name', type: 'String' },
					{ name: 'detail', type: 'String' },
                    { name: 'correctiontype', type: 'String' },
                    {name : 'start_date' , type: 'date' },
                    {name : 'end_date' , type: 'date' },
                    { name: 'emp_name', type: 'String' },
                    { name: 'correction_type', type: 'int' }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.correction_type == '1') {
                    return "salesManClass";
                } else if (data.correction_type == '2') {
                    return "salesAgentClass";
                } else if (data.correction_type == '3') {
                    return "rentalAgentClass";
                }  else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#workDetails").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Date', datafield: 'date', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '7%' },
						{ text: 'Form Name', datafield: 'form_name', cellclassname: cellclassname, width: '15%' },
						{ text: 'Detail', datafield: 'detail', cellclassname: cellclassname, width: '30%' },
						{ text: 'Type', datafield: 'correctiontype', cellclassname: cellclassname, width: '10%' },
						{ text: 'Start Date', datafield: 'start_date', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '7%' },
						{ text: 'End Date', datafield: 'end_date', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '7%' },
	                    { text: 'Employee', datafield: 'emp_name', cellclassname: cellclassname, width: '24%' },
	                    { text: 'Correction Type', datafield: 'correction_type', hidden: true, width: '10%' },
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="workDetails"></div>
