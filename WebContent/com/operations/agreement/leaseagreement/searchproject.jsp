<%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>   
   	<%
   	ClsLeaseAgreementDAO viewDAO=new ClsLeaseAgreementDAO();
   	
   	%> 

 <script type="text/javascript">

 var vehdatas='<%=viewDAO.searchproject()%>';
   // alert(data);
  /*  var url1='disfleetSearch.jsp'; */
        $(document).ready(function () { 	   // doc_no
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'project_name', type: 'String'  }
     					
     				                        	
                          	],
             
                          	localdata: vehdatas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#projectsearchgrid").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                columnsresize: true,
              /* 
              filterable: true,
              showfilterrow: true, */
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	 
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					{ text: 'Project Name', datafield: 'project_name', width: '100%' }
					 
					
					]
            });
            
            $('#projectsearchgrid').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	
                document.getElementById("leaseproject").value=$('#projectsearchgrid').jqxGrid('getcellvalue', rowindex1, "project_name");
                document.getElementById("leaseprojectDoc").value=$('#projectsearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	
                $('#projectwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="projectsearchgrid"></div>