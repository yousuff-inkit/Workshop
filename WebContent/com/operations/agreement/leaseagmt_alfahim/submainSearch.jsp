<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>
 <%
 ClsLeaseAgreementDAO viewDAO= new ClsLeaseAgreementDAO();
 
 String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 
 String branch_chk = request.getParameter("branch_chk")==null?"0":request.getParameter("branch_chk");
 
%> 
 <script type="text/javascript">
 
  var loaddata;
  <%--if('NA' != '<%=item1%>')  {
	 loaddata = '<%=item1%>';
 }
 alert("radata"+loaddata); --%>
 
 loaddata='<%=viewDAO.mainSrearch(session,sclname,smob,rno,flno,sregno,branch_chk)%>';
 
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'fleet_no', type: 'String'  }, 
      						{name : 'doc_no', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'reg_no', type: 'String'  },
      						{name : 'voc_no', type: 'String'  },
      						{name : 'checks', type: 'String'  },
      						
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
                height: 277,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'DOC NO', datafield: 'voc_no', width: '10%' },
					{ text: 'FLEET NO', datafield: 'fleet_no', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '50%' }, 
					{ text: 'MOB', datafield: 'per_mob', width: '18%' },
					{ text: 'REG NO', datafield: 'reg_no', width: '12%'},
					 { text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
					 
					 { text: 'docno', datafield: 'doc_no', width: '15%',hidden:true },
					 { text: 'check', datafield: 'checks', width: '10%',hidden:true  }, 
					
					]
            });
    
          /*   $("#jqxmainsearch").jqxGrid('addrow', null, {}); */
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				        	  document.getElementById("checkbranch").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "checks");
				            		
				         document.getElementById("masterdoc_no").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				         document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				               document.getElementById("clientid").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				                     /* document.getElementById("permanentfleet").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "perfleet"); */
				                     
				              
				        
				                $('#window').jqxWindow('close');
				                $('#frmLeaseAgreement_AlFahim permanentfleet').attr('disabled', false);
				                $('#frmLeaseAgreement_AlFahim clientid').attr('disabled', false);
				                $('#frmLeaseAgreement_AlFahim docno').attr('disabled', false); 
				                funSetlabel();
				                
				                $('#frmLeaseAgreement_AlFahim input').attr('disabled', false ); 
				                
				                document.getElementById("frmLeaseAgreement_AlFahim").submit();
				            	
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
