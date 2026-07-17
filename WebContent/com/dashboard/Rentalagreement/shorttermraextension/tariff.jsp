<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 

   	<%
   	String tdocno = request.getParameter("tdocno")==null?"NA":request.getParameter("tdocno").trim();
   	String revehGroup=request.getParameter("revehGroup")==null?"0":request.getParameter("revehGroup").trim();
   	String branch = request.getParameter("branch")==null?"0":request.getParameter("branch").trim();
  
System.out.println("-------"+tdocno);
   	%>
<script type="text/javascript">


 var temp2='<%=tdocno%>'; 


var hide;

var datatariff;
  if(temp2!="NA")
	{
	
		datatariff='<%=crad.relodeterm(session,branch,tdocno,revehGroup)%>';
	
	hide=2;
	
	}  

  else
	  {
	  
      datatariff;
	
}   
 

$(document).ready(function () { 
	
	var cellclassname;
	// var cellclass ;
    var num = 0; 
    
    
  
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
              	{name : 'rentaltype' , type: 'string' },
              	{name : 'rate' , type:'number'},
              	{name : 'cdw' , type:'number'},
              	{name : 'pai' , type:'number'},
              	{name : 'cdw1' , type:'number'},
              	{name : 'pai1' , type:'number'},
              	{name : 'gps' , type:'number'},
              	{name : 'babyseater' , type:'number'},
              	{name : 'cooler' , type:'number'},
              	 {name : 'kmrest' , type:'number'},
              	{name : 'exkmrte' , type:'number'},
              	{name : 'oinschg' , type:'number'},
              	{name : 'exhrchg' , type:'number'},
              	{name : 'chaufchg' , type:'number'},
              	{name : 'chaufexchg' , type:'number'},
              	{name : 'status' , type:'number'},
              	{name : 'disclevel' , type:'number'},
              	
              	
                
              	
              	
			   ],
			   localdata: datatariff,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
    $('#jqxgridtarif').on('bindingcomplete', function (event) {
    	
    	 
    	  
    
    	
    	
  if(temp2=="NA")
	  {

    
      $("#jqxgridtarif").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
      

    $("#jqxgridtarif").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
    
    $("#jqxgridtarif").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
	  } 
  
  
  else
	  {
	  
	   $("#jqxgridtarif").jqxGrid('addrow', null, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
	    
	    $("#jqxgridtarif").jqxGrid('addrow', null, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
		
	  }
  
 
  
});
	 
    var rowEdit = function (row) {
    	var rows11 = $("#jqxgridtarif").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    //	alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
    
    			 return false;
    	}
    }
    var cellsrenderer = function (row, column, value, defaultHtml) {
    				var rows11 = $("#jqxgridtarif").jqxGrid('getrows');
    					var rowval=rows11.length;
    				var row1=rowval-1;
    				var row2=rowval-2;
    				
    				
    			    if ( row == row1 ) {
    			    	//alert("row3"+row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#e6e6fa', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    				 if ( row == row2 ) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    			    var row3=rowval-3;
    			   
    			    if (row == row3) {
    			    	//alert(row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    			    return defaultHtml;
    			}


 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#jqxgridtarif").jqxGrid(
   {
      width: '100%',
      height: 86,
      source: dataAdapter,
      columnsresize: true,
      rowsheight:20,


      editable:true,
      selectionmode: 'singlecell',
      pagermode: 'default',
      theme: theme,
     

    

      
       columns: [  
            
					{ text: '   '+document.getElementById("mainrentaltype").value,   datafield: 'rentaltype', editable:false, cellsalign: 'center', align:'center',cellsrenderer: cellsrenderer },
					 { text: '      '+document.getElementById("mainrate").value,     datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer },
					{ text: '      '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai").value,     	 datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincdw1").value,    	 datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai1").value,    	 datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maingps").value,      	 datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainbabyseater").value,  	 datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '  '+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true, cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufchg").value,        datafield: 'chaufchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufexchg").value,      datafield: 'chaufexchg', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Status', datafield: 'status', editable:false,hidden:true},
					{ text: 'disclevel', datafield: 'disclevel', editable:false,hidden:true},
										]
      
        
					 }); 
   
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
   $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
  

   

   

   
   
   $("#jqxgridtarif").on('cellclick', function (event) 
		   {
		    
		       var dataField = event.args.datafield;
		     
		       var rowBoundIndex = event.args.rowindex;  
		     			       
		       if(dataField=="cdw"){
		    	   
		    
		    	   
		    var cdw1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw1") ;

		
		    	
		    if(cdw1>0||cdw1!="")
		    
		    	  {
		    $('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'cdw'); 
		    $.messager.alert('Message', 'Super CDW Is Selected ');	
		    //	document.getElementById("errormsg").innerText="Super CDW Is Selected";  
            
		    	return false;
		    	  }
		    else{
		    	 var cdwinsu=document.getElementById("cdwinsu").value;
		    	var tempss="excessinsur";
		    	 funRoundAmt(cdwinsu,tempss); 
		    	
		    	return true;
		      }
		       }
		       if(dataField=="cdw1"){
		     
				    var cdw=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw") ;
			
				    if(cdw>0||cdw!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'cdw1'); 
				    	$.messager.alert('Message', 'CDW Is Selected ');	
				    	//document.getElementById("errormsg").innerText="CDW Is Selected";  
				    	return false;
				    	  }
				    else
				    	{
				         var supercdwinsu=document.getElementById("supercdwinsu").value; 
			            var tempsss="excessinsur";
			            funRoundAmt(supercdwinsu,tempsss); 
				    	return true;
				    	}
				       }
		       if(dataField=="pai"){
		    	   
				    var pai1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai1") ;
					   
				    if(pai1>0||pai1!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'pai');
				    	$.messager.alert('Message', 'Super PAI Is Selected ');	
				    	//document.getElementById("errormsg").innerText="Super PAI Is Selected";  
				    	
				    	return false;
				    	  }
				    else{
				    	return true;
				    }
				       }
		       if(dataField=="pai1"){
		    	   
				    var pai=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai") ;
				
				    if(pai>0||pai!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'pai1');
				      	$.messager.alert('Message', 'Super PAI Is Selected');	
				    	
				    	
				    	//document.getElementById("errormsg").innerText="PAI Is Selected";  
				    	return false;
				    	  }
				    else
				    	{
				    	return true;
				    	}
				       }
		       
		   });


  
       
		   $("#jqxgridtarif").on("cellclick", function (event) {
			          var dataFields = event.args.datafield;
				
							 var columnfrist = event.args.columnindex;
							 
							 if(columnfrist==1)
							 {
								 
							 
							 var curdateout=new Date($('#jqxDaterentalout').jqxDateTimeInput('getDate')); 	
							 var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
							    
			                 $('#jqxDateOut ').jqxDateTimeInput('setDate', new Date(onemounth));
							 
							 }
							 
							 if(columnfrist>0)
								 {
																 
								 							 
			                   var val2;
			                var val1 = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, dataFields);
			                  val2 = $('#jqxgridtarif').jqxGrid('getcellvalue', 1, dataFields);
			               
							   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
							 
			                $('#jqxgridtarif').jqxGrid('setcellvalue', 2, dataFields,parseFloat(val3));
								 } 
					
				  
		   });
		  
				        
		 	
			   $("#jqxgridtarif").on('cellendedit', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				  //alert(""+rowBoundIndex)
				
				  
				  if(rowBoundIndex==1)
					   {
						     
							   var value = event.args.value;
							   
						  	   
							      
			

							   var temp = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, dataField);
							
									   if(value=="")
										   {
										   if(dataField=="cdw"){
									    	 var cdw1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw1") ;
	                                                     if(cdw1>0||cdw1!="")
											    
											    	  {
	                                                    	  $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw","");
	                                                    	
						
											  
											    	return false;
											    	  }
											    else{
									
											    	  $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw",temp);
											    	return true;
											      }
											       }
											       if(dataField=="cdw1"){
											     
													    var cdw=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw") ;
												
													    if(cdw>0||cdw!="")
													    
													    	  {
													    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw1","");
													   
													    	return false;
													    	  }
													    else
													    	{
													 
												            $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw1",temp);
													    	return true;
													    	}
													       }
											       if(dataField=="pai"){
											    	   
													    var pai1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai1") ;
														   
													    if(pai1>0||pai1!="")
													    
													    	  {
													    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai","");
											
													    	
													    	return false;
													    	  }
													    else{
													    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai",temp);
													    	return true;
													    }
													       }
											       if(dataField=="pai1"){
											    	   
													    var pai=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai") ;
													
													    if(pai>0||pai!="")
													    
													    	  {
													   	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai1","");
													 
													    	return false;
													    	  }
													    else
													    	{
													    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai1",temp);
													    	return true;
													    	}
													       }
											       
										   $("#jqxgridtarif").jqxGrid('setcellvalue', 2, dataField, temp);
										   }
									   if(value!="")
										   {
								
										var temp2=parseFloat(temp)-parseFloat(value);
											
									
											
						               $("#jqxgridtarif").jqxGrid('setcellvalue', 2, dataField, temp2);
						    
								
										
										}
								
                         }
				    }); 

	 		   $("#jqxgridtarif").on('cellvaluechanged', function (event) 
			            {
				   
				   var rowBoundIndex1 = event.args.rowindex;
				   var dataField = event.args.datafield;
				
				  if(rowBoundIndex1==1)
					   {
					   if(dataField=="cdw"){
						    	 var cdw1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw1") ;
                                            if(cdw1>0||cdw1!="")
								    
								    	  {
                                           	  $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw","");
                                           	 $('#jqxgridtarif').jqxGrid('setcellvalue', 1, "cdw","");
								
								  
								    	return false;
								    	  }
								    
								       }
								       if(dataField=="cdw1"){
								     
										    var cdw=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"cdw") ;
									
										    if(cdw>0||cdw!="")
										    
										    	  {
										    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "cdw1","");
										    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 1, "cdw1","");
										    
										    	return false;
										    	  }
										   
										       }
								       if(dataField=="pai"){
								    	   
										    var pai1=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai1") ;
											   
										    if(pai1>0||pai1!="")
										    
										    	  {
										    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai","");
										  
										    	 $('#jqxgridtarif').jqxGrid('setcellvalue', 1, "pai","");
										    	return false;
										    	  }
										   
										       }
								       if(dataField=="pai1"){
								    	   
										    var pai=$('#jqxgridtarif').jqxGrid('getcellvalue', 2,"pai") ;
										
										    if(pai>0||pai!="")
										    
										    	  {
										   	 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "pai1","");
										   	 $('#jqxgridtarif').jqxGrid('setcellvalue', 1, "pai1","");
										    	return false;
										    	  }
										    
										       }
							
							
					  
					        var tempval = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, dataField);
					        var value= $('#jqxgridtarif').jqxGrid('getcellvalue', 1, dataField);
					 	   var maxdisc=document.getElementById("calcuvals").value;
							if(parseFloat(value)>parseFloat(maxdisc))  
									{ 
								  var val="";
								  $('#jqxgridtarif').jqxGrid('setcellvalue', 1, dataField,val);
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', 2, dataField,tempval);
				            		//document.getElementById("errormsg").innerText="Discount Limit Exceeded";  
				            		$.messager.alert('Message', 'Discount Limit Exceeded');	
				            		
									return 0;
								  }
							
				             if(tempval=="")
				              {
				      
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', 1, dataField,"");
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', 2, dataField,"");
				              }
				            
				             else if(tempval==0)
				                {
				            	
				            	 var dataval=0;
				   
				             $('#jqxgridtarif').jqxGrid('setcellvalue', 1, dataField,dataval);
				            $('#jqxgridtarif').jqxGrid('setcellvalue', 2, dataField,dataval);
				                }
			            }
				  
				 
				  
				  
				  
			            }); 
			   $("#jqxgridtarif").on("celldoubleclick", function (event)
					   {
				  
				   var columnIndex3 = event.args.columnindex;
				   //alert(columnIndex3);
				  var rowindex3 = event.args.rowindex;
				  
				  var dataField = event.args.datafield;
		
				   var val="";
				   var columnNames = event.args.datafield;
				   
			
		                if(columnIndex3>0) 
		                	{
								   if(rowindex3<1)
									 {
									       
							                $('#jqxgridtarif').jqxGrid('setcellvalue', 1, columnNames,val);
							                $('#jqxgridtarif').jqxGrid('setcellvalue', 2, columnNames,val);
							                if(dataField=="cdw"){
												   
												   var normalinsu=document.getElementById("normalinsu").value;
													
											    	var tempss="excessinsur";
										             
										    	   funRoundAmt(normalinsu,tempss);
										    	   
									               }
									        if(dataField=="cdw1"){
									        	  var normalinsu=document.getElementById("normalinsu").value;
									        	  var tempss="excessinsur";
										             
										    	   funRoundAmt(normalinsu,tempss);
									    	 
											       }
							            
									 }
									
		                	}
				});
			   
			   $("#jqxgridtarif").on('cellbeginedit', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				   
				  if(rowBoundIndex==1)
					   {
						 
					
							   var rentalval = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, dataField);
							   var discval = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, "disclevel"); 
						
							var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
							
							if(parseFloat(calcval)==0)
							{
						
							 $('#jqxgridtarif').jqxGrid('clearselection');
								$.messager.alert('Message', 'Discount Not Allowed');	
						//	document.getElementById("errormsg").innerText="Discount Not Allowed ";
					//	alert("Discount Not Allowed ");
							return 0;
							}
							else
								{
							if(parseFloat(rentalval)>0)
								{
							document.getElementById("calcuvals").value=parseFloat(calcval);
								
								}
							
								}
							
							 
								
                         }
				    });
			   
			   $("#jqxgridtarif").on('cellselect', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				
				
				  
				  if(rowBoundIndex==1)
					   {
						 
							  
							   var rentalval = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, dataField);
							   var discval = $('#jqxgridtarif').jqxGrid('getcellvalue', 0, "disclevel");
						
							var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
							
							if(parseFloat(calcval)==0)
							{
						
							 $('#jqxgridtarif').jqxGrid('clearselection');
							 $.messager.alert('Message', 'Discount Not Allowed');	
						//	document.getElementById("errormsg").innerText="Discount Not Allowed ";
							return 0;
							}
													 
								
                         }
				    });
			   
			
		
			   
			   
});
    </script>

           
   <div id="jqxgridtarif"> </div>
   
   <input type="hidden" id="calcuvals">

<jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 