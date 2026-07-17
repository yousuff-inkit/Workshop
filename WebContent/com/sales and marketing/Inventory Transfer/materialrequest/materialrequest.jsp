<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

}
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}     
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>

<script type="text/javascript">


$(document).ready(function () {  
    
	   /* Date */ 	
	    
	   		 $('#btnvaluechange').hide();
	   
	   	document.getElementById("stockmsg").innerText="";
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
     
       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');  
	       $('#sidesearchwndow').jqxWindow({ width: '55%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');   
	     
	     
	     
	     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#searchwindow').jqxWindow('close'); 
	 
		   
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		     $('#importwindow').jqxWindow('close');   
		     
		     
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
			   
		     $('#sitewindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Site Search' ,position: { x: 400, y: 70 }, keyboardCloseKey: 27});
		     $('#sitewindow').jqxWindow('close');  
			   
		 
		   
		   $('#itemdocno').dblclick(function(){

				  if($("#mode").val() == "A" || $("#mode").val() == "E")
					  {
			 
				//itemtype,itemdocno,itemname
				  
		  	    $('#searchwindow').jqxWindow('open');
		  	
				if(document.getElementById("itemtype").value=="1")
					{
					refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
					}
				
				
				
	    		else if(document.getElementById("itemtype").value=="6")
				{
				 refsearchContent('fleetGrid.jsp?'); 	
				}
			
		  	  	  	  
		  	
	    		else
				{
				 refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				} 
					  }
			  }); 
			  
		   $('#site').dblclick(function(){

				  if($("#mode").val() == "A" || $("#mode").val() == "E")  
					  {
			 
		 
						if(document.getElementById("itemtype").value!="1" && document.getElementById("itemtype").value!="6")
						{
						sitesearchContent('sitesearch.jsp?typedocno='+document.getElementById("itemtype").value+'&tr_no='+document.getElementById("costtr_no").value); 	
						}
				
					  }
				
	    		 
			  }); 
		   
		   
			   $('#txtlocation').dblclick(function(){
				   
					  if($("#mode").val() == "A" || $("#mode").val() == "E")
						  {
					   
				  	    $('#locationwindow').jqxWindow('open');
				  	
				  	  locationsearchContent('searchlocation.jsp?'); 
						  }
					  
			  	  
		          
	                     }); 
		   
		   
 
  
});


 

	  
	  
	  function getitem(event){
	      	 var x= event.keyCode;
	      	 if(x==114){

	      		  $('#searchwindow').jqxWindow('open');
	      			
	      		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
				{
				refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
				}
	      		
	    		else if(document.getElementById("itemtype").value=="6")
				{
				 refsearchContent('fleetGrid.jsp?'); 	
				}
			
	      		
			else
				{
				 refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			

	      		 
	      		  
	      	 
	      	 }
	      	 else{
	      		 }
	      	 }  
	      	  function refsearchContent(url) {
	           //alert(url);
	              $.get(url).done(function (data) {
	      //alert(data);
	            $('#searchwindow').jqxWindow('setContent', data);

	      	}); 
	        	}
	  
	  
      function productSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#sidesearchwndow').jqxWindow('open');
     		$('#sidesearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 

      


	
      
      function getloc(event){
       	 var x= event.keyCode;
       	 if(x==114){
       	  $('#locationwindow').jqxWindow('open');
       	
       	  locationsearchContent('searchlocation.jsp?');   }
       	 else{
       		 }
       	 }  
	  
	  
      
      function getsite(event){
      	 var x= event.keyCode;
      	 if(x==114){
      		  if($("#mode").val() == "A" || $("#mode").val() == "E")
    		  {
     
     
    	if(document.getElementById("itemtype").value!="1" && document.getElementById("itemtype").value!="6")
    		{
    		sitesearchContent('sitesearch.jsp?typedocno='+document.getElementById("itemtype").value+'&tr_no='+document.getElementById("costtr_no").value); 	
    		}
    	
    		  }  }
      	 else{
      		 }
      	 }  
      	  function locationsearchContent(url) {
           //alert(url);
              $.get(url).done(function (data) {
      //alert(data);
            $('#locationwindow').jqxWindow('setContent', data);

      	}); 
        	}
      	  
      	  function sitesearchContent(url) {
      		 $('#sitewindow').jqxWindow('open');
                 $.get(url).done(function (data) {
         //alert(data);
               $('#sitewindow').jqxWindow('setContent', data);

         	}); 
           	}
         	   
      	  
      	


function funReset(){
	//$('#frmmr')[0].reset(); 
}
function funReadOnly(){
	$('#frmmr input').attr('readonly', true );
	$('#frmmr select').attr('disabled', true );
	 $('#masterdate').jqxDateTimeInput({ disabled: true});
	 $('#psearch').attr('disabled', true );
	 $('#setbtn').attr('disabled', true ); 
		$("#serviecGrid").jqxGrid({ disabled: true});
		
 
 
 $('#btnvaluechange').hide();
 
	
}
function funRemoveReadOnly(){
	reloads();
	 document.getElementById("editdata").value="";
	 document.getElementById("stockmsg").innerText="";
	$('#frmmr input').attr('readonly', false );
/* 	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true); */
	$('#frmmr select').attr('disabled', false );
    
		 $('#btnvaluechange').hide();
		 
		 $('#txtlocation').attr('readonly', true);
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		 $('#clientname').attr('readonly', true);
		 
		 $('#site').attr('readonly', true);
		 
		 
		// itemname  clientname site
		 
		 
	  
	 $('#masterdate').jqxDateTimeInput({ disabled: false});
	 
 
	 
	$('#docno').attr('readonly', true);
	 
	 $("#serviecGrid").jqxGrid({ disabled: false});

 
	 
	if ($("#mode").val() == "A") {
		  //$('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
	 
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
				 $('#itemname').attr('readonly', true);
				 
				 $('#clientname').attr('readonly', true);
				 
				 $('#site').attr('readonly', true);
				 
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
  	 
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		
		
	}  
  
$('#psearch').attr('disabled', false );
$('#setbtn').attr('disabled', false );
	
	
	
	 
}

function funcheckaccinvendor()
{
	if(document.getElementById("puraccid").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search Vendor";  
		 document.getElementById("puraccid").focus();
	       
	        return 0;
		}
	
}

function getunit(val){ 
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items3
	           var type=items[1].split(",");
	        
	           var optionstype;

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#unit").html(optionstype); 	
	            
	            
	         
	
	       }
   x.open("GET","getunit.jsp?psrno="+val,true);
		x.send();
	        }
}
function calculatedata(val)
{

}  
function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 
  
	   
if(document.getElementById("txtlocation").value=="")
{

 document.getElementById("errormsg").innerText="Search Location";  
 document.getElementById("txtlocation").focus();
   
    return 0;
}
	 
