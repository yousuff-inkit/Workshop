<%@page import="com.dashboard.vehiclepurchase.mortgagesettlement.ClsMortgageSettlementDAO"%>
<%ClsMortgageSettlementDAO mortgagedao=new ClsMortgageSettlementDAO(); %>
 <script type="text/javascript">
var balanceacnodata='<%=mortgagedao.getBalanceLoanAcno()%>';
$(document).ready(function () { 	
        
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'doc_no',type:'int'},
                            {name : 'account',type:'string'},
     						{name : 'description', type: 'string'  }
                 ],               
               localdata:balanceacnodata,
               
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

            
            
            $("#balanceLoanAcnoSearchGrid").jqxGrid(
            {
                width: '98%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                filterable:true,
                showfilterrow:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                 
				},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Account',datafield:'account',width:'15%'},
                            { text: 'Description',datafield:'description',width:'75%'},
                            { text: 'Doc No',datafield:'doc_no',width:'15%',hidden:true}
	              ]
            });
            
            $('#balanceLoanAcnoSearchGrid').on('rowdoubleclick', function (event) 
            	{ 
          	 		var rowindex=event.args.rowindex;
           		 	document.getElementById("balanceloanacno").value=$('#balanceLoanAcnoSearchGrid').jqxGrid('getcellvalue',rowindex,'description');
           		 	document.getElementById("hidbalanceloanacno").value=$('#balanceLoanAcnoSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
	           		$('#balanceloanacwindow').jqxWindow('close');
              	});	 
            
            
             });
    </script>
    
    <div id="balanceLoanAcnoSearchGrid"></div>