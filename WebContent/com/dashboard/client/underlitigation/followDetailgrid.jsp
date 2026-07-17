<%@page import="com.dashboard.client.ClsClientDAO"%>
<%ClsClientDAO DAO= new ClsClientDAO(); %>
<% String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
 
	 var detailss='<%=DAO.underlitigationDetails(rdoc,check)%>'; 
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date'  },
     						{name : 'user', type: 'String'},
     						{name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
                          	],
                          	localdata: detailss,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#duedetailsgrid").jqxGrid(
            { 
            	width: '100%',
                height: 102,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:false,
     					
                columns: [
						
							 { text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							 { text: 'User', datafield: 'user', width: '18%' },
							 { text: 'Follow Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 { text: 'Remarks', datafield: 'remk', width: '62%' },
					
					]
            });
         
});
                       
</script>
<div id="duedetailsgrid"></div>