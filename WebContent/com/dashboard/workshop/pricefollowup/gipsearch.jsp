<%@page import="com.dashboard.workshop.pricefollowup.ClsPriceFollowupDAO"%>
<%
ClsPriceFollowupDAO DAO= new ClsPriceFollowupDAO();
%>
       
<script type="text/javascript">
  
		var gipdata='<%=DAO.gipdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'refname', type: 'string'  }
                        ],
                 	localdata: gipdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#gipsearch").jqxGrid(
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
                              { text: 'Doc No', datafield: 'doc_no', width: '20%'},
                              { text: 'Client', datafield: 'refname', width: '100%'},
						]
            });
            
          $('#gipsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("gipno").value=$('#gipsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
               
                
                $('#gipwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="gipsearch"></div>