<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% 	
String seardoc = request.getParameter("seardoc")==null?"NA":request.getParameter("seardoc");

 String seardate = request.getParameter("seardate")==null?"0":request.getParameter("seardate");
 
 String seartype = request.getParameter("seartype")==null?"0":request.getParameter("seartype").trim(); 

%> 

 <script type="text/javascript">
 
 var masterdata;


 masterdata='<%=cstd.searchMaster(session,seardoc,seardate,seartype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'fleetno' , type: 'String' },
                   	{name : 'amount' , type: 'String' }  ,
                 	{name : 'type' , type: 'String' }       
                     	
						
                   	],
          localdata: masterdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            }		
     );
     $("#submastergrid").jqxGrid(
     {
         width: '100%',
         height: 310,
         source: dataAdapter,
         columnsresize: true,
        // pageable: true,
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
				{ text: 'Date', datafield: 'date', width: '35%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Fleet', datafield: 'fleetno', width: '35%' },
				{ text: 'Amount', datafield: 'amount', width: '30%',hidden:true },
				{ text: 'type', datafield: 'type', width: '25%',hidden:true }
				
		
		
				]
     });
     
     $("#submastergrid").jqxGrid('addrow', null, {});
     $('#submastergrid').on('rowdoubleclick', function (event) 
     		{ 
 	    var rowindex1=event.args.rowindex;
 
 
        	$('#tsDate').jqxDateTimeInput({ disabled: false});
            $('#tsDate').val($("#submastergrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
          
        document.getElementById("traficdocno").value= $('#submastergrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
     
        document.getElementById("entryval").value= $('#submastergrid').jqxGrid('getcellvalue', rowindex1, "type");              
           
        
 
         $('#window').jqxWindow('close');
     	$('#tsDate').jqxDateTimeInput({ disabled: false});
     	
       document.getElementById("frmsalic").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="submastergrid"></div>

    
    </body>
</html>
