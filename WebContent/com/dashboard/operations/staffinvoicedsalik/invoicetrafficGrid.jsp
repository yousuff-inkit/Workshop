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
 var trafficdailyexceldata;
 
 
 data= '<%= sd.invoicedGridLoading(fromdate,todate,satcateg) %>';
 trafficexcel= '<%= sd.TrafficExcel(fromdate,todate,satcateg) %>' ;
    
 // alert("==================loadTrafficData"); 
  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
            		
    //tcno,ticket_no,traffic_date,time,fine_source,amount,regno,Pcolor,licence_no,licence_from,tick_violat,tick_location
            		
                datatype: "json",
                datafields: [
							{name : 'ra_no', type: 'string'    },
							{name : 'rtype', type: 'string'    },
							{name : 'inv_no', type: 'string'    },
							{name : 'refname', type: 'string'    },
							{name : 'sal_name', type: 'string'    },
						
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'ticket_no', type: 'string'    },
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
            $("#jqxloadtrafficdataGrid").jqxGrid(
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
                          { text: 'Location', datafield: 'location', width: '20%' },
                          { text: 'Source', datafield: 'source', width: '30%' },
                          { text: 'Ticket No.', datafield: 'ticket_no', width: '15%' },
                          { text: 'Amount', datafield: 'amount', width: '15%',cellsformat: 'd2',cellsalign: 'right', align:'right' },

	              ]
            });

            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloadtrafficdataGrid"></div>
