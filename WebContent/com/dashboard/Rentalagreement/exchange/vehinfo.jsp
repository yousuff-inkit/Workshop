<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>
 
 
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

 var vehdata='<%=crad.vehSearchexchang(branchids,group)%>'; 
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
     						{name : 'kmin', type: 'String'  },
     						{name : 'fin', type: 'String'  },
     						{name : 'a_loc', type: 'String'  }
     						//a_loc
     				                        	
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
					
					{ text: 'FLEETNO', datafield: 'fleet_no', width: '30%'},
				
					{ text: 'NAME', datafield: 'flname', width: '70%'  },
		

					
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              //	outloc outfuel outkm outfleet
            	//alert($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fin"));
         $("#outfuel").prop("disabled", false);
               document.getElementById("outfleet").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
                document.getElementById("outkm").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
               document.getElementById("outfuel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fin");
               document.getElementById("outfuelval").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fin");
               document.getElementById("outloc").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
               
             
               $("#outfuel").prop("disabled", true);  

                $('#vehinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>