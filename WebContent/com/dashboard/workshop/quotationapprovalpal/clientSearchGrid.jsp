<%@page import="com.dashboard.workshop.quotationapprovalpal.*" %>
<% ClsQuotationApprovalDAO qadao=new ClsQuotationApprovalDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");  %>
<script type="text/javascript">
        
        var data1;
        var chk=<%=chk%>
        if(chk==1){
        	
           data1= '<%=qadao.clientDetailsGridReloading(clname,chk)%>';
        }
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'   },
     						{name : 'clname', type: 'string'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
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
                          
							{ text: 'Doc No',  datafield: 'cldocno', hidden: false, width: '10%' },
							{ text: 'Client', datafield: 'clname', width: '85%' },
						]
            });
            
             $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("cldocnos").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("clnames").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "clname"); 
                
            	$('#ClientDetailsToWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientSearchGridID"></div>
 