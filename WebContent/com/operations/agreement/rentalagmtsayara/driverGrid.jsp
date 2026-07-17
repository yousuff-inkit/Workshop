

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.agreement.rentalagmtsayara.*" %>
 <%
 ClsRentalAgmtSayaraDAO viewDAO= new ClsRentalAgmtSayaraDAO();
   	String drireload = request.getParameter("txtrentaldocno1")==null?"0":request.getParameter("txtrentaldocno1").trim();
   	  %> 

 <script type="text/javascript">
 
 var temp1='<%=drireload%>';
 
  if(temp1>0)
	 {
	 var datadri= '<%=viewDAO.reloadDriver(session,drireload)%>';
	 var valu=2;
	 } 
  else
	 { 
	 var datadri;
	
	 } 
       $(document).ready(function () { 	
        	
    		//alert(data1);
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
                            {name : 'name1', type: 'string'  },
     						{name : 'dob1', type: 'date'    },
     						{name : 'nation1', type: 'string'    },
     						{name : 'mobno1', type: 'string'    },
     						{name : 'dlno1', type: 'string'    },
     						{name : 'issdate1', type: 'date'    },
     						{name : 'led1', type: 'date' },
     						{name : 'ltype1', type: 'string'    },
     						{name : 'issfrm1', type: 'string'    },
     						{name : 'passport_no1', type: 'string' },
     						{name : 'pass_exp1', type: 'date'    },
     						{name : 'visano1', type: 'string'    },
     						{name : 'visa_exp1', type: 'date'    },
     						{name : 'hcdlno1', type: 'string'    },
     						{name : 'hcissdate1', type: 'date'    },
     						{name : 'hcled1', type: 'string'    },
     						{name : 'age1', type: 'number'    },
     						{name : 'drage1', type: 'number'    },
     						{name : 'licyr1', type: 'number'    },
     						{name : 'expiryear1', type: 'nember'},
     						{name : 'doc_no1', type: 'nember'}
     						
     						
     						
                 ],               
                 localdata: datadri,
                
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
           
            
            
            $("#jqxgrid2").jqxGrid(
            {
                width: '100%',
                height: 77,
                source: dataAdapter,
             
                disabled:true,
                altRows: true,
          
                selectionmode: 'singlecell',
             
                          
                
               
              /*   handlekeyboardnavigation: function (event) {
                	
                    var cell1 = $('#jqxgrid2').jqxGrid('getselectedcell');
                  alert(cell1);
                    if (cell1 != undefined && cell1.datafield == 'name1') {
                    	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        alert("asss"+key);
                        if (key == 114) {                                                      
                        	driverinfoSearchContent('clientDriverSearch.jsp');
                         }
                    } 
                    
                }, 
                */
                
                columns: [
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },							
							{ text: 'Name', datafield: 'name1', width: '12%', },
							{ text: 'Date of Birth', datafield: 'dob1', width: '6%',cellsformat: 'dd-MM-yyyy'},
							{ text: 'Age', datafield: 'age1', width: '3%'},
							{ text: 'dbage', datafield: 'drage1', width: '3%' ,hidden:true },
							{ text: 'Nationality', datafield: 'nation1', width: '9%' },
							{ text: 'Mob No', datafield: 'mobno1', width: '10%' },
							{ text: 'Licence#', datafield: 'dlno1', width: '8%' },
							{ text: 'Lic Issued', datafield: 'issdate1', width: '9%',cellsformat: 'dd-MM-yyyy' },
							{ text: 'dbLic Issued', datafield: 'licyr1', width: '9%' ,hidden:true },
							{ text: 'calcuLic Issued', datafield: 'expiryear1', width: '9%' ,hidden:true },
							{ text: 'Lic Expiry', datafield: 'led1', width: '7%',cellsformat: 'dd-MM-yyyy' },
							{ text: 'Lic Type', datafield: 'ltype1', width: '7%' },
							{ text: 'Iss From', datafield: 'issfrm1', width: '9%' },
							{ text: 'Passport#', datafield: 'passport_no1', width: '9%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp1', width: '7%',cellsformat: 'dd-MM-yyyy' }, 
						 	{ text: 'doc_no', datafield: 'dr_id1', width: '2%',hidden:true}
						 	/*{ text: 'Visa Exp.#', datafield: 'visa_exp1', width: '12%' },
							{ text: 'HC Licence#', datafield: 'hcdlno1', width: '10%' },
							{ text: 'HC Lic Issued', datafield: 'hcissdate1', width: '12%' },
							{ text: 'HC Lic Expiry', datafield: 'hcled1', width: '12%' }, */
	              ]
            });
            if ($("#mode").val() == "A") {
            	   $("#jqxgrid2").jqxGrid({ disabled: false});
            } 
            
            //Add empty row
            if(valu!=2)
            	{
      	   $("#jqxgrid2").jqxGrid('addrow', null, {});
        	 $("#jqxgrid2").jqxGrid('addrow', null, {}); 
            	}
            
            
            
      	 $('#jqxgrid2').on('cellclick', function (event) {
       	 if(event.args.columnindex >0)
               {
     		
       	 var rowindextemp = event.args.rowindex;
       	    document.getElementById("rowindex").value = rowindextemp;  
     	   var  clientval=document.getElementById("txtcusid").value;
       	driverinfoSearchContent('clientDriverSearch.jsp?clientval='+clientval);
       		  }
       	  
           }); 
      	 $('#jqxgrid2').on('celldoubleclick', function (event) {
           	  if(event.args.columnindex == 0)
           		  { 
           		document.getElementById("fordrivervali").value="";
           		 
           	 var rowindex6 = event.args.rowindex;
      
           	$('#jqxgrid2').jqxGrid('updaterow', rowindex6, "");
           	   
           		  }
           	  
           	  
           	  
           	  
           	  
               }); 
      	 

      	
      	
      	
      	
      	       
        });
    </script>
    <div id="jqxgrid2"></div>
 <input type="hidden" id="rowindex"/> 
