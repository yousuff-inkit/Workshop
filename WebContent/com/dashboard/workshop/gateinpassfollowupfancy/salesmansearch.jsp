<%@page import="com.dashboard.workshop.gateinpassfollowup.ClsGateInPassFollowupDAO"%>
<%
	ClsGateInPassFollowupDAO DAO= new ClsGateInPassFollowupDAO();
%>
       
<script type="text/javascript">
  
		var clientdata='<%=DAO.salesmandetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'salesman', type: 'string'  },
                            {name : 'salesmanid', type: 'string'  }
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesmansearch").jqxGrid(
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
                              { text: 'Doc No', datafield: 'salesmanid', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'salesman', width: '100%' },
						]
            });
            
          $('#salesmansearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("salesman").value=$('#salesmansearch').jqxGrid('getcellvalue', rowindex2, "salesman");
                document.getElementById("salid").value=$('#salesmansearch').jqxGrid('getcellvalue', rowindex2, "salesmanid");
               
                
                $('#salesmanwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="salesmansearch"></div>