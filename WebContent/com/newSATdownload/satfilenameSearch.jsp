<%--    <jsp:include page="../../includes.jsp"></jsp:include> --%> 
 <%@page import="com.NewSatDownload.SATdownloadDAO"%>
 <%
 	String site =request.getParameter("site")==null?"0":request.getParameter("site").toString();
 %>
 
 <%
 SATdownloadDAO Dao=new SATdownloadDAO();
  %>
 
 <script type="text/javascript">
    var datafile= '<%= Dao.sat_tfilesearch(site)%>';
    
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'username', type: 'String'  },
     						{name : 'iscaptcha', type: 'String'  }
                 ],
                 localdata: datafile,
                
                
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
            $("#jqxfilenameGrid").jqxGrid(
            {
            	 width: '98%',
                 height: 240,
                 source: dataAdapter,
                 editable: true,
                 selectionmode: 'singlecell',
                columns: [
					{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						   groupable: false, draggable: false, resizable: false,datafield: '',
						   columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						   cellsrenderer: function (row, column, value) {
						   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						   }  
						},  
					
					{ text: 'File No',columntype: 'textbox', filtertype: 'input', datafield: 'username', width: '90%',editable:false },
					{ text: 'iscaptcha',columntype: 'textbox', filtertype: 'input', datafield: 'iscaptcha', width: '90%',hidden:true }
	              ]
            });

            $('#jqxfilenameGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txttrafficplateno").value= $('#jqxfilenameGrid').jqxGrid('getcellvalue', rowindex1, "username");
		                document.getElementById("iscaptcha").value= $('#jqxfilenameGrid').jqxGrid('getcellvalue', rowindex1, "iscaptcha");
		               
		              $('#filenameWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxfilenameGrid"></div>
