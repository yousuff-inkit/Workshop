
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.agreement.rentalagmtsayara.*" %>
 <%
 ClsRentalAgmtSayaraDAO viewDAO= new ClsRentalAgmtSayaraDAO();
   	String relodedoc = request.getParameter("txtrentaldocno")==null?"0":request.getParameter("txtrentaldocno").trim();
   	String revehGroup=request.getParameter("revehGroup")==null?"0":request.getParameter("revehGroup").trim();
   	
  	String ratariffdocno1 = request.getParameter("ratariffdocno1")==null?"0":request.getParameter("ratariffdocno1").trim();
 	String vehGroup=request.getParameter("vehGroup")==null?"0":request.getParameter("vehGroup").trim();
 	
 	
	String weekdoc = request.getParameter("weekdoc")==null?"0":request.getParameter("weekdoc").trim();
 	String weekGroup=request.getParameter("weekGroup")==null?"0":request.getParameter("weekGroup").trim();
 	String outdate= request.getParameter("outdate")==null?"NA":request.getParameter("outdate").trim();
 	String outtime= request.getParameter("outtime")==null?"NA":request.getParameter("outtime").trim();
 	
   	%>
<script type="text/javascript">

var temp6='<%=weekdoc%>'; 
 var temp2='<%=relodedoc%>'; 
var temp='<%=ratariffdocno1%>';

var hide;

var datatariff;
  if(temp2>0)
	{
	
		datatariff='<%=viewDAO.tariffratereload(session,relodedoc,revehGroup)%>';
	
	hide=2;
	
	}  
  else if(temp>0)
	{
	 datatariff='<%=viewDAO.tariffRate(session,ratariffdocno1,vehGroup)%>';
	
	} 
  else if(temp6>0)
	{
	 datatariff='<%=viewDAO.weektariffRate(session,weekdoc,weekGroup,outdate,outtime)%>';
	
	} 
