<%@page import="com.operations.agreement.rentalagmtnew.*" %>
 <%
 ClsRentalAgmtNewDAO viewDAO= new ClsRentalAgmtNewDAO(); %>
  <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
 <script type="text/javascript">

 var datasal= '<%=viewDAO.SalesgentSearch()%>';
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
                 localdata: datasal,
          
				
                
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
            $("#jqxSalagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
               filterable:true,
               showfilterrow:true,
                altRows: true,
               
                selectionmode: 'singlerow',
                pagermode: 'default',
                //sortable: true,
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no',   columntype: 'textbox', filtertype: 'input',width: '20%',hidden:true},
					{ text: 'NAME', datafield: 'sal_name',  columntype: 'textbox', filtertype: 'input', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxSalagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("rasales_Agent").value=$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("tariffsales_Agentid").value=$('#jqxSalagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               $('#rarenral_Agent').attr('disabled', false);
     	       $('#ratariff_checkout').attr('disabled', false);

     	      document.getElementById("errormsg").innerText="";
                $('#Salesagentinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxSalagentsearch"></div>