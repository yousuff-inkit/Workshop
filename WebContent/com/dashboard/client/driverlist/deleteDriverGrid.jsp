<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.client.driverlist.ClsDriverList"%>
<%ClsDriverList DAO= new ClsDriverList(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
      String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>
<script type="text/javascript">
        var data2;      
        $(document).ready(function () { 	
           
        	 var temp2='<%=branchval%>';
             
     	  	 if(temp2!='NA'){ 
           	     data2='<%=DAO.driverListGridLoading(branchval,cldocno,check)%>';      
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
                 localdata: data2,
                                        
            };
            
            $("#deleteDriverGridID").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("mode").value;
            	var drid = $('#deleteDriverGridID').jqxGrid('getcellvalue', 0, "drid");

            	if (temp !="view" && (drid!="" || drid==null)){
            		$('#deleteDriverGridID').jqxGrid('hidecolumn', 'attachbtn');
            		$("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcdlno');
	    			$("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcissdate');
	    			$("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcled');
			    }
                
			    var rows = $("#deleteDriverGridID").jqxGrid('getrows');
					 for(var i=0 ; i < rows.length ; i++){
						 var value = $('#deleteDriverGridID').jqxGrid('getcellvalue', i, "ltype"); 
						 var idpinfo=document.getElementById("idpdetailsallowed").value;
						 if(value == "IDP" && parseInt(idpinfo)==0){
							 $("#deleteDriverGridID").jqxGrid('showcolumn', 'hcdlno');
				    	     $("#deleteDriverGridID").jqxGrid('showcolumn', 'hcissdate');
				    		 $("#deleteDriverGridID").jqxGrid('showcolumn', 'hcled');
				    		 break;
						 }else if(value != "IDP" && parseInt(idpinfo)==1){
							 $("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcdlno');
				    		 $("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcissdate');
				    		 $("#deleteDriverGridID").jqxGrid('hidecolumn', 'hcled'); 
						 }
					 }
            }); 
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#deleteDriverGridID").jqxGrid(
            {
            	width: '98%',
                height: 490,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'checkbox',
                editable: false,
                
                columns: [	
							{ text: 'Driver Name', datafield: 'name', width: '14%' },
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
							{ text: 'Hid-Doc No', datafield: 'doc_no', editable: false, hidden: true,  width: '10%' },
							{ text: 'Hid-Driver Id', datafield: 'dr_id', editable: false, hidden: true,  width: '10%' }
	              ]
            });
            
            $("#overlay, #PleaseWait").hide(); 
            
             
         	  
});       
</script>
<div id="deleteDriverGridID"></div>    