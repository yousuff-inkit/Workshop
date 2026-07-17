<%@page import="com.controlcentre.masters.vehiclemaster.enginesize.*" %>
<%ClsEngineSizeDAO coa=new ClsEngineSizeDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>


<script type="text/javascript">
	var id='<%=id%>';
    var searchdata=[];
    if(id=="1"){
    	searchdata='<%=coa.getEngineSizeData()%>';
    } 
    $(document).ready(function () { 	
    	var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'enginesize', type: 'String'  }
                          	
                 ],
                 localdata: searchdata,
                
                
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
            $("#engineSizeSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '40%' },
					{ text: 'Engine Size', datafield: 'enginesize',columntype: 'textbox', filtertype: 'input', width: '60%' }
	              ]
            });
          
            $('#engineSizeSearchGrid').on('rowdoubleclick', function (event) 
            		{ 
            			var rowindex1=event.args.rowindex;
              		 	 document.getElementById("docno").value= $('#engineSizeSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
               			 document.getElementById("enginesize").value = $("#engineSizeSearchGrid").jqxGrid('getcellvalue', rowindex1, "enginesize");                
            	 		 $('#window').jqxWindow('hide');
            		 }); 
          
        });
    </script>
    <div id="engineSizeSearchGrid"></div>
