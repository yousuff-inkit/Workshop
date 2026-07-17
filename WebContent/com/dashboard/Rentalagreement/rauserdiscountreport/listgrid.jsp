<%@page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	/* String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim(); */
  	ClsrentalagreementDAO viewDAO=new ClsrentalagreementDAO();
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

 
	     shotterm='<%=viewDAO.userdiscount(barchval)%>'; 
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

                             {name : 'voc_no', type: 'String'  },  
                 			 {name : 'ousername', type: 'String'  },
     						 {name : 'refname', type: 'String'},
     						 {name : 'newuser', type: 'String'  },
     						 {name : 'doc_no', type: 'String'  }, 
     						 {name : 'date', type: 'date'  }, 
     					  
                          	],
                          	localdata: shotterm,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            
            
            
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
                height: 430,
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
										    datafield: 'sl', columntype: 'number', width: '6%',
										    cellsrenderer: function (row, column, value) {
										        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
										    }  
						   },
										  
										  
							{ text: 'RA NO', datafield: 'voc_no', width: '12%'},
							{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy'},
							{ text: 'RA NO', datafield: 'doc_no', width: '4%',hidden:true },
							{ text: 'Create User', datafield: 'ousername', width: '20%'},
							{ text: 'Client Name', datafield: 'refname', width: '30%' },
							{ text: 'Allowed User', datafield: 'newuser', width: '20%' },


								
								
				 
								
							 
					]
            });
     
     	   $("#overlay, #PleaseWait").hide();
     	  var rows = $("#detailsgrid").jqxGrid('getrows');
     	   
     	   if(rows.length==0)
     		   {
     		   
     		   $("#detailsgrid").jqxGrid('addrow', null,  {});
     		      



     		   
     		   }
     	     
       
		   $("#detailsgrid").on("celldoubleclick", function (event)
				   {
				  var rentalrow = event.args.rowindex;
			 
			  
			var masterdoc= $('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "doc_no");
			
			  
	   
			  
			  $("#rtariff").load("rtariffdetails.jsp?rdocno="+masterdoc); 
			  
            
				   });
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>