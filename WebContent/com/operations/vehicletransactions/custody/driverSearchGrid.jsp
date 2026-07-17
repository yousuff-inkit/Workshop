 
 <%@page import="com.operations.vehicletransactions.replacementnew.ClsReplacementNewDAO" %>
 <%
 ClsReplacementNewDAO viewDAO= new ClsReplacementNewDAO();
 
%> 
 <script type="text/javascript">
       var driverdata='<%=viewDAO.getDriverData()%>';	
       $(document).ready(function () { 	
    	   var id='<%=request.getParameter("id")%>';
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'dr_id', type: 'int'  },
     						{name : 'name', type: 'String'  },
     						{name : 'led', type: 'date'}
     					
                 ],
                localdata: driverdata,
                //url: url,
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
            $("#driverSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'dr_id', width: '10%' },
							{ text: 'Name', datafield: 'name', width: '50%'},
						 	{ text: 'License Expiry', datafield: 'led', width: '40%',cellsformat:'dd.MM.yyyy' }
						
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
          
            $('#driverSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	if(id=="1"){
            		document.getElementById("colldriverid").value=$("#driverSearch").jqxGrid('getcellvalue', rowindex1, "dr_id");
            		document.getElementById("collectiondriver").value=$("#driverSearch").jqxGrid('getcellvalue', rowindex1, "name");
            	}
            	if(id=="2"){
            		document.getElementById("deldriverid").value=$("#driverSearch").jqxGrid('getcellvalue', rowindex1, "dr_id");
            		document.getElementById("deldriver").value=$("#driverSearch").jqxGrid('getcellvalue', rowindex1, "name");
            	}
            	$('#collectionwindow').jqxWindow('close');
            	
            });  
        });
    </script>
    <div id="driverSearch"></div>
