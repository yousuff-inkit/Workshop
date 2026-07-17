<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.workshop.invoicev3.*" %>
 <%ClsInvoiceV3DAO invdao=new ClsInvoiceV3DAO();
/* 'masterSearchGrid.jsp?docno='+docno+'&date='+date+'&jobcardno='+jobcardno+'&regno='+regno+'&cldocno='+cldocno+'&clientname='+clientname+'&id=1' */
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String jobcardno=request.getParameter("jobcardno")==null?"":request.getParameter("jobcardno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata=[];
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=invdao.getSearchData(docno,date,jobcardno,regno,cldocno,clientname,id,
			session,brhid)%>';
}
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'   },
                            {name : 'voc_no',type:'string'},
     						{name : 'refno', type: 'string'   },
     						{name : 'date',type:'date'},
     						{name : 'reftype', type: 'string'   },
     						{name : 'refvocno',type:'string'},
     						{name : 'userdetails', type: 'string'  },
     						{name : 'vehicledetails',type:'string'},
     						{name : 'regno',type:'string'},
     						{name : 'cldocno',type:'string'},
     						{name : 'refname',type:'string'},
     						{name : 'total', type: 'number'   },
                            {name : 'discount',type:'number'},
     						{name : 'excessamt', type: 'number'   },
     						{name : 'nettotal',type:'number'},
     						{name : 'remarks', type: 'string'   },
     						{name : 'invoicetoaccount',type:'string'},
     						{name : 'invoicetoacno', type: 'string'  },
     						{name : 'invoicetoacname',type:'string'},
     						{name : 'excesstoaccount',type:'string'},
     						{name : 'excesstoacno', type: 'string'  },
     						{name : 'excessacname',type:'string'},
     						{name : 'esttotal',type:'number'},
     						{name : 'taxpercent',type:'number'},
     						{name : 'taxamount',type:'number'},
     						{name : 'taxtotal',type:'number'},
							{name : 'roundamt',type:'number'},
	  						{name : 'billtoaccount',type:'string'},
	  						{name : 'billtoacname',type:'string'},
	  						{name : 'excessinvdocno',type:'string'},
	  						{name : 'tempinvoicetoacno',type:'string'}
     						
     						
                        ],
                		 localdata: searchdata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#masterSearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 290,
                columnsheight:23,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                sortable:false,
                
                columns: [
                          
							{ text: 'SI No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }
							},
                            { text: 'Doc No',  hidden:false, datafield: 'voc_no', width: '10%' },
                            { text: 'Doc No Original',  hidden:true, datafield: 'doc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Ref Type',datafield:'reftype',width:'10%'},
							{ text: 'Ref No',datafield:'refno',width:'10%',hidden:true},
							{ text: 'Ref No',datafield:'refvocno',width:'10%'},
							{ text: 'Client Doc No', datafield: 'cldocno', width: '10%',hidden:true },
							{ text: 'Client Name', datafield: 'refname', width: '45%',hidden:true },
							{ text: 'User Details',datafield:'userdetails',hidden:true},
							{ text: 'vehicle details',datafield:'vehicledetails',hidden:true},
							{ text: 'Regno',datafield:'regno',hidden:true},
							{ text: 'Total', datafield: 'total', width: '45%',hidden:true ,cellsformat:'d2'},
							{ text: 'Discount',datafield:'discount',hidden:true,cellsformat:'d2'},
							{ text: 'Excessamt',datafield:'excessamt',hidden:true,cellsformat:'d2'},
							{ text: 'Net Total',datafield:'nettotal',hidden:true,cellsformat:'d2'},
							{ text: 'Remarks',datafield:'remarks',hidden:true},
							{ text: 'Invoice To Account',datafield:'invoicetoaccount',hidden:false},
							{ text: 'Invoice To Acno',datafield:'invoicetoacno',hidden:true},
							{ text: 'Invoice To Acname', datafield: 'invoicetoacname', width: '45%',hidden:false },
							{ text: 'Excess Account',datafield:'excessaccount',hidden:true},
							{ text: 'Excess Acno',datafield:'excessacno',hidden:true},
							{ text: 'Excess Acname', datafield: 'excessacname', width: '45%',hidden:true },
							{ text: 'Est Total', datafield: 'esttotal', width: '45%',hidden:true ,cellsformat:'d2'},
							{ text: 'Tax Percent', datafield: 'taxpercent', width: '45%',hidden:true ,cellsformat:'d2'},
							{ text: 'Tax Amount', datafield: 'taxamount', width: '45%',hidden:true ,cellsformat:'d2'},
							{ text: 'Tax Total', datafield: 'taxtotal', width: '45%',hidden:true ,cellsformat:'d2'},
							{ text: 'Round Amt', datafield: 'roundamt', width: '45%',hidden:true ,cellsformat:'d2'},
	  						{text : 'Bill To Account' , datafield: 'billtoaccount',hidden:true,width:'10%'},
	  						{text : 'Bill To Acname' , datafield: 'billtoacname',hidden:true,width:'10%'},
	  						{text : 'Excess Inv Docno' , datafield: 'excessinvdocno',hidden:true,width:'10%'},
	  						{text : 'Temp Invoice To Ac No' , datafield: 'tempinvoicetoacno',hidden:true,width:'10%'},
						]
            });
            
           $('#masterSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex = event.args.rowindex;
                $('#refno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "refvocno"));
                $('#hidrefno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "refno"));
                $('#regno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "regno"));
                $('#vehicledetails').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "vehicledetails"));
                $('#userdetails').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "userdetails"));
                $('#cldocno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
                $('#cmbreftype').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "reftype"));
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "doc_no"));
                $('#vocno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "voc_no"));
                $('#total').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "total"));
                $('#discount').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "discount"));
                $('#excessamount').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "excessamt"));
                $('#nettotal').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "nettotal"));
                $('#remarks').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "remarks"));
                $('#invoicetoaccount').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "invoicetoaccount"));
                $('#invoicetoacno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "invoicetoacno"));
                $('#invoicetoacname').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "invoicetoacname"));
                $('#date').jqxDateTimeInput('setDate',$('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "date"));
                document.getElementById("tempinvoicetoaccount").value = $("#masterSearchGrid").jqxGrid('getcellvalue', rowindex, "billtoaccount");
    		  	document.getElementById("tempinvoicetoacname").value = $("#masterSearchGrid").jqxGrid('getcellvalue', rowindex, "billtoacname");
    		  	document.getElementById("tempinvoicetoacno").value = $("#masterSearchGrid").jqxGrid('getcellvalue', rowindex, "tempinvoicetoacno");
                $('#excessamountaccount').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "excessaccount"));
                $('#excessamountacno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "excessacno"));
                $('#excessamountacname').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "excessacname"));
                $('#esttotal').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "esttotal"));
                $('#taxpercent').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "taxpercent"));
                $('#taxamount').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "taxamount"));
                $('#taxtotal').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "taxtotal"));
				$('#roundamt').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "roundamt"));
				var excessinvdocno=$('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "excessinvdocno");
				if(excessinvdocno=="0"){
					document.getElementById("chksaperateinvoice").checked=false;
					document.getElementById("hidchksaperateinvoice").value="0";
				}
				else{
					document.getElementById("chksaperateinvoice").checked=true;
					document.getElementById("hidchksaperateinvoice").value="1";
				}
                $('#invoicediv').load('invoiceGrid.jsp?docno='+$('#docno').val()+'&id=1');
                $('#detaildiv').load('detailNewGrid.jsp?jobcarddocno='+$('#hidrefno').val()+'&id=1&docno='+$('#docno').val());
                var docno=$('#docno').val();
				$.get('getLogDetails.jsp',{'docno':docno},function(data){
					data=JSON.parse(data);
					document.getElementById("errormsg").innerText=data.msg;
				});
                $('#window').jqxWindow('close');
            });
        });
    </script>
    <div id="masterSearchGrid"></div>
 