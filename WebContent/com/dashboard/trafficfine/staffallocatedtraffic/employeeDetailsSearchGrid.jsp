<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.dashboard.salik.ClsSalikDAO" %>
<%ClsSalikDAO csd=new ClsSalikDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String salesman = request.getParameter("salesman")==null?"0":request.getParameter("salesman");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String salescode = request.getParameter("salescode")==null?"0":request.getParameter("salescode");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String led = request.getParameter("led")==null?"0":request.getParameter("led");
 String type = request.getParameter("type")==null?"0":request.getParameter("type");
%> 
 <script type="text/javascript">
 
 
  
 
      var data2='<%=csd.employeeSearch(salesman,smob,salescode,docno,date,led,type)%>';
         
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'},
     						{name : 'sal_code', type: 'String'}, 
     						{name : 'sal_name', type: 'String'},
     						{name : 'mobile', type: 'String'}, 
      						{name : 'lic_exp_dt', type: 'date'  }
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
            $("#jqxEmployeeSearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                editable: false,
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
							{ text: 'Code', datafield: 'sal_code', width: '10%' }, 
							{ text: 'Salesman', datafield: 'sal_name', width: '40%' },
							{ text: 'Mobile', datafield: 'mobile', width: '20%'},
							{ text: 'Licence Exp.', datafield: 'lic_exp_dt', cellsformat: 'dd.MM.yyyy' , width: '10%'},
					]
            });
    
            $("#jqxEmployeeSearch").jqxGrid('addrow', null, {});
      
				            
            $('#jqxEmployeeSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtempid").value = $('#jqxEmployeeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtempname").value = $('#jqxEmployeeSearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
            	$('#employeeDetailsWindow').jqxWindow('close'); 
            });  
				           
 }); 

</script>
<div id="jqxEmployeeSearch"></div>
    
