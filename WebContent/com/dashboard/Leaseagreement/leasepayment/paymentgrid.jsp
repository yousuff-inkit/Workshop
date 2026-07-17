
  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   


<script type="text/javascript">

 
	var da= '[{"payment":"Pre Auth"}]';

var list =['CARD','ONLINE'];
var list1 =['VISA','MASTER'];
	



$(document).ready(function () { 	
   var columnsrenderer = function (value) {
		return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
	}
var source =
 {
 datatype: "json",
 datafields: [
             {name : 'payment' , type: 'string'},
             {name : 'paytype' , type: 'string'},
             {name : 'mode' , type:'String'},
             {name : 'amount' , type:'number'}, 
             {name : 'acode' , type:'String'},
           	{name : 'card' , type:'String'},
           	{name : 'cardno' , type:'number'},
             {name : 'cardtype' , type:'number'},
             {name : 'expdate' , type:'date'},
           	{name : 'recieptno' , type:'String'},
           	{name : 'hidexpdate' , type:'String'},
			{name : 'btnsave', type: 'String'  },
			{name : 'odate', type: 'string'  },
			{name : 'brhid', type: 'String'  },
			//odate odate
			
			   ],
			localdata: da,
      
      pager: function (pagenum, pagesize, oldpagenum) {
          // callback called when a page or pagse size is changed.
      }
};


var cellsrenderer = function (row, column, value, defaultHtml) {

	
	
    if ( row == 0) {
    	//alert("row3"+row3); //ffe4e1
        var element = $(defaultHtml); //add8e6 // eee8aa //f5deb3
        element.css({ 'background-color': '#f5deb3', 'width': '100%', 'height': '100%', 'margin': '0px' });
        return element[0].outerHTML;
    }
   
    return defaultHtml;
}

var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
           //alert(error);
        }
      });

