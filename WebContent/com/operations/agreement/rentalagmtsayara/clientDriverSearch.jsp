 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.operations.agreement.rentalagmtsayara.*" %>
 <%
 ClsRentalAgmtSayaraDAO AgreementDAO= new ClsRentalAgmtSayaraDAO();
%>
       <script type="text/javascript">
       <%
		String  clientval=request.getParameter("clientval")==null?"0":request.getParameter("clientval");
       
		%>
		var temp='<%=clientval%>';
	
		var clientdir;
		if(temp>0)
			{
			 clientdir= '<%=AgreementDAO.clientDriver(clientval)%>';
			
			}
		else
			{
			clientdir;
			}
       
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
     						{name : 'expiryear', type: 'number'}
                        ],
                		
                        localdata: clientdir,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxclientdriverSearch").jqxGrid(
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
							
							
							
							
							{ text: 'age', datafield: 'age', width: '10%',hidden:true},
							{ text: 'drage', datafield: 'drage', width: '12%' ,hidden:true},
							{ text: 'licyr', datafield: 'licyr', width: '10%',hidden:true },
							{ text: 'expiryear', datafield: 'expiryear', width: '12%' ,hidden:true},
							{ text: 'licexp', datafield: 'licexp', width: '12%',hidden:true } 
	             
						]
            });
            
          $('#jqxclientdriverSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;

             
              var age=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "age");
              var drage=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "drage");
              var licyr=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "licyr");
              var expiryear=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "expiryear");
              var licexp=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "led");
              
              
            
           /*    alert("age"+age);
              alert("drage"+drage);
              alert("licyr"+licyr);
              alert("expiryear"+expiryear);
              alert("licexp"+licexp); */
             var today = new Date();
               
                 
                   if(licexp<today)
            	  {
                	 /*   $.messager.confirm('Warning', 'Licence Expired', function(r){
                		  
  				     }); */
                	   document.getElementById("errormsg").innerText=" Licence Expired";
                	   return false;
           	     	
            	  } 
                     if(age<drage)
              	    {
                    	/*  $.messager.confirm('Warning', 'Age Less than 25', function(r){
                   		  
      				     }); */
      					document.getElementById("errormsg").innerText=" Age Less than 25"; 	
           	      return false;
              	    }
              
             
                    if(expiryear<licyr)
              	  {
                    	/* $.messager.confirm('Warning', 'Issue Date Less Than One Year', function(r){
                     		  
     				     }); */
                 	  	
                    	
                    	document.getElementById("errormsg").innerText=" Issue Date Less Than One Year";
            	   
       	      // document.getElementById("fordrivervali").value=2;
       	         return false;
              	   }
                
              else
        	   {
            	  document.getElementById("errormsg").innerText="";	
        	 
        	   }
             
             
            	
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "name1" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "name"));
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "dob1", $('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "dob"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "age1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "age"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "drage1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "drage"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "licyr1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "licyr"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "expiryear1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "expiryear"));
              
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "dlno1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dlno"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "nation1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "nation"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "dlno1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dlno"));
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "mobno1" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "mobno"));
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "issdate1" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "issdate"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "led1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "led"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "ltype1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "ltype"));
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "issfrm1" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "issfrm"));
              $('#jqxgrid2').jqxGrid('setcellvalue', rowindex1, "passport_no1" ,$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex2, "passport_no"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "pass_exp1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "pass_exp"));
              $("#jqxgrid2").jqxGrid('setcellvalue', rowindex1, "dr_id1" ,$("#jqxclientdriverSearch").jqxGrid('getcellvalue', rowindex2, "dr_id"));
              
              document.getElementById("fordrivervali").value=1;
              document.getElementById("client_driverid").value=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex1, "dr_id");
              document.getElementById("client_driverdoc").value=$('#jqxclientdriverSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              $("table#tariffsub input").prop("disabled", false);
              var rows = $('#jqxgrid2').jqxGrid('getrows');
              var rowlength= rows.length;
              if(rowindex1==rowlength-1)
              {
              $("#jqxgrid2").jqxGrid('addrow', null, {});	
              }
              $('#driverinfowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxclientdriverSearch"></div>
 