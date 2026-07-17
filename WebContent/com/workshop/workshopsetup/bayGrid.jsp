<%@page import="com.workshop.workshopsetup.bay.ClsBayDAO" %>
<%ClsBayDAO ccd=new ClsBayDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%>
 <script type="text/javascript">
 var data= '<%=ccd.getBayGrid(docno)%>';
 $(document).ready(function () { 
 var source =
 {
     datatype: "json",
     datafields: [
               	{name : 'doc_no' , type: 'int' },
						{name : 'name', type: 'String'  },
               	
               	
               	{name : 'code',type:'string'},
               	{name :'date',type:'date'},
               	
      ],
      localdata: data,
     
     
     pager: function (pagenum, pagesize, oldpagenum) {
         // callback called when a page or page size is changed.
     }
 };
 
 var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
              // alert(error);    
               }
           }		
 ); 
 $("#jqxTECSearch1").jqxGrid(
         {
         	width: '100%',
         	height:310,
             source: dataAdapter,
             showfilterrow: true,
             filterable: true,
             selectionmode: 'singlerow',
             sortable: true,
             altrows:true,
             //Add row method
             columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '20%' },
					{ text: 'Code',datafield: 'code', width: '25%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '27%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Name', datafield: 'name', width: '28%' }
					
	              ]
         });

 $('#jqxTECSearch1').on('rowdoubleclick', function (event) 
 		{ 
           	var rowindex1=event.args.rowindex;
               document.getElementById("docno").value= $('#jqxTECSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
               document.getElementById("code").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "code");
               document.getElementById("name").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "name");
               $("#baydate").jqxDateTimeInput('val', $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
               document.getElementById("txtaccno").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
               document.getElementById("txtaccname").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "description");
               document.getElementById("hidacno").value=$("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
 		 });
 
 }); 
 
</script>

<div id="jqxTECSearch1"></div>
    