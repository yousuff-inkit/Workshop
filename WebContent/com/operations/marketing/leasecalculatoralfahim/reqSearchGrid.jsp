<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralfahim.*" %>
 <%
 String reqdocno = request.getParameter("reqdocno")==null?"":request.getParameter("reqdocno");
 String reqname = request.getParameter("reqname")==null?"":request.getParameter("reqname");
 String reqmob = request.getParameter("reqmob")==null?"":request.getParameter("reqmob");
 String reqdate = request.getParameter("reqdate")==null?"":request.getParameter("reqdate");
 String reqtype = request.getParameter("reqtype")==null?"":request.getParameter("reqtype").trim(); 
 String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
 String reqbranch=request.getParameter("reqbranch")==null?"":request.getParameter("reqbranch");
ClsLeaseCalcAlFahimDAO calcdao=new ClsLeaseCalcAlFahimDAO();
%>
 <script type="text/javascript">
 
 var reqsearchdata; 
 var id='<%=id%>';
 if(id=="1"){
	  reqsearchdata='<%=calcdao.getReqSearchData(reqbranch,reqdocno,reqname,reqmob,reqdate,reqtype,id)%>';  
 }
 else{
	 
 }

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [

	                {name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'address' , type: 'String' },
                 	{name : 'mobile' , type: 'String' },
                 	{name : 'reqtype' , type: 'Int' },
                    {name : 'remarks' , type: 'String'}                      	
                   	
						
                   	],
          localdata: reqsearchdata,
         
         
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
     $("#reqSearchGrid").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' ,hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'address', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'MOB', datafield: 'mobile', width: '15%' },
				{ text: 'enqtype', datafield: 'reqtype', width: '20%',hidden:true },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true }
		
				]
     });
     
   
     $('#reqSearchGrid').on('rowdoubleclick', function (event) 
     		{ 
 	  			var rowindex1=event.args.rowindex;
             	document.getElementById("leasereqdoc").value=$('#reqSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
              	document.getElementById("hidleasereqdoc").value=$('#reqSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("leasereqclient").value=$('#reqSearchGrid').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("clientmob").value=$('#reqSearchGrid').jqxGrid('getcellvalue', rowindex1, "mobile");
              	$('#reqsearchwindow').jqxWindow('close');
     			$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+$('#reqSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
     		 });	 
 });
</script>
<div id="reqSearchGrid"></div>
    </body>
</html>
