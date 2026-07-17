   <%@page import="com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO"%>
     <%ClsleaseApplicationFollowupDAO cmd= new ClsleaseApplicationFollowupDAO(); %>
 
 
 <%
    String barchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String stat = request.getParameter("stat")==null?"0":request.getParameter("stat").trim();
  	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
  	String salperson = request.getParameter("salperson")==null?"":request.getParameter("salperson").trim();
 %> 
           	  
 <style type="text/css">
  
    .yellowClass
    {
        background-color: #F8E489;  
    }
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  .greenClass
    {
        background-color: #7AFA90;
    }
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>
<script type="text/javascript">
var stat='<%=stat%>';
 var temp4='<%=barchval%>';
 var chck='<%=check%>';
var leasedatas;

 if(temp4!='NA' && chck=='1')
{ 
	
	 leasedatas='<%=cmd.leasefollowtsearch(barchval,fromdate,todate,stat,check,salperson)%>' ; 
	
} 

else{
	
 leasedatas=[];
	
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                      
                        {name : 'brand', type: 'String'  },
                        {name : 'model', type: 'String'  },
						{name : 'fdate', type: 'date'  },
						{name : 'vcost', type: 'String'  },
						{name : 'residalvalue', type: 'String'  },
						{name : 'nmonth', type: 'String'  },
						{name : 'qty', type: 'String'  },
						
						{name : 'updqty', type: 'String'  },
						{name : 'srno', type: 'String'  },
						{name : 'brdid', type: 'String'  },
						{name : 'modelid', type: 'String'  },
						{name : 'po_dealer', type: 'String'  },
						{name : 'refdoc', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'prchcost', type: 'String'  },
						{name : 'vendacno', type: 'String'  },
					
					
						{name : 'contactperson', type: 'String'},
						{name : 'per_mob', type: 'String'  },
						{name : 'mail1', type: 'String'  },
						 {name : 'address', type: 'String'  },
						 {name : 'per_tel', type: 'String'  },
						 {name : 'cldocno', type: 'String'  },
						 {name : 'acno', type: 'String'  },
						 {name : 'sal_name', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'blaf_srno', type: 'String'  },
							{name : 'printsrno', type: 'String'  },
							{name : 'printbrhid', type: 'String'  },
							{name : 'dealername', type: 'String'  },
    						{name : 'allotno', type: 'String'  },
    						{name : 'createla', type: 'String'  },
    						{name : 'rowcolor',type:'number'},
    						{name : 'pyttotalrent', type: 'String'  },
    						{name : 'kmuse', type: 'String'  },
    						{name : 'exrate', type: 'String'  },
						],
				    localdata: leasedatas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 
    $("#leasefollowgridid").on("bindingcomplete", function (event) {
    //	var radval = $('input[name="category"]:checked').val();
    	
    	if(stat=="FU")
  	  {
    	
    	 $('#leasefollowgridid').jqxGrid({ height: 400 });
  	  }
    });   
    
    var cellclassname = function (row, column, value, data) {
      
        if(stat=='NA' || stat=='LAC' || stat=='PO' || stat=='FU')
     	  {
    		
        	if(data.rowcolor=="1"){
            	return "orangeClass";
            }
         
     	  } 
        
        if(stat=='VR')
   	  {
  		
        if (typeof(data.pyttotalrent)!="" && data.pyttotalrent!="") {
        	return "greenClass";
        } 
        else
        	{
        	if(data.rowcolor=="1"){
            	return "orangeClass";
            }
        	}
       
   	  } 
          };
  /*  var cellclassname = function (row, column, value, data) {
    	if(stat=='PO')
     	  {
    		
          if (parseInt(data.po_dealer)>0) {
          	return "orangeClass";
          } 
         
     	  }  */
    	 
    	/* else if(stat=='FU')
   	  {
        if ((parseInt(data.qty)-parseInt(data.updqty))==0) {
        	return "yellowClass";
        } 
   	  } */
        /*  else {
        	return "whiteClass";
		}; */
  //  };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#leasefollowgridid").jqxGrid(
    {
        width: '99%',
        height: 530,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
    //    selectionmode: 'singlerow',
    selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columnsresize:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%', cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    { text: 'Ref Doc', datafield: 'refdoc',  width: '6%', cellclassname: cellclassname }, 
                    { text: 'Client', datafield: 'client',  width: '14%', cellclassname: cellclassname }, 
           	         { text: 'Brand', datafield: 'brand',  width: '10%' , cellclassname: cellclassname}, 
           	      { text: 'Model',datafield: 'model', width: '10%', cellclassname: cellclassname },
           	   { text: 'Sales Person', datafield: 'sal_name', width: '14%', cellclassname: cellclassname },
					 { text: 'From Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy', cellclassname: cellclassname},
				     
				     { text: 'Total Value',datafield: 'vcost', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right', cellclassname: cellclassname },
					 { text: 'Residual Value', datafield: 'residalvalue', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right', cellclassname: cellclassname },
					 { text: 'No. of Months', datafield: 'nmonth', width: '10%', cellclassname: cellclassname},
					 { text: 'Quantity', datafield: 'qty', width: '10%', cellclassname: cellclassname},
					 { text: ' ', datafield: 'createla', width: '7%',columntype: 'button',editable:false, filterable: false,hidden:true,cellclassname:cellclassname},
					 { text: 'updated quantity', datafield: 'updqty', width: '10%',hidden:true},
					 { text: 'srno', datafield: 'srno', width: '10%',hidden:true},
					 { text: 'brandid', datafield: 'brdid', width: '10%',hidden:true},
					 { text: 'modelid', datafield: 'modelid', width: '10%',hidden:true},
					 { text: 'po dealer', datafield: 'po_dealer', width: '10%',hidden:true},
					 { text: 'prchcost', datafield: 'prchcost', width: '10%',hidden:true},
					 { text: 'vendacno', datafield: 'vendacno', width: '10%',hidden:true},
				
					 { text: 'ADDRESS', datafield: 'address', width: '21%',hidden:true }, 
					 { text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
					
					 { text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
					 { text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					 { text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
					 { text: 'MOB', datafield: 'per_mob', width: '9%',hidden:true },
					 { text: 'TEL', datafield: 'per_tel', width: '8%',hidden:true },
					 { text: 'CLIENT NO', datafield: 'cldocno', width: '7%',hidden:true  },
					 { text: 'Blaf srno', datafield: 'blaf_srno', width: '7%',hidden:true  },
					 { text: 'Print srno', datafield: 'printsrno', width: '7%',hidden:true  },
					 { text: 'Print branch', datafield: 'printbrhid', width: '7%',hidden:true  },
					 { text: 'dealername', datafield: 'dealername',  width: '6%',hidden:true },
					 { text: 'allotno', datafield: 'allotno',  width: '6%',hidden:true },
					 { text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true,cellclassname:cellclassname},
					 { text: 'PaytotalRent',datafield:'pyttotalrent',width:'10%',hidden:true,cellclassname:cellclassname},
					 { text: 'Excess KM Use',datafield:'kmuse',width:'10%',hidden:true,cellclassname:cellclassname},
					 { text: 'Excess Rate',datafield:'exrate',width:'10%',hidden:true,cellclassname:cellclassname},
					]

   
    });
    if(stat=='LAC')
	{
    	 $("#leasefollowgridid").jqxGrid('setcolumnproperty', 'qty', 'width', '6%');
    	 $("#leasefollowgridid").jqxGrid('setcolumnproperty', 'nmonth', 'width', '7%');
   $('#leasefollowgridid').jqxGrid('showcolumn', 'createla');
  
	}
    $("#overlay, #PleaseWait").hide();
     
   $('#leasefollowgridid').on('celldoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	 
	  // set null;
	 // if(data!="createla"){
			var rows=$('#leasefollowgridid').jqxGrid('getrows');
			for(var i=0;i<rows.length;i++){
				$('#leasefollowgridid').jqxGrid('setcellvalue',i,'rowcolor','0');
			}
			$('#leasefollowgridid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
	//}
	   document.getElementById("srno").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "srno");
	   if(stat=='NA')
		  {
		   $('#btnSendingEmail').attr("disabled",true);
		   $('#txtallot').attr("disabled",false);
		   $('#txtchasis').attr("disabled",false);
			 $('#txtallotremark').attr("disabled",false);
			 $('#allotUpdate').attr("disabled",false);
			 $('#date').jqxDateTimeInput({ disabled: true});
			  $('#fleetdate').jqxDateTimeInput({ disabled: true});
				 $('#purdealer').attr("disabled",true);
				 $('#purchaseUpdate').attr("disabled",true);
				 $('#txtfleetno').attr("disabled",true);
				 $('#dealer').attr("disabled",true);
				 $('#fleetUpdate').attr("disabled",true);
				 $('#purchasePrint').attr("disabled",true);
				 $('#txtalloc').attr("disabled",true);
				 $('#txtinv').attr("disabled",true);
				 $('#txtvehremark').attr("disabled",true);
				   $('#vehreleaseUpdate').attr("disabled",true);
					 $('#vehreleasePrint').attr("disabled",true);
		  }
	   else if(stat=='VR')
		  {
		   $('#btnSendingEmail').attr("disabled",false);
		   document.getElementById("txtcostval").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "prchcost");
		   document.getElementById("txtcostresult").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "prchcost");
		   document.getElementById("txtcostadd").value="0";
		   document.getElementById("hidemail").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "mail1");
		   document.getElementById("hidcldocno").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "cldocno");
		   document.getElementById("printdocno").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "refdoc");
		   document.getElementById("printsrno").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "printsrno");
		   document.getElementById("printbrhid").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "printbrhid");
		   /* $('#txtvehremark').attr("disabled",false);
		     $('#txtcostval').attr("disabled",false);
			 $('#txtcostadd').attr("disabled",false);
			 $('#txtcostresult').attr("disabled",false); */
			 $('#instock_veh').attr("disabled",false);
			 $('#instock_veh').val('');
		     $('#vehreleaseUpdate').attr("disabled",false);
			
			 $('#vehreleasePrint').attr("disabled",false);
			 $('#txtallot').attr("disabled",true);
			 $('#txtchasis').attr("disabled",true);
			 $('#txtallotremark').attr("disabled",true);
			 $('#allotUpdate').attr("disabled",true);
			 $('#date').jqxDateTimeInput({ disabled: true});
			  $('#fleetdate').jqxDateTimeInput({ disabled: true});
				 $('#purdealer').attr("disabled",true);
				 $('#purchaseUpdate').attr("disabled",true);
				 $('#txtfleetno').attr("disabled",true);
				 $('#dealer').attr("disabled",true);
				 $('#fleetUpdate').attr("disabled",true);
				 $('#purchasePrint').attr("disabled",true);
				 $('#txtalloc').attr("disabled",true);
				 $('#txtinv').attr("disabled",true);
		  }
	   else if(stat=='PO')
		  {
		   $('#btnSendingEmail').attr("disabled",true);
		  var podealer=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "po_dealer");
		 
			  if(typeof(podealer)!="undefined" && podealer!="" && podealer!="undefined")
				  {
				  $('#purchasePrint').attr("disabled",false);
				  }
			  else{
			  $('#purchasePrint').attr("disabled",true); 
			  }
		  $('#date').jqxDateTimeInput({ disabled: false});
			 $('#purdealer').attr("disabled",false);
			
			 $('#purchaseUpdate').attr("disabled",false);
			  $('#fleetdate').jqxDateTimeInput({ disabled: true});
			 $('#txtfleetno').attr("disabled",true);
			 $('#dealer').attr("disabled",true);
			 $('#fleetUpdate').attr("disabled",true);
			 $('#txtalloc').attr("disabled",true);
			 $('#txtinv').attr("disabled",true); 
			 $('#txtallot').attr("disabled",true);
			 $('#txtchasis').attr("disabled",true);
			 $('#txtallotremark').attr("disabled",true);
			 $('#allotUpdate').attr("disabled",true);
			 $('#txtvehremark').attr("disabled",true);
			   $('#vehreleaseUpdate').attr("disabled",true);
				 $('#vehreleasePrint').attr("disabled",true);
		//	  document.getElementById("qty").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "qty");
		  
		  }
	  else if(stat=='FU')
	  {
		  $('#btnSendingEmail').attr("disabled",true);
		  var podealer=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "po_dealer");
			 
		  if(typeof(podealer)!="undefined" && podealer!="" && podealer!="undefined")
			  {
			  $('#purchasePrint').attr("disabled",false);
			  }
		  else{
		  $('#purchasePrint').attr("disabled",true); 
		  }
		  document.getElementById("txtfleetno").value="";
		  document.getElementById("dealer").value="";
		  document.getElementById("txtalloc").value="";
		  document.getElementById("txtinv").value="";
		  if(document.getElementById("txtfleetno").value=="")
		   {
	   $("#txtfleetno").attr('placeholder', 'Press F3 To Search');
		   }
	   if(document.getElementById("dealer").value=="")
	   {
 		 $("#dealer").attr('placeholder', 'Press F3 To Search');
	   }
		  
		  $("#fleetdetailsgrid").jqxGrid('clear');
		  
		  $('#date').jqxDateTimeInput({ disabled: true});
		  $('#fleetdate').jqxDateTimeInput({ disabled: true});
			 $('#purdealer').attr("disabled",true);
			 $('#purchaseUpdate').attr("disabled",true);
			 $('#txtfleetno').attr("disabled",true);
			 $('#dealer').attr("disabled",true);
			 $('#fleetUpdate').attr("disabled",true);
			
			 $('#txtalloc').attr("disabled",true);
			 $('#txtinv').attr("disabled",true);
			 $('#txtallot').attr("disabled",true);
			 $('#txtchasis').attr("disabled",true);
			 $('#txtallotremark').attr("disabled",true);
			 $('#allotUpdate').attr("disabled",true);
			 $('#txtvehremark').attr("disabled",true);
			   $('#vehreleaseUpdate').attr("disabled",true);
				 $('#vehreleasePrint').attr("disabled",true);
			 var aqty=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'qty');
			 var updqty=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'updqty');
			 var brand=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'brand');
			 var model=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'model');
			 var months=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'nmonth');
			 var vehcost=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'vcost');
			 var brndid=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'brdid');
			 var modelid=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'modelid');
			 var resval=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'residalvalue');
			 var prchcost=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'prchcost');
			 var refdoc=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'refdoc');
			 var reqsrno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'srno');
			 var dealerno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "po_dealer");
			 var dealername=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "dealername");
			 var allotno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "allotno");
			 var vendacno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, 'vendacno');
			
			var qty=aqty-updqty;
			
			 for(var i=0;i<qty;i++)
				 {
				 $("#fleetdetailsgrid").jqxGrid("addrow", null, {});
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'brand', brand);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'model', model);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'nmonth', months);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'vcost', vehcost);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'brdid', brndid);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'modelid', modelid);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'residalvalue', resval);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'prchcost', prchcost);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'refdoc', refdoc);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'reqsrno', reqsrno);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'dealerno', dealerno);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'dealername', dealername);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'allotno', allotno);
				 $("#fleetdetailsgrid").jqxGrid('setcellvalue', i, 'vendacno', vendacno);
				 
				 }
		
	  }
	  else if(stat=='LAC')
	  {
		  var data=event.args.datafield;
			
		  $('#btnSendingEmail').attr("disabled",true);
		  var podealer=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "po_dealer");
			 
		 /*  if(typeof(podealer)!="undefined" && podealer!="" && podealer!="undefined")
			  {
			  $('#purchasePrint').attr("disabled",false);
			  }
		  else{
		  $('#purchasePrint').attr("disabled",true); 
		  } */
		  $('#fieldvehrel').hide();
		     $('#fieldpur').hide();
		     $('#fieldnoallot').hide();
		     $('#fieldcomp').hide();
		     $('#fieldfleet').hide(); 
		     
		 
	  
	  }
    		 });	 
    
   
   $('#leasefollowgridid').on('cellclick', function (event) 
   		{ 
	   var rowindex1=event.args.rowindex;
  var data=event.args.datafield;
  if(data=="createla"){
   
	  var temp="";
	  temp=temp+" Contact Person : "+$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "contactperson");
    temp=temp+","+" MOB : "+$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "per_mob");
    temp=temp+","+" Email : "+$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "mail1");
    temp=temp+","+" ADDRESS : "+$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "address");
    temp=temp+","+" Tel NO : "+$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "per_tel");
   
    
   
   var fulldetail=temp; 
	var clientid=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "cldocno");
	var clientname=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "client");
	var le_clacno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "acno");
	var le_clcodeno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "cldocno");
 	var salesman=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "sal_name");
	var le_salmanid=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	var nmonth=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "nmonth");
	var totalval=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "vcost");
	var larefdoc=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "refdoc");
	var blaf_srno=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "blaf_srno");
	var kmuse=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "kmuse");
	var exrate=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "exrate");
	
		
