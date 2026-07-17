    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
    <%@page import="com.dashboard.operations.staffinvoicedsalik.StaffinvoicedsalikDAO" %>
<%
	StaffinvoicedsalikDAO sd=new StaffinvoicedsalikDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>

 <script type="text/javascript">
 var data;
  var salikdailyexceldata;
 
 data= '<%= sd.loadSalikdaily(fromdate,todate,satcateg) %>';
 salicexcel= '<%= sd.loadSalikdailyExcel(fromdate,todate,satcateg) %>' ; 
   
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							
						{name : 'ra_no', type: 'string'    },
						{name : 'rtype', type: 'string'    },
						{name : 'inv_no', type: 'string'    },
						{name : 'sal_name', type: 'string'    },

     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'amount', type: 'string'    }
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '100%',
                height: 480,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
{ text: 'Doc No', datafield: 'ra_no', width: '8%' },
{ text: 'Type', datafield: 'rtype', width: '14%' },
{ text: 'Jv No', datafield: 'inv_no', width: '8%' },
{ text: 'Employee', datafield: 'sal_name', width: '14%' },

{ text: 'Reg No.', datafield: 'regno', width: '10%' },
{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
{ text: 'Location', datafield: 'location', width: '15%' },
{ text: 'Direction', datafield: 'direction', width: '15%' },
{ text: 'Source', datafield: 'source', width: '20%' },
{ text: 'Tag No.', datafield: 'tagno', width: '15%' },
{ text: 'Amount', datafield: 'amount', width: '15%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
					
					
	              ]
            });

            /* $('#jqxloaddataGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txtsalikfleetno").value= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
		                document.getElementById("txtsaliktagno").value= $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "salik_tag");
		              $('#unameWindow').jqxWindow('close');
            		 }); */ 
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