else
	{
	  document.getElementById("errormsg").innerText="";
	}
	   
 
 

 
var rows = $("#serviecGrid").jqxGrid('getrows');
   $('#serviecGridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0 ; i < rows.length ; i++){
	  
	 
	  
			  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input"))  
				      .attr("type", "dil")
				      .attr("id", "sertest"+i)
				      .attr("name", "sertest"+i)
				      .attr("hidden", "true");         
				  
		 
				 
				 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
						   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+"0"+" :: "+"0" );
				
				 
				// alert(newTextBox.val());
				  newTextBox.appendTo('form');
				  
		   
 
   
  }   
	  
	    
	    	   
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
			 
			 
			 
			   
	   
	
	return 1;
} 



function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	     
		 		  document.getElementById("editdata").value="Editvalue";
				 
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		  $("#serviecGrid").jqxGrid('addrow', null, {});

	       }
	      });
	   }

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
function getCurrencyIds(){
	   
	      
	        }
	   
	   function getRatevalue(angel)
	   {
	   
	      
	        }
	   
	   
	   function combochange()
	   {
		   
 
		   
		   
		   
		   
		   
			
	   }

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			
			 
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
				 funchkforedit();
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  		  
		 	
		 	var locationid=document.getElementById("txtlocationid").value;
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&locationid="+locationid);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
		} 
	   function funPrintBtn(){
	 	  
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;
 
	        var reurl=url.split("saveActionmr");
	        
	        $("#docno").prop("disabled", false);                
	        var dtype=$('#formdetailcode').val();
	  
	 
	         var win= window.open(reurl[0]+"PRINTmr?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
	    	win.focus(); 
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmmr').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});
    function isNumber1(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }
 
    function reloads()
    {  
       var locid = document.getElementById("txtlocationid").value;      
          var date = document.getElementById("masterdate").value; 
     $("#part").load('part.jsp?locid='+locid+"&date="+date+"&id=1");
     $("#pnames").load('name.jsp?locid='+locid+"&date="+date+"&id=1");  
    }
 function funrefdisslno()
 {
	 
	 
 }
 
	 
		function funchkforedit()
	    {
		

		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
						{
						
						 $("#btnEdit").attr('disabled', true );
						 $("#btnDelete").attr('disabled', true ); 
						 
						 
						 
						}
					else
						{
						 
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	 
	function removemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
	}
	
	 function gettype(){ 
		 
			
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			       
			      items=items.split('####');
			           var docno=items[0].split(",");
			           var type=items[1].split(",");
			        
			           var optionstype = '';
 
			
			           for ( var i = 0; i < type.length; i++) {
			        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
				        }
			          
			            $("select#type").html(optionstype); 	
			            
			        
			            if($('#hidtype').val()!="")
						  {
						  
						  
						  $('#type').val($('#hidtype').val());   
						  
						  }
					 
			  
			    }
			       }
			   x.open("GET","gettype.jsp?",true);
				x.send();
			        
			      
			        }
	 
	 function getitemtype(){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		        
		            if($('#hideitemtype').val()!="")
					  {
					  
					  
					  $('#itemtype').val($('#hideitemtype').val());   
					  
					  }
				 
		  
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        
		      
		        }
	 
	 
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
		 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value="";
	 }

	 function setgrid()
	 {
		 var temppsrno=document.getElementById("temppsrno").value; 
		 var unit=document.getElementById("unit").value; 
		 var rows1 = $("#serviecGrid").jqxGrid('getrows');
         var aa=0;
    for(var i=0;i<rows1.length;i++){
	   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
		   {
	  
			 if((parseInt(document.getElementById("multimethod").value)==1))
			{	
				   
			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
			   {
				   
				   aa=1;
  			   break;
			   }
			}
			 else
				 {
		   
		   aa=1;
		   break;
				 }
		   }
	   else{
		   
		   aa=0;
	       } 
    }
		 
   if(parseInt(aa)==1)
	   {
	   
		document.getElementById("errormsg").innerText="You have already select this product";
		  

			 
	     document.getElementById("jqxInput1").focus();
		 
	   return 0;
	   
	   
	   
	   }
   else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
    
		
		
		
		 var rows = $('#serviecGrid').jqxGrid('getrows');
		  
	 	 
	     var rowlength= rows.length;
		 

	     
	  /*    if(document.getElementById("multi").checked)
		 {
	    	
	    	 
	    	 
	    	 
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
			  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
			  
			 
			  if(document.getElementById("colbatch").value=="")
				  {
				  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
	        		 
	        		return 0;
				  }
			  
			  
			  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
			     
	    	 
	    	 
	     }
	     else
	    	 {
	    	 
	    	 
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
			 
		 
			 if(parseInt(document.getElementById("expchk").value)==1)
				 {
				 
				  var  exp_date=document.getElementById("expdate").value;
				 
				 
				   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
	      	 	   {
						 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
		        		 
			        		return 0;
	      	 	   }
	     		   
				 
		 
				 
				 
				 
				   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
				 }else
					 {
					 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
					 }
			 
			 
			
			 
	    	 
	    	 } */
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
	    // $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
	    
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
	     if(document.getElementById("unit").value>0)
	     {
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
	     }
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
	     $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
	     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "stockqty", document.getElementById("stockmsg").innerText);
	   /*  


	     
	     if(document.getElementById("multi").checked)
		 {
	    	
	    	 
	    	 
	    	 
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
			  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
			  
			 
			  if(document.getElementById("colbatch").value=="")
				  {
				  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
	        		 
	        		return 0;
				  }
			  
			  
			  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
			     
	    	 
	    	 
	     }
	     else
	    	 {
	    	 
	    	 
	    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
			 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
			 
		 
			 if(parseInt(document.getElementById("expchk").value)==1)
				 {
				 
				  var  exp_date=document.getElementById("expdate").value;
				 
				 
				   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
	      	 	   {
						 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
		        		 
			        		return 0;
	      	 	   }
	     		   
				 
		 
				 
				 
				 
				   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
				 }else
					 {
					 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
					 }
			 
			 
			
			 
	    	 
	    	 }
			  
			  */ 
			   document.getElementById("jqxInput").value ="";
			   document.getElementById("jqxInput1").value="";
			   document.getElementById("brand").value=""; 
	           document.getElementById("collqty").value ="";
			   document.getElementById("quantity").value ="";
			   document.getElementById("unit").value ="";
			  /*  document.getElementById("focs").value="";
		  	   document.getElementById("batch").value="";
			   document.getElementById("colbatch").value=""; */
			    document.getElementById("temppsrno").value="";
			     document.getElementById("tempspecid").value="";
			     
			      
			     /*  
			      
			      document.getElementById("multi").checked=false;
				 	 document.getElementById("batch").value="";
					 document.getElementById("colbatch").value="";
					 
					 
					  $('#batch').attr('readonly', false);
					 $('#expdate').jqxDateTimeInput({ disabled: false});
					 $('#expdate').val(null);
					  */
			      								
		 		 $("#serviecGrid").jqxGrid('addrow', null, {});
	    		 document.getElementById("jqxInput1").focus();
	 
	 }
	 
