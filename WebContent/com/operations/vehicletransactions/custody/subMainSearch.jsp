<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.operations.vehicletransactions.custody.ClsCustodyDAO" %>
 <%
 ClsCustodyDAO viewDAO= new ClsCustodyDAO();
 
String client = request.getParameter("client")==null?"0":request.getParameter("client");
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String agmtno = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
%> 
 <script type="text/javascript">
 
  var loaddata;

 loaddata='<%=viewDAO.mainSearch(client,reftype,searchdate,agmtno,fleetno,docno)%>';
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             

                            {name : 'vocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						 {name : 'fleet_no', type: 'String'  }, 
     						{name : 'rtype', type: 'String'  },
      						{name : 'doc_no', type: 'String'  },
      						{name :'rdocno',type:'number'}
      						
      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 293,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [

                         { text: 'rdocno', datafield: 'rdocno', width: '10%' ,hidden:true},     
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%' },
					{ text: 'DATE', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'TYPE', datafield: 'rtype', width: '10%'},
					{ text:'AGMT NO',datafield:'vocno',width: '10%'},
					{ text: 'FLEET NO', datafield: 'fleet_no', width: '10%' },
					{ text: 'CLIENT', datafield: 'refname', width: '50%' }
					
					
					
					 
			
					
					
					]
            });
    
           // $("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				        	
				        			document.getElementById("docno").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
				        			//document.getElementById("masterrefno").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "vocno");
					   			
					              $('#window').jqxWindow('close');
					              funSetlabel();
					              document.getElementById("custody").submit();
			
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
