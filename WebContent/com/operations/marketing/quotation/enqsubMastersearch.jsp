

<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");

 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
 
 

%> 

 <script type="text/javascript">
 
 var enqmasterdata1; 
 

  enqmasterdata1='<%=viewDAO.enqsearchMaster(session,msdocno,Cl_names,enqdate)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                 	{name : 'voc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                     {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'com_add1' , type: 'String' },
                 	{name : 'mob' , type: 'String' },
                 	{name : 'enqtype' , type: 'Int' },
                   	{name : 'remarks' , type: 'String'}
                  
                   	
						
                   	],
          localdata: enqmasterdata1,
         
         
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
     $("#subenqsearch").jqxGrid(
     {
         width: '100%',
         height: 290,
         source: dataAdapter,
         columnsresize: true,
        // pageable: true,
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'com_add1', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'MOB', datafield: 'mob', width: '15%' },
				{ text: 'enqtype', datafield: 'enqtype', width: '20%',hidden:true },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true }
		
		
				]
     });
     
/*      $("#subenqsearch").jqxGrid('addrow', null, {}); */
     $('#subenqsearch').on('rowdoubleclick', function (event) 
     		{ 
    	 
    	 
 	  var rowindex1=event.args.rowindex;
     	var indexval3=$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
 	 document.getElementById("enqrefno").value=indexval3; 
 	 document.getElementById("refno").value=$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
 	 
      document.getElementById("cl_dcocno").value= $('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
      
    	var temp="";
  	 temp=temp+" NAME: "+$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "name");
          temp=temp+" , "+" ADDRESS: "+$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
     
          
      
     document.getElementById("client_details").value=temp;
     

     
     document.getElementById("txt_mobile").value=$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "mob");
     document.getElementById("txt_email").value=$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "email");
     document.getElementById("txt_remarks").value=$('#subenqsearch').jqxGrid('getcellvalue', rowindex1, "remarks");

     $('#refno').attr('disabled', false);
     $("#qutdetaildiv").load("quatDetails.jsp?enqrdocno1="+indexval3);
     
     $("#tarifDivId").load("tarifGrid.jsp?");
     $("#tarifcalGrid").jqxGrid('clear');
     $("#targridcalc").load("taricalcu.jsp?");
     
         $('#qotenqsearch').jqxWindow('close');
   
     //  document.getElementById("frmEnquiry").submit();
        
        
     
     		 }); 
 

 });
</script>
<div id="subenqsearch"></div>

