<%@page import="com.dashboard.security.ClsSecurity" %>
<%ClsSecurity cs=new ClsSecurity();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <script type="text/javascript">

 var data2='<%=cs.cardSearch()%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'cardtype', type: 'String'},
     						{name : 'cardno', type: 'String'},
     						{name : 'exp_date', type: 'date'},
     						{name : 'type', type: 'int'},
                          	],
                          	localdata: data2,
                
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
            $("#jqxCardSearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                columnsresize: true,
                selectionmode: 'singlerow',
               
                columns: [
							{ text: 'Card Type', datafield: 'cardtype', width: '30%' },
							{ text: 'Card No', datafield: 'cardno', width: '50%' },
							{ text: 'Exp Date', datafield: 'exp_date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
							{ text: 'Type', datafield: 'type', hidden: true, width: '10%' },
				
					]
            });
    
            $('#jqxCardSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("cmbcardtype").value = $('#jqxCardSearch').jqxGrid('getcellvalue', rowindex1, "type");
                document.getElementById("txtchequeno").value = $('#jqxCardSearch').jqxGrid('getcellvalue', rowindex1, "cardno");
                $("#chqdate").jqxDateTimeInput('val', $("#jqxCardSearch").jqxGrid('getcellvalue', rowindex1, "exp_date"));
                $('#cardDetailsWindow').jqxWindow('close');  
            });  
				           
 }); 

</script>
<div id="jqxCardSearch"></div>
    
