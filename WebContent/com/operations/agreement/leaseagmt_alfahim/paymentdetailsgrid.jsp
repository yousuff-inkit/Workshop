
  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>   
   	<%
   	String txtrentaldoc = request.getParameter("paymentGriddocno")==null?"0":request.getParameter("paymentGriddocno").trim();
   /* 	txtrentaldoc="35"; */
   ClsLeaseAgreementDAO viewDAO=new ClsLeaseAgreementDAO();
   	%>  
 
<script type="text/javascript">
  var temp='<%=txtrentaldoc%>';
  var da;
  var datas;
  var datas1;
//alert("temp"+temp);
//alert("condition = "+(temp>0));
 if(temp>0)
	{
	 
	 da='<%=viewDAO.reloadpayment(session,txtrentaldoc)%>';  
	//  alert(da);
	}

 else
	 
	{   
	 
	 var da= '[{"payment":"Advance"},{"payment":"Security"},{"payment":"Pre Auth"}]';
	 
		datas='<%=viewDAO.getmode()%>';  

		datas1='<%=viewDAO.getcard()%>';  
		//alert(datas);
		 var list = datas.split(","); 
		 var list1 = datas1.split(",");  
			
	
	 } 



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
           	{name : 'hidexpdate' , type:'String'}
			   ],
			localdata: da,
      
      pager: function (pagenum, pagesize, oldpagenum) {
          // callback called when a page or pagse size is changed.
      }
};

