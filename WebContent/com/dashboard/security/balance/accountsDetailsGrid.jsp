<%@page import="com.dashboard.security.ClsSecurity" %>
<%ClsSecurity cs=new ClsSecurity();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo"); %>
<script type="text/javascript">
        
       var data1= '<%=cs.clientDetailsSearch(accNo, partyname, contactNo)%>';  
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
     						{name : 'cldocno', type: 'int'   }
                        ],
                		 localdata: data1,
                
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
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '60%' },
							{ text: 'Contact', datafield: 'per_mob', width: '20%' },
							{ text: 'Cldocno',  datafield: 'cldocno', hidden:true, width: '5%' },
						]
            });
            
            //Add empty row
      	    $("#jqxAccountsTypeFromSearch").jqxGrid('addrow', null, {});   
            
             $('#jqxAccountsTypeFromSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcldocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtclientaccount").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("txtclientname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
    	       	
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxAccountsTypeFromSearch"></div>
 