</script>       
</head>
<body onLoad="setValues();gettype();getitemtype();">     
 
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmr" action="saveActionmr" method="post" autocomplete="off">  
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>
    
<table width="100%"    > 
  <tr>   
    <td width="6%" align="right">Date</td>
    <td width="11%"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
      <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
      
                     
      </td>
       <td width="7%" align="right">Type</td>
    <td width="13%"><select  id="type" name="type" style="width:90%;" > 
    <option>
     </option>
    
    </select></td>
            <td align="right" width="6%">Location</td> 
    <td colspan="3"  ><input type="text" id="txtlocation" name="txtlocation" style="width:90%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>'  onkeydown="getloc(event);"/>
      <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/></td>
    <td width="4%" align="right">Ref No</td>
    <td width="15%"><input type="text" name="refno" id="refno" style="width:90%;" value='<s:property value="refno"/>'></td>
 
   
    <td width="9%" align="right">Doc No</td>
    <td width="12%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>

     <tr>
   
        <td width="6%" align="right">&nbsp;</td>
        <td colspan="9"><select  id="itemtype" name="itemtype" style="width:15%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select>  
    <input type="text" id="itemdocno" placeholder="Press F3 to Search"  name="itemdocno"  value='<s:property value="itemdocno"/>' >
    
    <input type="text" id="itemname" name="itemname" style="width:43%;"   value='<s:property value="itemname"/>' onkeydown="getitem(event);">
    </td>
    <td>&nbsp;</td><td>&nbsp;</td> 
    </tr>
    <tr>
         <td width="6%" align="right">Client</td>    
    <td colspan="10"  ><input type="text" id="clientname" name="clientname"  style="width:42%;" value='<s:property value="clientname"/>'  />
      <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>&nbsp;&nbsp;
   Site
      <input type="text" name="site" id="site" style="width:18.5%;" value='<s:property value="site"/>' onkeydown="getsite(event);"   >
      
       <input type="hidden" name="siteid" id="siteid" style="width:18.5%;" value='<s:property value="siteid"/>'   >
      </td>
 
   <td>&nbsp;</td>
  </tr>
   
  <tr>
    <td   align="right">Description</td>
    <td colspan="11"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:55.7%;"> &nbsp;&nbsp;&nbsp;
   <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />  
 
 </fieldset>
 <br>
  <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% "  >   
   <tr> 
   <td align="center">Product ID</td>
   <td align="center" colspan="2">Product Name</td>
   <td align="center" style="width:15%;"  >Brand</td>
   <td align="center">Unit</td>
   <td  width="6%" align="center">Qty</td>
  <!--  <td align="center" class="ff">FOC</td>
  <td align="center" class="ff1">Multi_Batch</td> 
   <td align="center" class="ff2">Batch</td>
      <td align="center" class="ff3">ExpDate</td>  --> 
    <td align="center">&nbsp;</td>  
   </tr>
 
   
    <tr><td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td> 
 <td align="center" >   <input type="text" id="brand"   > <input type="hidden" id="collqty"   ></td>
