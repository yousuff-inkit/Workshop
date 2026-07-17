<%@page import="com.controlcentre.masters.client.ClsClientDAO" %>
<%
ClsClientDAO DAO=new ClsClientDAO();
%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">

<%--  
var trmps='<%=aa%>';
var vehdata;

 if(trmps!='NA')
	 { --%>

	 var vehdata;
	// alert(vehdata);
/* alert
	 }
 else
	 {
	 vehdata;

	 } */
   // alert(data);
  /*  var url1='disfleetSearch.jsp'; */
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	
     						{name : 'telesale', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     				                        	
                          	],
             
                          	localdata: vehdata,
                
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
            $("#telesearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
              
              filterable: true,
              showfilterrow: true, 
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [
					
					{ text: 'Tele Sales', datafield: 'telesale', width: '100%'},
				
					{ text: 'Docno', datafield: 'doc_no', width: '10%' ,hidden:true },
		

					
					]
            });
            
            $('#telesearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
         
               document.getElementById("tdocno").value=$('#telesearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("telesales").value=$('#telesearch').jqxGrid('getcellvalue', rowindex1, "telesale");

                $('#telesalesinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="telesearch"></div>