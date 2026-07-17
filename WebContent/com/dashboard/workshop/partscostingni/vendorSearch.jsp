<%@page import="com.dashboard.workshop.partscosting.ClsPartsCostingDAO"%>
<%
	ClsPartsCostingDAO DAO= new ClsPartsCostingDAO();
String index=request.getParameter("index")==null?"":request.getParameter("index");
%>
       
<script type="text/javascript">
  
		var clientdata='<%=DAO.vendorDetails()%>';
		var index='<%=index%>';
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
            
            $("#vendorsearch").jqxGrid(
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
            
          $('#vendorsearch').on('rowdoubleclick', function (event) {
           
                var rowindex1 = event.args.rowindex;
                $('#partsGridId').jqxGrid('setcellvalue',index,'vendor',$('#vendorsearch').jqxGrid('getcellvalue',rowindex1,'refname'));
                $('#partsGridId').jqxGrid('setcellvalue',index,'vndno',$('#vendorsearch').jqxGrid('getcellvalue',rowindex1,'cldocno'));
               
                
                $('#vendorwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="vendorsearch"></div>