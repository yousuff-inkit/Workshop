 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>



<%
 
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");

%> 

 <script type="text/javascript">
 
 var cldata1;

 cldata1='<%=viewDAO.searchClient(session,clname,mob)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'mail1', type: 'String'  }
      						
                          	],
                          	localdata: cldata1,
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
            $("#subclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
           
                //altRows: true,
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
					{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
					 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					
					
					
					]
            });
    
          /*   $("#subclientsearch").jqxGrid('addrow', null, {}); */
      
				            
				           $('#subclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	
				                document.getElementById("cl_dcocno").value= $('#subclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				       
				              	var temp="";
				            	 temp=temp+" NAME: "+$('#subclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				                    temp=temp+" , "+" ADDRESS: "+$('#subclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
				               
				                
				                
				               document.getElementById("client_details").value=temp;
				               
				          
				               
				               document.getElementById("txt_mobile").value=$('#subclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				               document.getElementById("txt_email").value=$('#subclientsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
				              
				                $('#qotclientsearch').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="subclientsearch"></div>
    