<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>

 <% 
 ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
 
 %>

 
 <% String clientId = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
 
 String rowindextemp = request.getParameter("rowindextemp")==null?"0":request.getParameter("rowindextemp");
 
 %> 
 <script type="text/javascript">

 var data2='<%=viewDAO.cardSearch(clientId)%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'cardtype', type: 'String'},
     						{name : 'cardno', type: 'String'},
     						{name : 'exp_date', type: 'date'},
     						{name : 'type', type: 'int'},
     						
     						{name : 'hidexpdate', type: 'string'},
     						
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
                height: 310,
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
							
							{ text: 'hidexpdate', datafield: 'hidexpdate',  width: '10%' , hidden: true},
							
				
					]
            });
    
            $('#jqxCardSearch').on('rowdoubleclick', function (event) {
                var rowindex2= '<%=rowindextemp%>';
        
                var rowindex = event.args.rowindex;
                $('#jqxgridpayment').jqxGrid('setcellvalue', rowindex2, "cardtype" ,$('#jqxCardSearch').jqxGrid('getcellvalue', rowindex, "type"));

                $('#jqxgridpayment').jqxGrid('setcellvalue', rowindex2, "card" ,$('#jqxCardSearch').jqxGrid('getcellvalue', rowindex, "cardtype")); 
                
             
                
                $('#jqxgridpayment').jqxGrid('setcellvalue', rowindex2, "cardno" ,$('#jqxCardSearch').jqxGrid('getcellvalue', rowindex, "cardno")); 
                
                $('#jqxgridpayment').jqxGrid('setcellvalue', rowindex2, "expdate" ,$('#jqxCardSearch').jqxGrid('getcellvalue', rowindex, "exp_date")); 
                
                $('#jqxgridpayment').jqxGrid('setcellvalue', rowindex2, "hidexpdate" ,$('#jqxCardSearch').jqxGrid('getcellvalue', rowindex, "hidexpdate")); 
                
                
              $('#cardwindow').jqxWindow('close'); 
            
            });  
				           
 }); 

</script>
<div id="jqxCardSearch"></div>
    
