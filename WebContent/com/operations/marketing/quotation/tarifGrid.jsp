
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>
<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>


<%

ClsquotationDAO viewDAO=new ClsquotationDAO();
ClsRentalAgreementDAO viewDAO1=new ClsRentalAgreementDAO();
%>



   	<%
  // 	String relodedoc = request.getParameter("txtrentaldocno")==null?"0":request.getParameter("txtrentaldocno").trim();
   //	String revehGroup=request.getParameter("revehGroup")==null?"0":request.getParameter("revehGroup").trim();
  // 	String indexVal7=request.getParameter("indexVal7")==null?"0":request.getParameter("indexVal7").trim();
  	
 	/* String vehGroup=request.getParameter("vehGroup")==null?"0":request.getParameter("vehGroup").trim(); */
 	
  	String ratariffdocno1 = request.getParameter("ratariffdocno1")==null?"0":request.getParameter("ratariffdocno1").trim();
 	String vehGroup=request.getParameter("vehGroup")==null?"0":request.getParameter("vehGroup").trim();
 	
   	%> 
<script type="text/javascript">
var datatariff;

<%-- var temp2='<%=relodedoc%>';  --%>
 var temp='<%=ratariffdocno1%>'; 
/* var temp='1'; */
var hide;


 <%--  if(temp2>0)
	{
	
	  datatariff='<%=com.operations.agreement.rentalagreement.ClsRentalAgreementDAO.tariffratereload(session,relodedoc,revehGroup)%>';
		hide=2;
	}   --%>
   if(temp>0)
	{ 
	   hide=2;
	 datatariff='<%=viewDAO1.tariffRate(session,ratariffdocno1,vehGroup)%>';
	
	 }
else 
	{  
	
       datatariff='<%=viewDAO.tariffType()%>'; 

      }  
	
