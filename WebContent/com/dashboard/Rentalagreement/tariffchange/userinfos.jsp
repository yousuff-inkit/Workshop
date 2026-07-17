<%@ page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
<%ClsRentalAgreementDAO crad=new ClsRentalAgreementDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%

String groupid= request.getParameter("vehgpid")==null?"0":request.getParameter("vehgpid").trim();
String tarifdoc= request.getParameter("tarifdoc")==null?"0":request.getParameter("tarifdoc").trim();

%>
<script type="text/javascript">


  var s='<%=crad.searchuser(session,tarifdoc,groupid)%>';



      
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
							{ text: 'User Name', datafield: 'user_name', width: '80%' },
							{ text: 'Daily', datafield: 'daily', width: '15%' ,cellsformat: 'd2',hidden:true},
							{ text: 'Weekly', datafield: 'weekly', width: '15%' ,cellsformat: 'd2',hidden:true},
							{ text: 'Monthly', datafield: 'monthly', width: '20%',cellsformat: 'd2' },
							


	              ]
            });
           
          
            $('#usersearchgrid').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
            	
            	
            	document.getElementById("usernames").value=$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "user_name");

            	document.getElementById("userdoc").value=$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
            $('#jqxgridtarif').jqxGrid('setcellvalue', 0, "disclevel",$('#usersearchgrid').jqxGrid('getcellvalue', rowindex1, "monthly"));
           
       
            
            		});
        });
        
    </script>
       <div id="usersearchgrid" ></div>
    
