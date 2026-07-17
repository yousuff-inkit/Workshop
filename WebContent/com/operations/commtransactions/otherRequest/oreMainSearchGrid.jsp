<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String raType = request.getParameter("raType")==null?"0":request.getParameter("raType");
 String raNo = request.getParameter("raNo")==null?"0":request.getParameter("raNo");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 

 <script type="text/javascript">
 
 			var data2='<%=cord.oreMainSearch(branch, partyname, docNo, date, raType, raNo)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
      						{name : 'date', type: 'date'  },
                            {name : 'refname', type: 'String' }, 
     						{name : 'ratype', type: 'String' },
     						{name : 'rano', type: 'String' }
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
            $("#jqxOtherRequestSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			
                columns: [
                          { text: 'Doc No', datafield: 'doc_no', width: '10%' },
     					  { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
                          { text: 'Client Name', datafield: 'refname', width: '58%' },
					      { text: 'Type', datafield: 'ratype', width: '7%' },
					      { text: 'Agreement No.', datafield: 'rano', width: '15%' },
					]
            });
            
			  $('#jqxOtherRequestSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtclientname").value= $('#jqxOtherRequestSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("docno").value= $('#jqxOtherRequestSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmOtherRequest select').attr('disabled', false);
                $('#jqxOtherRequestDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmOtherRequest").submit();
                $('#frmOtherRequest select').attr('disabled', true);
                $('#jqxOtherRequestDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxOtherRequestSearch"></div>
    