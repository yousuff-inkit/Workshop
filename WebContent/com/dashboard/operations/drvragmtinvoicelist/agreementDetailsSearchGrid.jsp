<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.dashboard.operations.drvragmtinvoicelist.ClsdriveragreementinvoicelistDAO" %>
<%ClsdriveragreementinvoicelistDAO cgd=new ClsdriveragreementinvoicelistDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 
 
%> 
 <script type="text/javascript">
 

  

 var data2='<%=cgd.agreementSearch(branchval,sclname,docno)%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'doc_no', type: 'String'},
     						{name : 'refname', type: 'String'},
     						
      					
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
                columnsresize: true,
                selectionmode: 'singlerow',
               
                columns: [   { text: 'Doc No', datafield: 'doc_no', width: '30%',hidden:false },
							
							{ text: 'Name', datafield: 'refname', width: '70%' }, 
							
				
					]
            });
    

      
				            
            $('#jqxAgreementSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtagreementno").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("vocnos").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "refname");
            	$('#agreementDetailsWindow').jqxWindow('close');  
            });  
				           
 }); 

</script>
<div id="jqxAgreementSearch"></div>
    
