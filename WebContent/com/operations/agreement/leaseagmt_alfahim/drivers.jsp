<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 <script type="text/javascript">
   <%-- var data= '<%=com.operations.agreement.rentalagreement.ClsRentalAgreementAction.driverGrid()%>'; --%>
        $(document).ready(function () { 	
         
            
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'NAME', type: 'string'  },
     						{name : 'DOB', type: 'string'    },
     						{name : 'NATION', type: 'string'    },
     						{name : 'MOBNO', type: 'string'    },
     						{name : 'DLNO', type: 'string'    },
     						{name : 'ISSDATE', type: 'string'    },
     						{name : 'LED', type: 'string'    },
     						{name : 'LTYPE', type: 'string'    },
     						{name : 'ISSFRM', type: 'string'    },
     						{name : 'PASSPORT_NO', type: 'string'    },
     						{name : 'pass_exp', type: 'string'    },
     						{name : 'visano', type: 'string'    },
     						{name : 'visa_exp', type: 'string'    },
     						{name : 'HCDLNO', type: 'string'    },
     						{name : 'HCISSDATE', type: 'string'    },
     						{name : 'HCLED', type: 'string'    }
                 ],
                 localdata: data,
                
                
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

            
            
            $("#jqxDrivers").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxDrivers').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxDrivers").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%' },	
							{ text: 'Name', datafield: 'NAME', width: '15%' },
							{ text: 'Date of Birth', datafield: 'DOB', width: '15%' },
							{ text: 'Nationality', datafield: 'NATION', width: '15%' },
							{ text: 'Mob No', datafield: 'MOBNO', width: '15%' },
							{ text: 'Licence#', datafield: 'DLNO', width: '10%' },
							{ text: 'Lic Issued', datafield: 'ISSDATE', width: '12%' },
							{ text: 'Lic Expiry', datafield: 'LED', width: '12%' },
							{ text: 'Lic Type', datafield: 'LTYPE', width: '15%' },
							{ text: 'Iss From', datafield: 'ISSFRM', width: '15%' },
							{ text: 'Passport#', datafield: 'PASSPORT_NO', width: '10%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp', width: '15%' },
							{ text: 'Visa#', datafield: 'visano', width: '10%' },
							{ text: 'Visa Exp.#', datafield: 'visa_exp', width: '15%' },
							{ text: 'HC Licence#', datafield: 'HCDLNO', width: '10%' },
							{ text: 'HC Lic Issued', datafield: 'HCISSDATE', width: '15%' },
							{ text: 'HC Lic Expiry', datafield: 'HCLED', width: '15%' },
	              ]
            });
        });
    </script>
    <div id="jqxDrivers"></div>
 
