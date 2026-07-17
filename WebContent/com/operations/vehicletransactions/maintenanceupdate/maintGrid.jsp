<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 <%@page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
 
 
 <%
 ClsmaintenanceDAO viewDAO=new ClsmaintenanceDAO();  
	String fleetno = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();
    String maindoc = request.getParameter("maindoc")==null?"NA":request.getParameter("maindoc").trim();

    %>
    <script type="text/javascript"> 
    
    var temp1='<%=fleetno%>';
    var temp2='<%=maindoc%>';
    var maindata;

    if(temp2!="NA")
    	{
    	
    maindata='<%=viewDAO.searchmaingridrelode(maindoc)%>';

    	}
    else if(temp1!="NA")
    	{
    	
     maindata='<%=viewDAO.searchfleetgridrelode(fleetno)%>';
    	}
    else
    	{
    	maindata;
    	}
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'date', type: 'date'  },
     						{name : 'maintype', type: 'string'  },
     						{name : 'description' , type: 'string' },
     						{name : 'remarks', type: 'string'  },
     						{name : 'clear', type: 'bool'  },
     						{name : 'clremarks', type: 'string'  },
     						{name : 'cldate', type: 'date'  },
     						{name : 'cltime', type: 'date'  },
     				     	 {name : 'hidrefdate', type: 'string'  }, 
     						{name : 'hidcldate', type: 'string'  },
     						{name : 'hidcltime', type: 'string'  }
     						
     						
     						                	],
                 localdata: maindata,
                
                
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
            $("#mainuppergrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
               
                editable:true,
                altRows: true,
           
                selectionmode: 'singlecell',
                pagermode: 'default',
             
              
	
                columns: [
									{ text: 'SL#', sortable: false, filterable: false, editable: false,
									    groupable: false, draggable: false, resizable: false,
									    datafield: 'sl', columntype: 'number', width: '2%',
									    cellsrenderer: function (row, column, value) {
									        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
									    }  
									  },
				
									{ text: 'V.Insp.No', datafield: 'srno',editable: false, width: '4%' },
									{ text: 'Ref Date', datafield: 'date', width: '9%',editable: false,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy' },
									{ text: 'Type', datafield: 'maintype',editable: false, width: '5%'},
									{ text: 'Description', datafield: 'description',editable: false, width: '20%'  },
									{ text: 'Remarks', datafield: 'remarks' ,editable: false,width: '23%' },
									{ text: 'Clear', datafield: 'clear',columntype: 'checkbox', editable: true, checked: false, width: '5%',cellsalign: 'center', align: 'center'
									},
									{ text: 'Cl.Remark', datafield: 'clremarks',width: '18%'},
									
									 { text: 'Cl.Time', datafield: 'cltime', width: '5%' ,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
							               editor.jqxDateTimeInput({ showCalendarButton: false });
							               
							             
							           }
									 
							         
									
							        },
									{ text: 'Cl.Date', datafield: 'cldate',width:"9%",columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
										/* validation:function(cell,value){
									         if(value.length==0){
									          return { result: false, message: "Required" };
									         }
									         else{
									          return true;
									         }
									        }	 */
									},
									
									{ text: 'hideCl.Date', datafield: 'hidcldate',width:"9%",hidden:true},
									{ text: 'hideCl.Time', datafield: 'hidcltime',width:"9%",hidden:true},
									
            ]
            });
           
           if((temp1=='NA')&&(temp2=='NA'))
        	   { 
            $("#mainuppergrid").jqxGrid('addrow', null, {});
        	    } 

            if((temp2!='NA'))
            	{
            	$("#mainuppergrid").jqxGrid({ disabled: true}); 
            	}
          
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#mainuppergrid").jqxGrid({ disabled: false}); 
    		}

            $("#mainuppergrid").on('cellvaluechanged', function (event) 
            {
            	
               
                var datafield = event.args.datafield;
              
                var rowBoundIndex = event.args.rowindex;
                // new cell value.
                var value = event.args.newvalue;
               
            
                
           /*      if(datafield=="date")
    		       {
    		    	  		       
    		          var hidrefdate = $('#mainuppergrid').jqxGrid('getcelltext', rowBoundIndex, "date");
 		        	 // alert(text);
 		        	  $('#mainuppergrid').jqxGrid('setcellvalue',rowBoundIndex, "hidrefdate",hidrefdate);
 		           } */
 		           
 		          if(($('#mode').val()=='A'))
 		        	  {
 		           
 		          if(datafield=="clear")
 		        	  
 		          {
 		        	  
 		        	var val= $('#mainuppergrid').jqxGrid('getcelltext', rowBoundIndex, "clear");
 		        	if(val==true)
 		        	  {
 		           $('#mainuppergrid').jqxGrid('setcellvalue', rowBoundIndex, "cldate",new Date());
 		          $('#mainuppergrid').jqxGrid('setcellvalue', rowBoundIndex, "cltime" ,new Date());
 		          
 		        	
 		        	  }
 		        	else{
 		        		 $('#mainuppergrid').jqxGrid('setcellvalue', rowBoundIndex, "cldate","");
 		        		  $('#mainuppergrid').jqxGrid('setcellvalue', rowBoundIndex, "cltime" ,"");
 		        	}
		          } 
 		        	  }
                if(datafield=="cltime")
 		        	  
 		          {
 		        	  
 		        
 		         $('#mainuppergrid').jqxGrid('setcellvalue', rowBoundIndex, "hidcltime" ,$('#mainuppergrid').jqxGrid('getcelltext', rowBoundIndex, "cltime"));
 		        	
 		        	 
		          } 
 		       
    		       
                if(datafield=="cldate")
 		          {
 		    	   
 		       
 		              var hidcldate = $('#mainuppergrid').jqxGrid('getcelltext', rowBoundIndex, "cldate");
		        	 // alert(text);
		        	  $('#mainuppergrid').jqxGrid('setcellvalue',rowBoundIndex, "hidcldate",hidcldate);
		          }
 		       
    		      
            });
                 

        }); 
    </script>
    <div id="mainuppergrid"></div>
