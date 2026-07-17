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

 
String qutdocno = request.getParameter("qutdocno")==null?"0":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String clmob = request.getParameter("clmob")==null?"0":request.getParameter("clmob");
 String qutdate = request.getParameter("qutdate")==null?"0":request.getParameter("qutdate");
 
 String quttype = request.getParameter("quttype")==null?"0":request.getParameter("quttype").trim(); 

%> 

 <script type="text/javascript">
 
 var qutmasterdata; 
 

 qutmasterdata='<%=viewDAO.searchMaster(session,qutdocno,clientname,clmob,qutdate,quttype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                	{name : 'voc_no' , type: 'number' },
                	{name : 'enqrefno' , type: 'number' },
                	
                   	{name : 'date' , type: 'date' },
                     {name : 'cldocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'address' , type: 'String' },
                 	{name : 'contact_no' , type: 'String' },
                 	{name : 'ref_no' , type: 'String' },
                 	{name : 'ref_type' , type: 'String'} ,
                    {name : 'remarks' , type: 'String'} ,
                    {name : 'attn_to' , type: 'String'} ,
                    {name : 'glterms' , type: 'String'} 
                    
                    
						
                   	],
          localdata: qutmasterdata,
         
         
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
     $("#qutmasterSearch").jqxGrid(
     {
         width: '100%',
         height: 290,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' ,hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'refname', width: '25%' },
				{ text: 'Address', datafield: 'address', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'MOB', datafield: 'contact_no', width: '15%' },
				{ text: 'ref_no', datafield: 'ref_no', width: '20%',hidden:true },
				{ text: 'ref_type', datafield: 'ref_type', width: '20%',hidden:true },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true },
				{ text: 'attend', datafield: 'attn_to', width: '20%',hidden:true },
				{ text: 'gelterm', datafield: 'glterms', width: '20%',hidden:true },
				{ text: 'enqrefno', datafield: 'enqrefno', width: '20%',hidden:true }
		
				]
     });
  /*    $("#qutmasterSearch").jqxGrid('addrow', null, {}); */
     
     $('#qutmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
 		$('#jqxQuoteDate').jqxDateTimeInput({ disabled: false});
        $('#jqxQuoteDate').val($("#qutmasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
 	 var reftype=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "ref_type");
     
     
     //  alert(cldocnval);
       if(reftype=="CEQ")
     	  {
     	 //alert(reftype);
    	   $('#cmbreftype').val(reftype);
    	   document.getElementById("reftypeval").value="CEQ";
     	
     	  }
       else
    	   {
    	   $('#cmbreftype').val(reftype);
    	   document.getElementById("reftypeval").value="";
    	   }
       document.getElementById("masterdoc_no").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
       document.getElementById("docno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
       $('#refno').attr('disabled', false);
       document.getElementById("refno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "enqrefno");
       document.getElementById("enqrefno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "ref_no");
       
      
       
       $('#jqxQuoteDate').jqxDateTimeInput({ disabled: false});
       $('#jqxQuoteDate').jqxDateTimeInput('val',$("#qutmasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
    	 
         document.getElementById("cl_dcocno").value= $('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
         
       	var temp="";
     	 temp=temp+" NAME: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
             temp=temp+" , "+" ADDRESS: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
        
             
         
        document.getElementById("client_details").value=temp;
        

        
        document.getElementById("txt_mobile").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no");
        document.getElementById("txt_email").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
        document.getElementById("txt_remarks").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
        document.getElementById("txt_attention").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "attn_to");
        
        document.getElementById("desc_main").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "glterms");
         $('#window').jqxWindow('close');
         $('#jqxQuoteDate').jqxDateTimeInput({ disabled: false});
         $('#refno').attr('disabled', false);
     	$('#frmQuote select').attr('disabled', false );
     	 funSetlabel();
       document.getElementById("frmQuote").submit();
        
        
     
     		 });	 
     
 });
</script>
<div id="qutmasterSearch"></div>

    
    </body>
</html>
