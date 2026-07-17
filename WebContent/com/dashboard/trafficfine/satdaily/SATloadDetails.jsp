    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
    <%@page import="com.SatAutoDownload.SATdownloadDAO" %>
<%SATdownloadDAO sd=new SATdownloadDAO(); %>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>

 <script type="text/javascript">
 var data;
  var salikdailyexceldata;
 
 data= '<%= sd.loadSalikdaily(fromdate,todate,satcateg) %>';
salikdailyexceldata= '<%= sd.loadSalikdailyExcel(fromdate,todate,satcateg) %>' ;
   
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'Salik_User', type: 'String'  },
     						{name : 'trans', type: 'String'  },
     						{name : 'salik_date', type: 'String' },
     						{name : 'salik_time', type: 'String' },
     						{name : 'sal_date', type: 'String' },
     						{name : 'regno', type: 'String' },
     						{name : 'source', type: 'String' },
     						{name : 'tagno', type: 'String' },
     						{name : 'location', type: 'String' },
     						{name : 'direction', type: 'String' },
     						{name : 'amount', type: 'Double' },
     						{name : 'date', type: 'String' }
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
					{ text: '#Transaction',columntype: 'textbox', datafield: 'trans', width: '10%' },
					{ text: 'Downloaded Date',columntype: 'textbox',  datafield: 'date', width: '10%' },
					{ text: 'Trip Date',columntype: 'textbox', datafield: 'salik_date', width: '10%' },
					{ text: 'Trip Time',columntype: 'textbox', datafield: 'salik_time', width: '10%' },
					{ text: 'Post Date',columntype: 'textbox', datafield: 'sal_date', width: '10%' },
					{ text: 'Plate',columntype: 'textbox',  datafield: 'regno', width: '10%' },
					{ text: 'Source',columntype: 'textbox',  datafield: 'source', width: '10%' },
					{ text: 'Tag',columntype: 'textbox',  datafield: 'tagno', width: '10%' },
					{ text: 'Location',columntype: 'textbox',  datafield: 'location', width: '10%' },
					{ text: 'direction',columntype: 'textbox',  datafield: 'direction', width: '10%' },
					{ text: 'Amount',columntype: 'textbox',  datafield: 'amount', width: '10%' }
					
					
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
