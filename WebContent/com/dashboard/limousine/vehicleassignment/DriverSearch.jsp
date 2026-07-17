     <%@ page import="com.dashboard.limousine.vehicleassignment.ClsToAssign" %>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
        
       <%--  var data1= '<%=com.finance.transactions.cashpayment.ClsCashPaymentDAO.cashPaymentGridSearch() %>';  --%>
       <script type="text/javascript">
       var drvs;
       <%
	  ClsToAssign ctds=new ClsToAssign();
       
		%>
		drvs='<%= ctds.searchDriver()%>';
		
       
		$(document).ready(function () { 	
        	/* var url=""; */
             var num = 0; 
             var data1;
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'dr_id', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation', type: 'string'    },
     						{name : 'mobno', type: 'string'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'issdate', type: 'date'    },
     						{name : 'led', type: 'date'    },
     						{name : 'ltype', type: 'string'    },
     						{name : 'issfrm', type: 'string'    },
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },
     						{name : 'visano', type: 'string'    },
     						{name : 'visa_exp', type: 'date'    },
     						{name : 'hcdlno', type: 'string'    },
     						{name : 'hcissdate', type: 'date'    },
     						{name : 'hcled', type: 'string'    },
     						{name : 'age', type: 'number'    },
     						{name : 'drage', type: 'number'    },
     						{name : 'licyr', type: 'number'    },
     						{name : 'expiryear', type: 'nember'}
                        ],
                		
                       
                       localdata: drvs,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverSearch").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              { text: 'clientid', datafield: 'codeno', width: '1%',hidden:true },
                              { text: 'cli drdoc', datafield: 'doc_no', width: '1%' ,hidden:true},
                              { text: 'cli drid', datafield: 'dr_id', width: '1%' ,hidden:true},
							{ text: 'Name', datafield: 'name', width: '15%' },
							{ text: 'Date of Birth', datafield: 'dob', cellsformat: 'dd-MM-yyyy',width: '10%' },
							{ text: 'Nationality', datafield: 'nation', width: '10%' },
							{ text: 'Mob No', datafield: 'mobno', width: '14%' },
							{ text: 'Licence#', datafield: 'dlno', width: '10%' },
							{ text: 'Lic Issued', datafield: 'issdate',cellsformat: 'dd-MM-yyyy', width: '9%' },
							{ text: 'Lic Expiry', datafield: 'led', width: '9%' , cellsformat: 'dd-MM-yyyy'},
							{ text: 'Lic Type', datafield: 'ltype', width: '12%',hidden:true },
							{ text: 'Iss From', datafield: 'issfrm', width: '9%' },
							{ text: 'Passport#', datafield: 'passport_no', width: '10%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp', width: '12%', cellsformat: 'dd-MM-yyyy',hidden:true },
						/* 	{ text: 'Visa#', datafield: 'visano', width: '10%' },
							{ text: 'Visa Exp.#', datafield: 'visa_exp', width: '12%' },
							{ text: 'HC Licence#', datafield: 'hcdlno', width: '10%' },
							{ text: 'HC Lic Issued', datafield: 'hcissdate', width: '12%' },
							{ text: 'HC Lic Expiry', datafield: 'hcled', width: '12%' }, */
	             
						]
            });
            
          $('#driverSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                document.getElementById("driver").value= $('#driverSearch').jqxGrid('getcellvalue',rowindex2, "name"); 
                document.getElementById("docno").value= $('#driverSearch').jqxGrid('getcellvalue',rowindex2, "doc_no"); 
                /* var rows = $('#jqxgrid2').jqxGrid('getrows');
               var rowlength= rows.length;
              if(rowindex1==rowlength-1)
              {
              $("#jqxgrid2").jqxGrid('addrow', null, {});	
              } */
              $('#searchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="driverSearch"></div>
 