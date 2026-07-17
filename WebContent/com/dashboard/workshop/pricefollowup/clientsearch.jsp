<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.dashboard.workshop.pricefollowup.ClsPriceFollowupDAO"%>
<%
ClsPriceFollowupDAO DAO= new ClsPriceFollowupDAO();
%>
       
<script type="text/javascript">
  
		var clientdata='<%=DAO.clentdetails()%>';
	
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientedsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc No', datafield: 'cldocno', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'refname', width: '100%' },
						]
            });
            
          $('#clientedsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("clientname").value=$('#clientedsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("cldocno").value=$('#clientedsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#clientwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="clientedsearch"></div>