var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
           //alert(error);
        }
      });


  $("#jqxgridpayment").jqxGrid(
  {
     width: '100%',
     height: 87,
      source: dataAdapter,
     
     rowsheight:20,
     pagesize: 25,
     disabled:true,
     selectionmode: 'singlecell',
     
     editable:true,
    

      columns: [
					{ text: 'Payment', datafield: 'payment', width: '9%',editable:false, cellsalign: 'center',align: 'center'},
					{ text: 'Mode',  datafield: 'mode',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                                             editor.jqxDropDownList({autoDropDownHeight: true,  source: list });
                                            
      							               
      							             
      							           }
                       
					
					},
					
					{ text: 'Amount',  datafield: 'amount',  width: '15%',editable:true,cellsalign: 'right',align: 'right',cellsformat: 'd2'},
					{ text: 'Auth No',  datafield: 'acode',  width: '18%',editable:true,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
						    			    	 
						       return false; 
						    	 }
						      
						   
						  }
					
					
					},
					{ text: 'Card Type',  datafield: 'card',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list1 });
                        
					
					},cellbeginedit: function (row) {
						var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', row, "paytype");
					     if (parseInt(temp) ==1)
					    	 {
						       
						       return false;
							 }
					}
				
                         },
                   { text: 'cardtypeno',  datafield: 'cardtype',  width: '15%',editable:true,hidden:true},    
					{ text: 'Card NO',  datafield: 'cardno',  width: '20%'  ,editable:true ,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
							       return false;
								 }
						   /*   if (temp =="CHEQUE")
						    	 {
						    	 
						    	 
						       return false;
						    	 } */
						  }
					},
					{ text: 'Exp:Date',  datafield: 'expdate',  width: '10%', editable:true,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'MM-yyyy',
			
						cellbeginedit: function (row) {
							var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
							       return false;
						    	 }
						    /*  if (temp =="CHEQUE")
						       return false; */
						
						  },
						
					
					  createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
			               editor.jqxDateTimeInput({ enableBrowserBoundsDetection: true});
			               
			             
			           }
					
					},
					{ text: 'Hide Date', datafield: 'hidexpdate', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'Reciept NO', datafield: 'recieptno', width: '8%',editable:false, cellsalign: 'left',align: 'left'},
					{ text: 'modetypeno', datafield: 'paytype', width: '8%',editable:false,hidden:true},
					{ text: 'Status', datafield: 'status', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
					
					
	              ]
        });

  if ($("#mode").val() == "A") {
	   
	   
	     $("#jqxgridpayment").jqxGrid({ disabled: false});
	  
		 
	    }
 
      $("#jqxgridpayment").on('cellvaluechanged', function (event) 
   		   {
   		        		  
   		       var rowBoundIndex = event.args.rowindex;
   		       var datafield = event.args.datafield;
   		       
   		       var paymentval4="";
   		       
   		       if(datafield=="mode")
   		       {
   		    	   
   		    
   		          if(rowBoundIndex==0)
   		        	  
   		        	  {
   		        
   		        	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
   		        	     		        
   		        	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
    		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
   		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",1);
   		        	 
   		        	  }
   		          if(rowBoundIndex==1)
   		        	  
		        	  {
   		        	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
   		        	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
     		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",2);
		        	 
		        	  
		        	  }
                   if(rowBoundIndex==2)
   		        	  
		        	  {
                   	//var value = event.args.newvalue;
                    
                       $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",3);
                       
                       var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex, "mode");
              		   	
         		   		 if (temp =="CASH")
         		   			 {
                   		 
                   		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "mode",paymentval4);
                   		  document.getElementById("errormsg").innerText=" Only Cards Can Be Opted"; 	 
                   		}
                   
                 /*   	else if(value=="CHEQUE")
               		{
                   		 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "mode",paymentval4);
                   		document.getElementById("errormsg").innerText=" Only Cards Can Be Opted"; 	 
               		} */
                   	else{
                   		document.getElementById("errormsg").innerText="";	
                   	}
                   	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
                   	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
    		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
		        	
		        	  
		        	  }
   		       }
   		       if(datafield=="expdate")
   		       {
   		    	   
   		          if(rowBoundIndex>=0)
   		        	  
   		        	  {
   		        	    
   		          var text = $('#jqxgridpayment').jqxGrid('getcelltext', rowBoundIndex, "expdate");
		        	 // alert(text);
		        	  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",text);
		        	    }
   		       
   		       
   		       }
   		     
   		 /*       if(datafield=="card")
   		    {
   		   		var temp=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex, "mode");
   		   	
   		   		 if (temp =="CASH")
   		   			 {
   		   		document.getElementById("errormsg").innerText=" Card Type Cannot Opted For Cash  "; 	
   		   			$('#jqxgridpayment').jqxGrid('setcellvalue', rowBoundIndex, "card",paymentval4);
   		   			
   		   			 
   		   			 } */
   		   /* 	  else if (temp =="CHEQUE")
   		   	    	 {
   		        	document.getElementById("errormsg").innerText=" Card Type Cannot Opted For Cheque"; 	
   		   	    	$('#jqxgridpayment').jqxGrid('setcellvalue', rowBoundIndex, "card",paymentval4);
   		  
   		   	    	 } */
   		  /*  	else{
           		document.getElementById("errormsg").innerText="";	
           	}
       	   */
   		   	   
   		   	  
   		       
   		       
   		       if(datafield=="cardno"){
   		    	  
   		           var cardvalue = event.args.newvalue; 
   		           var length = (cardvalue + '').replace('-', '').length;
   		             if(rowBoundIndex==0)
   		            	 {
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
   		             if(rowBoundIndex==1)
		            	 {
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
		           $("#jqxgridpayment").jqxGrid('showvalidationpopup', 1, "cardno", "Invalid Card Number");
		           return false;  
		           }
		           }
   		             if(rowBoundIndex==2)
		            	 {
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
		           $("#jqxgridpayment").jqxGrid('showvalidationpopup', 2, "cardno", "Invalid Card Number");
		           return false;  
		           }
		           }
   		           }
   	
   		   
   		   });
      

   		       
      
      $("#jqxgridpayment").on("cellclick", function (event) 
   		   {
   	   document.getElementById("errormsg").innerText="";
   		   });
      
      $("#jqxgridpayment").on("celldoubleclick", function (event) 
   		   {
   		     var columnindex2 = event.args.columnindex;
   		      if(columnindex2==1)
   		    	   {
   		    	   var valmode="";
   		    	   var rowBoundIndex2 = event.args.rowindex;
   		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "mode",valmode);
   		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "status","");
   		    	  
   		    	   }
   		       if(columnindex2==0)
		    	   {
		    	   var valmode="";
		    	   var rowBoundIndex2 = event.args.rowindex;
		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "amount",valmode);
		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "paytype",valmode);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "cardtype",valmode);
		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "mode",valmode);
		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "acode",valmode);
		    	   $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "card",valmode);
		    	   	$('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "expdate",valmode);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "hidexpdate",valmode);
		        	 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "status","");
		    	   }
   		       
   		     
   		       
   		   });    
      $("#jqxgridpayment").on('cellvaluechanged', function (event) 
   		   { 		  
   		       var rowBoundIndex1 = event.args.rowindex;
   		       var datafield1 = event.args.datafield;
   		      
   		    if(datafield1=="mode")
		    	  {
		    	  var modeval=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "mode");
		    	  
		    	  
		    	getmode(modeval,rowBoundIndex1);
		    	  }
   		    
		     if(datafield1=="card")
	    	  {
		    	 
		    	 var cardval=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "card");
		    	 
		    	getcard(cardval,rowBoundIndex1);
	    	  }
   		  /*     
   		      if(datafield1=="mode")
   		    	  {
   		    	  var modeval=$('#jqxgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "mode");
   		    	 
   		    	  if(modeval=="CASH")
   		    		  {
   		    		  
   		    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",1);
   		    		  }
   		    	  else  if(modeval=="CARD")
		    		  {
		    		  
		    		  $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",2);
		    		  }
   		    	  else  if(modeval=="ONLINE")
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
		    	  } */
   		        
   		       
   		   });
   		 
         });
function getmode(modeval,rowBoundIndex)
{

			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				
		     			
					var items=x.responseText;
			var docno=items.trim();
		//alert(docno);
					 if(parseInt(docno)>0)
						 {
						 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",docno);
						 }
					
			
					
					}
				
			}
				
		x.open("GET","getmodeforpayment.jsp?modeval="+modeval,true);
		
		x.send();

}
function getcard(modeval,rowBoundIndex)
{

			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				
		     			
					var items=x.responseText;
			var docno=items.trim();
		//alert(docno);
					 if(parseInt(docno)>0)
						 {
						 $('#jqxgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",docno);
						 }
					
			
					
					}
				
			}
				
		x.open("GET","getcardtypeforpayment.jsp?modeval="+modeval,true);
		
		x.send();

}
   </script>

          
  <div id="jqxgridpayment"></div>  


