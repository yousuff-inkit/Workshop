<%@page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>

 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
 ClsrentalagreementDAO dao= new ClsrentalagreementDAO();
 %>
 
  <style>
/*   .yellowClass
        {
        
       
       background-color: #eedd82; 
       
        }
 .greenClass
        {
            background-color: #ACF6CB;
        } */
   .redClass
        {
             background-color: #ffc0cb; 
         /*  background-color: #FFEBEB; */
        }
 </style> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var shotterm;
 var aa;
  if(temp4!='NA')
 { 

 
	  shotterm='<%=dao.termdetailsgrid(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type)%>';
 aa=0;
 }
  
  
  else
	  {
	  shotterm;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'vehdetails', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						
     						
     						{name : 'ddate', type: 'date'  },
     						{name : 'dtime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						{name : 'gid', type: 'string'  },
     						{name : 'branchname', type: 'string'  },
     						{name : 'tdocno', type: 'string'  },
     						{name : 'insurexcess', type: 'number'  },                     
    						{name : 'cdwexcess', type: 'number'    },
    						{name : 'scdwexcess', type: 'number'    },
    						{name : 'insex', type: 'number'    },
    						{name : 'caludays', type: 'string'    },
    						
    						
    						
    						{name : 'radvc', type: 'string'    },
     						
    						{name : 'rinvtype', type: 'string'    },
     						
    						{name : 'clientadvc', type: 'string'    },
     						
    						{name : 'clientinvtype', type: 'string'    },
     						
    						{name : 'method', type: 'string'    },
     						
    						
     				 
     						
                          	],
                          	localdata: shotterm,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname =  function (row, column, value, data) {

             if(parseInt(data.caludays)>0)
            	 {
            	 return "redClass";
            	 }
             else if(parseInt(data.caludays)<0)
            	 {
            	 return "redClass";
            	 }


			}
    	       
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            
            
            
            
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 325,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                rowsheight:20,
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
										{ text: 'SL#', sortable: false, filterable: false, editable: false,
										    groupable: false, draggable: false, resizable: false,
										    datafield: 'sl', columntype: 'number', width: '3%',
										    cellsrenderer: function (row, column, value) {
										        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
										    }  
										  },
										  
										  
							 { text: 'gid', datafield: 'gid', width: '2%',hidden:true },
                          
							{ text: 'RA NO', datafield: 'doc_no', width: '4%',cellclassname: cellclassname,hidden:true},
							{ text: 'RA NO', datafield: 'voc_no', width: '6%',cellclassname: cellclassname},
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%',cellclassname: cellclassname },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '12%' ,cellclassname: cellclassname},
							{ text: 'Reg NO', datafield: 'reg_no', width: '7%' ,cellclassname: cellclassname},
							{ text: 'Client Name', datafield: 'refname', width: '15%' ,cellclassname: cellclassname},
							{ text: 'Contact Person', datafield: 'contactperson', width: '13%',cellclassname: cellclassname},
							
							{ text: 'Mob NO', datafield: 'per_mob', width: '10%',cellclassname: cellclassname},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '6%' ,cellclassname: cellclassname},
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							
							 { text: 'Out Time', datafield: 'otime', width: '5%',cellclassname: cellclassname },
							
							 
							 
							 { text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
								
							 { text: 'DueTime', datafield: 'dtime', width: '5%' ,cellclassname: cellclassname},
							 
							 { text: 'tdocno', datafield: 'tdocno', width: '4%',hidden:true},
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
							 { text: 'branchname', datafield: 'branchname', width: '10%' ,hidden:true},
							 
							 
								{ text: 'rdocinsu', datafield: 'insex', width: '10%',cellsformat:'d2' ,hidden:true},
								{ text: 'insurexcess', datafield: 'insurexcess', width: '10%',cellsformat:'d2',hidden:true },
								{ text: 'cdwexcess', datafield: 'cdwexcess', width: '10%',cellsformat:'d2' ,hidden:true },
								{ text: 'scdwexcess TO', datafield: 'scdwexcess', width: '10%' ,cellsformat:'d2',hidden:true},
								{ text: 'caludays', datafield: 'caludays', width: '10%' ,cellsformat:'d2',hidden:true}, //-- for inv chk
								
	    						
								{ text: 'radvc', datafield: 'radvc' , width: '10%' ,cellsformat:'d2',hidden:true},
								{ text: 'rinvtype', datafield: 'rinvtype', width: '10%' ,cellsformat:'d2' ,hidden:true}, 
								
								{ text: 'clientadvc', datafield: 'clientadvc' , width: '10%' ,cellsformat:'d2',hidden:true},       
								{ text: 'clientinvtype', datafield: 'clientinvtype', width: '10%' ,cellsformat:'d2',hidden:true },  
								
								{ text: 'method', datafield: 'method', width: '10%' ,cellsformat:'d2',hidden:true },
								
								
								
				 
								
							 
					]
            });
     
     	   $("#overlay, #PleaseWait").hide();
            
       
		   $("#detailsgrid").on("celldoubleclick", function (event)
				   {
				  var rentalrow = event.args.rowindex;
			   var calcu=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "caludays");
			   if(parseInt(calcu)>0 || parseInt(calcu)<0 )
				   {
				   $.messager.alert('Message','RA Is Invoiced  ','warning');   
				   return 0;
				   
				   }
			   
			   
			   
			   
			   
		    	
            	 $('#searchuser').attr("disabled",false);
       		
          	 $('#update').attr("disabled",false);
	
        	 $('#advance_chk').attr("disabled",false);
     		
        	 $('#invoice').attr("disabled",false);
          	 
          	 
          	 
          	if(parseInt($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "radvc"))==1)
            {
           	document.getElementById('advance_chk').checked=true;
           	
           	document.getElementById('advance_chk').value=1;
            }
            else
            	{
            	document.getElementById('advance_chk').checked=false;
            	document.getElementById('advance_chk').value=0;
            	
            	}
          	
          	
          	 document.getElementById("invoice").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "rinvtype");
          	 
          	 
          	 document.getElementById("advchkval").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "clientadvc");
          	 
          	 document.getElementById("invval").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "clientinvtype");
          	 
          	 
        	 document.getElementById("configmethod").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "method");
          	 
          	 
               
          	 
          	
   
          	 
          	 
          	 
			  
			   $('#jqxDaterentalout').val($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "odate"));
			  
			    var exinsuss=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "insex");
                var aa="excessinsur";
                funRoundAmt(exinsuss,aa);
                
              document.getElementById("normalinsu").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "insurexcess");
              document.getElementById("cdwinsu").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "cdwexcess");
              document.getElementById("supercdwinsu").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "scdwexcess");
			  
			  
              document.getElementById("branchid").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "brhid");	  
			  
			  document.getElementById("docnos").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "doc_no");
			  
			var masterdoc= $('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "doc_no");
			
			  
	    var branchname=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "brhid");
				  
		var docno=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "tdocno");
					
		var gid=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "gid");
			  
			  $("#tariff").load("tariff.jsp?branch="+branchname+"&tdocno="+docno+"&revehGroup="+gid);
			  
			  $("#rtariff").load("rtariffdetails.jsp?rdocno="+masterdoc); 
			  
            
				   });
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>