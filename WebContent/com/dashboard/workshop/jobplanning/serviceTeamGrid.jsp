<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.workshop.jobplanning.*"%>
<%ClsWSJobPlanningDAO DAO= new ClsWSJobPlanningDAO();
String id = request.getParameter("id")==null?"0":request.getParameter("id").toString();
%> 
 <script type="text/javascript">
 
  var serviceteamdata=[];
  var id='<%=id%>';
  if(id=="1"){
  	serviceteamdata='<%=DAO.getTeamData(id,"1")%>'; 
  }
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                             
              
     						{name : 'grpcode', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
      						{name : 'docno', type: 'String'  },
      						{name : 'ismulemp', type: 'String'  },
      						{name : 'teamuserlinkid', type: 'String'  },
                          	{name : 'teamuserlinkname', type: 'String'  },
      						
                          	],
                          	localdata: serviceteamdata,
                          
          
				
                
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
            $("#serviceTeamGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
           
                selectionmode: 'checkbox',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Group Code', datafield: 'grpcode', width: '35%' },
					{ text: 'Description', datafield: 'desc1', width: '59%' },
					{ text: 'Docno', datafield: 'docno', width: '15%',hidden:true},
					{ text: 'ismulemp', datafield: 'ismulemp', width: '15%',hidden:true},
					{ text: 'Team User Link',datafield:'teamuserlinkname',width:'20%',hidden:true},
					{ text: 'Team User Link Id',datafield:'teamuserlinkid',width:'60%',hidden:true}
					
					]
            });

     }); 
				       
                       
    </script>
    <div id="serviceTeamGrid"></div>
    
