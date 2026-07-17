 <%@page import="com.workshop.wsinvoicepal.*" %>
 <%ClsWSInvoiceDAO invdao=new ClsWSInvoiceDAO();
 String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
 String date=request.getParameter("date")==null?"":request.getParameter("date");
 String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
 String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String rtype=request.getParameter("rtype")==null?"":request.getParameter("rtype");
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 %>
 <script type="text/javascript">
var id='<%=id%>';
var searchdata;
if(id=="1"){
	<%-- searchdata='<%=invdao.getClientData(docno,date,cldocno,clientname,rtype,id)%>'; --%>
}
 $(document).ready(function () {
	 
	 
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
						
  						{name : 'refno', type: 'string'},
  						{name : 'date', type: 'string'},
  						{name : 'cldocno', type: 'string'},
  						{name : 'clientname' , type: 'string'},
  						{name : 'fleetno', type: 'string'},
  						{name : 'fleetname', type: 'string'},
  						{name : 'invaccount', type: 'string'},
  						{name : 'invacname' , type: 'string'},
  						{name : 'invacno' , type: 'string'}
  						     						
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
	 
	 $("#jqxJobCardSearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 350,
                pageable: false,
                source: dataAdapter,
                editable: false, 
                autoheight: false,
                sortable: 'true',
                selectionmode: 'singlerow',
                
                columns: [
							
							{ text: 'Doc. No', datafield: 'refno', width: '18%' },
							{ text: 'Date', datafield: 'date', width: '23%' },
							{ text: 'Client Doc. No.', datafield: 'cldocno', width: '18%' },
							{ text: 'Client Name', datafield: 'clientname', width: '40%' },
							{text : 'fleetno', datafield: 'fleetno',hidden:true,width:'0%'},
	  						{text : 'fleetname', datafield: 'fleetname',hidden:true,width:'0%'},
	  						{text : 'invaccount', datafield: 'invaccount',hidden:true,width:'0%'},
	  						{text : 'invacname' , datafield: 'invacname',hidden:true,width:'0%'},
	  						{text : 'invacno' , datafield: 'invacno',hidden:true,width:'0%'}
																					
	              ]
            });
	 
	 $('#jqxJobCardSearchGrid').on('rowdoubleclick', function (event) {
         var rowindex=event.args.rowindex;
			funReset();
		  	document.getElementById("refno").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "refno");
		  	document.getElementById("cldocno").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "cldocno");
		  	document.getElementById("clientdetails").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "clientname");
		  	document.getElementById("fleetno").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "fleetno");
		  	document.getElementById("fleetdetails").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "fleetname");
		  	document.getElementById("invoicetoaccount").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "invaccount");
		  	document.getElementById("invoicetoacname").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "invacname");
		  	document.getElementById("invoicetoacno").value = $("#jqxJobCardSearchGrid").jqxGrid('getcellvalue', rowindex, "invacno");
		  	
			$('#jobCardSearchWindow').jqxWindow('close'); 
     });
	 
	 
 });
 
 </script>
 <div id="jqxJobCardSearchGrid"></div>