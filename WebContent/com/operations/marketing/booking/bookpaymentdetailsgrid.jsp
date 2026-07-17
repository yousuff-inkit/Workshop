
  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
<%
ClsbookingDAO viewDAO= new ClsbookingDAO();
ClsRentalAgreementDAO  viewDAO1= new ClsRentalAgreementDAO();
   	String bookdocno1 = request.getParameter("bookdocno1")==null?"0":request.getParameter("bookdocno1").trim();

   	%>  

<script type="text/javascript">
   var temp='<%=bookdocno1%>';
  var paymentdata;

 if(temp>0)
	{
	 
	 paymentdata='<%=viewDAO.reloadpayment(session,bookdocno1)%>';  
	
	}

 else
	 
	{  
	 
		var paymentdata= '[{"payment":"Advance"},{"payment":"Security"},{"payment":"Pre Auth"}]';

		
		datas='<%=viewDAO1.getmode()%>';  
		
		datas1='<%=viewDAO1.getcard()%>';  
		//alert(datas);
		 var list = datas.split(","); 
		 var list1 = datas1.split(",");  
	 
		 
		/* var paymentdata= '[{"payment":"Advance"},{"payment":"Security"},{"payment":"Blocked"}]'; 
 var list =['CASH','CARD'];
var list1 =['VISA','MASTER']; */
	
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
			localdata: paymentdata,
       
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
 
   $("#bookgridpayment").jqxGrid(
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
                                              editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                        }
					},
					
					{ text: 'Amount',  datafield: 'amount',  width: '15%',editable:true,cellsalign: 'right',align: 'right',cellsformat: 'd2'},
					{ text: 'Auth No',  datafield: 'acode',  width: '18%',editable:true,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#bookgridpayment').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {	    	 
						       return false; 
						    	 }
						  }
					
					
					},
					{ text: 'Card Type',  datafield: 'card',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                        editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
                         
					
					},cellbeginedit: function (row) {
						var temp=$('#bookgridpayment').jqxGrid('getcellvalue', row, "paytype");
					     if (parseInt(temp) ==1)
					    	 {
						       return false;
							 }
					    /*  if (temp =="CHEQUE")
					    	 {
					    	 
					    	 
					       return false;
					    	 } */
					     
					     			    	
					    	 
					  }
				
                          },
                    { text: 'cardtypeno',  datafield: 'cardtype',  width: '15%',editable:true,hidden:true},    
					{ text: 'Card NO',  datafield: 'cardno',  width: '20%'  ,editable:true ,cellsalign: 'left',align: 'left',
						cellbeginedit: function (row) {
							var temp=$('#bookgridpayment').jqxGrid('getcellvalue', row, "paytype");
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
					{ text: 'Exp:Date',  datafield: 'expdate',  width: '10%',editable:true,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'MM-yyyy',
			
						cellbeginedit: function (row) {
							var temp=$('#bookgridpayment').jqxGrid('getcellvalue', row, "paytype");
						     if (parseInt(temp) ==1)
						    	 {
							       return false;
						    	 }
						     /* if (temp =="CHEQUE")
						       return false; */
						  }
					
					
					},
					{ text: 'Hide Date', datafield: 'hidexpdate', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'Reciept NO', datafield: 'recieptno', width: '8%',editable:false, cellsalign: 'left',align: 'left'},
					{ text: 'modetypeno', datafield: 'paytype', width: '8%',editable:false,hidden:true},
					{ text: 'Status', datafield: 'status', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
					
					
	              ]
         });
    
   if ($("#mode").val() == "A") {
	   
	   
	     $("#bookgridpayment").jqxGrid({ disabled: false});
	  
		 
	    }
       
       $("#bookgridpayment").on('cellvaluechanged', function (event) 
    		   {
    		        		  
    		       var rowBoundIndex = event.args.rowindex;
    		       var datafield = event.args.datafield;
    		       
    		       var paymentval4="";
    		       
    		       if(datafield=="mode")
    		       {
    		    	   
    		    	 
    		          if(rowBoundIndex==0)
    		        	  
    		        	  {
    		        
    		        	  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
    		        	     		        
    		        	  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
     		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
    		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",1);
    		        	 
    		        	  }
    		          if(rowBoundIndex==1)
    		        	  
		        	  {
    		        	  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
    		        	  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
      		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",2);
		        	 
		        	  
		        	  }
                    if(rowBoundIndex==2)
    		        	  
		        	  {
                    	var value = event.args.newvalue;
                     
                        $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "status",3);
                        
                    	
                    	
                    	if(value=="CASH")
                    		{
                    		 
                    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "mode",paymentval4);
                    		document.getElementById("errormsg").innerText=" Only Cards Can Be Opted"; 	 
                    		}
                    
                    	/* else if(value=="CHEQUE")
                		{
                    		 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "mode",paymentval4);
                    		document.getElementById("errormsg").innerText=" Only Cards Can Be Opted"; 	 
                		} */
                    	else{
                    		document.getElementById("errormsg").innerText="";	
                    	}
                    	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "amount",paymentval4);
                    	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",paymentval4);
     		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "acode",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "card",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardno",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "expdate",paymentval4);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",paymentval4);
		        	
		        	  
		        	  }
    		       }
    		       if(datafield=="expdate")
    		       {
    		    	   
    		          if(rowBoundIndex>=0)
    		        	  
    		        	  {
    		        	    
    		          var text = $('#bookgridpayment').jqxGrid('getcelltext', rowBoundIndex, "expdate");
		        	 // alert(text);
		        	  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",text);
		        	    }
    		       
    		       
    		       }
    		     
    		    
    		       
    		       
    		       if(datafield=="cardno"){
    		    	  
    		           var cardvalue = event.args.newvalue; 
    		           var length = (cardvalue + '').replace('-', '').length;
    		             if(rowBoundIndex==0)
    		            	 {
    		           if(length==16){ 
    		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
    		            return true;  
    		           }
    		           
    		           if(length==0){ 
        		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
        		            return true;  
        		           }
    		           
    		           else  
    		           {  
    		           $("#bookgridpayment").jqxGrid('showvalidationpopup', 0, "cardno", "Invalid Card Number");
    		           return false;  
    		           }
    		           }
    		             if(rowBoundIndex==1)
		            	 {
		           if(length==16){ 
		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
		            return true;  
		           }
		           if(length==0){ 
    		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
    		            return true;  
    		           }
		           
		           else  
		           {  
		           $("#bookgridpayment").jqxGrid('showvalidationpopup', 1, "cardno", "Invalid Card Number");
		           return false;  
		           }
		           }
    		             if(rowBoundIndex==2)
		            	 {
		           if(length==16){ 
		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
		            return true;  
		           }
		           if(length==0){ 
    		           $("#bookgridpayment").jqxGrid('hidevalidationpopups');
    		            return true;  
    		           }
		           
		           else  
		           {  
		           $("#bookgridpayment").jqxGrid('showvalidationpopup', 2, "cardno", "Invalid Card Number");
		           return false;  
		           }
		           }
    		           }
    	
    		   
    		   });
       

    		       
       
       $("#bookgridpayment").on("cellclick", function (event) 
    		   {
    	   document.getElementById("errormsg").innerText="";
    		   });
       
       $("#bookgridpayment").on("celldoubleclick", function (event) 
    		   {
    		     var columnindex2 = event.args.columnindex;
    		      if(columnindex2==1)
    		    	   {
    		    	   var valmode="";
    		    	   var rowBoundIndex2 = event.args.rowindex;
    		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "mode",valmode);
    		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "status","");
    		    	  
    		    	   }
    		       if(columnindex2==0)
		    	   {
		    	   var valmode="";
		    	   var rowBoundIndex2 = event.args.rowindex;
		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "amount",valmode);
		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "paytype",valmode);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "cardtype",valmode);
		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "mode",valmode);
		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "acode",valmode);
		    	   $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "card",valmode);
		    	   	$('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "expdate",valmode);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "hidexpdate",valmode);
		        	 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex2, "status","");
		    	   }
    		       
    		     
    		       
    		   });    
       $("#bookgridpayment").on('cellvaluechanged', function (event) 
    		   { 		  
    		       var rowBoundIndex1 = event.args.rowindex;
    		       var datafield1 = event.args.datafield;
    		      
    		    
    		      
    		 
    		    	  
    		          if(datafield1=="mode")
       		    	  {
       		    	  var modeval=$('#bookgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "mode");
       		    	  
       		    	  
       		    	getmode(modeval,rowBoundIndex1);
    		    	 
    		    	 /*  if(modeval=="CASH")
    		    		  {
    		    		  
    		    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",1);
    		    		  }
    		    	  else  if(modeval=="CARD")
		    		  {
		    		  
		    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",2);
		    		  }
    		    	   else  if(modeval=="ONLINE")
		    		  {
		    		  
		    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "paytype",3);
		    		  } 
    		    	  else
		    		  {   		  
		    		 
		    		  } */
    		    	  }
    		     if(datafield1=="card")
		    	  {
    		    	 
    		    	
    		    	 
       		    	 var cardval=$('#bookgridpayment').jqxGrid('getcellvalue', rowBoundIndex1, "card");
       		    	 
       		    	getcard(cardval,rowBoundIndex1);
		    	 /*  if(cardval=="VISA")
		    		  {
		    		  
		    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "cardtype",1);
		    		  }
		    	  else  if(cardval=="MASTER")
	    		  {
	    		  
	    		  $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex1, "cardtype",2);
	    		  }
		    	
		    	  else
	    		  {   		  
	    		 
	    		  } */
		    	  }
    		        
    		       
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
						 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "paytype",docno);
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
						 $('#bookgridpayment').jqxGrid('setcellvalue',rowBoundIndex, "cardtype",docno);
						 }
					
			
					
					}
				
			}
				
		x.open("GET","getcardtypeforpayment.jsp?modeval="+modeval,true);
		
		x.send();

} 
          
    </script>

           
   <div id="bookgridpayment"></div>  
