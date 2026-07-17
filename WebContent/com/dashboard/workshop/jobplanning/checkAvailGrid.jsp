<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.workshop.jobplanning.*"%>
<%ClsWSJobPlanningDAO DAO= new ClsWSJobPlanningDAO();
String id = request.getParameter("id")==null?"0":request.getParameter("id").toString();
%> 
 <script type="text/javascript">
 
  var techavaildata=[];
  var id='<%=id%>';
  if(id=="1"){
  	techavaildata='<%=DAO.getAvailability(id)%>'; 
  }
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                             
              
     						{name : 'grpcode', type: 'String'  },
     						{name : 'description', type: 'String'  },
      						{name : 'docno', type: 'String'  },
      						{name : 'availability', type: 'String'  },
      						{name : 'teamuserlinkid', type: 'String'  },
                          	{name : 'teamuserlinkname', type: 'String'  },
      						
                          	],
                          	localdata: techavaildata,
                          
          
				
                
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
            $("#TechAvailableGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Group Code', datafield: 'grpcode', width: '20%' },
					{ text: 'Description', datafield: 'description', width: '20%' },
					{ text: 'Docno', datafield: 'docno', width: '15%',hidden:true},
					{ text: 'Availability', datafield: 'availability', width: '60%'},
					{ text: 'Team User Link',datafield:'teamuserlinkname',width:'20%',hidden:true},
					{ text: 'Team User Link Id',datafield:'teamuserlinkid',width:'60%',hidden:true}
					
					]
            });

     }); 
				       
                       
    </script>
    <div id="TechAvailableGrid"></div>
    
