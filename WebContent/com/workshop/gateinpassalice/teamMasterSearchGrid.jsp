<%@page import="com.workshop.gateinpassalice.ClsGateInPassAliceDAO"%>  
<%ClsGateInPassAliceDAO DAO= new ClsGateInPassAliceDAO();
String id = request.getParameter("id")==null?"":request.getParameter("id").toString();
%> 
 <script type="text/javascript">
 var teammasterdata=[];
 var id='<%=id%>';
 if(id=="1"){
 	teammasterdata='<%=DAO.getTeamMasterData(id)%>'; 
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
                          	localdata: teammasterdata,
                          
          
				
                
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
            $("#teamMasterSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Group Code', datafield: 'grpcode', width: '35%' },
					{ text: 'Description', datafield: 'desc1', width: '50%' },
					{ text: 'Docno', datafield: 'docno', width: '15%'},
					{ text: 'ismulemp', datafield: 'ismulemp', width: '15%',hidden:true},
					{ text: 'Team User Link',datafield:'teamuserlinkname',width:'20%',hidden:true},
					{ text: 'Team User Link Id',datafield:'teamuserlinkid',width:'60%',hidden:true}
					
					]
            });
    
          /*   $("#teamMasterSearchGrid").jqxGrid('addrow', null, {}); */
      
				            
				          $('#teamMasterSearchGrid').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				         document.getElementById("hidteammaster").value=$('#teamMasterSearchGrid').jqxGrid('getcellvalue', rowindex1, "docno");
				         document.getElementById("teammaster").value=$('#teamMasterSearchGrid').jqxGrid('getcellvalue', rowindex1, "grpcode");
				                  
				                $('#teammasterwindow').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="teamMasterSearchGrid"></div>
