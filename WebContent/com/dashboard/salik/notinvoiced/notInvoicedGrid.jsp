<%@page import="com.dashboard.salik.*" %>
<%String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentalType = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
 ClsSalikDAO  salikdao=new ClsSalikDAO();
 %>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		data1='<%=salikdao.notInvoicedGridLoading(branchval,fromDate, toDate, cldocno, rentalType, agmtNo,type)%>';
    }
 	
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'amount', type: 'string'    },
     						{name : 'ra_no',type:'string'},
     						{name : 'vocno',type:'string'},
     						{name :'rtype',type:'string'},
     						{name :'sal_date',type:'date'}
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
                $("#jqxNotInvoiced").on("bindingcomplete", function (event) {
					$("#overlay, #PleaseWait").hide();
    	
				});
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxNotInvoiced").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
}   },
						{ text: 'Original Agmt No.', datafield: 'ra_no', width: '7%',hidden:true },
						{ text: 'Agmt No.', datafield: 'vocno', width: '7%' },
						{ text: 'Agmt Type.', datafield: 'rtype', width: '7%' },
						{ text: 'Reg No.', datafield: 'regno', width: '8%' },
						{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
						{ text: 'Salik Date', datafield: 'sal_date', width: '8%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Location', datafield: 'location', width: '12.5%' },
						{ text: 'Direction', datafield: 'direction', width: '10%' },
						{ text: 'Source', datafield: 'source', width: '12.5%' },
						{ text: 'Tag No.', datafield: 'tagno', width: '10%' },
						{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxNotInvoiced").jqxGrid("addrow", null, {});
            }
        });
</script>
<div id="jqxNotInvoiced"></div>
