<%@page import="com.dashboard.audit.userroledetailed.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urb=new ClsUserRoleDAO(); %>

<script type="text/javascript">
        
   var data= '<%=urb.userNameSearch()%>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'role_id', type: 'int'   },
                            {name : 'doc_no', type: 'int'   },
                            {name : 'user_name', type: 'String'   },
     						{name : 'user_role', type: 'string'   }
                        ],
                		localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxNameSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Role Id', datafield: 'role_id', width: '20%' },
							{ text: 'User Name', datafield: 'user_name', width: '80%' },
							/* { text: 'User Role', datafield: 'user_role', width: '300%' }, */
						]
            });
            
             $('#jqxNameSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtrolleid").value = $('#jqxNameSearch').jqxGrid('getcellvalue', rowindex1, "role_id");
                document.getElementById("txtusername").value = $('#jqxNameSearch').jqxGrid('getcellvalue', rowindex1, "user_name");
                document.getElementById("txtrolename").value = $('#jqxNameSearch').jqxGrid('getcellvalue', rowindex1, "user_role");
                document.getElementById("txtroleid").value = $('#jqxNameSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

              $('#userRoleDetailsWindow').jqxWindow('close');  
            });  
        });
    </script>
    <div id="jqxNameSearch"></div>
 