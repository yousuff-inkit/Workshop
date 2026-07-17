<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% ClsJobExecutionDAO DAO=new ClsJobExecutionDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String bayname = request.getParameter("bayName")==null?"":request.getParameter("bayName");
 String id = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
	var data1;
	var id='<%=id%>';
	
		if(id=='1'){
      		data1= '<%=DAO.bayData(bayname, id)%>';
		}else{
			data1=[];
		}
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
							{name : 'code', type: 'String'},
     						{name : 'name', type: 'string'},
							{name : 'doc_no', type: 'string'},
							{name : 'bayno', type: 'string'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#baySearchGrid").jqxGrid(
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
                          
							{ text: 'Code',  datafield: 'code', width: '20%' },
							{ text: 'Bay', datafield: 'name', width: '75%' },
							{ text: 'Docno', datafield: 'doc_no', width: '75%',hidden:true },
							{ text: 'bayno', datafield: 'bayno', width: '75%',hidden:true }
						]
            });
            
             $('#baySearchGrid').on('rowdoubleclick', function (event) {
               
            	var techindex=$('#techindex').val();
             	var rowindex1=event.args.rowindex;
             	$('#servicegrid2').jqxGrid('setcellvalue',techindex,'bay',$('#baySearchGrid').jqxGrid('getcellvalue',rowindex1,'name'));
             	$('#servicegrid2').jqxGrid('setcellvalue',techindex,'bayno',$('#baySearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
             	$('#bayWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="baySearchGrid"></div>