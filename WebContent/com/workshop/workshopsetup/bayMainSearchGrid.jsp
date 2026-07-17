<%@page import="com.workshop.workshopsetup.bay.ClsBayDAO" %>
<% ClsBayDAO wd=new ClsBayDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String code = request.getParameter("code")==null?"0":request.getParameter("code");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
%> 

 <script type="text/javascript">
 
 			var data3='<%=wd.bayMainSearch(docNo,date,code,name)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },  
      						{name : 'date', type: 'date'  },
                            {name : 'code', type: 'String' }, 
                            {name : 'name', type: 'String' },
     						
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
            $("#baySearch").jqxGrid(
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
					]
            });
            
			   $('#baySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                funReset();
                $('#baydate').jqxDateTimeInput({disabled: false});
                document.getElementById("docno").value= $('#baySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("baydate").value= $('#baySearch').jqxGrid('getcellvalue', rowindex1, "date");
                document.getElementById("name").value= $('#baySearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("code").value= $('#baySearch').jqxGrid('getcellvalue', rowindex1, "code");
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
    <div id="baySearch"></div>
    