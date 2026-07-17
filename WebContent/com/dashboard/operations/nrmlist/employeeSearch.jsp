<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.nrmlist.*" %>
 <%
 ClsNrmListDAO nrmdao=new ClsNrmListDAO();
 String emptype = request.getParameter("emptype")==null?"":request.getParameter("emptype");
%> 
<script type="text/javascript">

	var empdata= '<%=nrmdao.employeeSearch(emptype)%>'; 
      
		$(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'String' },
     						{name : 'employee',type:'String'},
     						{name : 'code',type:'String'}
                 ],
                localdata: empdata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#employeeSearch").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text:'Doc No',datafield:'doc_no',width:'10%'},
							{ text: 'Code', datafield: 'code', width: '15%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Employee', datafield: 'employee', width: '75%' }
							]
            });
           
           $('#employeeSearch').on('rowdoubleclick',function(event){
            	var rowindex1=event.args.rowindex;
            	document.getElementById("employee").value=$('#employeeSearch').jqxGrid('getcellvalue', rowindex1, "employee");
            	document.getElementById("hidemployee").value=$('#employeeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	$('#employeewindow').jqxWindow('close');
               
            }); 
        });
    </script>
    <div id="employeeSearch"></div>
