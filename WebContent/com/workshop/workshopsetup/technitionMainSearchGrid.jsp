<%@page import="com.workshop.workshopsetup.technician.ClsTechnicianDAO" %>
<%ClsTechnicianDAO ccd=new ClsTechnicianDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String code = request.getParameter("code")==null?"0":request.getParameter("code");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
%> 

 <script type="text/javascript">
 
 			var data3='<%=ccd.technitionMainSearch(docNo,date,code,name)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },  
      						{name : 'date', type: 'date'  },
                            {name : 'code', type: 'String' }, 
                            {name : 'name', type: 'String' },
                            {name : 'email', type: 'date'  },
                            {name : 'mobile', type: 'String' }, 
                            {name : 'description', type: 'String' },
                            {name : 'acdoc', type: 'String' },
     						
                          	],
                          	localdata: data3,
                
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
            $("#technitionSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			 showfilterrow: true, 
                filterable: true,
     			
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'Code', datafield: 'code', width: '20%' },
					 { text: 'Name', datafield: 'name', width: '50%' },
					 { text: 'Email', datafield: 'email', width: '20%' },
					 { text: 'Mobile', datafield: 'mobile', width: '50%' },
					 { text: 'Account', datafield: 'description', width: '20%' },
					 { text: 'Acdoc', datafield: 'acdoc', width: '50%' },
					 
					]
            });
            
			   $('#technitionSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                funReset();
                $('#techniciandate').jqxDateTimeInput({disabled: false});
                document.getElementById("docno").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("techniciandate").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "date");
                document.getElementById("name").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("code").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("email").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txtaccno").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "acdoc");
                document.getElementById("txtaccname").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("mobile").value= $('#technitionSearch').jqxGrid('getcellvalue', rowindex1, "mobile");
                setValues();
               /*  $('#workDetailsDate').jqxDateTimeInput({disabled: false});
    			
    			$('#endDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmWorkDetails").submit();
                $('#frmWorkDetails select').attr('disabled', true);
                $('#workDetailsDate').jqxDateTimeInput({disabled: true});
    			$('#startDate').jqxDateTimeInput({disabled: true});
    			$('#endDate').jqxDateTimeInput({disabled: true}); */
                
               $('#window').jqxWindow('close');
            });    
				           
}); 
				       
                       
    </script>
    <div id="technitionSearch"></div>
    