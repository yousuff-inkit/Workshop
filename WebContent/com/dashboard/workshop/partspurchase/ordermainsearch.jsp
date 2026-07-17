<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
ClsPartsPurchaseDAO plandao=new ClsPartsPurchaseDAO();
String sparerownos=request.getParameter("sparerownos")==null?"0":request.getParameter("sparerownos");
%> 
 
<script type="text/javascript">

var niordermain= '<%=plandao.refnosearch(session, sparerownos) %>'; 
 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'date', type: 'date'   },
     						{name : 'netamount', type: 'number'   },
     						{name : 'type', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'delterm', type: 'string'   },
     						{name : 'payterm', type: 'string'   },
                        	{name : 'deldate', type: 'date'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						{name : 'curid', type: 'string'   },
     						{name : 'voc_no', type: 'string'   },
     						{name : 'typeid', type: 'string'   },
     						{name : 'ptype', type: 'string'   },
     						{name : 'per', type: 'string'   },
     						{name : 'cldocno', type: 'int'   },
     						
                        ],
                		localdata: niordermain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#refnosearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
	
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '15%' },
							{ text: 'Account Name', datafield: 'description', width: '44%' },
							{ text: 'Amount', datafield: 'netamount', width: '16%',cellsalign: 'right', align:'right',cellsformat:'d2'  },
							{ text: 'type', datafield: 'type', width: '5%',hidden:true },
							{ text: 'refno', datafield: 'refno', width: '5%',hidden:true },
							{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
							{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
							{ text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
							{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'Description', datafield: 'desc1', width: '32%' ,hidden:true},
							{ text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
							{ text: 'curid', datafield: 'curid', width: '2%',hidden:true },
							{ text: 'docno', datafield: 'doc_no', width: '2%' ,hidden:true },
										
						]
            });
            
             $('#refnosearch').on('rowdoubleclick', function (event) {
            	 var  rowindex1=event.args.rowindex;
            	
            	 $("#nirefno").val($('#refnosearch').jqxGrid('getcellvalue', rowindex1, "voc_no")); 
            	 $("#npodoc_no").val($('#refnosearch').jqxGrid('getcellvalue', rowindex1, "doc_no")); 
            	 
            	 $("#cmbvendor").val($('#refnosearch').jqxGrid('getcellvalue', rowindex1, "cldocno")).trigger('change'); 
            
            	 $('#refnosearchwindow').jqxWindow('close');
            }); 
             
        });
    </script>
    <div id="refnosearch"></div>