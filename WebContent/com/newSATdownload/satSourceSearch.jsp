
     <%@page import="com.NewSatDownload.SATdownloadDAO" %>
      <%
      SATdownloadDAO DAO= new SATdownloadDAO();
      String site = request.getParameter("site")==null?"0":request.getParameter("site");     
     
%> 
  <script type="text/javascript">
    var srcdata= '<%=DAO.sat_sourcesearch(site)%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'source', type: 'String'  },
							{name : 'sourceid', type: 'String'  }
                 ],
                 localdata: srcdata,
                
                
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
            $("#jqxSourceGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                          
					{ text: 'Doc_No',columntype: 'textbox', filtertype: 'input', datafield: 'sourceid', width: '40%',editable:false },      
					{ text: 'Plate Source',columntype: 'textbox', filtertype: 'input', datafield: 'source', width: '60%',editable:false },
					
					
	              ]
            });

            $('#jqxSourceGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txttrafficpsourceid").value= $('#jqxSourceGrid').jqxGrid('getcellvalue', rowindex1, "sourceid");
		                document.getElementById("txttrafficpsource").value= $('#jqxSourceGrid').jqxGrid('getcellvalue', rowindex1, "source");
		              $('#sourceWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxSourceGrid"></div>
