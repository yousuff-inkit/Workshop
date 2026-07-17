 <%@page import="com.workshop.wsinvoice.*" %>
 <%ClsWSInvoiceDAO invdao=new ClsWSInvoiceDAO();
 String docno=request.getParameter("refsearchdocno")==null?"":request.getParameter("refsearchdocno");
 String date=request.getParameter("refsearchdate")==null?"":request.getParameter("refsearchdate");
 String cldocno=request.getParameter("refsearchcldocno")==null?"":request.getParameter("refsearchcldocno");
 String clientname=request.getParameter("refsearchclientname")==null?"":request.getParameter("refsearchclientname");
 String rtype=request.getParameter("reftype")==null?"":request.getParameter("reftype");
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
 %>

 <script type="text/javascript">
var id='<%=id%>';
var searchdata=[];
if(id=="1"){
	searchdata='<%=invdao.getRefData(docno,date,cldocno,clientname,rtype,id,brhid)%>';
}
 $(document).ready(function () {
	 
	 
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
						
  						{name : 'cldocno', type: 'string'},
  						{name : 'regno', type: 'string'},
  						{name : 'account', type: 'string'},
  						{name : 'acname' , type: 'string'},
  						{name : 'acno', type: 'string'},
  						{name : 'voc_no', type: 'string'},
  						{name : 'doc_no', type: 'string'},
  						{name : 'refname' , type: 'string'},
  						{name : 'userdetails' , type: 'string'},
  						{name : 'vehicledetails',type:'string'},
  						{name : 'date',type:'date'},
  						{name : 'nettotal',type:'number'},
  						{name : 'billtoinsurance',type:'number'},
  						{name : 'billtoaccount',type:'string'},
  						{name : 'billtoacname',type:'string'},
  						{name : 'billtoacno',type:'string'}
  						     						
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
	 
	 $("#JobCardSearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 300,
                pageable: false,
                source: dataAdapter,
                editable: false, 
                autoheight: false,
                sortable: 'true',
                selectionmode: 'singlerow',
                
                columns: [
							
							{ text: 'Doc. Nogyhuikjhg', datafield: 'voc_no', width: '18%' },
							{ text: 'Doc. No Original', datafield: 'doc_no', width: '18%',hidden:true },
							{ text: 'Date', datafield: 'date', width: '23%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Client Doc. No.', datafield: 'cldocno', width: '18%' },
							{ text: 'Client Name', datafield: 'refname', width: '40%' },
							{text : 'Acno', datafield: 'acno',hidden:true,width:'0%'},
	  						{text : 'Account', datafield: 'account',hidden:true,width:'0%'},
	  						{text : 'Account Name', datafield: 'acname',hidden:true,width:'0%'},
	  						{text : 'Client Details' , datafield: 'userdetails',hidden:true,width:'10%'},
	  						{text : 'Vehicle Details' , datafield: 'vehicledetails',hidden:true,width:'0%'},
	  						{text : 'Reg No' , datafield: 'regno',hidden:true,width:'0%'},
	  						{text : 'Net Total' , datafield: 'nettotal',hidden:true,width:'0%',cellsformat:'d2'},
	  						{text : 'Bill To Insurance Company' , datafield: 'billtoinsurance',hidden:true,width:'10%'},
	  						{text : 'Bill To Account' , datafield: 'billtoaccount',hidden:true,width:'10%'},
	  						{text : 'Bill To Acname' , datafield: 'billtoacname',hidden:true,width:'10%'},
	  						{text : 'Bill To Acno' , datafield: 'billtoacno',hidden:true,width:'10%'},
	  						
																					
	              ]
            });
	 
	 $('#JobCardSearchGrid').on('rowdoubleclick', function (event) {
         var rowindex=event.args.rowindex;
		  	document.getElementById("refno").value = $("#JobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "voc_no");
		  	document.getElementById("hidrefno").value = $("#JobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "doc_no");
		  	var docno=document.getElementById("hidrefno").value;
		  	funSetJobCardSearchData(docno);
		  	//$('#searchWindow').jqxWindow('close'); 
		  	
     });
 });
 function funSetJobCardSearchData(docno){
	 var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items=JSON.parse(items);
			  	document.getElementById("cldocno").value = items.cldocno;
			  	document.getElementById("userdetails").value =items.userdetails;
			  	document.getElementById("vehicledetails").value = items.vehicledetails;
			  	document.getElementById("regno").value = items.regno;
			  	document.getElementById("invoicetoaccount").value = items.account;
			  	document.getElementById("invoicetoacname").value = items.acname;
			  	document.getElementById("tempinvoicetoaccount").value = items.billtoaccount;
			  	document.getElementById("tempinvoicetoacname").value = items.billtoacname;
			  	document.getElementById("tempinvoicetoacno").value = items.billtoacno;
			  	document.getElementById("invoicetoacno").value = items.acno;
			  	document.getElementById("esttotal").value = items.nettotal;
			  	$('#detaildiv').load('detailGrid.jsp?jobcarddocno='+document.getElementById("hidrefno").value+'&id=1');
			  	var cldocno=document.getElementById("cldocno").value;
			  	var date=$('#date').jqxDateTimeInput('val');
			  	var hidrefno=document.getElementById("hidrefno").value;
			  	getTax(cldocno,date,hidrefno);
				if(items.billtoinsurance=="1"){
					document.getElementById("excessamount").disabled=false;
				}
				else{
					document.getElementById("excessamount").disabled=true;
				}
		  		$('#searchWindow').jqxWindow('close'); 
			}
			else{
			}
		}
		x.open("GET", "setJobCardSearchData.jsp?docno="+docno, true);
		x.send();	
 }
 </script>
 <div id="JobCardSearchGrid"></div>