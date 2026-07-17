
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%> 
<%
ClsRentalAgreementDAO AgreementDAO =new ClsRentalAgreementDAO();
%>
<%

String groupid= request.getParameter("vehgpid")==null?"0":request.getParameter("vehgpid").trim();
String tarifdoc= request.getParameter("tarifdoc")==null?"0":request.getParameter("tarifdoc").trim();




%>
<script type="text/javascript">


  var s='<%=AgreementDAO.searchuser(session,tarifdoc,groupid)%>';



      
        $(document).ready(function () { 	
        	
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
                            {name : 'user_name', type: 'string'  },
                            {name : 'doc_no', type: 'number'  },
                            {name : 'daily', type: 'number'  },
                            {name : 'weekly', type: 'number'  },
                            {name : 'monthly', type: 'number'  }
     				
                             						
                 ],               
                localdata: s,
             
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#usersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
          
                altRows: true,
          
                selectionmode: 'singlerow',
                pagermode: 'default',
                
          
                
                columns: [
                           

						
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'User Name', datafield: 'user_name', width: '55%' },
							{ text: 'Daily', datafield: 'daily', width: '15%' ,cellsformat: 'd2'},
							{ text: 'Weekly', datafield: 'weekly', width: '15%' ,cellsformat: 'd2'},
							{ text: 'Monthly', datafield: 'monthly', width: '15%',cellsformat: 'd2' },
							


	              ]
            });
           
          
            $('#usersearchgrid').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
            	
            	
            	document.getElementById("usernames").value=$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "user_name");

            	document.getElementById("userdoc").value=$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
            $('#jqxgridtarif').jqxGrid('setcellvalue', 0, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "daily"));
            $('#jqxgridtarif').jqxGrid('setcellvalue',1, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "weekly"));
            $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "monthly"));
            
            
            var setvalu = $("#jqxgridtarif").jqxGrid('getrows');
        	
        	var tempone=setvalu.length;

        	var rentalrow=tempone-3; 
       	  
            var rentalchk=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "rentaltype");

			   if(!(rentalchk==""))
					   {


			   if(rentalchk=="Daily")
	              {
	          			          

				   $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "daily"));

					
	              }
	             else  if(rentalchk=="Weekly")
           {
	            	
	            	   $('#jqxgridtarif').jqxGrid('setcellvalue',rentalrow, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "weekly"));
         	
           }
	           
	             else if(rentalchk=="Monthly")
           {
	            	 
	            	
	                 $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "monthly"));

           }
	             else
	            	 {
	            	 
	            	 }


			  
			  }
            
            
            
            		});
        });
        
    </script>
       <div id="usersearchgrid" ></div>
    
