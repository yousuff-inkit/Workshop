<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

   	<%
   	String rdocno = request.getParameter("rdocno")==null?"NA":request.getParameter("rdocno").trim();


   	%>

 
<script type="text/javascript">

var rtariffs;

var tepss='<%=rdocno%>';

if(tepss!='NA')
	{
	 rtariffs='<%=crad.ratariffchangegrid(rdocno)%>';
	
	}
else
	{
	
	rtariffs;
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
			   localdata: rtariffs,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
    $('#rtaiff').on('bindingcomplete', function (event) {
    	
    
    	
  if(tepss!="NA")
	  {

    
      $("#rtaiff").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
      

    $("#rtaiff").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
    
    $("#rtaiff").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
	  } 
  
  
});
	 
    var rowEdit = function (row) {
    	var rows11 = $("#rtaiff").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    //	alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
    
    			 return false;
    	}
    }
    var cellsrenderer = function (row, column, value, defaultHtml) {
    				var rows11 = $("#rtaiff").jqxGrid('getrows');
    					var rowval=rows11.length;
    				var row1=rowval-1;
    				var row2=rowval-2;
    				
    				 if ( row == 0 || row == 1 || row == 2) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
     				 if ( row == row2 ) {
      			    	//alert("row3"+row3);
      			        var element = $(defaultHtml);
      			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
      			        return element[0].outerHTML;
      			    }
     			    var row3=rowval-3;
     			   
     			    if (row == row3 || row == row1 ) {
     			    	//alert(row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#FFE87C', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    				
    			   /*  if ( row == row1 ) {
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
    			    } */
    			    return defaultHtml;
    			}


 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#rtaiff").jqxGrid(
   {
      width: '100%',
      height: 167,
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
   
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
  

   
  var setvalu = $("#rtaiff").jqxGrid('getrows');
	
	var tempone=setvalu.length;
	var nettotalrow=tempone-1;
	var discountrow=tempone-2;
	var rentalrow=tempone-3; 
	
 
  
	  $("#rtaiff").on('cellclick', function (event) 
			   {
			    
			       var dataField = event.args.datafield;
			     
			       var rowBoundIndex = event.args.rowindex;  
			     			       
			       if(dataField=="cdw"){
			    	   
			    
			    	   
			    var cdw1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;

			
			    	
			    if(cdw1>0||cdw1!="")
			    
			    	  {
			    $('#rtaiff').jqxGrid('unselectcell', rowBoundIndex, 'cdw'); 
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
			     
					    var cdw=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
				
					    if(cdw>0||cdw!="")
					    
					    	  {
					    	$('#rtaiff').jqxGrid('unselectcell', rowBoundIndex, 'cdw1'); 
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
			    	   
					    var pai1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
						   
					    if(pai1>0||pai1!="")
					    
					    	  {
					    	$('#rtaiff').jqxGrid('unselectcell', rowBoundIndex, 'pai');
					    	$.messager.alert('Message', 'Super PAI Is Selected ');	
					    	//document.getElementById("errormsg").innerText="Super PAI Is Selected";  
					    	
					    	return false;
					    	  }
					    else{
					    	return true;
					    }
					       }
			       if(dataField=="pai1"){
			    	   
					    var pai=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai") ;
					
					    if(pai>0||pai!="")
					    
					    	  {
					    	$('#rtaiff').jqxGrid('unselectcell', rowBoundIndex, 'pai1');
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
	       
			   $("#rtaiff").on("cellclick", function (event) {
				          var dataFields = event.args.datafield;
					
								 var columnfrist = event.args.columnindex;
								 if(columnfrist==0)
								  {
								rowindex1 = event.args.rowindex;
								 
								 if(rowindex1<rentalrow)
									 {
										
								$("#rtaiff").jqxGrid('updaterow', rentalrow, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
								$("#rtaiff").jqxGrid('updaterow', discountrow, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
								$("#rtaiff").jqxGrid('updaterow', nettotalrow, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
								 var normalinsu=document.getElementById("normalinsu").value;
					        	 var tempss="excessinsur";
						    	 funRoundAmt(normalinsu,tempss);
								$('#rtaiff').jqxGrid('setcellvalue', rentalrow, "rentaltype",$('#rtaiff').jqxGrid('getcellvalue', rowindex1, "rentaltype"));
								
					 
								
					 		  $('#rtaiff').jqxGrid('setcellvalue', rentalrow, "rate",$('#rtaiff').jqxGrid('getcellvalue', rowindex1, "rate"));
								$('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "rate",$('#rtaiff').jqxGrid('getcellvalue', rowindex1, "rate"));
									 }
								  }
								 if(columnfrist==1)
								 {
									 
								 
								 var curdateout=new Date($('#jqxDaterentalout').jqxDateTimeInput('getDate')); 	
								 var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
								    
				                 $('#jqxDateOut ').jqxDateTimeInput('setDate', new Date(onemounth));
								 
								 }
								 
								 if(columnfrist>0)
									 {
																	 
									 							 
				                   var val2;
				                var val1 = $('#rtaiff').jqxGrid('getcellvalue', rowindex1, dataFields);
				                  val2 = $('#rtaiff').jqxGrid('getcellvalue', discountrow, dataFields);
				               
								   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
								   $('#rtaiff').jqxGrid('setcellvalue', rentalrow, dataFields,val1);
				                $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, dataFields,parseFloat(val3));
									 } 
						
					  
			   });
			  
					        
			 	
				   $("#rtaiff").on('cellendedit', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					  //alert(""+rowBoundIndex)
					
					  
					  if(rowBoundIndex==discountrow)
						   {
							     
								   var value = event.args.value;
						
								   var temp = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, dataField);
								
										   if(value=="")
											   {
											   if(dataField=="cdw"){
										    	 var cdw1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;
		                                                     if(cdw1>0||cdw1!="")
												    
												    	  {
		                                                    	  $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw","");
		                                                    	
							
												  
												    	return false;
												    	  }
												    else{
										
												    	  $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw",temp);
												    	return true;
												      }
												       }
												       if(dataField=="cdw1"){
												     
														    var cdw=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
													
														    if(cdw>0||cdw!="")
														    
														    	  {
														    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw1","");
														   
														    	return false;
														    	  }
														    else
														    	{
														 
													            $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw1",temp);
														    	return true;
														    	}
														       }
												       if(dataField=="pai"){
												    	   
														    var pai1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
															   
														    if(pai1>0||pai1!="")
														    
														    	  {
														    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai","");
												
														    	
														    	return false;
														    	  }
														    else{
														    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai",temp);
														    	return true;
														    }
														       }
												       if(dataField=="pai1"){
												    	   
														    var pai=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai") ;
														
														    if(pai>0||pai!="")
														    
														    	  {
														   	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai1","");
														 
														    	return false;
														    	  }
														    else
														    	{
														    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai1",temp);
														    	return true;
														    	}
														       }
												       
											   $("#rtaiff").jqxGrid('setcellvalue', nettotalrow, dataField, temp);
											   }
										   if(value!="")
											   {
									
											var temp2=parseFloat(temp)-parseFloat(value);
												
										
												
							               $("#rtaiff").jqxGrid('setcellvalue', nettotalrow, dataField, temp2);
							    
									
											
											}
									
	                         }
					    }); 

		 		   $("#rtaiff").on('cellvaluechanged', function (event) 
				            {
					   
					   var rowBoundIndex1 = event.args.rowindex;
					   var dataField = event.args.datafield;
					
					  if(rowBoundIndex1==discountrow)
						   {
						   if(dataField=="cdw"){
							    	 var cdw1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw1") ;
	                                            if(cdw1>0||cdw1!="")
									    
									    	  {
	                                           	  $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw","");
	                                           	 $('#rtaiff').jqxGrid('setcellvalue', discountrow, "cdw","");
									
									  
									    	return false;
									    	  }
									    
									       }
									       if(dataField=="cdw1"){
									     
											    var cdw=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"cdw") ;
										
											    if(cdw>0||cdw!="")
											    
											    	  {
											    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "cdw1","");
											    	 $('#rtaiff').jqxGrid('setcellvalue', discountrow, "cdw1","");
											    
											    	return false;
											    	  }
											   
											       }
									       if(dataField=="pai"){
									    	   
											    var pai1=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai1") ;
												   
											    if(pai1>0||pai1!="")
											    
											    	  {
											    	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai","");
											  
											    	 $('#rtaiff').jqxGrid('setcellvalue', discountrow, "pai","");
											    	return false;
											    	  }
											   
											       }
									       if(dataField=="pai1"){
									    	   
											    var pai=$('#rtaiff').jqxGrid('getcellvalue', nettotalrow,"pai") ;
											
											    if(pai>0||pai!="")
											    
											    	  {
											   	 $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, "pai1","");
											   	 $('#rtaiff').jqxGrid('setcellvalue', discountrow, "pai1","");
											    	return false;
											    	  }
											    
											       }
								
								
						  
						        var tempval = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, dataField);
						        var value= $('#rtaiff').jqxGrid('getcellvalue', discountrow, dataField);
						 	   var maxdisc=document.getElementById("calcuvals").value;
								if(parseFloat(value)>parseFloat(maxdisc))  
										{ 
									  var val="";
									  $('#rtaiff').jqxGrid('setcellvalue', discountrow, dataField,val);
					            	  $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, dataField,tempval);
					            		//document.getElementById("errormsg").innerText="Discount Limit Exceeded";  
					            		$.messager.alert('Message', 'Discount Limit Exceeded');	
					            		
										return 0;
									  }
								
					             if(tempval=="")
					              {
					      
					            	  $('#rtaiff').jqxGrid('setcellvalue', discountrow, dataField,"");
					            	  $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, dataField,"");
					              }
					            
					             else if(tempval==0)
					                {
					            	
					            	 var dataval=0;
					   
					             $('#rtaiff').jqxGrid('setcellvalue', discountrow, dataField,dataval);
					            $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, dataField,dataval);
					                }
				            }
					  
					  
				            }); 
				   $("#rtaiff").on("celldoubleclick", function (event)
						   {
					  
					   var columnIndex3 = event.args.columnindex;
					   //alert(columnIndex3);
					  var rowindex3 = event.args.rowindex;
					  
					  var dataField = event.args.datafield;
			
					   var val="";
					   var columnNames = event.args.datafield;
					   
				
			                if(columnIndex3>0) 
			                	{
									   if(rowindex3<discountrow)
										 {
										       
								                $('#rtaiff').jqxGrid('setcellvalue', discountrow, columnNames,val);
								                $('#rtaiff').jqxGrid('setcellvalue', nettotalrow, columnNames,val);
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
				   
				   $("#rtaiff").on('cellbeginedit', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					   
					  if(rowBoundIndex==discountrow)
						   {
							 
						
								   var rentalval = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, dataField);
								   var discval = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, "disclevel"); 
							
								var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
								
								if(parseFloat(calcval)==0)
								{
							
								 $('#rtaiff').jqxGrid('clearselection');
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
				   
				   $("#rtaiff").on('cellselect', function (event) 
						   {
					   var rowBoundIndex = event.args.rowindex;
					   var dataField = event.args.datafield;
					
					
					  
					  if(rowBoundIndex==discountrow)
						   {
							 
								  
								   var rentalval = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, dataField);
								   var discval = $('#rtaiff').jqxGrid('getcellvalue', rentalrow, "disclevel");
							
								var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
								
								if(parseFloat(calcval)==0)
								{
							
								 $('#rtaiff').jqxGrid('clearselection');
								 $.messager.alert('Message', 'Discount Not Allowed');	
							//	document.getElementById("errormsg").innerText="Discount Not Allowed ";
								return 0;
								}
														 
									
	                         }
					    });
		   
		
			   

		
			   
			   
});
    </script>

           
   <div id="rtaiff"> </div>
   

<input type="hidden" id="calcuvals">

 <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include>   



