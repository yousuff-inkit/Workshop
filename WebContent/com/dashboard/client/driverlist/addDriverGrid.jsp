<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
        var data2;      
        $(document).ready(function () { 	
                     
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
     						{name : 'hcdlno', type: 'string'    },
     						{name : 'hcissdate', type: 'date'    }, 
     						{name : 'hcled', type: 'date'    }, 
     						{name : 'passport_no', type: 'string'    },
     						{name : 'pass_exp', type: 'date'    },     						     						
     						{name : 'visano', type: 'string' },
     						{name : 'visa_exp', type: 'date' },
     						{name : 'attachbtn', type: 'String'  },
     						{name : 'hiddob', type: 'string' },
     						{name : 'hidpassexp', type: 'string' },
     						{name : 'hidissdate', type: 'string' },
     						{name : 'hidled', type: 'string'    },
     						{name : 'hidvisaexp', type: 'string' },
     						{name : 'hidhcissdate', type: 'string'    },
     						{name : 'hidhcled', type: 'string' },
     						{name : 'doc_no', type: 'int' },
     						{name : 'drid', type: 'int'  }
     								
                 ],
                 localdata: data2,
                                        
            };
            
             $("#addDriverGridID").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("mode").value;
            	var drid = $('#addDriverGridID').jqxGrid('getcellvalue', 0, "drid");

            	if (temp !="view" && (drid!="" || drid==null)){
            		$('#addDriverGridID').jqxGrid('hidecolumn', 'attachbtn');
            		$("#addDriverGridID").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#addDriverGridID").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#addDriverGridID").jqxGrid('hidecolumn', 'hcled');
			    }
                
			    var rows = $("#addDriverGridID").jqxGrid('getrows');
					 for(var i=0 ; i < rows.length ; i++){
						 var value = $('#addDriverGridID').jqxGrid('getcellvalue', i, "ltype"); 
						 var idpinfo=document.getElementById("idpdetailsallowed").value;
						 if(value == "IDP" && parseInt(idpinfo)==0){
							 $("#addDriverGridID").jqxGrid('showcolumn', 'hcdlno');
				    	     $("#addDriverGridID").jqxGrid('showcolumn', 'hcissdate');
				    		 $("#addDriverGridID").jqxGrid('showcolumn', 'hcled');
				    		 break;
						 }else if(value != "IDP" && parseInt(idpinfo)==1){
							 $("#addDriverGridID").jqxGrid('hidecolumn', 'hcdlno');
				    		 $("#addDriverGridID").jqxGrid('hidecolumn', 'hcissdate');
				    		 $("#addDriverGridID").jqxGrid('hidecolumn', 'hcled'); 
						 }
					 }
            }); 
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            var list = ['GCC', 'IDP','UAE'];
            
            $("#addDriverGridID").jqxGrid(
            {
                width: '100%',
                height: 490,
                source: dataAdapter,
                editable: true,
                enableAnimations: true,
                selectionmode: 'singlecell',
                
                 handlekeyboardnavigation: function (event) {
                    
                    //Search Pop-Up
                    var cell1 = $('#addDriverGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'nation1') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	var temp=document.getElementById("mode").value;
                        	if (temp !="view"){
                        		document.getElementById("rowindex").value = cell1.rowindex;
                        		$('#addDriverGridID').jqxGrid('render');
                        		nationalitySearchContent('nationSearchGrid.jsp?check=1');
                        	}
                        }
                    }
                    
                  //Search Pop-Up
                    var cell1 = $('#addDriverGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'issfrm') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	var temp=document.getElementById("mode").value;
                        	if (temp !="view"){
                        	var value = $('#addDriverGridID').jqxGrid('getcellvalue', cell1.rowindex, "ltype");
                        	if(value == "UAE"){
	                        	document.getElementById("rowindex").value = cell1.rowindex;
	                        	$('#addDriverGridID').jqxGrid('render');
	                        	stateSearchContent('stateSearchGrid.jsp?check=1');
                        	}
                          }
                        }
                    }
                },
                
                columns: [							
							{ text: 'Name', datafield: 'name', width: '12%',
								validation:function(cell,value){
									if(value.length==0){
										return {result:false,message:"Required"};
									}
									else{
										return true;
									}
								}, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'Date of Birth', datafield: 'dob', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy', width: '9%',
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
    			                  }, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   } 
			                 },

			                 { text: 'Nationality', datafield: 'nation1', editable:false,
			                	 validation:function (cell,value){
			                		 if(value.length==0){
			                			 return { result: false, message: "Required." };
			                		 }
			                		 else{
			                			 return true;
			                		 }
			                	 }, cellbeginedit: function (row) {
									    var temp=document.getElementById("mode").value;
									    if (temp =="view"){
									          return false;
									     }
									   }
			                 },
			                 { text: 'Mob No', datafield: 'mobno', width: '8%', cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
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
									}, cellbeginedit: function (row) {
									    var temp=document.getElementById("mode").value;
									    if (temp =="view"){
									          return false;
									     }
									   }
							},
							{ text: 'Lic Type', datafield: 'ltype', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
                            },
							{ text: 'Iss From', datafield: 'issfrm', width: '8%' ,
								validation:function(cell,value){
									if(value.length==0){
										return {result:false,message:"Required"};
									}
									else{
										return true;
									}
								},
								cellbeginedit: function (row) {
									var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
							        if ($('#addDriverGridID').jqxGrid('getcellvalue', row, "ltype")=="UAE")
							         {
							              return false;
							         }}
							},
							{ text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: 'Lic Expiry', datafield: 'led', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%',
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
								}, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'HC Licence#', datafield: 'hcdlno', width: '8%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'HC Lic Issued', datafield: 'hcissdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: 'HC Lic Expiry', datafield: 'hcled', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%' ,
								validation: function (cell, value) {
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          var year = value.getFullYear();
			                          if (year < cyear) {
			                        	  document.getElementById("chkvalid").value=1;
			                              return { result: false, message: "HC Licence Expired." };
			                          }
			                          document.getElementById("chkvalid").value=0;
			                          return true;
								}, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							
							},
							{ text: 'Passport#', datafield: 'passport_no', width: '8%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%' ,
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
								}, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							
							},
							{ text: 'ID#', datafield: 'visano', width: '8%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: 'ID Exp.', datafield: 'visa_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '9%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: ' ', datafield: 'attachbtn', width: '6%', columntype: 'button', editable:false, filterable: false},
							{ text: 'Hid-Dob', datafield: 'hiddob', editable: false, hidden: true, width: '10%' },
							{ text: 'Hid-Pass-Exp', datafield: 'hidpassexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Iss-Date', datafield: 'hidissdate', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-LED', datafield: 'hidled', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-HC-Iss-Date', datafield: 'hidhcissdate', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-HC-LED', datafield: 'hidhcled', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Visa-Exp', datafield: 'hidvisaexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'drid', editable: false, hidden: true,  width: '10%' }
	              ]
            });
       	  
       	$('#addDriverGridID').on('celldoubleclick', function (event) {
      	  if(event.args.columnindex == 2)
      		  {
      	    	var rowindextemp = event.args.rowindex;
      	    	var temp=document.getElementById("mode").value;
            	if (temp !="view"){
      	        	document.getElementById("rowindex").value = rowindextemp;
      	        	$('#addDriverGridID').jqxGrid('clearselection');
      	        	nationalitySearchContent('nationSearchGrid.jsp?check=1');
            	}
      		  }
      	  
      	if(event.args.columnindex == 6)
		  {
	    	var rowindextemp = event.args.rowindex;
	    	var temp=document.getElementById("mode").value;
        	if (temp !="view"){
	        	document.getElementById("rowindex").value = rowindextemp;
	        	var value = $('#addDriverGridID').jqxGrid('getcellvalue', rowindextemp, "ltype");
        		if(value == "UAE"){
		        	$('#addDriverGridID').jqxGrid('clearselection');
		        	stateSearchContent('stateSearchGrid.jsp?check=1');
        		}
        	}
		  }
      	  
          }); 
                
               $("#addDriverGridID").on('cellendedit', function (event) {
               	var rowIndex=event.args.rowindex;
               	var datafield=event.args.datafield;
               	if(datafield=="mobno"){
                       var mobivalue = event.args.value; 
                       var phoneno = /^\d{12}$/;  
                       if(mobivalue.match(phoneno)){ 
                       			$("#addDriverGridID").jqxGrid('hidevalidationpopups');
                        		return true;  
                       }
                       else {  
                       		$("#addDriverGridID").jqxGrid('showvalidationpopup', rowIndex, "mobno", "Invalid Mobile Number.");
                       		return false;  
                       }
                       } 
               		});
                
       	$("#addDriverGridID").on('cellvaluechanged', function (event){
        	var datafield = event.args.datafield;
       		var rowBoundIndex = event.args.rowindex;
	        if(datafield=="dob")
	        {
	            var dob = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "dob");
	            $('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hiddob",dob);
	        }
	        
	        if(datafield=="pass_exp")
	        {
	            var passexp = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "pass_exp");
	            $('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidpassexp",passexp);
	         }
	        
	        if(datafield=="issdate")
	        {
	            var issdate = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "issdate");
	            $('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidissdate",issdate);
	         }
	        
	        if(datafield=="led")
	        {
	            var led = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "led");
	            $('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidled",led);
	         }
	        
	        if(datafield=="visa_exp")
	        {
	            var visaexp = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "visa_exp");
	            $('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidvisaexp",visaexp);
	         }
	        
	        if(datafield=="visano")
	        {
	            var visano = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "visano");
	            getVisaNoAlreadyExists(visano,$('#docno').val(),$('#mode').val());
	         }
	        
	        if(datafield=="passport_no")
	        {
	            var passportno = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "passport_no");
	            getPassportNoAlreadyExists(passportno,$('#docno').val(),$('#mode').val());
	         }
	        
	        if(datafield=="ltype")
	        {
	        	var value = $('#addDriverGridID').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
	        	var idpinfo=document.getElementById("idpdetailsallowed").value;
		        if(value == "IDP" && parseInt(idpinfo)==0){
		        	$("#addDriverGridID").jqxGrid('showcolumn', 'hcdlno');
	    			$("#addDriverGridID").jqxGrid('showcolumn', 'hcissdate');
	    			$("#addDriverGridID").jqxGrid('showcolumn', 'hcled');
		         }
	    		else if(value != "IDP" && parseInt(idpinfo)==1){
	    			$("#addDriverGridID").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#addDriverGridID").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#addDriverGridID").jqxGrid('hidecolumn', 'hcled');
	    			$('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hcdlno",'');
	    			$('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidhcissdate",'');
	    			$('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidhcled",'');
	    		}
       	   }
	        
	       if(datafield=="hcissdate")
	        {
	        	var value = $('#addDriverGridID').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
		        if(value == "IDP"){
	            	var hcissdate = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "hcissdate");
	            	$('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidhcissdate",hcissdate);
		        }
	        }
	        
	        if(datafield=="hcled")
	        {
	        	var value = $('#addDriverGridID').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
		        if(value == "IDP"){
	            	var hcled = $('#addDriverGridID').jqxGrid('getcelltext', rowBoundIndex, "hcled");
	            	$('#addDriverGridID').jqxGrid('setcellvalue',rowBoundIndex, "hidhcled",hcled);
		        }
	        } 
        });
       	  
});
        
</script>
<div id="addDriverGridID"></div>
<input type="hidden" id="rowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid">
<input type="hidden" id="hiddrid" name="hiddrid">
<input type="hidden" id="hiddriver" name="hiddriver">