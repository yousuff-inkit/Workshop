<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 <%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <script type="text/javascript">

   var mtufleet1='<%=cmwd.searchdamage() %>';
  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  }
     						
     						
     				                        	
                          	],
             
                          	localdata: mtufleet1,
                
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
            $("#danagesearch").jqxGrid(
            {
                width: '99.9%',
                height: 382,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
       
                //Add row method
	
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					
					{ text: 'Name', datafield: 'name', width: '100%'  },
			
					
					]
            });
            
            $('#danagesearch').on('rowdoubleclick', function (event) 
            		{ 
            
               var rowindex1 =$('#rowindex1').val();
            	
                var rowindex2 = event.args.rowindex;
                $('#mainuppergrid').jqxGrid('setcellvalue', rowindex1, "damageid" ,$('#danagesearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#mainuppergrid').jqxGrid('setcellvalue', rowindex1, "damagename" ,$('#danagesearch').jqxGrid('getcellvalue', rowindex2, "name"));
        
 
                var rows = $('#mainuppergrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if (rowindex1 == rowlength - 1) {
              
                $("#mainuppergrid").jqxGrid('addrow', null, {});	
                
              
                
                }
                
                
                
                
                
            	$('#damagewindow').jqxWindow('close');
                
              
            	
            		 }); 
            
      
        });
    </script>
    <div id="danagesearch"></div>