$("#jqxgridpayment").on("bindingcomplete", function (event) {
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "btnsave","Save");
	// $("#jqxgridpayment").jqxGrid({ disabled: true});
});                       




  $("#jqxgridpayment").jqxGrid(
  {
     width: '100%',
     height: 120,
     source: dataAdapter,
    // rowsheight:20,
 
     selectionmode: 'singlecell',
     
     editable:true, 
    

      columns: [   
                
           
                { text: 'LA NO', datafield: 'vocno', width: '8%',editable:false ,cellsrenderer: cellsrenderer },
                    { text: 'LA NO', datafield: 'rano', width: '8%',editable:false ,cellsrenderer: cellsrenderer ,hidden:true},
					{ text: 'Payment', datafield: 'payment', width: '9%',editable:false, cellsalign: 'center',align: 'center',cellsrenderer: cellsrenderer },
					{ text: 'Mode',  datafield: 'mode',  width: '10%',cellsalign: 'center',cellsrenderer: cellsrenderer ,align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                                             editor.jqxDropDownList({autoDropDownHeight: true,  source: list });
                       }
                       
					
					},
					
					{ text: 'Amount',  datafield: 'amount',  width: '12%',editable:true,cellsalign: 'right',align: 'right',cellsformat: 'd2',cellsrenderer: cellsrenderer },
					{ text: 'Auth No',  datafield: 'acode',  width: '15%',editable:true,cellsalign: 'left',align: 'left',cellsrenderer: cellsrenderer 
					
					},
					{ text: 'Card Type',  datafield: 'card',  width: '10%',cellsalign: 'center',align: 'center',cellsrenderer: cellsrenderer ,columntype:'dropdownlist',createeditor: function (row, column, editor) {
                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list1 });
                        
					
					}
                         },
                   { text: 'cardtypeno',  datafield: 'cardtype',  width: '15%',editable:true,hidden:true,cellsrenderer: cellsrenderer },    
					{ text: 'Card NO',  datafield: 'cardno',  width: '20%'  ,editable:true ,cellsalign: 'left',align: 'left',cellsrenderer: cellsrenderer 
						
					},
					{ text: 'Exp:Date',  datafield: 'expdate',  width: '10%', editable:true,cellsrenderer: cellsrenderer ,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'MM-yyyy'				
					
					
					},
					{ text: 'Hide Date', datafield: 'hidexpdate', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					{ text: 'modetypeno', datafield: 'paytype', width: '8%',editable:false,hidden:true},
					{ text: 'Status', datafield: 'status', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'odate', datafield: 'odate', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true}, 
					{ text: 'brhih', datafield: 'brhid', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true} 
					
					
	              ]
        });

  
  $("#jqxgridpayment").on('cellvaluechanged', function (event) 
  		   { 		  
  		       var rowBoundIndex1 = event.args.rowindex;
  		       var datafield1 = event.args.datafield;
  		      
  		    
  		      
  		      if(datafield1=="mode")
  		    	  {
  		    	  var modeval=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "mode");
  		    	 
  		    	 
  		    	    if(modeval=="CARD")
		    		  {
		    		  
		    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",2);
		    		  }
  		    	   else if(modeval=="ONLINE")
		    		  {
		    		  
		    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",3);
		    		  } 
  		    	  else
		    		  {   		  
		    		 
		    		  }
  		    	  }
  		     if(datafield1=="card")
		    	  {
  		    	 
  		    	 var cardval=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "card");
		    	  if(cardval=="VISA")
		    		  {
		    		  
		    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "cardtype",1);
		    		  }
		    	  else  if(cardval=="MASTER")
	    		  {
	    		  
	    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "cardtype",2);
	    		  }
		    	
		    	  else
	    		  {   		  
	    		 
	    		  }
		    	  }
  		        
  	       if(datafield1=="cardno"){
		    	  
		           var cardvalue = event.args.newvalue; 
		           var length = (cardvalue + '').replace('-', '').length;
		        
		           if(length==16){ 
		           $("#jqxgridpayment").jqxGrid('hidevalidationpopups');
		            return true;  
		           }
		           
		           if(length==0){ 
   		           $("#jqxgridpayment").jqxGrid('hidevalidationpopups');
   		            return true;  
   		           }
		           
		           else  
		           {  
		           $("#jqxgridpayment").jqxGrid('showvalidationpopup', 0, "cardno", "Invalid Card Number");
		           return false;  
		           }
		         
  	           }
  	       
  	       
  	       
  	     if(datafield1=="expdate")
		       {
		    	   
		        
		        
		        	    
		          var text = $('#jqxgridpayment').jqxGrid('getcelltext', 0, "expdate");
	        	 // alert(text);
	        	  $('#jqxgridpayment').jqxGrid('setcellvalue',0, "hidexpdate",text);
	        	 
		       
		       }
  		   });
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  $("#jqxgridpayment").on('cellclick', function (event) 
  		{
  		 
  		    var datafield = event.args.datafield;

  		  //  var rowBoundIndex = event.args.rowindex;
  		  //  var columnindex = event.args.columnindex;
  			  
  		 /* 
  			  if(columnindex>7)
  				  {
  				  if(columnindex!=13 && columnindex!=14 )
  					  {
  				  if($('#jqxgridpayment').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
  					  $.messager.alert('Message','Click Edit Button','warning');
  					
  				            }
  				  
  					  }
  				  
  				  
  				  } */
  		    
  			
  			   /*  newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
						   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
						   +rows[i].invno+" :: "+rows[i].status+" :: ");  */ 
            if(datafield=="btnsave"){
/*           	 if($('#jqxgridpayment').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){ */
          		
          		 var payment= $('#jqxgridpayment').jqxGrid('getcelltext', 0, "payment");
          		 var mode= $('#jqxgridpayment').jqxGrid('getcellvalue',0, "mode");
          		 var amount= $('#jqxgridpayment').jqxGrid('getcellvalue',0, "amount");
          		 var acode= $('#jqxgridpayment').jqxGrid('getcelltext', 0, "acode");
          		 var cardno= $('#jqxgridpayment').jqxGrid('getcellvalue', 0, "cardno");
          		 var hidexpdate= $('#jqxgridpayment').jqxGrid('getcellvalue', 0, "hidexpdate");
          		 var card=$('#jqxgridpayment').jqxGrid('getcellvalue',0, "card");
          		 
          		 var cardtype=$('#jqxgridpayment').jqxGrid('getcellvalue',0, "cardtype");
          		 var paytype=$('#jqxgridpayment').jqxGrid('getcellvalue',0, "paytype");
          		var rano=$('#jqxgridpayment').jqxGrid('getcellvalue',0, "rano");
          		 
          		 var odate=$('#jqxgridpayment').jqxGrid('getcelltext',0, "odate");
          		 var brhid=$('#jqxgridpayment').jqxGrid('getcellvalue',0, "brhid");
          		 
          	//	 alert(payment);
          		 
          	//	odate brhid
          		 
          		 //for 
          		 
          		 
          		 // var renval;
		            		 if(rano==""||typeof(rano)=="undefined")
		            		 {
		            			
		            			  $.messager.alert('Message',' RA NO Is Required','warning');
		                       
		            			  
		            				return false; 
		            			
					            		 }
			            		 if(mode==""||typeof(mode)=="undefined")
			            		 {
			            			
			            			 $.messager.alert('Message','Select Mode','warning');
			                       
			            			  
			            				return false; 
			            			
			            		 }
		          	 	 
		          		          if(amount==""||typeof(amount)=="undefined")
						            		 {
		          		        	  $.messager.alert('Message','Enter Amount','warning'); 
						            			
						            			  
						            				return false; 
						            		 }
						            		
          		 
				            		 if(acode==""||typeof(acode)=="undefined")
				            		 {
				            			  $.messager.alert('Message',' Enter Auth NO','warning'); 
				                         
				            				return false; 
				            		 }
				            		 if(cardtype==""||typeof(cardtype)=="undefined")
				            		 {
				            			  $.messager.alert('Message',' Enter Card Type','warning'); 
				                         
				            				return false; 
				            		 }
				            		 
				            		 if(cardno==""||typeof(cardno)=="undefined")
				            		 {
				            			  $.messager.alert('Message',' Enter Card No','warning'); 
				                         
				            				return false; 
				            		 }
				            		 
          		
					            		 if(hidexpdate==null||typeof(hidexpdate)=="undefined")
					            		 {
					            			
					            			 $.messager.alert('Message',' Enter Expiry Date','warning'); 
					                       
					            			  
					            				return false; 
					            			
					            		 }
          		 
          		 
				            		/*  var nmax = renval.length;
				            		
				            		
				     		           if(nmax>39)
				     		        	   {
				     		        	   
				     		        	  $.messager.alert('Message','Remarks cannot contain more than 40 characters ','warning');   
				     		        	 
				             			  
				             				return false; 
				     		        	   
				     		        	 
				     		        	 
				     		        	   }   */
   		                          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   		                        	 
   		                   		 
   	     		       
					       		        	if(r==false)
					       		        	  {
					       		        		return false; 
					       		        	  }
					       		        	else{
					       		        		//alert("1");
					        				 savegriddata(payment,mode,amount,acode,cardno,hidexpdate,card,cardtype,paytype,rano,odate,brhid);
					       		        	   }
   		                      });
          	// }
          	 /* else {
          		 
          	
          	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
          	    } */
            }
  		   
  		}); 


  
});
  
     
function  savegriddata(payment,mode,amount,acode,cardno,hidexpdate,card,cardtype,paytype,rano,odate,brhid)
{
	
 
	 var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		 	 $.messager.alert('Message', '  Record successfully Updated ', function(r){
		 		 
		 		 
				     
			     });
		 	 
		 	funreload(event);
		 	 
    }
	}
     x.open("GET","paymentsave.jsp?payment="+payment+"&mode="+mode+"&amount="+amount+"&acode="+acode+"&cardno="+cardno+"&hidexpdate="+hidexpdate+"&card="+card+"&cardtype="+cardtype+"&paytype="+paytype+"&rano="+rano+"&odate="+odate+"&brhid="+brhid,true);
    x.send(); 
   
  
}       
         
  

         
         
         
   </script>

          
  <div id="jqxgridpayment"></div>  