$(document).ready(function () { 
	
	var cellclassname;

    var num = 0; 
  
    
    
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
              	{name : 'rentaltype' , type: 'String' },
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
                {name : 'status' , type:'number'},
              	{name : 'count' , type:'number'},
            /* 	{name : 'tdocno' , type:'number'} */
                
              	
              	
			   ],
			   localdata: datatariff,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
    $('#tarifGrid').on('bindingcomplete', function (event) {


    
      $("#tarifGrid").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
      

    $("#tarifGrid").jqxGrid('addrow', null, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
  
    $("#tarifGrid").jqxGrid('addrow', null, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
	
});
   
    var rowEdit = function (row) {
    	var rows11 = $("#tarifGrid").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    //	alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
    
    			 return false;
    	}
    }
   
    	
    
    var cellsrenderer = function (row, column, value, defaultHtml) {
		var rows11 = $("#tarifGrid").jqxGrid('getrows');
			var rowval=rows11.length;
		var row1=rowval-1;
		var row2=rowval-2;
		
		
	    if ( row == row1 || row == row2) {
	    	//alert("row3"+row3);
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
	        return element[0].outerHTML;
	    }
	    var row3=rowval-3;
	   
	    if (row == row3) {
	    	//alert(row3);
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#ACF6CB', 'width': '100%', 'height': '100%', 'margin': '0px' });
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


 
   $("#tarifGrid").jqxGrid(
   {
      width: '100%',
      height: 167,
      source: dataAdapter,
       disabled:true,
      rowsheight:20,
      editable:true,
      selectionmode: 'singlecell',
      pagermode: 'default',
      theme: theme,
     


      

      
       columns: [
{ text: '   '+document.getElementById("mainrentaltype").value,   datafield: 'rentaltype', editable:false, cellsalign: 'center', align:'center',cellsrenderer: cellsrenderer },
{ text: '      '+document.getElementById("mainrate").value,     datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer },
{ text: '     '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
{ text: '     '+document.getElementById("mainpai").value,     	 datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
{ text: '     '+document.getElementById("maincdw1").value,    	 datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: '     '+document.getElementById("mainpai1").value,    	 datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: '     '+document.getElementById("maingps").value,      	 datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainbabyseater").value,  	 datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true, cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					
					
					{ text: 'count',  datafield: 'count',  width: '7%',hidden:true},
					{ text: 'Status', datafield: 'status', width: '9%',hidden:true},
					
					
					
										]
              
					 }); 
   
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#tarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   
   
   
/*       $('#jqxgridtarif').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   if(hide==2)
	{
	   $("#tarifGrid").jqxGrid({ disabled: false});
	}
    */
   if(($('#mode').val()=='A')||($('#mode').val()=='E'))
	{
	  $("#tarifGrid").jqxGrid({ disabled: false}); 
	}
   
/*    var renttypeval = $('#tarifGrid').jqxGrid('getcellvalue', 0, "count");
   var discountval=renttypeval+1;
   var nettotalval=renttypeval+2; */
   var setvalu = $("#tarifGrid").jqxGrid('getrows');
	
	var tempone=setvalu.length;
	var nettotalval=tempone-1;
	var discountval=tempone-2;
	var renttypeval=tempone-3; 
	
 
		   
              var rowindex1=-1;
		   $("#tarifGrid").on("cellclick", function (event) {
	
			   var columnindex1 = event.args.columnindex;
			   
			   
			   
			   if(columnindex1==0)
				   {
				    var rows = $('#qutgrid').jqxGrid('getrows');
	                 /*  var rowlength= rows.length-2; */
					var rowlength=document.getElementById("rowindex").value;
				    var rentypevalids=$('#tarifGrid').jqxGrid('getcellvalue', args.rowindex, "rentaltype");
		
				   var rentyps=$('#qutgrid').jqxGrid('getcellvalue',rowlength, "renttype");
				   if(rentypevalids!=rentyps)
					   {
					   
					   document.getElementById("errormsg").innerText="Rental Type Is Not match";
					   return 0;
					   
					   }
				   else
					   {
					   document.getElementById("errormsg").innerText="";
					   }
				   
				   
				   }
			   
			   
			   
		
			   var rowval= document.getElementById("tacalrowindex").value;
			   
			   
			   
			  
           var rentypevalid=$('#tarifGrid').jqxGrid('getcellvalue', renttypeval, "rentaltype");
               
     
           if(columnindex1>0)
            	{
            if(rentypevalid=="")
            	{
            	 document.getElementById("errormsg").innerText="Select Rental Type";
            	 document.getElementById("errorvalid").value=1;
            	 return false;
            	 
            	}}  
			   if(columnindex1==0)
				  {
				rowindex1 = event.args.rowindex;
			    		
 				document.getElementById("errormsg").innerText="";
            	 
            	 document.getElementById("errorvalid").value="";
				 
				 if(rowindex1<renttypeval)
					 {
					
					
				$("#tarifGrid").jqxGrid('updaterow', renttypeval, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
				$("#tarifGrid").jqxGrid('updaterow', discountval, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
				$("#tarifGrid").jqxGrid('updaterow', nettotalval, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
				var val=""; 
				$("#tarifcalGrid").jqxGrid('setcellvalue', rowval, "rate", val);
		     	  $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"cdw",val);
				 $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"pai",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"cdw1",val);
				  $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"pai1",val);
				    $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"gps",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"babyseater",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"cooler",val);
				  $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"kmrest",val);
				  $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"exkmrte",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"oinschg",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"exhrchg",val);
				   $('#tarifcalGrid').jqxGrid('setcellvalue', rowval,"tdocno",val);
				$('#tarifGrid').jqxGrid('setcellvalue',renttypeval , "rentaltype",$('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "rentaltype"));
	
				var ss= document.getElementById("tdocnos").value;
				 $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "tdocno",ss);
				 $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "rentaltype",$('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "rentaltype"));
				 
			 
				
					 }
				 
				  }
				 
			  
			   if(rowindex1<renttypeval)
				 {

					 var columnfrist = event.args.columnindex;
					 
					 
					 if(columnfrist>0)
						 {
				   
				  
				   var dataFields = event.args.datafield;
				   var val2;
	                var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, dataFields);
	                  val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, dataFields);
	               
					   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
					   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, dataFields,val1);
	                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, dataFields,parseFloat(val3));
	                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , dataFields,parseFloat(val3));
						 }
					
				  /*  if(columnindex1==1){
					   var dataField1 = event.args.datafield;
			                  
			                   var val2;
			                var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, dataField1);
			                  val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, dataField1);
			                 // alert(val2);
							   if(val2==null)   { val2=0;}   var  val3=parseInt(val1)-val2;
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, dataField1,val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, dataField1,parseInt(val3));
			                
			      
			           $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , dataField1,parseInt(val3)); 
			               
				    }
				   if(columnindex1==2){
			                var  val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "cdw");
			                var   val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "cdw");
							   if(val2=="")  { val2=0;}   var  val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "cdw",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "cdw",val3);
			                
			               $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "cdw",parseInt(val3)); 
				   }
				   if(columnindex1==3){
					    
		              
					        var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "pai");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "pai");
							   if(val2=="")  { val2=0;}  var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue',renttypeval , "pai",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "pai",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "pai",val3);
						   }
				   if(columnindex1==4){
					         var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "cdw1");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "cdw1");
							   if(val2=="")  { val2=0;} var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "cdw1",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "cdw1",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "cdw1",val3);
						   }
				   if(columnindex1==5){
					   
					         var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "pai1");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "pai1");
							   if(val2=="")  { val2=0;}  var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "pai1",val1); 
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "pai1",val3); 
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "pai1",val3);
				   }
				   if(columnindex1==6){
					  
					         var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "gps");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "gps");
							   if(val2=="")  { val2=0;}  var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "gps",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "gps",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "gps",val3);
						   }
				   if(columnindex1==7){
					         var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "babyseater");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "babyseater");
							   if(val2=="")  { val2=0;}   var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "babyseater",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "babyseater",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "babyseater",val3);
			                
				   }
				   if(columnindex1==8){
					   
					         var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "cooler");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "cooler");
							   if(val2=="")  { val2=0;}  var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "cooler",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "cooler",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "cooler",val3);

                             }
				   if(columnindex1==9){
					 
					           var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "kmrest");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "kmrest");
							   if(val2=="")  { val2=0;}
							   var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "kmrest",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "kmrest",val3);
			                
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "kmrest",val3);
					           
						   }
				   if(columnindex1==10){
							   var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "exkmrte");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "exkmrte");
							   if(val2=="")  { val2=0;}
							   var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "exkmrte",val1);	
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "exkmrte",val3);
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "exkmrte",val3);
			                
				   }
				   if(columnindex1==11){
							   var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "oinschg");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "oinschg");
							   if(val2=="")  { val2=0;}
							   var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "oinschg",val1);	
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "oinschg",val3);	
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "oinschg",val3);
			                
			                
			                
				   }
				  if(columnindex1==12){
							   var val1 = $('#tarifGrid').jqxGrid('getcellvalue', rowindex1, "exhrchg");
							   var val2 = $('#tarifGrid').jqxGrid('getcellvalue', discountval, "exhrchg");
							   if(val2=="")  { val2=0;}
							   var val3=parseInt(val1)-parseInt(val2);
							   $('#tarifGrid').jqxGrid('setcellvalue', renttypeval, "exhrchg",val1);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, "exhrchg",val3);	
			                
			                $('#tarifcalGrid').jqxGrid('setcellvalue',rowval , "exhrchg",val3);
				  }
		 */
			   }	
		   });
		   
			    $("#tarifGrid").on('cellendedit', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				  //alert(""+rowBoundIndex)
				  
				   var rowval= document.getElementById("tacalrowindex").value;
				  
				  if(rowBoundIndex==discountval)
					   {
						      
							   var value = event.args.value;
							   var temp = $('#tarifGrid').jqxGrid('getcellvalue', renttypeval, dataField);
							  // alert("value"+value);
							   if(value=="")
								   {
								   $("#tarifGrid").jqxGrid('setcellvalue', nettotalval, dataField, temp);
								   
								   $("#tarifcalGrid").jqxGrid('setcellvalue', rowval, dataField, temp);
								   
								   }
							   if(value!="")
								   {
								   var temp2=parseFloat(temp)-parseFloat(value);
				               $("#tarifGrid").jqxGrid('setcellvalue', nettotalval, dataField, temp2);
				               
				               $("#tarifcalGrid").jqxGrid('setcellvalue', rowval, dataField, temp2);
				               
								   }}
						       
				
						
				    });  

			    /*    discountval
		           renttypeval
		            nettotalval */
		 	 
			  $("#tarifGrid").on("celldoubleclick", function (event)
					   {
				  
				   var columnIndex3 = event.args.columnindex;
				   var columnName = event.args.datafield;
			
				  var rowindex3 = event.args.rowindex;
				   var val="";
				   var rowval= document.getElementById("tacalrowindex").value;
					   
				   if(rowindex3<discountval)
					 {
					if(columnIndex3>0)
						{
			                $('#tarifGrid').jqxGrid('setcellvalue', renttypeval,columnName,val);
			                $('#tarifGrid').jqxGrid('setcellvalue', discountval, columnName,val);
			                $('#tarifGrid').jqxGrid('setcellvalue', nettotalval, columnName,val);
			                $("#tarifcalGrid").jqxGrid('setcellvalue', rowval, columnName, val);
						}
					 }
				   
				});  
 
});
    </script>

           
   <div id="tarifGrid"> </div> 
      <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 