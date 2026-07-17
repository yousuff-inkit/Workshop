<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%ClsPartsPurchaseDAO viewDAO=new ClsPartsPurchaseDAO();%>
<%String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");%>

<script type="text/javascript">
        var typedata= '<%=viewDAO.getNiPendingJobs(id, brhid) %>';
        $(document).ready(function () { 
        	
        	 var rendererstring1=function (aggregates){
              	var value=aggregates['sum1'];
              	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
              }    
         
          var rendererstring=function (aggregates) {
          	var value=aggregates['sum'];
          	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
          }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     							{name : 'jobvocno', type: 'int' },
     							{name : 'clientname', type: 'string' },
     							{name : 'vehicledetails', type: 'string' },
     							{name : 'cotaccount', type: 'string' },
     							{name : 'cotdocno', type: 'int' },
     							{name : 'cotdate', type: 'date' },
     							{name : 'productname', type: 'string' },
     							{name : 'cotqty', type: 'number' },
     							{name : 'cotamount', type: 'number' },
                        	],
                		 localdata: typedata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#niPendingJobsGrid").jqxGrid(
            {
            	width: '99.5%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                enabletooltips:true,
                sortable:true,
                columnsresize: true,
                
                columns: [
							{ text: 'Job No',  datafield: 'jobvocno', width: '7%' },
							{ text: 'Client',  datafield: 'clientname', width: '15%' },
							{ text: 'Vehicle',  datafield: 'vehicledetails', width: '18%' },
							{ text: 'To Account',  datafield: 'cotaccount', width: '15%' },
							{ text: 'COT No',  datafield: 'cotdocno', width: '7%' },
							{ text: 'Date',  datafield: 'cotdate', width: '7%', cellsformat:'dd.MM.yyyy' },
							{ text: 'Product Name',  datafield: 'productname', width: '15%', aggregates: ['sum1'], aggregatesrenderer:rendererstring1  },
							{ text: 'COT Qty',  datafield: 'cotqty', width: '8%', cellsformat:'d2',  aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'COT Amount',  datafield: 'cotamount', width: '8%', align:'right', cellsalign:'right', cellsformat:'d2',aggregates: ['sum'], aggregatesrenderer:rendererstring },
						],
            });
            
        });
               
    </script>
    <div id="niPendingJobsGrid"></div>
 