<%-- 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

   	<%
   
   	//main
   	String revehGroup=request.getParameter("revehGroup")==null?"0":request.getParameter("revehGroup").trim();
   		String bookdocno=request.getParameter("bookdocno")==null?"0":request.getParameter("bookdocno").trim();
   	
   	//rental search
   	String rentaltype=request.getParameter("rentaltype")==null?"NA":request.getParameter("rentaltype").trim();
 	String vehGroup=request.getParameter("vehGroup")==null?"NA":request.getParameter("vehGroup").trim();
	//rental slno
   	String indexrdocno=request.getParameter("indexrdocno")==null?"0":request.getParameter("indexrdocno").trim();
  		String qotslno=request.getParameter("qotslno")==null?"0":request.getParameter("qotslno").trim();
  		
   	%> 
<script type="text/javascript">
var datatariff;
var temp3='<%=bookdocno%>'; 
 var temp2='<%=vehGroup%>'; 
 var temp='<%=indexrdocno%>'; 

var hide;
if(temp3>0)
	{
	
	datatariff='<%=com.operations.marketing.booking.ClsbookingDAO.tariffratereload(session,bookdocno,revehGroup)%>';
	}


else if(temp2!='NA')
	{
	
	  datatariff='<%=com.operations.marketing.booking.ClsbookingDAO.tariffRate(session,vehGroup,rentaltype)%>';
		
	}   
  else if(temp>0)              
	{
	 
	 datatariff='<%=com.operations.marketing.booking.ClsbookingDAO.tarifrdocnorelode(indexrdocno,qotslno)%>';
		
	 } 
else 
	{ 

       datatariff;'<%=com.operations.marketing.booking.ClsbookingDAO.tariffType()%>'; 
	
      }   

