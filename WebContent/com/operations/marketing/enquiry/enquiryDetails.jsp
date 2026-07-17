<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>



<%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO" %>
<%@page import="com.operations.marketing.enquiry.ClsEnquiryAction" %>
 


 <%
 
 ClsEnquiryDAO viewDAO=new ClsEnquiryDAO();
 ClsEnquiryAction viewDAO1=new ClsEnquiryAction();
 
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
           //System.out.println("---------"+enqrdocno);
           	  %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	 var enqdata1= '<%=viewDAO.searchrelode(enqrdocno,session)%>';
          	   hide=2; 
          	 } 
            else
          	 { 
            	var enqdata1;
            	 var codes="<%=viewDAO1.searchTariff()%>";  
            	 var list = codes.split(","); 
          	/* 	 /* '[{"Name":""},{"Date of Birth":""},{"Age":""},{"dbage":""},{"Nationality":""},{"Mob No":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Lic Expiry":""},{"Lic Type":""},{"Iss From":""},{"Passport#":""},{"Pass Exp":""},{"doc_no":""}]'; */
          	 } 
   <%--  var data= '<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchDetails() %>'; --%>
  
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
     						
     						{name : 'renttype', type: 'string'  },
     						{ name: 'fromdate', type: 'date' },
     						{name : 'todate', type: 'date' },
     						{ name: 'hidfromdate', type: 'string' },
     						{name : 'hidtodate', type: 'string' },
     						{name : 'unit', type: 'int'  },
     						{name : 'sr_no', type: 'int'  }
     						
     											
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
                            
							{ text: 'Brand', datafield: 'brand', width: '15%' },	
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Model', datafield: 'model', width: '15%' },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							
							{ text: 'Specification', datafield: 'specification', width: '15%' , initeditor: function (row, column, editor) {
		                          editor.attr('maxlength', 44);
		                      } },	
							{ text: 'Color', datafield: 'color', width: '10%' },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
							{ text: 'Rent Type', datafield: 'renttype', width: '12%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                            }
			               },
													
							{ text: 'From Date', datafield: 'fromdate', width: '10%',columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},	
							{ text: 'To Date', datafield: 'todate', width: '10%',columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy'},
							{ text: 'From Date', datafield: 'hidfromdate', width: '10%',hidden:true},	
							{ text: 'To Date', datafield: 'hidtodate', width: '10%',hidden:true},
							{ text: 'Unit', datafield: 'unit', width: '9%'},
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
         		    	
         		    	if(fromdate<today)
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
         		    	
         		    
         		    	  
         		    	   var text = $('#jqxEnquiry').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	
      		        	  $('#jqxEnquiry').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
      		        	  
      		        	 
      		        	  
      		        	  
       		       }
         		     if(datafield=="todate")
         		       {
         		    	 
         		    	 var fromdates=$('#jqxEnquiry').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
         		    	  var todates =$('#jqxEnquiry').jqxGrid('getcellvalue', rowBoundIndex, "todate");
         				   if(fromdates>todates){
         					   
         					  document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
         					 document.getElementById("todateval").value=1;
         				   return false;
         				  } 
         				  else
       		    		{
         					
       		    		 document.getElementById("errormsg").innerText="";
       		    		document.getElementById("todateval").value="";
       		    		}
       		    	
         		    	 
           		    	  
           		    	   var text1 = $('#jqxEnquiry').jqxGrid('getcelltext', rowBoundIndex, "todate");
        		        	// alert(text1);
        		        	  $('#jqxEnquiry').jqxGrid('setcellvalue',rowBoundIndex, "hidtodate",text1);
         		       }
         		     
         		     
         		     
         		     
         		     
         		     
         		     
         		       
         		  }); 
        });
    </script>
    <div id="jqxEnquiry"></div>
  <input type="hidden" id="rowindex"/> 