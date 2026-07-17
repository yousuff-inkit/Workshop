<%@page import="com.operations.marketing.leasecalculator.*" %>
<%ClsLeaseCalculatorDAO calcdao=new ClsLeaseCalculatorDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String leasereqdocno=request.getParameter("leasereqdocno")==null?"":request.getParameter("leasereqdocno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
%>
 
 <script type="text/javascript">
    var searchdata='<%=calcdao.getSearchData(docno,leasereqdocno,date,id,client,mobile)%>';  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'leasereqdocno', type: 'String'  },
     						{name : 'date',type:'date'},
     						{name : 'refname',type:'string'},
     						{name : 'mobile',type:'string'}
                 ],
                 localdata: searchdata,
                
                
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
            $("#leaseCalcSearch").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //showfilterrow: true,
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Lease Req Doc', datafield: 'leasereqdocno', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Client', datafield: 'refname', width: '45%' },
					{ text: 'Mobile', datafield: 'mobile', width: '20%' },
	              ]
            });

            $('#leaseCalcSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#leaseCalcSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("leasereqdoc").value = $("#leaseCalcSearch").jqxGrid('getcellvalue', rowindex1, "leasereqdocno");
		                $('#date').jqxDateTimeInput('val',$("#leaseCalcSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                document.getElementById("leasereqclient").value=$('#leaseCalcSearch').jqxGrid('getcellvalue', rowindex1, "refname");
		                document.getElementById("clientmob").value=$('#leaseCalcSearch').jqxGrid('getcellvalue', rowindex1, "mobile");
		                $('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
		                document.getElementById("btnleaseedit").style.display="block";
		                document.getElementById("btnleaseedit").disabled=true;
		                $('#window').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="leaseCalcSearch"></div>