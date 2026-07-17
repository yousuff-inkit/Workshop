<%@page import="com.limousine.limobooking.*" %>
<%
ClsLimoBookingDAO limodao=new ClsLimoBookingDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String clientdoc=request.getParameter("clientdocno")==null?"0":request.getParameter("clientdocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
String clientlicense=request.getParameter("clientlicense")==null?"":request.getParameter("clientlicense");
String clientdob=request.getParameter("clientdob")==null?"":request.getParameter("clientdob");
%> 

 <script type="text/javascript">
 var id='<%=id%>';
 var clientdata;
 if(id=="1"){
	 clientdata='<%=limodao.getClientData(id,clientdoc,clientname,clientmobile,clientlicense,clientdob)%>';  	 
 }
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }      						
      					
                          	],
                          	localdata: clientdata,
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
            $("#clientSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
                columns: [
					{ text: 'Client No', datafield: 'cldocno', width: '10%' },
					{ text: 'Name', datafield: 'refname', width: '50%' },
					{ text: 'DOB', datafield: 'dob', width: '10%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Mobile', datafield: 'per_mob', width: '15%' },
					{ text: 'License', datafield: 'dlno', width: '15%' },
					]
            });
    
			$('#clientSearchGrid').on('rowdoubleclick', function (event) 
				{ 
				var rowindex1=event.args.rowindex;
	            document.getElementById("client").value=$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'refname');
	            document.getElementById("hidclient").value=$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'cldocno');
	            var details="Mobile: "+$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'per_mob')+" License: "+$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'dlno');
	            document.getElementById("clientdetails").value=details;
				$('#clientwindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="clientSearchGrid"></div>
    