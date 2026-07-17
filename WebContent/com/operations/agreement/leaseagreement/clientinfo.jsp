<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>
 <%
 ClsLeaseAgreementDAO viewDAO= new ClsLeaseAgreementDAO();
 
 String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
%> 

 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  radata='<%=viewDAO.clientSearch(session,clname,mob,lcno,passno,nation,dob)%>';
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
     						 {name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
                          	],
                          	localdata: radata,
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
            $("#jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
		/* 			{ text: 'CLIENT NO', datafield: 'cldocno', width: '4%' },
					{ text: 'NAME', datafield: 'refname', width: '18%' },
					{ text: 'DRIVER NAME', datafield: 'drname', width: '18%' },
					{ text: 'ADDRESS', datafield: 'address', width: '50%' }, 
					{ text: 'MOB', datafield: 'per_mob', width: '12%' },
					 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
					 { text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
					 { text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
					 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
					 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
					 { text: 'per_tel', datafield: 'per_tel', width: '20%',hidden:true }, */
					
		{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
		{ text: 'NAME', datafield: 'refname', width: '16%' },
		{ text: 'DRIVER NAME', datafield: 'drname', width: '14%' },
		 { text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
			{ text: 'MOB', datafield: 'per_mob', width: '9%' },
			 { text: 'TEL', datafield: 'per_tel', width: '8%' },
		 { text: 'LICENCE', datafield: 'dlno', width: '9%' },
		 { text: 'NATION', datafield: 'nation', width: '9%' },
		{ text: 'ADDRESS', datafield: 'address', width: '21%' }, 
		 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
		 { text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
		 { text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
		 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
		 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
		 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
	 
					
					]
            });
    
           /*  $("#jqxclientsearch").jqxGrid('addrow', null, {}); */
      
				            
				           $('#jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 var temp="";
				            	  temp=temp+" Contact Person : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "contactperson");
				                temp=temp+","+" MOB : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				                temp=temp+","+" Email : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
				                temp=temp+","+" ADDRESS : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
				                temp=temp+","+" Tel NO : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
				               
				                
				            	document.getElementById("cusaddress").value=temp; 
				            	
				               document.getElementById("clientid").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("clientname").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               
				               document.getElementById("le_clacno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "acno");
				               document.getElementById("le_clcodeno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               
				               document.getElementById("salesman").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
				               document.getElementById("le_salmanid").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				          
				       
				           
				               $('#delivery_chk').attr('disabled', false);
			       	           $('#radrivercheck').attr('disabled', false);
			       	          
			       	            $("table#tariffsub input").prop("disabled", false); 
				           
				              document.getElementById("errormsg").innerText="";
				              
				              $("#jqxgrid2").jqxGrid('clear');
						      $("#jqxgrid2").jqxGrid('addrow', null, {});
						      $("#jqxgrid2").jqxGrid('addrow', null, {});
				              if(document.getElementById('ladrivercheck').checked==true) {
				            
				            	
							      $("#jqxgrid2").jqxGrid({ disabled: true});   
				              }
				              
				              
				                $('#clientinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>
    
    </body>
</html>