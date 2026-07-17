<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.client.driverlist.ClsDriverList"%>
<%ClsDriverList DAO= new ClsDriverList(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>
<script type="text/javascript">
        var data;      
        $(document).ready(function () { 	
           
        	 var temp='<%=branchval%>';
             
     	  	 if(temp!='NA'){ 
           	     data='<%=DAO.driverListGridLoading(branchval,cldocno,check)%>';      
          	 } 
                 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'refname', type: 'string'  },
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
            
            $("#driverListGridID").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("mode").value;
            	var drid = $('#driverListGridID').jqxGrid('getcellvalue', 0, "drid");

            	if (temp !="view" && (drid!="" || drid==null)){
            		$("#driverListGridID").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#driverListGridID").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#driverListGridID").jqxGrid('hidecolumn', 'hcled');
			    }
                
			    var rows = $("#driverListGridID").jqxGrid('getrows');
					 for(var i=0 ; i < rows.length ; i++){
						 var value = $('#driverListGridID').jqxGrid('getcellvalue', i, "ltype"); 
						 var idpinfo=document.getElementById("idpdetailsallowed").value;
						 if(value == "IDP" && parseInt(idpinfo)==0){
							 $("#driverListGridID").jqxGrid('showcolumn', 'hcdlno');
				    	     $("#driverListGridID").jqxGrid('showcolumn', 'hcissdate');
				    		 $("#driverListGridID").jqxGrid('showcolumn', 'hcled');
				    		 break;
						 }else if(value != "IDP" && parseInt(idpinfo)==1){
							 $("#driverListGridID").jqxGrid('hidecolumn', 'hcdlno');
				    		 $("#driverListGridID").jqxGrid('hidecolumn', 'hcissdate');
				    		 $("#driverListGridID").jqxGrid('hidecolumn', 'hcled'); 
						 }
					 }
            }); 
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#driverListGridID").jqxGrid(
            {
            	width: '98%',
                height: 490,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [	
							{ text: 'Client Name', datafield: 'refname', width: '12%' },
							{ text: 'Driver Name', datafield: 'name', width: '10%' },
							{ text: 'Date of Birth', datafield: 'dob', cellsformat: 'dd.MM.yyyy', width: '7%' },
			                { text: 'Nationality', datafield: 'nation1',  width: '7%' },
			                { text: 'Mob No', datafield: 'mobno', width: '7%' },
			                { text: 'Licence#', datafield: 'dlno', width: '7%' },
							{ text: 'Lic Type', datafield: 'ltype', width: '6%' },
							{ text: 'Iss From', datafield: 'issfrm', width: '7%' },
							{ text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Lic Expiry', datafield: 'led', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'HC Licence#', datafield: 'hcdlno', width: '7%' },
							{ text: 'HC Lic Issued', datafield: 'hcissdate', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'HC Lic Expiry', datafield: 'hcled', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Passport#', datafield: 'passport_no', width: '7%'},
							{ text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'ID#', datafield: 'visano', width: '7%' },
							{ text: 'ID Exp.', datafield: 'visa_exp', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: ' ', datafield: 'attachbtn', width: '6%', columntype: 'button', editable:false, filterable: false},
							{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'dr_id', editable: false, hidden: true,  width: '10%' }
	              ]
            });
            
            $("#overlay, #PleaseWait").hide(); 
            
            $("#driverListGridID").on('cellclick', function (event) {
       		 
          	  var datafield = event.args.datafield;
          	  var rowBoundIndex = event.args.rowindex;
        			  
        			 if(datafield=="attachbtn"){

                  		 $("#windowattach").jqxWindow('setTitle', $('#driverListGridID').jqxGrid('getcellvalue',rowBoundIndex, "dr_id")+" - CRM - "+$('#driverListGridID').jqxGrid('getcellvalue',rowBoundIndex, "doc_no"));
                  		 changeDashBoardAttachContent("<%=contextPath%>/com/common/multiAttachGrid.jsp?formCode=CRM&docno="+$('#driverListGridID').jqxGrid('getcellvalue',rowBoundIndex, 'doc_no')+"&barchvals="+temp+"&drid="+$('#driverListGridID').jqxGrid('getcellvalue',rowBoundIndex, 'dr_id'));
        			 }
          		   
          		}); 
         	  
});       
</script>
<div id="driverListGridID"></div>    