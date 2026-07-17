<%@page import="com.limousine.limobooking.*" %>
<%
ClsLimoBookingDAO limodao=new ClsLimoBookingDAO();
%> 

 <script type="text/javascript">
 
 var guestdata='<%=limodao.getGuestData()%>'; 
	 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'guest', type: 'String'  },
     						{name : 'guestcontactno', type: 'String'  }      						
      					
                          	],
                          	localdata: guestdata,
                          //	 url: url1,
          
				
                
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
            $("#guestSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Guest', datafield: 'guest', width: '50%' },
					{ text: 'Contact No', datafield: 'guestcontactno', width: '30%'}
					]
            });
    
			$('#guestSearchGrid').on('rowdoubleclick', function (event) 
				{ 
				var rowindex1=event.args.rowindex;
	            document.getElementById("guest").value=$('#guestSearchGrid').jqxGrid('getcellvalue',rowindex1,'guest');
	            document.getElementById("hidguest").value=$('#guestSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
	            document.getElementById("guestcontactno").value=$('#guestSearchGrid').jqxGrid('getcellvalue',rowindex1,'guestcontactno');
				$('#guestwindow').jqxWindow('close');
				}); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="guestSearchGrid"></div>
    