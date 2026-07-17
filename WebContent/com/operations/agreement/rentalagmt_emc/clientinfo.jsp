<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.operations.agreement.rentalagmtemc.ClsRentalAgmtEMCDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%
 ClsRentalAgmtEMCDAO viewDAO= new ClsRentalAgmtEMCDAO();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
 String idno = request.getParameter("idno")==null?"":request.getParameter("idno");
%> 

 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  radata='<%=viewDAO.clientSearch(session,clname,mob,lcno,passno,nation,dob,idno)%>';
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
     						
      						{name : 'pcase', type: 'String' },
      						
      						{name : 'advance', type: 'int' },
      						{name : 'invc_method', type: 'int' },
      						
      						{name : 'method', type: 'int' },
      						{name : 'outstanding',type:'number'},
      						{name : 'idno',type:'string'}
      						
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
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
					{ text: 'NAME', datafield: 'refname', width: '16%' },
					{ text: 'DRIVER NAME', datafield: 'drname', width: '14%' },
					 { text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
						{ text: 'MOB', datafield: 'per_mob', width: '9%' },
						 { text: 'TEL', datafield: 'per_tel', width: '8%' ,hidden:true},
					 { text: 'LICENCE', datafield: 'dlno', width: '9%' },
					 { text: 'NATION', datafield: 'nation', width: '9%' },
					 { text: 'ID',datafield:'idno',width:'8%'},
					{ text: 'ADDRESS', datafield: 'address', width: '21%' }, 
					 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
					 { text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
					 { text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
					 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
					 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
					 { text: 'pcase', datafield: 'pcase', width: '20%',hidden:true},
					 
					 { text: 'advance', datafield: 'advance', width: '20%',hidden:true},
					 
					 { text: 'invc_method', datafield: 'invc_method', width: '20%',hidden:true},
					 
					 { text: 'method', datafield: 'method', width: '20%',hidden:true}, 
					 { text: 'Outstanding Amount', datafield: 'outstanding', width: '20%',hidden:true,cellsformat:'d2'}
					 
					
					 

					
					]
            });
    
         /*    $("#jqxclientsearch").jqxGrid('addrow', null, {}); */
      
				            
$('#jqxclientsearch').on('rowdoubleclick', function (event) 
{ 
	var rowindex1=event.args.rowindex;
  	var temp="";
  	temp=temp+" CONTACT PERSON : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "contactperson");
    temp=temp+","+" MOB : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
    temp=temp+","+" EMAIL : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "mail1");
    temp=temp+","+" ADDRESS : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
    temp=temp+","+" TEL NO : "+$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
  	document.getElementById("clientdetails").value=temp; 				            	
    document.getElementById("cldocno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
    document.getElementById("clientname").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
    document.getElementById("clientacno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "acno");
    document.getElementById("salesman").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
    document.getElementById("hidsalesman").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
    $('#clientinfowindow').jqxWindow('close');
}); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>
    
    </body>
</html>