<td align="center"> <select    id="unit"   >   </select>      </td> 
 
<td width="6%" align="center"> <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">  
  <input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
<td align="center" class="ff"><input type="hidden" id="focs"  onblur="funRoundAmt(this.value,this.id);"  style="width:82%;" onkeypress="javascript:return isNumber1 (event);"     ></td>
 
 
   <td align="center" class="ff1"> 
   <input type="hidden" id="multi" style="text-align: right;" onchange="chkmultis()" > </td>
 
   <td align="center" class="ff2"> 
   <input type="hidden" id="batch"    onkeydown="getbatch(event)" > </td>
<td  class="ff3"><div id="expdate" hidden:"true" name="expdate" value='<s:property value="expdate"/>'></div> </td> 
 
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>

 </tr>  
 
   
   </table> 
   </fieldset> 
 <fieldset>
 
    <div id="sevdesc" ><jsp:include page="serviecgrid.jsp"></jsp:include></div>
     

</fieldset>

   <label id="stockmsg" name="stockmsg" class="blink" style="position:fixed;z-index:1000;right:250px;top:20px;color:#003300;font-weight:bold;font-size: 14px;font-family: Times New Roman, Times, serif;">  </label>
<table width="100%">
<tr>
<td align="right">&nbsp;</td><td><input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;"></td>

 <td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<%-- <td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td> --%>
  <%-- <td align="right">Discount Value</td><td><input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>  
