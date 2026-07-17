<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 <%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
<%ClsMarketingDAO cmd= new ClsMarketingDAO(); %>
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%



String branchids = request.getParameter("branchids")==null?"0":request.getParameter("branchids");


String group = request.getParameter("groupid")==null?"NA":request.getParameter("groupid");


%>
 
 <script type="text/javascript">

<%--  
var trmps='<%=aa%>';
var vehdata;

 if(trmps!='NA')
	 { --%>

 var vehdata='<%=cmd.vehSearchbooking(branchids,group)%>'; 
/* 
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
                          	
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						
     				                        	
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
            $("#jqxfleetsearch").jqxGrid(
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
					
					{ text: 'FLEET NO', datafield: 'fleet_no', width: '22%'},
					{ text: 'REG NO', datafield: 'reg_no', width: '18%'},
				
					{ text: 'NAME', datafield: 'flname', width: '60%'  },
		

					
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
         
            	
        
               document.getElementById("txtfleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
/*                document.getElementById("re_Km").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
               document.getElementById("ratariff_fuel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fin");
               document.getElementById("payment_Conveh").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               document.getElementById("vehlocation").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
               
               document.getElementById("hidvehfuel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "hidfin"); */
               
               

                $('#vehinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>