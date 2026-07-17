  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="com.operations.agreement.rentalagmtnew.*" %>
 <%
 ClsRentalAgmtNewDAO viewDAO= new ClsRentalAgmtNewDAO();
%>
 <script type="text/javascript">

 var datara= '<%=viewDAO.RentalgentSearch()%>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     						{name : 'sal_code', type: 'String'  },
     						{name : 'sal_name', type: 'String'  }
     						
     					
     					
                          	
                          	],
                 localdata: datara,
          
				
                
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
            $("#jqxrentagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
              
                altRows: true,
				filterable:true,
               showfilterrow:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
               // sortable: true,
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no',   columntype: 'textbox', filtertype: 'input',width: '20%',hidden:true },
					{ text: 'NAME', datafield: 'sal_name',  columntype: 'textbox', filtertype: 'input', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxrentagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("rarenral_Agent").value=$('#jqxrentagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("tariffrenral_Agentid").value=$('#jqxrentagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("errormsg").innerText="";		 
   	       
   	       $('#ratariff_checkout').attr('disabled', false);
              
                $('#Rentalagentinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxrentagentsearch"></div>