//	  document.getElementById("qty").value=$('#leasefollowgridid').jqxGrid('getcellvalue', rowindex1, "qty");

	     var url=document.URL;
 		var reurl=url.split("com/");
 		var mod="A";
 		window.parent.formName.value="Lease Agreement Create";
 		window.parent.formCode.value="LAG";
 		var detName= "Lease Agreement Create";
 		 var path1='com/operations/agreement/leaseagmt_alfahim/leaseAgmt.jsp';
       //   var path= path1+"?client="+client+"&ctype="+ctype+"&cno="+cno+"&site="+site+"&area="+area+"&scheduleno="+scheduleno+"&mod="+mod+"&cldocno2="+docno2+"&clacno="+acno+"&claddress2="+claddress+"&conttrno="+conttrno+"&contdet="+contdet+"&siteid="+siteid+"&areaid="+areaid;
       /*  var path= path1+"?mod="+mod+"&fulldetail="+fulldetail+"&clientid="+clientid+"&clientname="+clientname+"&le_clacno="+le_clacno+"&le_clcodeno="+le_clcodeno+"&salesman="+salesman+"&le_salmanid="+le_salmanid+"&nmonth="+nmonth+"&totalval="+totalval+"&larefdoc="+larefdoc+"&blaf_srno="+blaf_srno; 
    		    */
    		    
    		    var rent=totalval/nmonth;
    		    var res=parseFloat(rent).toFixed(0);
				  var res1=(res=='NaN'?"0":res);
    		    var path= path1+"?mod="+mod+"&nmonth="+nmonth+"&totalval="+res1+"&larefdoc="+larefdoc+"&blaf_srno="+blaf_srno+"&clientid="
    		    		+clientid+"&clientname="+clientname+"&le_clacno="+le_clacno+"&le_clcodeno="+le_clcodeno+"&salesman="+salesman
    		    		+"&le_salmanid="+le_salmanid+"&fulldetail="+fulldetail+"&kmuse="+kmuse+"&exrate="+exrate;
      
 		top.addTab( detName,reurl[0]+""+path);

		
		}
   		});
   
   
 
});


</script>
<div id="leasefollowgridid"></div>