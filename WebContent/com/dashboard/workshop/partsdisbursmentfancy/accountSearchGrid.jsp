<%@page import="com.dashboard.workshop.partsdisbursmentfancy.*"%>
<% ClsWSPartsDisbursmentFancyDAO DAO= new ClsWSPartsDisbursmentFancyDAO(); %>
 <%
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String fromto = request.getParameter("fromto")==null?"0":request.getParameter("fromto");
%> 

 <script type="text/javascript">
 var id='<%=id%>';
 var accountdata=[];
 if(id=="1"){
 	accountdata='<%=DAO.getAccountData(fromto,id)%>';
 }
 else{
 	accountdata=[];
 }
 	$(document).ready(function () { 
 		 var temp='<%=fromto%>';
 		 
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'number'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'currency', type: 'string'  },
 						{name : 'curid', type: 'int'  },
 						{name : 'rate', type: 'number'  },
 						{name : 'type', type: 'string'  }
                    ],
            		localdata: accountdata, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#accountSearchGrid").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			filterable:true,
 			showfilterrow:true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
            			{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '10%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '60%' }
					]
        });
        
         $('#accountSearchGrid').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            if(temp=="1"){
	            document.getElementById("fromacno").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("fromaccount").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("fromaccountname").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "description");
            }
            else if(temp=="2"){
            	document.getElementById("toacno").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("toaccount").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("toaccountname").value = $('#accountSearchGrid').jqxGrid('getcellvalue', rowindex1, "description");
            }
          $('#accountwindow').jqxWindow('close');  
        });  
    });
</script>

<div id="accountSearchGrid"></div>
    