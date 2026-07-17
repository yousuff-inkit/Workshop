   <%@page import="com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO"%>
     <%ClsleaseApplicationFollowupDAO cmd= new ClsleaseApplicationFollowupDAO(); %>

<%
String stat = request.getParameter("stat")==null?"0":request.getParameter("stat").trim();
%> 

<%--     <jsp:include page="../../../includes.jsp"></jsp:include>  
 --%>
  <script type="text/javascript">
  var stat='<%=stat%>';
    var data= '<%= cmd.dealerMSearch()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'name', type: 'String'  },
     						{name : 'acc_no', type: 'String'  }
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
            $("#jqxDealerGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', filtertype: 'number',datafield: 'doc_no', width: '20%' },
					{ text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '80%' },
					{ text: 'ACC No', filtertype: 'number',datafield: 'acc_no', width: '20%',hidden:true },
	              ]
            });

            $('#jqxDealerGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	if(stat=='PO')
		      		  {
		                document.getElementById("purdealer").value= $('#jqxDealerGrid').jqxGrid('getcellvalue', rowindex1, "name"); 
		                document.getElementById("hidpurdealer").value = $("#jqxDealerGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		              $('#dealerinfowindow').jqxWindow('close');
		      		  }
		            	
		            	else if(stat=='FU')
			      		  {
			                document.getElementById("dealer").value= $('#jqxDealerGrid').jqxGrid('getcellvalue', rowindex1, "name"); 
			                document.getElementById("hiddealer").value = $("#jqxDealerGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
			                document.getElementById("vendacno").value=$('#jqxDealerGrid').jqxGrid('getcellvalue', rowindex1, "acc_no");
			              $('#dealerinfowindow').jqxWindow('close');
			      		  }
            		 }); 
           
        });
    </script>
    <div id="jqxDealerGrid"></div>
