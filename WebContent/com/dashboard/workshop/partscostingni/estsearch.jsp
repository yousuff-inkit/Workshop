<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="com.dashboard.workshop.partscosting.ClsPartsCostingDAO"%>
<%
	ClsPartsCostingDAO DAO= new ClsPartsCostingDAO();
%>
       
<script type="text/javascript">
  
		var clientdata='<%=DAO.estDetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'voc_no', type: 'number'}
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#estsearch").jqxGrid(
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
                              { text: 'Doc No', datafield: 'docno', width: '20%',hidden:true},
                              { text: 'Voucher No', datafield: 'voc_no', width: '100%' },
						]
            });
            
          $('#estsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("estimation").value=$('#estsearch').jqxGrid('getcellvalue', rowindex2, "voc_no");
                document.getElementById("estno").value=$('#estsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
                
                $('#estwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="estsearch"></div>