else 
	{ 
	 
      datatariff='<%=viewDAO.tariffType()%>'; 
	
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
              	
            	{name : 'startday' , type:'String'},       
              	{name : 'starttime' , type:'String'},
            	{name : 'endday' , type:'String'},
              	{name : 'endtime' , type:'String'},
                
           	 
              	
			   ],
			   localdata: datatariff,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
    $('#jqxgridtarif').on('bindingcomplete', function (event) {
    	
    	 
    	  
    
    	
    	
  if(temp2<=0)
	  {

    
      $("#jqxgridtarif").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
      

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


 
   $("#jqxgridtarif").jqxGrid(
   {
      width: '100%',
      height: 167,
      source: dataAdapter,
      columnsresize: true,
      rowsheight:20,
      disabled:true,
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
					
					{ text: 'startday', datafield: 'startday', editable:false,hidden:true},
					{ text: 'starttime', datafield: 'starttime', editable:false,hidden:true},
					{ text: 'endday', datafield: 'endday', editable:false,hidden:true},
					{ text: 'endtime', datafield: 'endtime', editable:false,hidden:true},
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
  

   
   
   
   
   
   
   
   if ($("#mode").val() == "A") {
   
  
     $("#jqxgridtarif").jqxGrid({ disabled: false});
     
     
  
	 
    }
   
   
   var setvalu = $("#jqxgridtarif").jqxGrid('getrows');
	
	var tempone=setvalu.length;
	var nettotalrow=tempone-1;
	var discountrow=tempone-2;
	var rentalrow=tempone-3; 
	
   
   
   $("#jqxgridtarif").on('cellclick', function (event) 
		   {
		    
		       var dataField = event.args.datafield;
		     
		       var rowBoundIndex = event.args.rowindex;  
		     			       
		       if(dataField=="cdw"){
		    	   
		    
		    	   
		    var cdw1=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow,"cdw1") ;

		
		    	
		    if(cdw1>0||cdw1!="")
		    
		    	  {
		    $('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'cdw');
		    	document.getElementById("errormsg").innerText="Super CDW Is Selected";  
            
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
		     
				    var cdw=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow,"cdw") ;
			
				    if(cdw>0||cdw!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'cdw1');
				    	document.getElementById("errormsg").innerText="CDW Is Selected";  
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
		    	   
				    var pai1=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow,"pai1") ;
					   
				    if(pai1>0||pai1!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'pai');
				    	document.getElementById("errormsg").innerText="Super PAI Is Selected";  
				    	
				    	return false;
				    	  }
				    else{
				    	return true;
				    }
				       }
		       if(dataField=="pai1"){
		    	   
				    var pai=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow,"pai") ;
				
				    if(pai>0||pai!="")
				    
				    	  {
				    	$('#jqxgridtarif').jqxGrid('unselectcell', rowBoundIndex, 'pai1');
				    	document.getElementById("errormsg").innerText="PAI Is Selected";  
				    	return false;
				    	  }
				    else
				    	{
				    	return true;
				    	}
				       }
		       
		   });


  
              var rowindex1=-1;
		   $("#jqxgridtarif").on("cellclick", function (event) {
			
	
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   var columnindex1 = event.args.columnindex;
		
		
               
           var rentypevalid=$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "rentaltype");
               
               
            if(columnindex1>0)
            	{
            	if((rentypevalid=="")||(rentypevalid=="undefined")||(rentypevalid=="NaN")||(rentypevalid=="null"))
            
            	{
            		  
            	document.getElementById("errormsg").innerText=" Select Rental Type";  
            	return false;
            	}
            	else
            		{
            		document.getElementById("errormsg").innerText="";	
            		}
            	
            	} 
			   if(columnindex1==0)
				  {
				rowindex1 = event.args.rowindex;
				 
				 if(rowindex1<rentalrow)
					 {
						
				$("#jqxgridtarif").jqxGrid('updaterow', rentalrow, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				$("#jqxgridtarif").jqxGrid('updaterow', discountrow, {"rentaltype": "Discount","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				$("#jqxgridtarif").jqxGrid('updaterow', nettotalrow, {"rentaltype": "Net Total","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": ""});
				 var normalinsu=document.getElementById("normalinsu").value;
	        	 var tempss="excessinsur";
		    	 funRoundAmt(normalinsu,tempss);
				$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "rentaltype",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "rentaltype"));
				
	 
				
	 		  $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "rate",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "rate"));
				$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "rate",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "rate"));
				
		 if(document.getElementById("configtarif").value==1)
			 {
				
				$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "kmrest",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "kmrest"));
				$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "kmrest",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "kmrest"));
				
				
				$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "exkmrte",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "exkmrte"));
				$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "exkmrte",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "exkmrte"));
			 
				
			 }
				
				$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "disclevel",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "disclevel"));
				  document.getElementById("errormsg").innerText="";
					  
				 $('#jqxgridtarif').jqxGrid('setcellvalue', 0, "status",1);
				 $('#jqxgridtarif').jqxGrid('setcellvalue', 1, "status",2);
				 $('#jqxgridtarif').jqxGrid('setcellvalue', 2, "status",3);
				 $('#jqxgridtarif').jqxGrid('setcellvalue', 3, "status",4);
				 $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "status",5);
				 $('#jqxgridtarif').jqxGrid('setcellvalue',discountrow, "status",6);
				 $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "status",7);
				
					 }	
				 
				  }
			   
			   
			   if(rowindex1<rentalrow) // startday starttime endday endtime
			   {
				   document.getElementById("rentaltype").value=	$('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "rentaltype");
				   
					$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "startday",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "startday"));
				 	$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "startday",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "startday"));
					
	
					$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "starttime",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "starttime"));
				 	$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "starttime",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "starttime"));
					
					$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "endday",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "endday"));
				    $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "endday",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "endday"));
					
					$('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, "endtime",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "endtime"));
					$('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, "endtime",$('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, "endtime"));
				   
					
				   var dataFields = event.args.datafield;
				
							 var columnfrist = event.args.columnindex;
							 
							 
							 if(columnfrist>0)
								 {
																 
								 							 
			                   var val2;
			                var val1 = $('#jqxgridtarif').jqxGrid('getcellvalue', rowindex1, dataFields);
			                  val2 = $('#jqxgridtarif').jqxGrid('getcellvalue', discountrow, dataFields);
			               
							   if(val2==null)   { val2=0;}   var  val3=parseFloat(val1)-val2;
							   $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow, dataFields,val1);
			                $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, dataFields,parseFloat(val3));
								 } 
							
							 
				
							
			   }
				  
		   });
		  
				        
		 	
			   $("#jqxgridtarif").on('cellendedit', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				  //alert(""+rowBoundIndex)
				
				  
				  if(rowBoundIndex==discountrow)
					   {
						     
							   var value = event.args.value;
							   
						  	   
							      
			

							   var temp = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, dataField);
							
									   if(value=="")
										   {
										   $("#jqxgridtarif").jqxGrid('setcellvalue', nettotalrow, dataField, temp);
										   }
									   if(value!="")
										   {
										   var calvalss=document.getElementById("calcuvals").value;
									if(parseFloat(value)<=parseFloat(calvalss))  
											{ 
										var temp2=parseFloat(temp)-parseFloat(value);
						               $("#jqxgridtarif").jqxGrid('setcellvalue', nettotalrow, dataField, temp2);
						               document.getElementById("errormsg").innerText="";
						           
						               
										   } 
								
										else
											{
										
										
											} 
										}
								
                         }
				    });

			   $("#jqxgridtarif").on('cellvaluechanged', function (event) 
			            {
				   
				   var rowBoundIndex1 = event.args.rowindex;
				   var dataField = event.args.datafield;
				
				  if(rowBoundIndex1==discountrow)
					   {
					  
					 
					  
					        var tempval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, dataField);
					        var value= $('#jqxgridtarif').jqxGrid('getcellvalue', discountrow, dataField);
					 	   var maxdisc=document.getElementById("calcuvals").value;
							if(parseFloat(value)>parseFloat(maxdisc))  
									{ 
								  var val="";
								  $('#jqxgridtarif').jqxGrid('setcellvalue', discountrow, dataField,val);
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, dataField,tempval);
				            		document.getElementById("errormsg").innerText="Discount Limit Exceeded";
									return 0;
								  }
							
				             if(tempval=="")
				              {
				      
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', discountrow, dataField,"");
				            	  $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, dataField,"");
				              }
				            
				             else if(tempval==0)
				                {
				            	
				            	 var dataval=0;
				   
				             $('#jqxgridtarif').jqxGrid('setcellvalue', discountrow, dataField,dataval);
				            $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, dataField,dataval);
				                }
			            }
				  
				  /* if(rowBoundIndex1==rentalrow)
					  
					  {
					 
					  var dateval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "rentaltype");
						
					  var curdateout=new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); 
					  
			             if(dateval=="Daily")
			              {
			          			          
			                  var plusoneday=new Date(new Date(curdateout).setDate(curdateout.getDate()+1));
			                  $('#jqxOnDate ').jqxDateTimeInput('setDate', new Date(plusoneday));
							
			              }
			             else  if(dateval=="Weekly")
		              {
			            	 var oneweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+7));
			                  $('#jqxOnDate ').jqxDateTimeInput('setDate', new Date(oneweek));
		            	
		              }
			             else  if(dateval=="Fortnightly")
		              {
			            	 var twoweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+14));
			                  $('#jqxOnDate ').jqxDateTimeInput('setDate', new Date(twoweek));
		            	
		              }
			             else if(dateval=="Monthly")
		              {
			            	    var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
					    
					                 $('#jqxOnDate ').jqxDateTimeInput('setDate', new Date(onemounth));
		            	
		              }
			             else
			            	 {
			            	 
			            	 }
					  
					  } */
				  
				  
				  
				  
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
								   if(rowindex3<discountrow)
									 {
									       $('#jqxgridtarif').jqxGrid('setcellvalue', rentalrow,columnNames,val);
							                $('#jqxgridtarif').jqxGrid('setcellvalue', discountrow, columnNames,val);
							                $('#jqxgridtarif').jqxGrid('setcellvalue', nettotalrow, columnNames,val);
							                
									   if(dataField=="cdw"){
										   
										   var normalinsu=document.getElementById("normalinsu").value;
											
									    	var tempss="excessinsur";
								             
								    	   funRoundAmt(normalinsu,tempss);
								    	   
				                            // document.getElementById("excessinsur").value=0;	
				                   
							               }
							        if(dataField=="cdw1"){
							        	  var normalinsu=document.getElementById("normalinsu").value;
							        	  var tempss="excessinsur";
								             
								    	   funRoundAmt(normalinsu,tempss);
							    	  // document.getElementById("excessinsur").value=0;	
							    	  
									       }
								   
									   }
		                	}
				});
			   
			   $("#jqxgridtarif").on('cellbeginedit', function (event) 
					   {
				   var rowBoundIndex = event.args.rowindex;
				   var dataField = event.args.datafield;
				   
				  if(rowBoundIndex==discountrow)
					   {
						 
					
							   var rentalval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, dataField);
							   var discval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "disclevel");
						
							var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
							
							if(parseFloat(calcval)==0)
							{
						
							 $('#jqxgridtarif').jqxGrid('clearselection');
							document.getElementById("errormsg").innerText="Discount Not Allowed ";
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
				
				
				  
				  if(rowBoundIndex==discountrow)
					   {
						 
							  
							   var rentalval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, dataField);
							   var discval = $('#jqxgridtarif').jqxGrid('getcellvalue', rentalrow, "disclevel");
						
							var calcval=(parseFloat(rentalval)*parseFloat(discval))/100;
							
							if(parseFloat(calcval)==0)
							{
						
							 $('#jqxgridtarif').jqxGrid('clearselection');
							document.getElementById("errormsg").innerText="Discount Not Allowed ";
							return 0;
							}
													 
								
                         }
				    });
			   
			
		
			   
			   
});
    </script>

           
   <div id="jqxgridtarif"> </div>
   
   <input type="hidden" id="calcuvals">

<jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 