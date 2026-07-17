<%@page import="com.dashboard.workshop.partsmanagement.*" %>
<% CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String vndname = request.getParameter("vndname")==null?"0":request.getParameter("vndname");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");  %>
<script type="text/javascript">
        
        var data1;
        var chk=<%=chk%>
        if(chk==1){
        	
           data1= <%=partsdao.getVendorDeatils(vndname,chk)%>;
        }
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'vndocno', type: 'int'   },
							{name : 'acno', type: 'int'   },
							{name : 'vndname', type: 'string'},
							{name : 'tax', type: 'number'},
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vendorSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
                          
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
                          
							{ text: 'Doc No',  datafield: 'vndocno', hidden: false, width: '10%' },
							{ text: 'Accno',  datafield: 'acno', hidden: false, width: '10%' },
							{ text: 'Tax',  datafield: 'tax', hidden: true, width: '10%' },
							{ text: 'Vendor', datafield: 'vndname', width: '85%' },
						]
            });
            
             $('#vendorSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("vendorid").value = $('#vendorSearchGridID').jqxGrid('getcellvalue', rowindex1, "vndocno");
                document.getElementById("vendor").value = $('#vendorSearchGridID').jqxGrid('getcellvalue', rowindex1, "vndname"); 
                document.getElementById("vendtax").value = $('#vendorSearchGridID').jqxGrid('getcellvalue', rowindex1, "tax");
                document.getElementById("vendacno").value = $('#vendorSearchGridID').jqxGrid('getcellvalue', rowindex1, "acno");
            	$('#vendorToWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="vendorSearchGridID"></div>
 