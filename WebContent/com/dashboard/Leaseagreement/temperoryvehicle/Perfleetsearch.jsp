<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO clad=new ClsleaseagreementDAO(); %>

 <%
 
String doc_no = request.getParameter("doc_no")==null?"0":request.getParameter("doc_no");
 %>
<script type="text/javascript">


var flsearch='<%=clad.searchperfleet(doc_no)%>';

    
   
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'number' },
     						{name : 'flname', type: 'String'  },
                          	
     						{name : 'reg_no', type: 'String'  },
                          	
                 ],
                 localdata: flsearch,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#fleetsearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
          
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                

                columns: [
					{ text: 'Fleet',datafield: 'fleet_no', width: '20%' },
					{ text: 'Fleet Name', datafield: 'flname', width: '65%' },
					{ text: 'Reg_NO', datafield: 'reg_no', width: '15%' },
					
					]
            });
            $('#fleetsearch').on('rowdoubleclick', function (event) 
            		{ 
		            	
		            	var rowindex1 =$('#rowindex').val();
		            	// alert(rowindex1);
		                var rowindex2 = event.args.rowindex;
		                $('#templistupdategrid').jqxGrid('setcellvalue', rowindex1, "perfleet_no" ,$('#fleetsearch').jqxGrid('getcellvalue', rowindex2, "fleet_no"));
		                $('#templistupdategrid').jqxGrid('setcellvalue', rowindex1, "perflname" ,$('#fleetsearch').jqxGrid('getcellvalue', rowindex2, "flname"));
		                $('#perfleetSearchwindow').jqxWindow('close');
		               
            		 }); 
        
        
        });
    </script>
    <div id="fleetsearch"></div>
    
    