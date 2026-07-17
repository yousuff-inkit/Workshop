        	<%@page import="com.operations.marketing.leasepricerequest.ClsLeasepriceRequestDAO" %>


            <%
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
            ClsLeasepriceRequestDAO viewDAO=new ClsLeasepriceRequestDAO();
           	  %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	 var reqdata1= '<%=viewDAO.searchrelode(enqrdocno)%>';
          	   hide=2; 
          	 } 
            else
          	 { 
            	var reqdata1;
            	
        
          	 } 
  
  
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brand', type: 'string'  },
     						{name : 'brdid', type: 'int'   },
     						{name : 'model', type: 'string'   },
     						{name : 'modid', type: 'string'   },
     						{name : 'specification', type: 'string'  },
     						{name : 'color', type: 'string'   },
     						{name : 'clrid', type: 'string'   },
     						
     						{name : 'Group', type: 'string'   },
     						{name : 'grpid', type: 'int'   },
     						
     						{name : 'ldur', type: 'number'  },
     						{ name: 'fromdate', type: 'date' },
     						{name : 'kmusage', type: 'number' },
     						{ name: 'hidfromdate', type: 'string' },
     					
     						{name : 'qty', type: 'int'  },
     						{name : 'sr_no', type: 'int'  }
     						
     											
                 ],
                 localdata: reqdata1,
                
                
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
            
                disabled:true,
                editable: true,
                altRows: true,
             
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#jqxEnquiry').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'brand') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	brandinfoSearchContent('enqbrandSearch.jsp');
                        	 $('#jqxEnquiry').jqxGrid('render');
                        }
                        }
                   
               	 if (cell1 != undefined && cell1.datafield == 'color') { 
                	
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                    	 document.getElementById("rowindex").value = cell1.rowindex;
                    	 colorinfoSearchContent('colorSearch.jsp');
                    	 $('#jqxEnquiry').jqxGrid('render');
                     }
                  }
           
                 	 if (cell1 != undefined && cell1.datafield == 'model') {  
                 
             
		                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                    if (key == 114) {  
		                    	 document.getElementById("rowindex").value = cell1.rowindex;
		                  	  var  brandval=document.getElementById("brandval").value;
		                  	
		                  	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
		                  	 $('#jqxEnquiry').jqxGrid('render');
		                    }
                    }
              
              
                  }, 
              
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            
							{ text: 'Brand', datafield: 'brand', width: '16%' },	
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Model', datafield: 'model', width: '16%' },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							
							{ text: 'Specification', datafield: 'specification', width: '20%' },	
							{ text: 'Color', datafield: 'color', width: '10%' },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
							{ text: 'Lease Duration(Months)', datafield: 'ldur', width: '9%'},
													
							{ text: 'From Date', datafield: 'fromdate', width: '10%',columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},	
							{ text: 'KM Usage', datafield: 'kmusage', width: '10%'},
							{ text: 'From Date', datafield: 'hidfromdate', width: '10%',hidden:true},	
							{ text: 'Qty', datafield: 'qty', width: '5%'},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true}
			              ]
               
            });
           
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
            
            	
           
            $("#jqxEnquiry").on('cellclick', function (event) 
             		{
         
         	   var rowindextemp2 = event.args.rowindex;
                document.getElementById("rowindex").value = rowindextemp2;
               
                if(event.args.columnindex ==1)
             	   {
             	
                $("#jqxEnquiry").jqxGrid('clearselection');
             	   }
                if(event.args.columnindex ==3)
         	   {
         	
                $("#jqxEnquiry").jqxGrid('clearselection');
         	   } 
                if(event.args.columnindex ==6)
         	   {
         	
                $("#jqxEnquiry").jqxGrid('clearselection');
         	   } 
                
                     }); 

            $('#jqxEnquiry').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
              	  if(columnindex1 == 1)
              		  { 
            		
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#jqxEnquiry').jqxGrid('clearselection');
              	brandinfoSearchContent('enqbrandSearch.jsp');
              	
              		  } 
              	  
              	 if(columnindex1 == 3)
         		  { 

         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         		  $('#jqxEnquiry').jqxGrid('clearselection');
         	   var  brandval=document.getElementById("brandval").value;
         
         	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
         	
         		  } 
         	  
              	 if(columnindex1 == 6)
        		  { 

        	     		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        		  $('#jqxEnquiry').jqxGrid('clearselection');
        	    colorinfoSearchContent('colorSearch.jsp');
        			
        		  }
        	  
              	
              	  
                  }); 
            
            $("#jqxEnquiry").on('cellvaluechanged', function (event) 
         		   {
         		        		  
         		       var rowBoundIndex = event.args.rowindex;
         		       
         		       var datafield = event.args.datafield;
         		       
          		       
         		      if(datafield=="fromdate")
       		           {
         		    	  
         		    	  var fromdate=$('#jqxEnquiry').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
         		    		 var today = new Date();
         		            today.setHours(0, 0, 0, 0);
         		    	
         		    	/* if(fromdate<today)
         		    		{
         		    		 document.getElementById("errormsg").innerText="From Date Less Than Current Date";
         		    		document.getElementById("fromdatesval").value=1;
         		    		
         		    		 
         					return 0;
         		    		
         		    		}
         		    	else
         		    		{
         		   	        	
         		    		 document.getElementById("errormsg").innerText="";
         		    		document.getElementById("fromdatesval").value="";
         		    		
         		    		}
         		    	
         		     */
         		    	  
         		    	   var text = $('#jqxEnquiry').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	
      		        	  $('#jqxEnquiry').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
      		        	  
      		        	 
      		        	  
      		        	  
       		       }
         		   
         		       
         		  }); 
        });
    </script>
    <div id="jqxEnquiry"></div>
  <input type="hidden" id="rowindex"/> 