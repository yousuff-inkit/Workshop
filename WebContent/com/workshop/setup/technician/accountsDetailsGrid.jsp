<%@page import="com.workshop.setup.technician.ClsTechnicianDAO" %>
<%ClsTechnicianDAO dao=new ClsTechnicianDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); 
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var accdata= '<%=dao.accountDetails( accNo, partyname, contactNo,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'  },
     						{name : 'per_mob', type: 'int'   },
                        ],
                		 localdata: accdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsTypeFromSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Acc Doc No',  datafield: 'doc_no', hidden: false, width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '60%' },
							{ text: 'Contact', datafield: 'per_mob', width: '20%' },
						]
            });
            
            //Add empty row
      	    $("#jqxAccountsTypeFromSearch").jqxGrid('addrow', null, {});   
            
             $('#jqxAccountsTypeFromSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;  
                document.getElementById("accountno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("accountname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
            	document.getElementById("hidaccdocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxAccountsTypeFromSearch"></div>
 