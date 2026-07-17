<%@page import="com.dashboard.audit.userroledetailed.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urd=new ClsUserRoleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String roleId = request.getParameter("roleid")==null?"0":request.getParameter("roleid");%>

<% String rolleId = request.getParameter("rolleid")==null?"0":request.getParameter("rolleid");%>
<% String Id = request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">
        
    var data1;
        $(document).ready(function () { 	
        	 var temp='<%=roleId%>';
        	 
        	 var id='<%=Id%>';
        	 
        	 if(id==1){
        	 if(temp!=0)
           	 { 
        		 data1='<%=urd.userRoleGridReloading(roleId,rolleId)%>';
        		 data11='<%=urd.userRoleGridReloadingExcel(roleId,rolleId)%>';
           	 }
             else
             {
            	 data1='<%=urd.userRoleGridLoading()%>'; 
            	 data11='<%=urd.userRoleGridLoadingExcel()%>';
             } 
        	 }
        	 else{
        		 data1='<%=urd.userRoleGridLoadingg()%>';
        		 data1='<%=urd.userRoleGridLoadinggExcel()%>';
        	 }
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'menu_name', type: 'string'  },
     						{name : 'user_role', type: 'string'  },
     						{name : 'add1', type: 'bool'   },
     						{name : 'edit', type: 'bool'  },
     						{name : 'del', type: 'bool'   },
     						{name : 'print', type: 'bool'  },
     						{name : 'attach', type: 'bool'   },
     						{name : 'excel', type: 'bool'   },
     						{name : 'mno', type: 'int'  },
     						{name : 'email', type: 'int'  },
                            ],
                            localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxUserRole").jqxGrid({
            	width: '90%',
                height: 268,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                editable: true,
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxUserRole').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxUserRole').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'excel' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxUserRole").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                       
                columns: [							
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'User Role', datafield: 'user_role', editable: false, width: '23%'},
							{ text: 'Menu', datafield: 'menu_name', editable: false, width: '25%'},	
							
							{ text: 'Add', datafield: 'add1', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Edit', datafield: 'edit', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Delete', datafield: 'del', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Print', datafield: 'print', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Attach', datafield: 'attach', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Excel', datafield: 'excel', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'MNO', datafield: 'mno', hidden:true, width: '9%'},
							{ text: 'E-Mail', datafield: 'email',columntype: 'checkbox', hidden:false, width: '9%'},
							
			              ]
            });
            
            if(temp>0){
            //	$("#jqxUserRole").jqxGrid('disabled', true);
            } 
            
        });
    </script>
    <div id="jqxUserRole"></div>
 