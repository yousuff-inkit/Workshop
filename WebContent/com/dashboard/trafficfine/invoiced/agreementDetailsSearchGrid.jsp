<%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO" %>
<%ClsTrafficfineDAO ctd=new ClsTrafficfineDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 String rentaltype = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype");
%> 
 <script type="text/javascript">

 var data2='<%=ctd.agreementSearch(branchval,sclname,smob,rno,flno,sregno,rentaltype)%>';
         
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
      						{name : 'voc_no', type: 'String'  }
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
               
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '12%' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '12%' },
							{ text: 'Name', datafield: 'refname', width: '40%' }, 
							{ text: 'Mobile', datafield: 'per_mob', width: '22%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '14%'},
							{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '12%' },
				
					]
            });
    
            $('#jqxAgreementSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtagreementvoucherno").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
                document.getElementById("txtagreementno").value = $('#jqxAgreementSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	$('#agreementDetailsWindow').jqxWindow('close'); 
            });  
				           
 }); 

</script>
<div id="jqxAgreementSearch"></div>
    
