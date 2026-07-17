<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%   String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
     String cldocno = request.getParameter("clientId")==null?"0":request.getParameter("clientId"); 
%> 

<script type="text/javascript">
        var data;      
        $(document).ready(function () { 	
           
           var temp1='<%=docNo%>';
            
             if(temp1>0)
          	 {   
           	     data='<%=cord.driverGridReloading(docNo,cldocno,session)%>';       
          	 }
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'name', type: 'string'  },
     						{name : 'dob', type: 'date'    },
     						{name : 'nation1', type: 'string'    },
     						{name : 'mobno', type: 'string'    },
     						{name : 'dlno', type: 'string'    },
     						{name : 'ltype', type: 'string' },
     						{name : 'issfrm', type: 'string' },
     						{name : 'issdate', type: 'date'    },
     						{name : 'led', type: 'date' },
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },     						     						
     						{name : 'visano', type: 'string' },
     						{name : 'visa_exp', type: 'date' },
     						{name : 'hiddob', type: 'string' },
     						{name : 'hidpassexp', type: 'string' },
     						{name : 'hidissdate', type: 'string' },
     						{name : 'hidled', type: 'string'    },
     						{name : 'hidvisaexp', type: 'string' },
     						{name : 'doc_no', type: 'int' },
     						{name : 'dr_id', type: 'int'    }
     								
                 ],
                  localdata: data, 
                                        
            };
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            var list = ['GCC', 'IDP','UAE'];
            
            $("#jqxDriver").jqxGrid(
            {
                width: '98%',
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxDriver').jqxGrid('getrows');
                	var rowlength= rows.length;
                    var cell = $('#jqxDriver').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'visa_exp' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxDriver").jqxGrid('addrow', null, {});
                            rowlength++; 
                        }
                    } 
                    
                    //Search Pop-Up
                    var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'nation1') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	document.getElementById("rowindex").value = cell1.rowindex;
                        	$('#jqxDriver').jqxGrid('render');
                        	nationalitySearchContent('nationSearchGrid.jsp');
                        }
                    }
                    
                  //Search Pop-Up
                    var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'issfrm') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	var value = $('#jqxDriver').jqxGrid('getcellvalue', cell1.rowindex, "ltype");
                        	if(value == "UAE"){
	                        	document.getElementById("rowindex").value = cell1.rowindex;
	                        	$('#jqxDriver').jqxGrid('render');
	                        	stateSearchContent('stateSearchGrid.jsp');
                        	}
                        }
                    }
                },
                
                columns: [		
						    { text: 'No.', sortable: false, filterable: false, editable: false,
						      groupable: false, draggable: false, resizable: false,datafield: '',
						      columntype: 'number', width: '2%',cellsalign: 'center', align: 'center',
						      cellsrenderer: function (row, column, value) {
						  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
							},
							{ text: 'Name', datafield: 'name', width: '11%',
								validation:function(cell,value){
									if(value.length==0){
										return {result:false,message:"Required"};
									}
									else{
										return true;
									}
								},
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
							},
							{ text: 'Date of Birth', datafield: 'dob', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy', width: '7%',
			                      validation: function (cell, value) {
			                          if (value == "")
			                             return true; 
			                          
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          if (year >= cyear) {
			                        	  document.getElementById("chkvalid").value=1;
			                              return { result: false, message: "Date of birth should be before 1.1."+cyear+"." };
			                          }
			                          document.getElementById("chkvalid").value=0;
			                          return true;
    			                  },
    			                  cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
			                 },

			                 { text: 'Nationality', datafield: 'nation1', width: '7%',editable:false,
			                	 validation:function (cell,value){
			                		 if(value.length==0){
			                			 return { result: false, message: "Required." };
			                		 }
			                		 else{
			                			 return true;
			                		 }
			                	 },
			                	 cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
			                 },
			                 { text: 'Mob No', datafield: 'mobno', width: '7%',
			                	 cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
									/* validation: function (cell,value){
										var phoneno = /^\d{12}$/;  
										if(value.match(/^\d{12}$/)){
											return true;
										}
										else{
											return { result: false, message: "Invalid Mobile Number." };
										}
									} */
			                 },
			                 { text: 'Licence#', datafield: 'dlno', width: '7%' ,
									validation:function(cell,value){
										if(value.length==0){
											return { result: false, message: "Required" };
										}
										else{
											return true;
										}
									},
									cellbeginedit: function (row) {
									       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
									           if (parseInt(tempchk)>0)
									            {
									             return false; 
									            }
									        }
							},
							{ text: 'Lic Type', datafield: 'ltype', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                },
                                cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
                            },
							{ text: 'Iss From', datafield: 'issfrm', width: '7%' ,
								validation:function(cell,value){
									if(value.length==0){
										return {result:false,message:"Required"};
									}
									else{
										return true;
									}
								},
								cellbeginedit: function (row) {
							        if ($('#jqxDriver').jqxGrid('getcellvalue', row, "ltype")=="UAE")
							         {
							              return false;
							         }
									 var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
									     if (parseInt(tempchk)>0)
									      {
									         return false; 
									       }
									 }
							},
							{ text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '8%',
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
							},
							{ text: 'Lic Expiry', datafield: 'led', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%',
								validation: function (cell, value) {
			                          if (value.length==0)
			                        	  return {result:false,message:"Required"};
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          var year = value.getFullYear();
			                          if (year < cyear) {
			                        	  document.getElementById("chkvalid").value=1;
			                              return { result: false, message: "Licence Expired." };
			                          }
			                          document.getElementById("chkvalid").value=0;
			                          return true;
								},
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
							},
							{ text: 'Passport#', datafield: 'passport_no', width: '7%',
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }	
							},
							{ text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '8%' ,
								validation: function (cell, value) {
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          var year = value.getFullYear();
			                          if (year < cyear) {
			                        	  document.getElementById("chkvalid").value=1;
			                              return { result: false, message: "Passport Expired." };
			                          }
			                          document.getElementById("chkvalid").value=0;
			                          return true;
								},
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }
							},
							{ text: 'Visa#', datafield: 'visano', width: '7%',
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }	
							},
							{ text: 'Visa Exp.', datafield: 'visa_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '8%',
								cellbeginedit: function (row) {
								       var tempchk=$('#jqxDriver').jqxGrid('getcellvalue', row, "dr_id");
								           if (parseInt(tempchk)>0)
								            {
								             return false; 
								            }
								        }		
							},
							{ text: 'Hid-Dob', datafield: 'hiddob', editable: false, hidden: true, width: '10%' },
							{ text: 'Hid-Pass-Exp', datafield: 'hidpassexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Iss-Date', datafield: 'hidissdate', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-LED', datafield: 'hidled', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Visa-Exp', datafield: 'hidvisaexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'dr_id', editable: false, hidden: true,  width: '10%' },
	              ]
            });
            
          if(temp1>0){  
        	  $("#jqxDriver").jqxGrid({ disabled: true});
       	  }
            
       	$('#jqxDriver').on('celldoubleclick', function (event) {
       		
       		if(event.args.columnindex == 0)
    		  {
    	    	var rowindextemp = event.args.rowindex;
      	    	$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "name" ,'');	
      	    	$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "dob" ,'');	
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "nation1" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "mobno" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "dlno" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "ltype" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "issfrm" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "issdate" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "led" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "passport_no" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "pass_exp" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "visano" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "visa_exp" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "hiddob" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "hidpassexp" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "hidissdate" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "hidled" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "hidvisaexp" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "doc_no" ,'');
     			$('#jqxDriver').jqxGrid('setcellvalue', rowindextemp, "dr_id" ,'');
    		  }
       		
      	  if(event.args.columnindex == 3)
      		  {
      	    	var rowindextemp = event.args.rowindex;
      	        document.getElementById("rowindex").value = rowindextemp;
      	        $('#jqxDriver').jqxGrid('clearselection');
      	        nationalitySearchContent('nationSearchGrid.jsp');
      		  }
      	  
      	if(event.args.columnindex == 7)
		  {
	    	var rowindextemp = event.args.rowindex;
	        document.getElementById("rowindex").value = rowindextemp;
	        var value = $('#jqxDriver').jqxGrid('getcellvalue', rowindextemp, "ltype");
        	if(value == "UAE"){
		        $('#jqxDriver').jqxGrid('clearselection');
		        stateSearchContent('stateSearchGrid.jsp');
        	}
		  }
      	  
          }); 
       	
       	/* $("#jqxDriver").on('cellendedit', function (event) {
                    var dataField = event.args.datafield;
                    var rowBoundIndex = event.args.rowindex;
                    
                    if(dataField=="visa_exp"){
                     $('#jqxDriver').jqxGrid('selectcell', rowBoundIndex+1, 'name');
                     }
                   
                }); */
                
               $("#jqxDriver").on('cellendedit', function (event) {
               	var rowIndex=event.args.rowindex;
               	var datafield=event.args.datafield;
               	if(datafield=="mobno"){
                       var mobivalue = event.args.value; 
                       var phoneno = /^\d{12}$/;  
                       if(mobivalue.match(phoneno)){ 
                       			$("#jqxDriver").jqxGrid('hidevalidationpopups');
                        		return true;  
                       }
                       else {  
                       		$("#jqxDriver").jqxGrid('showvalidationpopup', rowIndex, "mobno", "Invalid Mobile Number.");
                       		return false;  
                       }
                       } 
               		});
                
       	$("#jqxDriver").on('cellvaluechanged', function (event){
        	var datafield = event.args.datafield;
       		var rowBoundIndex = event.args.rowindex;
	        if(datafield=="dob")
	        {
	            var dob = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "dob");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hiddob",dob);
	         }
	        
	        if(datafield=="pass_exp")
	        {
	            var passexp = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "pass_exp");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidpassexp",passexp);
	         }
	        
	        if(datafield=="issdate")
	        {
	            var issdate = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "issdate");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidissdate",issdate);
	         }
	        
	        if(datafield=="led")
	        {
	            var led = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "led");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidled",led);
	         }
	        
	        if(datafield=="visa_exp")
	        {
	            var visaexp = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "visa_exp");
	            $('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidvisaexp",visaexp);
	         }
        });
       	  
        });
        
    </script>
    <div id="jqxDriver"></div>
    <input type="hidden" id="rowindex"/>
    <input type="hidden" id="chkvalid" name="chkvalid">