$(document).ready(function () { 
	
	var cellclassname;

    var num = 0; 
  
    
    
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
                  	{name : 'tdocno' , type: 'String' },
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
           
                {name : 'insurexcess', type: 'string' },                     
				{name : 'cdwexcess', type: 'string'  },
				{name : 'scdwexcess', type: 'string' }
              
              	
			   ],
			   localdata: datatariff,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
   

 $('#booktarifGrid').on('bindingcomplete', function (event) {
	
	 
	 
	
	//document.getElementById("insuexcess").value=$('#booktarifGrid').jqxGrid('getcellvalue', 0,"insurexcess") ; 
	document.getElementById("normalinsu").value=$('#booktarifGrid').jqxGrid('getcellvalue', 0,"insurexcess") ;
	document.getElementById("cdwinsu").value=$('#booktarifGrid').jqxGrid('getcellvalue', 0,"cdwexcess") ;
	document.getElementById("supercdwinsu").value=$('#booktarifGrid').jqxGrid('getcellvalue', 0,"scdwexcess") ;

	  
	}); 
		 


  


    
    var rowEdit = function (row) {
    	var rows11 = $("#booktarifGrid").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    //	alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
    
    			 return false;
    	}
}
var cellsrenderer = function (row, column, value, defaultHtml) {
	var rows11 = $("#booktarifGrid").jqxGrid('getrows');
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


 
   $("#booktarifGrid").jqxGrid(
   {
      width: '100%',
      height: 87,
      source: dataAdapter,
     // columnsresize: true,
      rowsheight:20,
      editable:true,
      disabled:true,
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
{ text: ''+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
{ text: 'tdocno',datafield: 'tdocno',width: '4%',hidden:true},
                 
         /*    
					{ text: 'Rental Type', datafield: 'rentaltype', width: '9%',editable:false, cellsalign: 'center', align:'center',cellsrenderer: cellsrenderer },
					 { text: 'Tariff',  datafield: 'rate',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer },
					{ text: 'CDW',  datafield: 'cdw',  width: '7%'  ,editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'PAI',  datafield: 'pai',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Super CDW',  datafield: 'cdw1',  width: '8%'  ,editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Super PAI',  datafield: 'pai1',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'GPS',  datafield: 'gps',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Baby Seater',  datafield: 'babyseater',  width: '7%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Cooler',  datafield: 'cooler',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'KM Restrict',  datafield: 'kmrest',  width: '8%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Excess KM Rate',  datafield: 'exkmrte',  width: '7%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Insur Chg',  datafield: 'oinschg',  width: '7%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Extra Hr Charge',  datafield: 'exhrchg',  width: '7%',editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					
					 */
					
				 ]
              
					 });
   
   
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#booktarifGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   
   
   
   
   
   
   if(temp2!='NA')
   {
   	   $("#booktarifGrid").jqxGrid('addrow', null, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
   	    $("#booktarifGrid").jqxGrid('addrow', null, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""}); 
   }
   if(temp>0)              
   { 
   	 $("#booktarifGrid").jqxGrid('addrow', null, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""});
   	    $("#booktarifGrid").jqxGrid('addrow', null, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": ""}); 

   }
   
   
   if ($("#mode").val() == "A" ||$("#mode").val() == "E") {
	   

	  
	     $("#booktarifGrid").jqxGrid({ disabled: false});
	     
		  
	    }
  
   
	var setvalu = $("#booktarifGrid").jqxGrid('getrows');
	
	var tempone=setvalu.length;
	var nettotalrow=tempone-1;
	var discountrow=tempone-2;
	var rentalrow=tempone-3;
	 $("#booktarifGrid").on('cellclick', function (event) 
			   {
			    
			       var dataField = event.args.datafield;
			     
			       var rowBoundIndex = event.args.rowindex;  
			     			       
			       if(dataField=="cdw"){
			    	   
			    
			    	   
			    var cdw1=$('#booktarifGrid').jqxGrid('getcellvalue', rentalrow,"cdw1") ;

			
			    	
			    if(cdw1>0||cdw1!="")
			    
			    	  {
			    $('#booktarifGrid').jqxGrid('unselectcell', rowBoundIndex, 'cdw');
			    	document.getElementById("errormsg").innerText="Super CDW Is Selected";  
	            
			    	return false;
			    	  }
			    else{
			   	var cdwinsu=document.getElementById("cdwinsu").value;
			   	
			    	var tempss="insuexcess";
			    	 funRoundAmt(cdwinsu,tempss);
			    	
			    	return true;
			      }
			       }
			       if(dataField=="cdw1"){
			     
					    var cdw=$('#booktarifGrid').jqxGrid('getcellvalue', rentalrow,"cdw") ;
				
					    if(cdw>0||cdw!="")
					    
					    	  {
					    	$('#booktarifGrid').jqxGrid('unselectcell', rowBoundIndex, 'cdw1');
					    	document.getElementById("errormsg").innerText="CDW Is Selected";  
					    	return false;
					    	  }
					    else
					    	{
					        var supercdwinsu=document.getElementById("supercdwinsu").value; 
				            var tempsss="insuexcess";
				            funRoundAmt(supercdwinsu,tempsss); 
					    	return true;
					    	}
					       }
			       if(dataField=="pai"){
			    	   
					    var pai1=$('#booktarifGrid').jqxGrid('getcellvalue', rentalrow,"pai1") ;
						   
					    if(pai1>0||pai1!="")
					    
					    	  {
					    	$('#booktarifGrid').jqxGrid('unselectcell', rowBoundIndex, 'pai');
					    	document.getElementById("errormsg").innerText="Super PAI Is Selected";  
					    	
					    	return false;
					    	  }
					    else{
					    	return true;
					    }
					       }
			       if(dataField=="pai1"){
			    	   
					    var pai=$('#booktarifGrid').jqxGrid('getcellvalue', rentalrow,"pai") ;
					
					    if(pai>0||pai!="")
					    
					    	  {
					    	$('#booktarifGrid').jqxGrid('unselectcell', rowBoundIndex, 'pai1');
					    	document.getElementById("errormsg").innerText="PAI Is Selected";  
					    	return false;
					    	  }
					    else
					    	{
					    	return true;
					    	}
					       }
			       
			   });

	   $("#booktarifGrid").on("cellclick", function (event) {
		   
		  
				var bookcolumnindex = event.args.columnindex; 
		   	  var columnName1 = event.args.datafield;
		   var qutrowindex=event.args.rowindex;
	
		 if(bookcolumnindex>0)
			 {
		if(qutrowindex==0)
			{
			 
				if(bookcolumnindex==1)
					{
					
					 document.getElementById("tarifdoc").value=$('#booktarifGrid').jqxGrid('getcellvalue', qutrowindex,"tdocno");
					
					}
			
			
               
               var val2;
            var val1 = $('#booktarifGrid').jqxGrid('getcellvalue', qutrowindex, columnName1);
              val2 = $('#booktarifGrid').jqxGrid('getcellvalue', discountrow, columnName1);
             // alert(val2);
			   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
			   $('#booktarifGrid').jqxGrid('setcellvalue', rentalrow, columnName1,val1);
            $('#booktarifGrid').jqxGrid('setcellvalue', nettotalrow, columnName1,parseFloat(val3));
		   }
		  
			 }		   
	   });
	      $("#booktarifGrid").on('cellendedit', function (event) 
				   {
			   var rowBoundIndex = event.args.rowindex;
			   var dataField = event.args.datafield;
			  //alert(""+rowBoundIndex)
			
			  
			  
			  if(rowBoundIndex==discountrow)
				   {
					       
						   var value = event.args.value;
						   var temp = $('#booktarifGrid').jqxGrid('getcellvalue', rentalrow, dataField);
						  // alert("value"+value);
						   if(value=="")
							   {
							   $("#booktarifGrid").jqxGrid('setcellvalue', nettotalrow, dataField, temp);
							   
							  
							   
							   }
						   if(value!="")
							   {
							   var temp2=parseFloat(temp)-parseFloat(value);
				
			               $("#booktarifGrid").jqxGrid('setcellvalue', nettotalrow, dataField, temp2);
			               
			              
			               
							   }}
					      
				
					 
			    });    
  
	    $("#booktarifGrid").on("celldoubleclick", function (event)
				   {
			  
			   var columnIndex3 = event.args.columnindex;
			   //alert(columnIndex3);
			  var rowindex3 = event.args.rowindex;
			  var columnName = event.args.datafield;
			   var val="";
			  
				   
			   if(rowindex3<discountrow)
				 {          
				  
		           if(columnIndex3>0)  {
		        	   
			                $('#booktarifGrid').jqxGrid('setcellvalue', discountrow, columnName,val);
			                $('#booktarifGrid').jqxGrid('setcellvalue', nettotalrow, columnName,val);
			                if(columnName=="cdw"){
								   
								   var normalinsu=document.getElementById("normalinsu").value;
									
							    	var tempss="insuexcess";
						             
						    	   funRoundAmt(normalinsu,tempss);
						    	   
		                            // document.getElementById("excessinsur").value=0;	
		                   
					               }
					        if(columnName=="cdw1"){
					        	  var normalinsu=document.getElementById("normalinsu").value;
					        	  var tempss="insuexcess";
						             
						    	   funRoundAmt(normalinsu,tempss);
					    	  // document.getElementById("excessinsur").value=0;	
					    	  
							       }
		                     }  
					 }
				 
			   
			});  
  
 
}); 
    </script>

           
   <div id="booktarifGrid"> </div> 
         <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include>  --%>