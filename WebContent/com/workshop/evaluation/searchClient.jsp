<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.workshop.evaluation.ClsEvaluationDAO"%>  
<% ClsEvaluationDAO DAO= new ClsEvaluationDAO();  %>  
<%
 String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String checkrads = request.getParameter("checkrads")==null?"0":request.getParameter("checkrads");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%>             
   
 <script type="text/javascript">
 
 var cldata;
  
 cldata='<%=DAO.searchClient(session,clname,mob,id)%>';    
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                            {name : 'mobno', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
                          	],
                          	localdata: cldata,
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
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },  
					{ text: 'NAME', datafield: 'refname', width: '60%' },
					{ text: 'MOB NO', datafield: 'mobno', width: '30%' },
					]
            });
                 $('#Jqxclientsearch').on('rowdoubleclick', function (event){     
				              	var rowindex1=event.args.rowindex;
				                document.getElementById("cldocno").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				                document.getElementById("txtevaluatedfor").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				                $('#clientsearchwindow').jqxWindow('close');   
				   }); 	 
        
             }); 
    </script>
    <div id="Jqxclientsearch"></div>
    