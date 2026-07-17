<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%ClsPartsPurchaseDAO viewDAO=new ClsPartsPurchaseDAO();%>
<%String docno = request.getParameter("docno").toString();%>

<script type="text/javascript">
        var typedata= '<%=viewDAO.getEstimationDetails(docno) %>';
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     							{name : 'doc_no', type: 'int' },
     							{name : 'brhid', type: 'int' },
     							{name : 'dtype', type: 'string' },
                            	{name : 'voc_no', type: 'int' },
     							{name : 'date', type: 'date' },
     							{name : 'nettotal', type: 'number' },
     							{name : 'print', type: 'string' },
                        	],
                		 localdata: typedata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#estDetailsGrid").jqxGrid(
            {
            	width: '99.5%',
                height: 440,
                source: dataAdapter,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Doc Type',  datafield: 'dtype', width: '20%' }, 
							{ text: 'Doc No', datafield: 'voc_no', width: '20%' },
							{ text: 'Date', datafield: 'date', width: '20%', cellsformat:'dd.MM.yyyy' },
							{ text: 'Net Total', datafield: 'nettotal', width: '25%', align:'right', cellsalign:'right', cellsformat:'d2' },
							{ text: '',  datafield: 'print', columntype: 'button', width: '15%' },
						]
            });
            
            $("#estDetailsGrid").on('cellclick', function (event){
          		var rowindextemp = event.args.rowindex;
           		var datafield = event.args.datafield;
            	
           		if(datafield=="print"){
           			var dtype=$('#estDetailsGrid').jqxGrid('getcellvalue', rowindextemp, "dtype");
           			var doc_no=$('#estDetailsGrid').jqxGrid('getcellvalue', rowindextemp, "doc_no");
           			var brhid=$('#estDetailsGrid').jqxGrid('getcellvalue', rowindextemp, "brhid");
            		funPrintDoc(dtype, doc_no, brhid);
            	}
            });
            
        });
        
        function funPrintDoc(dtype, doc_no, brhid){
    		var url=document.URL;
    		
    		var reurl=url.split("com/");
    		 
    		if(dtype=="GIS"){
    			 var win= window.open(reurl[0]+"com/sales and marketing/Inventory Transfer/goodsissuenote/PRINTgin?docno="+doc_no+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    		     
    		}else if(dtype=="COT"){
    			$('#printWindow').jqxWindow('open');
    	    	SearchContent('printVoucherWindow.jsp?doc_no='+doc_no+'&brhid='+brhid,'printWindow');
    			
    		}else if(dtype=="NPO"){
    			var win= window.open(reurl[0]+"com/finance/nipurchase/nipurchaseorder/printniphOrder?docno="+doc_no+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");

    		}else if(dtype=="CPU"){
    			var win= window.open(reurl[0]+"com/finance/nipurchase/nipurchase/printniphs1?docno="+doc_no+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    		
    		}
    	}
        
    </script>
    <div id="estDetailsGrid"></div>
 