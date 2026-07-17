<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.operations.agreement.rentalclosenew.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 String smra = request.getParameter("smra")==null?"0":request.getParameter("smra");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
 String allbranch = request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
 ClsRentalCloseNewDAO closedao=new ClsRentalCloseNewDAO();
%> 
 <script type="text/javascript">
 
  var loaddata;

 loaddata='<%=closedao.mainSearch(session,sclname,smob,rno,flno,sregno,smra,branch,allbranch)%>';
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'fleet_no', type: 'String'  }, 
     						{name : 'reg_no', type: 'String'  },
     						 {name : 'mrano', type: 'String'  }, 
      						{name : 'doc_no', type: 'String'  },
      						{name :'agmtno',type:'number'},
      						{name :'voc_no',type:'number'},
      						{name :'voucherno',type:'number'},
							{name : 'allbranch',type:'number'}
      						
      						
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
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Doc No', datafield: 'voucherno', width: '10%' },
					{ text: 'Original Doc No',datafield:'doc_no',width:'10%',hidden:true},
					{ text:'Agmt No',datafield:'voc_no',width: '10%'},
					{ text: 'Original Agreement',datafield:'agmtno',width:'10%',hidden:true},
					{ text: 'Fleet No', datafield: 'fleet_no', width: '10%' },
					{ text: 'Client', datafield: 'refname', width: '28%' }, 
					{ text: 'Mobile', datafield: 'per_mob', width: '22%' },
					{ text: 'Reg No', datafield: 'reg_no', width: '10%'},
					 { text: 'MRA No', datafield: 'mrano', width: '10%' },
					 {text:'All Branch',datafield:'allbranch',width:'10%',hidden:true}
					
					 
			
					
					
					]
            });
    
            $("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var row1=event.args.rowindex;
				        	  document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "doc_no");
				        	  document.getElementById("vocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "voc_no");
				        	  document.getElementById("voucherno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "voucherno");
				      //  	  $("#closedate").jqxDateTimeInput('val',$("#rentalCloseSearch").jqxGrid('getcellvalue', row1, "date"));
				        	  document.getElementById("agreementno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "agmtno");
							  document.getElementById("allbranch").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "allbranch");
				        		$('#window').jqxWindow('close');
				        		document.getElementById("mode").value="view";
				        		funSetlabel();
				        		document.getElementById("frmRentalClose").submit();
				               
				            		});	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
