 <%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>
 
  <%@page import="com.operations.marketing.quotation.ClsquotationAction" %>
 

 <%         
	String qutdocno1 = request.getParameter("qutdocno1")==null?"0":request.getParameter("qutdocno1").trim();
           	String enqrdocno = request.getParameter("enqrdocno1")==null?"0":request.getParameter("enqrdocno1").trim();
           	
           	ClsquotationDAO Clsquotation=new ClsquotationDAO();
           	 ClsquotationAction viewDAO=new ClsquotationAction();
           	  %> 
<script type="text/javascript">

	var temp1='<%=enqrdocno%>';
	var temp2='<%=qutdocno1%>';
    var hide;
    
    if(temp2>0)
 	 {
   	 var enqdata1= '<%=Clsquotation.enqsaverelode(qutdocno1)%>';
   	 hide=0; 
 	 }
    else if(temp1>0)
  	 {
    	 var enqdata1= '<%=Clsquotation.enqsearchrelode(enqrdocno)%>';
  	   hide=2; 
  	 } 
    else
    	{
   	 hide=10; 
   	 var enqdata1;
            	var codes="<%=viewDAO.searchTariff()%>";  
            	 var list = codes.split(","); 
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
							{name : 'gname', type: 'string'   },
							{name : 'grpid', type: 'int'   },
							{name : 'renttype', type: 'string'  },
							{ name: 'fromdate', type: 'date' },
							{name : 'todate', type: 'date' },
							{ name: 'hidfromdate', type: 'string' },
							{name : 'hidtodate', type: 'string' },
							{name : 'unit', type: 'int'  },
							{name : 'sr_no', type: 'int'  },
							{name : 'yom', type: 'string'  },
							{name : 'yomid', type: 'string'  }						
     											
                 ],
                 localdata: enqdata1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
        
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }	       );

            $("#qutgrid").jqxGrid(
            {
                width: '100%',
                height: 102,
             
                source: dataAdapter,
                disabled:true,
                 editable: true,
             
                 selectionmode: 'singlecell',
                pagermode: 'default',
               
              handlekeyboardnavigation: function (event) {
                   
                  
            		 var cell1 = $('#qutgrid').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'brand') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                          	brandSearchContent('quatbrandSearch.jsp');
                        	 $('#qutgrid').jqxGrid('render');
                        }
                        }
            	  
                	   
            		 var cell2 = $('#qutgrid').jqxGrid('getselectedcell');
                	 if (cell2 != undefined && cell2.datafield == 'model') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell2.rowindex;
                         	var  brandval=document.getElementById("qubrandval").value;
                          	modelSearchContent('modelSearch.jsp?brandval='+brandval);
                        	 $('#qutgrid').jqxGrid('render');
                        }
                        }
            	  
                	 var cell3 = $('#qutgrid').jqxGrid('getselectedcell');
                	 if (cell3 != undefined && cell3.datafield == 'color') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell3.rowindex;
                         	colorSearchContent('colorSearch.jsp');
                       	 $('#qutgrid').jqxGrid('render');
                        	
                        }
                        }
                	 var cell4 = $('#qutgrid').jqxGrid('getselectedcell');
                	 if (cell4 != undefined && cell4.datafield == 'gname') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell4.rowindex;
                         	 var branddoc=$('#qutgrid').jqxGrid('getcellvalue', cell4.rowindex, "brdid");
                	    	 var modeldoc=$('#qutgrid').jqxGrid('getcellvalue', cell4.rowindex, "modid");
                       	    
                       	    
                       	
                       	    groupSearchContent('groupSearch.jsp?branddoc='+branddoc+'&modeldoc='+modeldoc);
                       	    
                          	
                        	 $('#qutgrid').jqxGrid('render');
                        	
                        }
                        }
                	 
                  	 var cell5 = $('#qutgrid').jqxGrid('getselectedcell');
                	 if (cell5 != undefined && cell5.datafield == 'yom') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell5.rowindex;
                          	yomSearchContent('yomSearch.jsp');
                        	 $('#qutgrid').jqxGrid('render');
                        	
                        }
                        }
                	 
            	  
                	/*  if(args.datafield=="gname")
                 	{
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {                                                      
                     	groupSearchContent('groupSearch.jsp');
                     	 $('#qutgrid').jqxGrid('render');
                     }
                       } */
                	 
            	  
                /* 
                    if(args.datafield=="brand")
                	{
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {                                                      
                    
                   	brandSearchContent('quatbrandSearch.jsp');
                    	 $('#qutgrid').jqxGrid('render');
                    }
                      }
                 
                    if(args.datafield=="color")
                	{
                
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {      
                    	  colorSearchContent('colorSearch.jsp');
                    	 $('#qutgrid').jqxGrid('render');
                     }
                    }
               
                    if(args.datafield=="model")
                	{
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {                                                      
                    	 var  brandval=document.getElementById("qubrandval").value;
                      	modelSearchContent('modelSearch.jsp?brandval='+brandval);
                  	 $('#qutgrid').jqxGrid('render');
                    }
                } */
                   
              
              },   
                       
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
							{ text: 'Brand', datafield: 'brand', width: '12%' },	
							
							{ text: 'Model', datafield: 'model', width: '11%' },
							
							{ text: 'Specification', datafield: 'specification', width: '15%' },
							{ text: 'YOM', datafield: 'yom', width: '7%' },
							
							{ text: 'Color', datafield: 'color', width: '10%' },
						
						
							{ text: 'Rent Type', datafield: 'renttype', width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                            }
			               },
							{ text: 'From Date', datafield: 'fromdate', width: '10%',columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},	
							{ text: 'To Date', datafield: 'todate', width: '10%',columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},
							{ text: 'From Date', datafield: 'hidfromdate', width: '5%',hidden:true},	
							{ text: 'To Date', datafield: 'hidtodate', width: '5%',hidden:true},
							{ text: 'Unit', datafield: 'unit', width: '4%'},
							{ text: 'Group', datafield: 'gname', width: '8%'},
							{ text: 'Groupid', datafield: 'grpid', width: '3%',hidden:true},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '2%',hidden:true },
							{ text: 'YOMid', datafield: 'yomid', width: '10%' ,hidden:true},	
			              ]
               
            });
           if(hide==2)
        	  {
        	   $("#qutgrid").jqxGrid({ disabled: false});
           }
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
           	{
       	     $("#qutgrid").jqxGrid({ disabled: false}); 
          	}
           if(hide=='10')
     	  {
             $("#qutgrid").jqxGrid('addrow', null, {});
             }
         
             $("#qutgrid").on('cellclick', function (event) 
             		{

           	   var datafield = event.args.datafield;
         	   var rowindextemp2 = event.args.rowindex;
                document.getElementById("rowindex").value = rowindextemp2;
               
                if(datafield =="model")
             	   {
             	
                $("#qutgrid").jqxGrid('clearselection');
             	   }
                if(datafield =="brand")
         	   {
         	
                $("#qutgrid").jqxGrid('clearselection');
         	   } 
                if(datafield =="yom")
         	   {
         	
                $("#qutgrid").jqxGrid('clearselection');
         	   } 
                if(datafield =="color")
          	   {
          	
                 $("#qutgrid").jqxGrid('clearselection');
          	   } 
                if(datafield =="gname")
           	   {
           	
                  $("#qutgrid").jqxGrid('clearselection');
           	   } 
                
                     }); 
            $('#qutgrid').on('celldoubleclick', function (event) {

            	
          	   var datafield = event.args.datafield;
            	var columnindex1=event.args.columnindex;
              	  if(datafield=="brand")
              		  { 

              	
              	
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#qutgrid').jqxGrid('clearselection');
              	brandSearchContent('quatbrandSearch.jsp');
              	
              		  } 
              	  
                if(datafield=="model")
         		  { 

         	     
         	  var rowindextemp = event.args.rowindex;
         	   document.getElementById("rowindex").value = rowindextemp;  
         	  $('#qutgrid').jqxGrid('clearselection');
         	   var  brandval=document.getElementById("qubrandval").value;
         	modelSearchContent('modelSearch.jsp?brandval='+brandval);
         	
         		  } 
         	  
           	 if(datafield=="yom")
   		  { 

 		
   	 var rowindextemp = event.args.rowindex;
   	    document.getElementById("rowindex").value = rowindextemp;  
   	    $('#qutgrid').jqxGrid('clearselection');
            	 yomSearchContent('yomSearch.jsp');
   			
   		  } 
                
                
              	 if(datafield=="color")
        		  { 
 
      		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    $('#qutgrid').jqxGrid('clearselection');
        	    colorSearchContent('colorSearch.jsp');
        			
        		  }
              	 if(datafield=="gname")
       		  { 

     		
       	   var rowindextemp = event.args.rowindex;
       	    document.getElementById("rowindex").value = rowindextemp;  
       	  
       	    
	    	 var branddoc=$('#qutgrid').jqxGrid('getcellvalue', rowindextemp, "brdid");
	    	 var modeldoc=$('#qutgrid').jqxGrid('getcellvalue', rowindextemp, "modid");
       	    
       	    
       	 $('#qutgrid').jqxGrid('clearselection');
       	    groupSearchContent('groupSearch.jsp?branddoc='+branddoc+'&modeldoc='+modeldoc);
       	    
       		  } 
       	  
                  }); 
            	
        
            
            $("#qutgrid").on('cellvaluechanged', function (event) 
         		   {
         		        		  
         		       var rowBoundIndex = event.args.rowindex;
         		       
         		       var datafield = event.args.datafield;
         		    
         		      if(datafield=="fromdate")
       		       {
         		    	  
         		    	 var fromdate=$('#qutgrid').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
     		    		 var today = new Date();
     		            today.setHours(0, 0, 0, 0);
     		    	
     		    	if(fromdate<today)
     		    		{
     		    		 document.getElementById("errormsg").innerText="From Date Less Than Current Date";
     		    		document.getElementById("fromdatesvals").value=1;
     		    		
     		    		 
     					return 0;
     		    		
     		    		}
     		    	else
     		    		{
     		   	        	
     		    		 document.getElementById("errormsg").innerText="";
     		    		document.getElementById("fromdatesvals").value="";
     		    		
     		    		}
     		    	
         		    	  
         		    	  
         		    	
         		    	   var text = $('#qutgrid').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	// alert(text);
      		        	  $('#qutgrid').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
       		       }
         		     if(datafield=="todate")
         		       {
           		    	  
         		    	 
         		    	 var fromdates=$('#qutgrid').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
        		    	  var todates =$('#qutgrid').jqxGrid('getcellvalue', rowBoundIndex, "todate");
        				 
        				  
        				 	
        				 	 
        				   if(fromdates>todates){
        					   
        					  document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
        					 document.getElementById("todatevals").value=1;
        				   return false;
        				  } 
        				  else
      		    		{
        					
      		    		 document.getElementById("errormsg").innerText="";
      		    		document.getElementById("todatevals").value="";
      		    		}
      		    	
         		    	 
         		    	 
         		    	 
           		    	   var text1 = $('#qutgrid').jqxGrid('getcelltext', rowBoundIndex, "todate");
        		        	// alert(text1);
        		        	  $('#qutgrid').jqxGrid('setcellvalue',rowBoundIndex, "hidtodate",text1);
         		       }
         		       
         		  }); 
        });
    </script>
    <div id="qutgrid"></div>
  <input type="hidden" id="rowindex"/> 
 