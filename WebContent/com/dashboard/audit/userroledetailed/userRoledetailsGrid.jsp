<%@page import="com.dashboard.audit.userroledetailed.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urb=new ClsUserRoleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String roleId = request.getParameter("roleid")==null?"0":request.getParameter("roleid");%>
<% String rolleId = request.getParameter("rolleid")==null?"0":request.getParameter("rolleid");%>
<% String Id = request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">
        
    var data12;
        $(document).ready(function () { 	
        	 var temp='<%=roleId%>';
        	 var id='<%=Id%>';
        	 if(id==1){
        	 if(temp!=0)
           	 { 
        		 data12='<%=urb.UserRoleGridReloading(roleId,rolleId)%>'; 
        		 data13='<%=urb.UserRoleGridReloadingexcel(roleId,rolleId)%>';
        		 
           	 }
             else
             {
            	 data12='<%=urb.UserRoleGridLoading()%>';  
            	 data13='<%=urb.UserRoleGridLoadingexcel()%>';
             } 
        	 }
        	 else{
        		 data12='<%=urb.UserRoleGridLoadingg()%>';
        		 data13='<%=urb.UserRoleGridLoadinggexcel()%>';
        	 }
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'master', type: 'string'  },
     						{name : 'user_role', type: 'string'  },
     						{name : 'detail', type: 'string'   },
     						{name : 'permission', type: 'bool'  },
     						{name : 'mno', type: 'int'   },
     						{name : 'dno', type: 'int'  },
     						{name : 'email', type: 'string' },
     						{name : 'excel', type: 'string' }
                            ],
                            localdata: data12,
                
                
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
            
            $("#jqxUserRoledetails").jqxGrid({
            	width: '90%',
                height: 268,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                editable: true,
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxUserRoledetails').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxUserRoledetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'status' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxUserRoledetails").jqxGrid('addrow', null, {});
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
							{ text: 'Main', datafield: 'master', editable: false, width: '25%'},			
							{ text: 'Sub', datafield: 'detail', editable: false, width: '25%'},
							{ text: 'Status', datafield: 'permission', columntype: 'checkbox', width: '15%',cellsalign: 'center', align: 'center' },
							{ text: 'MNO', datafield: 'mno', hidden: true, width: '10%'},
							{ text: 'DNO', datafield: 'dno', hidden: true, width: '10%'},
							{ text: 'Email', datafield: 'email',columntype: 'checkbox', hidden: false, width: '10%'},
							{ text: 'Excel', datafield: 'excel', columntype: 'checkbox', width: '9%',cellsalign: 'center', align: 'center' },
			              ]
            });
            
            if(temp>0){
            //	$("#jqxUserRoledetails").jqxGrid('disabled', true);
            } 
            
        });
    </script>
    <div id="jqxUserRoledetails"></div>
 