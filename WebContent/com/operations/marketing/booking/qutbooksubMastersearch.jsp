
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>

 <%
 ClsbookingDAO viewDAO=new ClsbookingDAO();
 
String qutdocno = request.getParameter("qutdocno")==null?"0":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");

 String qutdate = request.getParameter("qutdate")==null?"0":request.getParameter("qutdate");
 
%> 

 <script type="text/javascript">
 
 var qutmasterdata1; 
 qutmasterdata1='<%=viewDAO.qutsearchMaster(session,qutdocno,clientname,qutdate)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                 	{name : 'qotrefno' , type: 'number' },
                   	
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
                    {name : 'acno' , type: 'String'} 
                    
                    
						
                   	],
          localdata: qutmasterdata1,
         
         
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
         height: 299,
         source: dataAdapter,
         columnsresize: true,
        // pageable: true,
    
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
              
                 
				{ text: 'hidden doc', datafield: 'doc_no', width: '10%' ,hidden:true},
				{ text: 'Doc No', datafield: 'qotrefno', width: '10%' },
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
				{ text: 'acno', datafield: 'acno', width: '20%',hidden:true }
				
		
				]
     });
     
   
     $('#qutmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
 	 document.getElementById("bookrefno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "qotrefno");
 	 document.getElementById("refqouteno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
 	 
 	 
      var indexvals=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");

    if(parseInt(indexvals)>0)
    	{
    	 document.getElementById("bookclientno").value= indexvals;
    	 document.getElementById("errormsg").innerText="";
    	}
    else
    	{
    	 document.getElementById("bookclientno").value="";
    	
    	 	var temp="";
        	 temp=temp+" NAME: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
               temp=temp+" , "+" ADDRESS: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
           

               
               var temp1="";
             	 temp1=temp1+" Name:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                    temp1=temp1+" , "+" Address:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
                    temp1=temp1+" , "+" Mobile:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no");  
            
         /*   document.getElementById("bookclientname").value=temp;            var values="";
           values=values+" NAME: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname")+"*";
           values=values+" ADDRESS: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address")+"*";
           values=values+" MOB: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no"); */
           
      //    var aa =values.toString().replace(/\*/g, ' \n');   
              
           
           
           document.getElementById("clientdetails").value=temp;

        	   
           document.getElementById("clientdetails").value=temp1;
        	   
        	
        	   
        	  
           
           document.getElementById("bookcontactno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no");
           document.getElementById("bookemail").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
           document.getElementById("guestremark").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
           document.getElementById("bookattention").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "attn_to");
           
           document.getElementById("clientacno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "acno"); 
           
           document.getElementById("clientname").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname"); 
           
           $('#bookqutSearch').jqxWindow('close');
           
           document.getElementById("errormsg").innerText="Its Not a Valid Client";
           return 0;
    	}
         
         
       	var temp="";
     	 temp=temp+" NAME: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
             temp=temp+" , "+" ADDRESS: "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
        
             
             var temp1="";
           	 temp1=temp1+" Name:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                  temp1=temp1+" , "+" Address:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "address");
                  temp1=temp1+" , "+" Mobile:- "+$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no");  
                 
        document.getElementById("bookclientname").value=temp;
        
        document.getElementById("clientdetails").value=temp1;
        
        document.getElementById("bookcontactno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "contact_no");
        document.getElementById("bookemail").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
        document.getElementById("guestremark").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
        document.getElementById("bookattention").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "attn_to");
        
        document.getElementById("clientacno").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "acno"); 
        
        document.getElementById("clientname").value=$('#qutmasterSearch').jqxGrid('getcellvalue', rowindex1, "refname"); 
        
        
        document.getElementById("errormsg").innerText="";
  
        
       $('#bookqutSearch').jqxWindow('close');
     
     		 });	 
     
 });
</script>
<div id="qutmasterSearch"></div>

