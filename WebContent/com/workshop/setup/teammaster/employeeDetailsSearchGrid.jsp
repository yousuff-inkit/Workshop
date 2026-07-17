<%@page import="com.workshop.setup.teammaster.*"%>
<%ClsTeamMasterDAO DAO= new ClsTeamMasterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno"); 
 String rownindex = request.getParameter("rownindex")==null?"0":request.getParameter("rownindex");
 %>
<script type="text/javascript">
        
       var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno)%>';
       var rownindex="<%=rownindex%>";
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'name', type: 'string'   },
     						{name : 'mobile', type: 'string'  },
     						{name : 'doc_no', type: 'int'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', width: '20%' },
							{ text: 'Technician Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'mobile', width: '20%' },
							
						]
            });
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {

                var rowindex1 = event.args.rowindex;
                $('#serviceteamGrid').jqxGrid('setcellvalue', rownindex, "empid", $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                $('#serviceteamGrid').jqxGrid('setcellvalue', rownindex, "empname", $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name"));
                //$('#serviceteamGrid').jqxGrid('setcellvalue', rownindex, "empcode", $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "codeno"));
            	
    	       	
            	$('#employeeDetailsWindow').jqxWindow('close'); 
           
            	if(document.getElementById("ismemp").checked==true)
            	{
            		document.getElementById("ismultiemp").value=1;
            	$("#serviceteamGrid").jqxGrid('addrow', null, {});
            	}
            });  
        });
    </script>
    <div id="employeeDetailsSearch"></div>
 