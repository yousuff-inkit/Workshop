<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.operations.agreement.leaseclose_alfahim.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 String searchdate=request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
  String allbranch = request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
 ClsLeaseCloseAlFahimDAO leasedao=new ClsLeaseCloseAlFahimDAO();
%> 
 <script type="text/javascript">
 
  var loaddata;

 loaddata='<%=leasedao.mainSearch(session,sclname,smob,rno,flno,sregno,searchdate,branch,allbranch)%>';  
               
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
     						{name : 'date',type:'date'},
      						{name : 'doc_no', type: 'String'  },
      						{name :'agmtno',type:'number'},
      						{name : 'voc_no',type:'number'},
      						{name : 'voucherno',type:'number'},
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
					{ text: 'Original Doc No', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Doc No', datafield:'voucherno',width:'10%'},
					{ text: 'Agmt No',datafield:'voc_no',width:'10%'},
					{ text:'Original Agmt No',datafield:'agmtno',width: '10%',hidden:true},
					{ text: 'Date',datafield:'date',cellsformat:'dd.MM.yyyy',width:'10%'},
					{ text: 'Fleet No', datafield: 'fleet_no', width: '10%' },
					{ text: 'Client', datafield: 'refname', width: '28%' }, 
					{ text: 'Mobile', datafield: 'per_mob', width: '22%' },
					{ text: 'Reg No', datafield: 'reg_no', width: '10%'},
					 {text:'All Branch',datafield:'allbranch',width:'10%',hidden:true}
					 
					
					 
			
					
					
					]
            });
    
        
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var row1=event.args.rowindex;
				        	  document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "doc_no");
				        	  document.getElementById("vocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "voc_no");
				        	  document.getElementById("voucherno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "voucherno");
				        		  //  	  $("#closedate").jqxDateTimeInput('val',$("#rentalCloseSearch").jqxGrid('getcellvalue', row1, "date"));
							document.getElementById("allbranch").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "allbranch");
				        	  document.getElementById("agreementno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row1, "agmtno");
				        		$('#window').jqxWindow('close');
				        		document.getElementById("mode").value="view";
				        		funSetlabel();
				        		document.getElementById("frmLeaseCloseAlFahim").submit();
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
