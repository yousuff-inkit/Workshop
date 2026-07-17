<%@page import="com.workshop.workshopsetup.technician.ClsTechnicianDAO" %>
<%ClsTechnicianDAO ccd=new ClsTechnicianDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%>
 <script type="text/javascript">
	$(document).ready(function () {     
		var data= '<%=ccd.searchDetails(docno)%>';
		 
		  
		  var source =
          {
              datatype: "json",
              datafields: [
                        	{name : 'doc_no' , type: 'int' },
   							{name : 'name', type: 'String'  },
                        	{name : 'email', type: 'String'  },
                        	{name : 'acno',type:'string'},
                        	{name : 'description',type:'String'},
                        	{name : 'mobile',type:'string'},
                        	{name : 'code',type:'string'},
                        	{name :'date',type:'date'},
                        	{name : 'acdoc',type:'String'}
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
      					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
      					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
      					{ text: 'Name', datafield: 'name', width: '20%' },
      					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
      					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
      					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'email', width: '15%' },
      					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
      					{ text: 'Ac Doc',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true }

      	              ]
                  });

          $('#jqxTECSearch1').on('rowdoubleclick', function (event) 
          		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxTECSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("code").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("name").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("email").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "email");
		                document.getElementById("mobile").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
		                $("#techniciandate").jqxDateTimeInput('val', $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("txtaccno").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
		                document.getElementById("txtaccname").value = $("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "description");
		                document.getElementById("hidacno").value=$("#jqxTECSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
          		 });
 
 }); 
 
</script>

<div id="jqxTECSearch1"></div>
    