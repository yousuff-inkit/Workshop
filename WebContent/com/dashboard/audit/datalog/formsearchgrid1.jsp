<%@page import="com.dashboard.audit.datalog.ClsDataLogDAO"%>
<%ClsDataLogDAO logdao=new ClsDataLogDAO();
String check=request.getParameter("check")==null?"":request.getParameter("check").trim();%>
       <script type="text/javascript">
  
	    var formdata='<%=logdao.getForm1(check)%>'; 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'description', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: formdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#formSearchGrid1").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Form', datafield: 'description', width: '100%' },
						]
            });
            
          $('#formSearchGrid1').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                 document.getElementById("form").value=$('#formSearchGrid1').jqxGrid('getcellvalue', rowindex2, "description");
                document.getElementById("hidform").value=$('#formSearchGrid1').jqxGrid('getcellvalue', rowindex2, "doc_no"); 
               $('#formwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="formSearchGrid1"></div>