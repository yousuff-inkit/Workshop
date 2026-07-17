<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String docNo = request.getParameter("txtclientdocno1")==null?"0":request.getParameter("txtclientdocno1"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
        var data;      
        $(document).ready(function () { 	
           
           var temp='<%=docNo%>';
            
             if(temp>0)
          	 {   
           	     data='<%=DAO.driverGridReloading(docNo,check)%>';      
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
     						{name : 'dr_id', type: 'int'  }
     								
                 ],
                 localdata: data,
                                        
            };
            
            $("#jqxDriver").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("mode").value;
            	var drid = $('#jqxDriver').jqxGrid('getcellvalue', 0, "dr_id");
            	
			    if (temp !="view" && drid!="" || drid==null){
            		$('#jqxDriver').jqxGrid('hidecolumn', 'attachbtn');
					$("#jqxDriver").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#jqxDriver").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#jqxDriver").jqxGrid('hidecolumn', 'hcled');
			    }
                
				var rows = $("#jqxDriver").jqxGrid('getrows');
					 for(var i=0 ; i < rows.length ; i++){
						 var value = $('#jqxDriver').jqxGrid('getcellvalue', i, "ltype"); 
						 var idpinfo=document.getElementById("idpdetailsallowed").value;
					     if(value == "IDP" && parseInt(idpinfo)==0){
							 $("#jqxDriver").jqxGrid('showcolumn', 'hcdlno');
				    	     $("#jqxDriver").jqxGrid('showcolumn', 'hcissdate');
				    		 $("#jqxDriver").jqxGrid('showcolumn', 'hcled');
				    		 break;
						 }else if(value != "IDP" && parseInt(idpinfo)==1){
							 $("#jqxDriver").jqxGrid('hidecolumn', 'hcdlno');
				    		 $("#jqxDriver").jqxGrid('hidecolumn', 'hcissdate');
				    		 $("#jqxDriver").jqxGrid('hidecolumn', 'hcled'); 
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
            
            $("#jqxDriver").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: true,
                enableAnimations: true,
                selectionmode: 'singlecell',
                
                 handlekeyboardnavigation: function (event) {
                    
                    //Search Pop-Up
                    var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'nation1') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	var temp=document.getElementById("mode").value;
                        	if (temp !="view"){
                        		document.getElementById("rowindex").value = cell1.rowindex;
                        		$('#jqxDriver').jqxGrid('render');
                        		nationalitySearchContent('nationSearchGrid.jsp?check=1');
                        	}
                        }
                    }
                    
                  //Search Pop-Up
                    var cell1 = $('#jqxDriver').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'issfrm') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        	var temp=document.getElementById("mode").value;
                        	if (temp !="view"){
                        	var value = $('#jqxDriver').jqxGrid('getcellvalue', cell1.rowindex, "ltype");
                        	if(value == "UAE"){
	                        	document.getElementById("rowindex").value = cell1.rowindex;
	                        	$('#jqxDriver').jqxGrid('render');
	                        	stateSearchContent('stateSearchGrid.jsp?check=1s');
                        	}
                          }
                        }
                    }
                },
                
                columns: [							
							{ text: 'Name', datafield: 'name', width: '9%',
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
			                 { text: 'Mob No', datafield: 'mobno', width: '7%', cellbeginedit: function (row) {
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
							{ text: 'Lic Type', datafield: 'ltype', width: '6%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
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
									var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
							        if ($('#jqxDriver').jqxGrid('getcellvalue', row, "ltype")=="UAE")
							         {
							              return false;
							         }}
							},
							{ text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
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
								}, cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'HC Licence#', datafield: 'hcdlno', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'HC Lic Issued', datafield: 'hcissdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: 'HC Lic Expiry', datafield: 'hcled', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' ,
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
							{ text: 'Passport#', datafield: 'passport_no', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }
							},
							{ text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' ,
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
							{ text: 'ID#', datafield: 'visano', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
							{ text: 'ID Exp.', datafield: 'visa_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%',
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
							{ text: 'Hid-Visa-Exp', datafield: 'hidvisaexp', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-HC-Iss-Date', datafield: 'hidhcissdate', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-HC-LED', datafield: 'hidhcled', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'dr_id', editable: false, hidden: true,  width: '10%' }
	              ]
            });
            
            //Add empty row
            if(temp==0){ 
       	      $("#jqxDriver").jqxGrid('addrow', null, {});  
            }
           
            
          /* if(temp>0){  
        	  $("#jqxDriver").jqxGrid({ disabled: true});
       	  } */
            
            
       	$('#jqxDriver').on('celldoubleclick', function (event) {
      	  if(event.args.columnindex == 2)
      		  {
      	    	var rowindextemp = event.args.rowindex;
      	    	var temp=document.getElementById("mode").value;
            	if (temp !="view"){
      	        	document.getElementById("rowindex").value = rowindextemp;
      	        	$('#jqxDriver').jqxGrid('clearselection');
      	        	nationalitySearchContent('nationSearchGrid.jsp?check=1');
            	}
      		  }
      	  
      	if(event.args.columnindex == 6)
		  {
	    	var rowindextemp = event.args.rowindex;
	    	var temp=document.getElementById("mode").value;
        	if (temp !="view"){
	        	document.getElementById("rowindex").value = rowindextemp;
	        	var value = $('#jqxDriver').jqxGrid('getcellvalue', rowindextemp, "ltype");
        		if(value == "UAE"){
		        	$('#jqxDriver').jqxGrid('clearselection');
		        	stateSearchContent('stateSearchGrid.jsp?check=1');
        		}
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
			 
			if(datafield=="dlno")
	        {
	            var dlno = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "dlno");
	            getDrivingLicenceNoAlreadyExists(dlno,$('#docno').val(),$('#mode').val());
	        }
			
			if(datafield=="visano")
	        {
	            var visano = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "visano");
	            getVisaNoAlreadyExists(visano,$('#docno').val(),$('#mode').val());
	         }
	        
	        if(datafield=="passport_no")
	        {
	            var passportno = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "passport_no");
	            getPassportNoAlreadyExists(passportno,$('#docno').val(),$('#mode').val());
	        }
			
			 if(datafield=="ltype")
	        {
				if ($("#mode").val() == "A" || $("#mode").val() == "E") {
					var value = $('#jqxDriver').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
					var idpinfo=document.getElementById("idpdetailsallowed").value;
					if(value == "IDP" && parseInt(idpinfo)==0){
						$("#jqxDriver").jqxGrid('showcolumn', 'hcdlno');
						$("#jqxDriver").jqxGrid('showcolumn', 'hcissdate');
						$("#jqxDriver").jqxGrid('showcolumn', 'hcled');
		            }
					else if(value != "IDP" && parseInt(idpinfo)==1){
						$("#jqxDriver").jqxGrid('hidecolumn', 'hcdlno');
						$("#jqxDriver").jqxGrid('hidecolumn', 'hcissdate');
						$("#jqxDriver").jqxGrid('hidecolumn', 'hcled');
						$('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hcdlno",'');
						$('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidhcissdate",'');
						$('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidhcled",'');
					}
				}
       	   }
	        
	       if(datafield=="hcissdate")
	        {
	        	var value = $('#jqxDriver').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
		        if(value == "IDP"){
	            	var hcissdate = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "hcissdate");
	            	$('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidhcissdate",hcissdate);
		        }
	        }
	        
	        if(datafield=="hcled")
	        {
	        	var value = $('#jqxDriver').jqxGrid('getcellvalue', rowBoundIndex, "ltype");
		        if(value == "IDP"){
	            	var hcled = $('#jqxDriver').jqxGrid('getcelltext', rowBoundIndex, "hcled");
	            	$('#jqxDriver').jqxGrid('setcellvalue',rowBoundIndex, "hidhcled",hcled);
		        }
	        } 
			
        });
       	
       	$("#jqxDriver").on('cellclick', function (event) {
        		 
        	  var datafield = event.args.datafield;
        	  var rowBoundIndex = event.args.rowindex;
        	  //var columnindex = event.args.columnindex;
      			  
      			 if(datafield=="attachbtn"){
      				
                		 document.getElementById("hiddrid").value=$('#jqxDriver').jqxGrid('getcellvalue',rowBoundIndex, "dr_id");
                		 document.getElementById("hiddriver").value=$('#jqxDriver').jqxGrid('getcellvalue',rowBoundIndex, "name");

                		 funAttachedBtn();
      			 }
        		   
        		}); 
       	  
        });
        
        function funAttachedBtn(){
        	
      	    $("#windowattach").jqxWindow('setTitle', document.getElementById("hiddriver").value+" - CRM - "+document.getElementById("docno").value);
      		changeAttachContent("<%=contextPath%>/com/common/multiAttach.jsp?formCode=CRM&docno="+document.getElementById("docno").value+"&barchvals="+document.getElementById("brchName").value+"&drid="+document.getElementById("hiddrid").value);		
      	
      }
        
</script>
<div id="jqxDriver"></div>
<input type="hidden" id="rowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid">
<input type="hidden" id="hiddrid" name="hiddrid">
<input type="hidden" id="hiddriver" name="hiddriver">