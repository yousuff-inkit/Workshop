<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% ClsJobExecutionDAO DAO=new ClsJobExecutionDAO(); %>

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
							{ text: 'Doc No',  datafield: 'doc_no', width: '20%' },
							{ text: 'Technician', datafield: 'name', width: '80%' }
						]
            });
            
             $('#techSearchGrid').on('rowdoubleclick', function (event) {
            	var techindex=$('#techindex').val();
            	var rowindex1=event.args.rowindex;
            	$('#servicegrid2').jqxGrid('setcellvalue',techindex,'technician',$('#techSearchGrid').jqxGrid('getcellvalue',rowindex1,'name'));
            	$('#servicegrid2').jqxGrid('setcellvalue',techindex,'techno',$('#techSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
            	$('#TechnicianWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="techSearchGrid"></div>