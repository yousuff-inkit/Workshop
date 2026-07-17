<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecostgroup.ClsleaseCostGroupDAO" %>
<%ClsleaseCostGroupDAO viewDAO= new ClsleaseCostGroupDAO(); %>
 <%
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String gpname = request.getParameter("gpnames")==null?"0":request.getParameter("gpnames");
 
%> 

 <script type="text/javascript">
 
 var masterdata; 
 

  masterdata='<%=viewDAO.searchMaster(gpname,docno)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [

	                  
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'gpname' , type: 'String' },
                   	{name : 'brdid' , type: 'String' },
                   	{name : 'brname' , type: 'String' },
                   	{name : 'modid' , type: 'String' },
                 	{name : 'modelname' , type: 'String' },
                 	 
                    {name : 'desc1' , type: 'String'}   ,
                    
                    {name : 'grpid' , type: 'String' },
                 	
                 	
                 //	doc_no, date, gpname, brdid, modid, brname, vtype, desc1
                   	
						
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
     $("#subsearch").jqxGrid(
     {
         width: '100%',
         height: 315,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%'  },
			 
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
			 
				{ text: 'Group Name', datafield: 'gpname', width: '25%' },
				{ text: 'Brand', datafield: 'brname', width: '25%' },
				{ text: 'Model', datafield: 'modelname', width: '25%'  },
				{ text: 'desc1', datafield: 'desc1', width: '20%',hidden:true },
			 
				{ text: 'brdid', datafield: 'brdid', width: '20%',hidden:true },
				{ text: 'modid', datafield: 'modid', width: '20%',hidden:true },
				{ text: 'grpid', datafield: 'grpid', width: '20%',hidden:true },
				
				
		
				]
     });
     
   
     $('#subsearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
   
   	$('#masterdate').jqxDateTimeInput({ disabled: false});
       $('#masterdate').val($("#subsearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
              document.getElementById("docno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
              document.getElementById("groupname").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "gpname");
              document.getElementById("brandname").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "brname");
              
              document.getElementById("modelname").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "modelname");
                       
              document.getElementById("desc").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "desc1");
      
              document.getElementById("brandid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "brdid");
              document.getElementById("modelid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "modid");
              
              document.getElementById("groupid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "grpid");
              
              
              
              $('#masterdate').jqxDateTimeInput({ disabled: true});
           
       
 
         $('#window').jqxWindow('close');
     	
     	
         
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>
