<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% ClsJobExecutionDAO DAO=new ClsJobExecutionDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partname = request.getParameter("partName")==null?"":request.getParameter("partName");
 String partno = request.getParameter("partNo")==null?"":request.getParameter("partNo");

 String id = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
		var id='<%=id%>';
		var data4;
		if(id=='1'){
			 data4= '<%=DAO.partNoData(partname,partno,id)%>';
		}else{
			data4=[];
		}
		
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'part_no', type: 'String'},
     						{name : 'productname', type: 'string'}
                        ],
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#partNoSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Sr.No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
							{ text: 'Part No',  datafield: 'part_no', width: '20%' },
							{ text: 'Spare Part', datafield: 'productname', width: '75%' }
						]
            });
            
             $('#partNoSearchGrid').on('rowdoubleclick', function (event) {
            	var techindex=$('#techindex').val();
            	var rowindex1=event.args.rowindex;
            	$('#partsgrid3').jqxGrid('setcellvalue',techindex,'part',$('#techSearchGrid').jqxGrid('getcellvalue',rowindex1,'name'));
            	$('#TechnicianWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="partNoSearchGrid"></div>