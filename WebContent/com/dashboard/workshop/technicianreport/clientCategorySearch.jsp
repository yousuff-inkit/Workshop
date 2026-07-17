<%@page import="com.dashboard.workshop.technicianreport.*" %>
<% ClsTechnicianReportDAO DAO=new ClsTechnicianReportDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<script type="text/javascript">
		
		var data2;
			 data2= '<%=DAO.getClientCategory()%>';
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'},
     						{name : 'cat_name', type: 'string'}
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#categorySearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                          
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
							{ text: 'Doc No',  datafield: 'doc_no', width: '20%',hidden:true },
							{ text: 'Category', datafield: 'cat_name', width: '94%' }
						]
            });
            
             $('#categorySearchGrid').on('rowdoubleclick', function (event) {
            	 var rowindex2 = event.args.rowindex;
            	 document.getElementById("clcatid").value=$('#categorySearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	 document.getElementById("clientcat").value=$('#categorySearchGrid').jqxGrid('getcellvalue', rowindex2, "cat_name");
            	 $('#categoryToWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="categorySearchGrid"></div>