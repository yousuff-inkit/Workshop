<%@page import="com.dashboard.workshop.nipurchasecreate.ClsNiPurchaseCreateDAO" %>
<% ClsNiPurchaseCreateDAO DAO=new ClsNiPurchaseCreateDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");  %>
<script type="text/javascript">
        
        var data2;
        var chk=<%=chk%>
        if(chk==1){
        	
           data2= <%=DAO.getPoSearchDeatils(docno,date,chk)%>;
        }
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'int'   },
							{name : 'doc_no', type: 'int'   },
							{name : 'date', type: 'date'   },
							{name : 'refname', type: 'string'},
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#poSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
                          
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
                          
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Voc No',  datafield: 'voc_no', hidden: false, width: '10%' },
							{ text: 'Date',  datafield: 'date',cellsformat:'dd.MM.yyyy', width: '10%'},
							{ text: 'Vendor', datafield: 'refname', width: '75%' },
						]
            });
            
             $('#poSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("pono").value = $('#poSearchGridID').jqxGrid('getcellvalue', rowindex1, "voc_no");
                document.getElementById("podocno").value = $('#poSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                
            	$('#poToWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="poSearchGridID"></div>
 