<%-- <td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>
<td align="right">&nbsp;</td><td><input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
<%-- <td align="right">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td> --%>
 
 
</tr>


</table>
 





 


 <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 

 <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
	 <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
	 <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>

 
<input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no"  value='<s:property value="refmasterdoc_no"/>'/>
     <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
     <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
    

     <input type="hidden" id="rowval" name="rowval"  value='<s:property value="rowval"/>'/>   <!-- for refno  slno set grid -->
               <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>  
           
           
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
            <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
           
            <input type="hidden" id="serviecGridlength" name="serviecGridlength"  value='<s:property value="serviecGridlength"/>'/>  
          
                <input type="hidden" id="hidelocation" name="hidelocation"  value='<s:property value="hidelocation"/>'/>
                  <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
                 <input type="hidden" id="temppsrno" >  
                 <input type="hidden" id="tempspecid" > 
                 <input type="hidden" id="tempunitdocno" >   
          
</form>
 <div id="searchwindow">
   <div ></div>
</div>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	  <div id="sidesearchwndow">
	   <div ></div>
	</div>
		  <div id="importwindow">
	   <div ></div>
	</div>
		  <div id="searchwndow">
	   <div ></div>
	</div>
		  <div id="locationwindow">
	   <div ></div>
	</div>
		  <div id="sitewindow">
	   <div ></div>
	</div>
	
	
	
</div>
</body>
</html>