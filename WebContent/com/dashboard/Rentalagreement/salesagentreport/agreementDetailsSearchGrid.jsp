 
<%@ page import="com.dashboard.rentalagreement.salesagentreport.ClssalesagentReportDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");

 
 
 
 ClssalesagentReportDAO DAO=new ClssalesagentReportDAO(); 
 
%> 
 <script type="text/javascript">
 

  

 var data2='<%=DAO.agreementSearch(branchval,sclname,smob,rno,flno,sregno)%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'refname', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						
      						{name : 'doc_no', type: 'String'  },
      						{name : 'voc_no', type: 'String'  },
      					
                          	],
                          	localdata: data2,
                
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
            $("#jqxAgreementSearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                   source: dataAdapter,
                showaggregates:true,
       
              
                selectionmode: 'checkbox',
               sortable:false,
               
                columns: [   { text: 'masterDoc No', datafield: 'doc_no', width: '12%',hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '12%' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '11%' },
							{ text: 'Name', datafield: 'refname', width: '38%' }, 
							{ text: 'Mobile', datafield: 'per_mob', width: '20%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '14%'},
				
					]
            });
    

            $("#btnok2").click(function() {
            	var rows = $("#jqxAgreementSearch").jqxGrid('selectedrowindexes');
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Doc NO";
                		document.getElementById("rag").value="Doc NO";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nDoc NO";
                		document.getElementById("rag").value+="\nDoc NO";
                	}	
            	}
             
            	
            	//document.getElementById("hidbrand").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#jqxAgreementSearch').jqxGrid('getcellvalue',rows[i],'voc_no');
            		var docno=$('#jqxAgreementSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("rag").value+="::"+dummy;
            		
            		
            		if(i==0){
            			if(document.getElementById("hidrag").value==""){
                			document.getElementById("hidrag").value+=docno;    				
            			}
            			else{
                			document.getElementById("hidrag").value+=","+docno;
                			
            			}

            		}
            		else{
            			document.getElementById("hidrag").value+=","+docno;
            		}
            	}
            	$('#agreementDetailsWindow').jqxWindow('close');
            	exit();
            	
            	});
            
            $( "#btncancel" ).click(function() {
            	$('#agreementDetailsWindow').jqxWindow('close');
            	});
				            
         /*    $('#jqxAgreementSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtagreementno").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("vocnos").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
            	$('#agreementDetailsWindow').jqxWindow('close'); 
            }); */  
				           
 }); 

</script>
<div id="jqxAgreementSearch"></div>
    
