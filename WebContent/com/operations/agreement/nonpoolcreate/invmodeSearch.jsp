<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.agreement.nonpoolcreate.*"%>
<%ClsNonPoolCreateDAO nonpooldao=new ClsNonPoolCreateDAO(); %>
<script type="text/javascript">
        $(document).ready(function () { 	
        	//var url = "specification.txt";
            var invmodedata='<%=nonpooldao.getInvmodeData()%>';
            //alert(dataspec);
        	var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'idno', type: 'int'  },
     						{name : 'description', type: 'string'   },							
     						{name : 'acno', type: 'string'   }
     						],
                 localdata: invmodedata,
                
                
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

            
            
            $("#invmodeSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                //editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#invmodeSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'acno' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invmodeSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'ID',datafield: 'idno', width: '20%' },	
							{ text: 'Description', datafield: 'description', width: '80%' },			
							{ text: 'Ac No', datafield: 'acno', width: '20%',hidden:true }					
			              ]
            });
            $("#invmodeSearch").on("rowdoubleclick", function (event) {
            	
                var row2=event.args.rowindex;
              var row5=document.getElementById("invmoderow").value;
              var idno = $('#invmodeSearch').jqxGrid('getcellvalue', row2, "idno");
              var desc1=$('#invmodeSearch').jqxGrid('getcellvalue', row2, "description");
              var acno=$('#invmodeSearch').jqxGrid('getcellvalue', row2, "acno");
              $('#nonPoolRateGrid').jqxGrid('setcellvalue', row5, "idno",idno);
              $('#nonPoolRateGrid').jqxGrid('setcellvalue', row5, "description",desc1);
              $('#nonPoolRateGrid').jqxGrid('setcellvalue', row5, "acno",acno);
              $('#invmodewindow').jqxWindow('close'); 
              $("#nonPoolRateGrid").jqxGrid("addrow", null, {});
                });
        });
    </script>
    <div id="invmodeSearch"></div>
