<%@page import="com.dashboard.workshop.vehiclehistory.ClsVehicleHistoryDAO"%>
<%
ClsVehicleHistoryDAO DAO= new ClsVehicleHistoryDAO();
%>
       
<script type="text/javascript">
  
		var clientdata='<%=DAO.regnodetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'regno', type: 'string'  },
                            {name : 'pltid', type: 'string'  },
                            {name : 'clientinfo', type: 'string'  },
                            {name : 'refname', type: 'string'  },
                            {name : 'mobile', type: 'string'  },
                            {name : 'other', type: 'string'  },
                            {name : 'brand',type:'string'},
                            {name : 'model',type:'string'}
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#regsearch").jqxGrid(
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
                              { text: 'Reg No.', datafield: 'regno', width: '10%' },
                              { text: 'plate Code', datafield: 'pltid', width: '10%' },
                              { text: 'Client', datafield: 'refname', width: '20%' },
                              { text: 'Mobile', datafield: 'mobile', width: '15%' },
                              { text: 'Chasis No.', datafield: 'other', width: '15%' },
                              { text: 'Brand', datafield: 'brand', width: '15%' },
                              { text: 'Model', datafield: 'model', width: '15%' },
                              { text: 'Client Info', datafield: 'clientinfo', hidden:true, width: '10%' },
						]
            });
            
          $('#regsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("regno").value=$('#regsearch').jqxGrid('getcellvalue', rowindex2, "regno");
                document.getElementById("txtpltid").value=$('#regsearch').jqxGrid('getcellvalue', rowindex2, "pltid");
                var values= $('#regsearch').jqxGrid('getcellvalue',rowindex2, "clientinfo");
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("clientinfo").value=sum2;
               
                
                $('#regwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="regsearch"></div>