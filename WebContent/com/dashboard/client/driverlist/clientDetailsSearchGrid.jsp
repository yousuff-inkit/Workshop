<%@ page import="com.dashboard.client.driverlist.ClsDriverList" %>
<% ClsDriverList cdl=new ClsDriverList();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
       var data1= '<%=cdl.clientDetailsSearch(clientname, contactNo,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'description', type: 'string'  },
     						{name : 'per_mob', type: 'int'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxClientSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Client Name', datafield: 'description', width: '70%' },
							{ text: 'Contact', datafield: 'per_mob', width: '30%' },
						]
            });
            
             $('#jqxClientSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcldocno").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtclientname").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "description");
    	       	
            	var rows = $('#addDriverGridID').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex2 = rowlength - 1;
          	    var name=$("#addDriverGridID").jqxGrid('getcellvalue', rowindex2, "name");
          	    if(typeof(name) != "undefined" && name != ""){
          	    	$("#addDriverGridID").jqxGrid('addrow', null, {});
          	    }
          	    
            	$('#clientDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxClientSearch"></div>
 