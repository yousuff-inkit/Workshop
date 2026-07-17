      <%@page import="com.NewSatDownload.SATdownloadDAO" %>
       <% SATdownloadDAO DAO=new SATdownloadDAO(); %> 
     <%
String source = request.getParameter("source")==null?"0":request.getParameter("source");
String site = request.getParameter("site")==null?"0":request.getParameter("site");     
     
%> 
  <script type="text/javascript">
    var clrdata= '<%=DAO.sat_colorsearch(source,site)%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'color', type: 'String'  },
							{name : 'colorid', type: 'String'  }
                 ],
                 localdata: clrdata,
                
                
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
            $("#jqxColorGrid").jqxGrid(
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
                          
					{ text: 'Doc_No',columntype: 'textbox', filtertype: 'input', datafield: 'colorid', width: '40%',editable:false },      
					{ text: 'Plate Colour',columntype: 'textbox', filtertype: 'input', datafield: 'color', width: '60%',editable:false },
					
					
	              ]
            });

            $('#jqxColorGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txttrafficpcolorid").value= $('#jqxColorGrid').jqxGrid('getcellvalue', rowindex1, "colorid");
		                document.getElementById("txttrafficpcolor").value= $('#jqxColorGrid').jqxGrid('getcellvalue', rowindex1, "color");
		                document.getElementById("txttrafficptypeid").value='1';
		                document.getElementById("txttrafficptype").value='Private';
		              $('#colorWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxColorGrid"></div>
