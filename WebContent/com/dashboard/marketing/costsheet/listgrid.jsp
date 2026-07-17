<%-- <%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetNo = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String group = request.getParameter("group")==null?"0":request.getParameter("group").trim();
     String model = request.getParameter("model")==null?"0":request.getParameter("model").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
 --%>
 <%@page import="com.dashboard.marketing.costsheet.ClscostSheetDAO" %>
 
 <%ClscostSheetDAO vewDAO= new ClscostSheetDAO();
  String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
 var check='<%=check%>';
if(check=="1")
	{
	 var data='<%=vewDAO.searchgrid()%>';
	}

else
{
	 var data;
	}
     
   
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no' , type: 'number' },
							{name : 'gpname' , type: 'String' },
							{name : 'descp' , type: 'String' },
     						{name : 'dy1', type: 'int'  },
     						{name : 'dy2',type:'int'},
     						{name : 'dy3',type:'int'},
     						{name : 'dy4',type:'int'},
     						{name : 'dy5',type:'int'},
     						{name : 'ins_per',type:'number'},
     						{name : 'mininsur',type:'number'},
     						{name : 'extrainsurperyear',type:'number'},
     						{name : 'majorsrvckm',type:'number'},
     						{name : 'srv_km',type:'number'},
     						{name : 'tyrechg_km',type:'number'},
     						{name : 'tyre_cost',type:'number'},
     						{name : 'maint_cost',type:'number'},
     						{name : 'majorsrvccost',type:'number'},
     						{name : 'trackidexp',type:'number'},
     						{name : 'repl_cost',type:'number'},
     						{name : 'carwash_cost',type:'number'},
     						{name : 'auh',type:'number'},
     						{name : 'dxb',type:'number'},
     						{name : 'shj',type:'number'},
     						{name : 'fuj',type:'number'},
     						{name : 'rak',type:'number'},
     						{name : 'btnsave', type: 'String'  },
     						{name : 'grpid',type:'number'},
     						
	                      ],
	                      
	                      
	                   
                          localdata: data,
               
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
            $("#listGridID").jqxGrid(
            {
                width: '98%',
                height: 560,
                source: dataAdapter,
                rowsheight:25,
                 
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlecell',
                showaggregates: true,
             	 
                editable: true,
                
                columns: [
							{ text: 'SL No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'Group', datafield: 'gpname', width: '14%',editable: false  },
							{ text: 'Description', datafield: 'descp', width: '14%',editable: false  },
							{ text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
							{ text: 'DY1', datafield: 'dy1', width: '5%',columngroup:'Depreciation',editable: true
								,cellbeginedit: function (row) {
									var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
								     if (temp =="Edit")
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  } },
							{ text: 'DY2', datafield: 'dy2', width: '5%',columngroup:'Depreciation',cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'DY3', datafield: 'dy3', width: '5%',columngroup:'Depreciation',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  }  },
							{ text: 'DY4', datafield: 'dy4', width: '5%',columngroup:'Depreciation',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  }  },
							{ text: 'DY5', datafield: 'dy5', width: '5%',columngroup:'Depreciation',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  }  },
							{ text: 'Insurance(%)', datafield: 'ins_per', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							  { text: 'Min. Insurance', datafield: 'mininsur', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
									var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
								     if (temp =="Edit")
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  } },
							  { text: 'Extra Insurance/Year', datafield: 'extrainsurperyear', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
									var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
								     if (temp =="Edit")
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  } },  
								  { text: 'Major srvc (km)', datafield: 'majorsrvckm', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
										var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
									     if (temp =="Edit")
									    	 {
									    			    	 
									       return false; 
									    	 }
									      
									   
									  } },
							{ text: 'Service(KM)', datafield: 'srv_km', width: '7%',columngroup:'Maintanence',editable: true ,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'Tyre Change(KM)', datafield: 'tyrechg_km', width: '9%',columngroup:'Maintanence',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'Tyre Cost',datafield:'tyre_cost', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'Maint.Cost',  datafield:'maint_cost',width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    	 
							       return false; 
							    	 }
							      
							   
							  } },
							  { text: 'Major Srvc Cost', datafield: 'majorsrvccost', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
									var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
								     if (temp =="Edit")
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  } },
								  { text: 'Tracking ID Exp', datafield: 'trackidexp', width: '7%',cellsformat:'d2',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
										var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
									     if (temp =="Edit")
									    	 {
									    			    	 
									       return false; 
									    	 }
									      
									   
									  } },
							{ text: 'Repl Cost', datafield: 'repl_cost', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Maintanence',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  }  },
							{ text: 'Car Wash Cost', datafield: 'carwash_cost', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Maintanence' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'AUH',datafield:'auh', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Registration',editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  }  },
							{ text: 'DXB',  datafield:'dxb',width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Registration' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'SHJ',  datafield:'shj',width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Registration',editable: true ,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'FUJ',  datafield:'fuj',width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Registration' ,editable: true,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'RAK',  datafield:'rak',width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Registration',editable: true ,cellbeginedit: function (row) {
								var temp=$('#listGridID').jqxGrid('getcellvalue', row, "btnsave");
							     if (temp =="Edit")
							    	 {
							    			    	 
							       return false; 
							    	 }
							      
							   
							  } },
							{ text: 'doc_no',  datafield:'doc_no',width: '7%',hidden:true},
							{ text: 'grpid',  datafield:'grpid',width: '7%',hidden:true},
							
							
							
							],
							columngroups: 
							  [
							    { text: 'Depreciation %', align: 'center', name: 'Depreciation',width: '20%' },
							    { text: 'Maint. Cycle', align: 'center', name: 'Maintanence',width: '20%' },
							    { text: 'Registration Cost', align: 'center', name: 'Registration',width: '20%' }
							 
							  ]
            
            
            
            //doc_no, gpname, dy1, dy2, dy3, dy4, dy5, ins_per, srv_km, tyrechg_km, tyre_cost, maint_cost, repl_cost, carwash_cost, auh, dxb, shj, fuj, rak;
            });
            if(check=="1")
	         {
              
           }  
          else
       	   {
       	   $("#listGridID").jqxGrid("addrow", null, {});
       	  $('#listGridID').jqxGrid('setcellvalue',0, "btnsave","Edit");
       	   }

			$("#overlay, #PleaseWait").hide();
			
			
			  $("#listGridID").on('cellendedit', function (event) {
	            	var dataField = event.args.datafield;
	                var rowIndex = event.args.rowindex;
	               
	          		if(dataField=="ins_per"){
	          			var value1 = event.args.value;
	          			if(parseFloat(value1)>100){ 
	          		        $("#listGridID").jqxGrid('showvalidationpopup', (rowIndex), "srv_km", "Limit Already Reached,Invalid Amount.");
	          		        //$('#txtvalidation').val(1);
	          		         return true;  
	          		        }
	          		    else {
	          		        $("#listGridID").jqxGrid('hidevalidationpopups');
	          		        //$('#txtvalidation').val(0);
	          		        return false;  
	          		        }
	          			}
	          		   
	          		
	          	 
	             });
	            
            
			  $("#listGridID").on('celldoubleclick', function (event) 
	            		{
	            		 
	            		    var datafield = event.args.datafield;

	            		    var rowBoundIndex = event.args.rowindex;
	            		    if(datafield=="gpname"){  
	              		  		 
	              		  		 var grpid= $('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "grpid");
	                               
	                         		 $("#sidegrid").load("listsidegrid.jsp?grpid="+grpid);
	              		  	}
	            		    if($('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
	          					if(datafield!="btnsave"){  
	          					  
	          					 var grpid= $('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "grpid");
	                            
	                       		 $("#sidegrid").load("listsidegrid.jsp?grpid="+grpid);
	          					}
	          					
	          				  }
			  
	            		});   
					      
			
            $("#listGridID").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;

            		    var rowBoundIndex = event.args.rowindex;
            			
            			
            		   
            		
            		  //  var columnindex = event.args.columnindex;
            		  
            		  
        /* 	if(datafield=="gpname"){  
		  		 
		  		 var grpid= $('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "grpid");
                
          		 $("#sidegrid").load("listsidegrid.jsp?grpid="+grpid);
		  	}
      */
          		 
          				 /*  if($('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
          					if(datafield!="btnsave"){  
          					  
          					 var grpid= $('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "grpid");
                            
                       		 $("#sidegrid").load("listsidegrid.jsp?grpid="+grpid);
          					}
          					
          				  } */
          	 
          			  
          			// doc_no, gpname, dy1, dy2, dy3, dy4, dy5, ins_per, srv_km, tyrechg_km, tyre_cost, maint_cost, repl_cost, carwash_cost, auh, dxb, shj, fuj, rak	    
                      if(datafield=="btnsave"){
                    	 if($('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
                    		
                    		 var doc_no= $('#listGridID').jqxGrid('getcelltext', rowBoundIndex, "doc_no");
                    		 
                    		 var dy1= $('#listGridID').jqxGrid('getcelltext', rowBoundIndex, "dy1");
                    		 var dy2=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "dy2");
                    		 var dy3=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "dy3");
                    		 var dy4=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "dy4");
                    		 var dy5=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "dy5");
                    		      
                    		 
                      		 var ins_per= $('#listGridID').jqxGrid('getcelltext', rowBoundIndex, "ins_per");
                      		 var mininsur=$('#listGridID').jqxGrid('getcellvalue', rowBoundIndex, "mininsur");
                    		 var extrainsurperyear=$('#listGridID').jqxGrid('getcellvalue', rowBoundIndex, "extrainsurperyear");
                    		 var majorsrvckm=$('#listGridID').jqxGrid('getcellvalue', rowBoundIndex, "majorsrvckm");
                      		 var srv_km=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "srv_km");
                    		 var tyrechg_km=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "tyrechg_km");
                    		 var tyre_cost=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "tyre_cost");
                    		 var maint_cost=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "maint_cost");
                    		 var majorsrvccost=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "majorsrvccost");
                    		 var trackidexp=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "trackidexp");
                    		 var repl_cost= $('#listGridID').jqxGrid('getcelltext', rowBoundIndex, "repl_cost");
                    		 var carwash_cost=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "carwash_cost");
                    		 var auh=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "auh");  
                    		 var dxb=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "dxb");
                    		 var shj=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "shj");
                    		 
                    		 var fuj=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "fuj");  
                    		 var rak=$('#listGridID').jqxGrid('getcellvalue',rowBoundIndex, "rak");
                    		 
                    		
                    		if(parseFloat(ins_per)>100)
                    			{
                    			 $.messager.alert('Message', 'Limit Already Reached,Invalid Amount In Insurance(%) ', function(r){
                				     
                			     });
                    			 
                    			 return 0;
                    			}
                    		
                    		
                    		
             		           
             		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
             		        	  
             		       
             		        	if(r==false)
             		        	  {
             		        		return false; 
             		        	  }
             		        	else{
             		        	 savegriddata(doc_no, dy1, dy2, dy3, dy4, dy5, ins_per, srv_km, tyrechg_km, tyre_cost, maint_cost, repl_cost, carwash_cost, auh, dxb, shj, fuj, rak,extrainsurperyear,majorsrvckm,majorsrvccost,trackidexp,mininsur);
             		        	}
             			     });
             		 	  
                    	 }
                    	 else {
                    	
                    		// var doc_no= $('#listGridID').jqxGrid('getcelltext', rowBoundIndex, "doc_no");
                    		
                    		// $("#sidegrid").load("listsidegrid.jsp?grpid"+grpid+"&doc_no="+doc_no); 
                    		 
                    	  $('#listGridID').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
                    	 }
                      }
            		   
            		}); 

            
			
        });
        function savegriddata(doc_no, dy1, dy2, dy3, dy4, dy5, ins_per, srv_km, tyrechg_km, tyre_cost, maint_cost, repl_cost, carwash_cost, auh, dxb, shj, fuj, rak,extrainsurperyear,majorsrvckm,majorsrvccost,trackidexp,mininsur)
        {
        	
        	
        	

        	var x=new XMLHttpRequest();
        	x.onreadystatechange=function(){
        	if (x.readyState==4 && x.status==200)
        		{
        		
        		
        		 	var items= x.responseText;
        		 	
        		
        		 	 $.messager.alert('Message', 'Record successfully Updated ', function(r){
        				     
        			     });
        		 	funreload(event);
        			
        		 	 
            }
        	}
        	
        	// doc_no, gpname, dy1, dy2, dy3, dy4, dy5, ins_per, srv_km, tyrechg_km, tyre_cost, maint_cost, repl_cost, carwash_cost, auh, dxb, shj, fuj, rak
        	
             x.open("GET","saveGriddate.jsp?doc_no="+doc_no+"&dy1="+dy1+"&dy2="+dy2+"&dy3="+dy3+"&dy4="+dy4+"&dy5="+dy5+"&ins_per="+ins_per
            		 +"&srv_km="+srv_km+"&tyrechg_km="+tyrechg_km+"&tyre_cost="+tyre_cost+"&maint_cost="+maint_cost+"&repl_cost="+repl_cost+"&carwash_cost="+carwash_cost
            		 +"&auh="+auh+"&dxb="+dxb+"&shj="+shj+"&fuj="+fuj+"&rak="+rak+"&extrainsurperyear="+extrainsurperyear+"&majorsrvckm="+majorsrvckm+"&majorsrvccost="+majorsrvccost+"&trackidexp="+trackidexp+"&mininsur="+mininsur,true);
        	 
            x.send();
           
          
        }
</script>
<div id="listGridID"></div>
