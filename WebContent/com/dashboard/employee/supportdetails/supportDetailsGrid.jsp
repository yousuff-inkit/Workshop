<%@page import="com.dashboard.employee.supportdetails.ClsSupportDetails" %>
<%ClsSupportDetails csd=new ClsSupportDetails(); %>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String company = request.getParameter("company")==null?"0":request.getParameter("company").trim();
	 String userid = request.getParameter("userid")==null?"0":request.getParameter("userid").trim();
	 String action = request.getParameter("action")==null?"0":request.getParameter("action").trim();
	 String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();
	 String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	 String support = request.getParameter("support")==null?"0":request.getParameter("support").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
						 
<style type="text/css">
        .openClass
        {
            background-color: #FFEBEB;
        }
        .pendingClass
        {
            background-color: #FFFFD1;
        }
        .closedClass
        {
           background-color: #D8F6CE;
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
	  		data='<%=csd.supportDetailsGridLoading(branchval, fromdate, todate, company, userid, action, status, category, support)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	$("#btnExcel").click(function() {
    			$("#supportDetails").jqxGrid('exportdata', 'xls', 'SupportDetails');
    		});
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name : 'date' , type: 'date' },
					{ name: 'time', type: 'String' },
					{ name: 'companycode', type: 'String' },
                    { name: 'user', type: 'String' },
                    { name : 'issue_category' , type: 'String' },
                    { name : 'issue_description' , type: 'String' },
                    { name: 'actionname', type: 'String' },
                    { name: 'remarks', type: 'String' },
                    { name: 'status', type: 'String' },
                    { name: 'supportname', type: 'String' },
                    { name: 'issue_status', type: 'int' }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.issue_status == '1') {
                    return "openClass";
                } else if (data.issue_status == '2') {
                    return "pendingClass";
                } else if (data.issue_status == '0') {
                    return "closedClass";
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
            
            $("#supportDetails").jqxGrid(
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
						{ text: 'Time', datafield: 'time', cellclassname: cellclassname, width: '5%' },
						{ text: 'Company', datafield: 'companycode', cellclassname: cellclassname, width: '10%' },
						{ text: 'User', datafield: 'user', cellclassname: cellclassname, width: '16%' },
						{ text: 'Category', datafield: 'issue_category', cellclassname: cellclassname, width: '8%' },
						{ text: 'Issue Description', datafield: 'issue_description', cellclassname: cellclassname, width: '35%' },
	                    { text: 'Action Taken', datafield: 'actionname', cellclassname: cellclassname, width: '16%' },
	                    { text: 'Remarks', datafield: 'remarks', cellclassname: cellclassname, width: '35%' },
	                    { text: 'Status', datafield: 'status', cellclassname: cellclassname, width: '10%' },
	                    { text: 'Support', datafield: 'supportname', cellclassname: cellclassname, width: '16%' },
	                    { text: 'Status Id', datafield: 'issue_status', hidden:true, width: '10%' },
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="supportDetails"></div>
