   <%@page import="com.dashboard.workshop.partsmanagement.*"%>
<%
CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();
%>
<% String trdocno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();%>
 <script type="text/javascript">
 var data1 ='<%=partsdao.loadfollowupGridData(trdocno) %>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'date', type: 'date' },
     						{name : 'status', type: 'String'},
     						{name : 'remarks', type: 'String'},
     						{name : 'rowno' , type : 'number'}
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#amcfollowupGrid").jqxGrid({ 
            	width: '99%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Status', datafield: 'status', width: '18%' },
							{ text: 'rowno', datafield: 'rowno', width: '10%',hidden:true,cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remarks', width: '80%' },
					]
            });
         
           
        });
                       
</script>
<div id="amcfollowupGrid"></div>