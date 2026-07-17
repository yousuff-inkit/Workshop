<%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
<%ClsMarketingDAO cmd= new ClsMarketingDAO(); %>


 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';

 
var books;
 if(temp4!='NA')
{ 
	
	 books='<%=cmd.bookingfollowsearch(barchval,fromdate,todate)%>'; 
	
} 
else
{ 
	
	books;

	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'brmodel', type: 'String'},
						{name : 'mob', type: 'String'},
						{name : 'rtype', type: 'String'  },
						{name : 'frmdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'brhid', type: 'string'  },
						{name : 'reftype', type: 'string'  },
						{name : 'fdate', type: 'date'  },
						{name : 'cldocno', type: 'string'  },
						{name : 'delivery', type: 'string'  },
						{name : 'chuef', type: 'string'  },
						{name : 'grpid', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'brhid', type: 'string'  },
						{name : 'frmtime', type: 'date'  },
						{name : 'delchg', type: 'string'  },
						
				 
						
						],
				    localdata: books,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#qutfollowgrid").jqxGrid(
    {
        width: '98%',
        height: 450,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
           	         { text: 'Type', datafield: 'type',  width: '6%' }, 
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'hidDoc No',datafield: 'doc_no', width: '5%',hidden:true},
				     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
				     
				     { text: 'Client',datafield: 'name', width: '12%' },
					 { text: 'MOB', datafield: 'mob', width: '8%' },
					  { text: 'Fleet', datafield: 'fleet_no', width: '7%'},
					 
					 { text: 'Brand Model', datafield: 'brmodel', width: '16%'},
					 { text: 'Rental Type', datafield: 'rtype', width: '6%'},
					 { text: 'From Date', datafield: 'frmdate', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'From Time', datafield: 'frmtime', width: '5%'},
				
					 { text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Follow up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy' },
					 { text: 'branch', datafield: 'brhid', width: '7%',hidden:true},
					 { text: 'reftype', datafield: 'reftype', width: '7%',hidden:true},
					 
					 { text: 'cldocno', datafield: 'cldocno', width: '7%',hidden:true},
					 { text: 'delivery', datafield: 'delivery', width: '7%',hidden:true},
					 { text: 'chuef', datafield: 'chuef', width: '7%',hidden:true},
					 { text: 'grpid', datafield: 'grpid', width: '7%',hidden:true},
					 { text: 'delchg', datafield: 'delchg', width: '7%' ,hidden:true},
					
				/* 	 { text: 'brhid', datafield: 'brhid', width: '7%'}, */
					 /* { text: 'Remarks', datafield: 'remarks', width: '13%'}, */
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#qutfollowgrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  // set null
	  
	  	$('#date').val(new Date());
	   	   document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("reftype").value=""; 
			 
			  document.getElementById("rdocno").value="";
			 document.getElementById("txtfleetno").value="";
			 document.getElementById("rdocno").value="";
			 document.getElementById("del_chaufferid").value="";
			   document.getElementById("clientdrvid").value="";
			   document.getElementById("tariffrenral_Agentid").value="";
			  document.getElementById("ratariff_checkoutid").value="";
			   document.getElementById("delivery").value="";
			  document.getElementById("chuef").value="";
			 document.getElementById("radriverlist").value="";
			 document.getElementById("clientdrv").value="";
			 document.getElementById("rarenral_Agent").value="";
			document.getElementById("ratariff_checkout").value="";
			document.getElementById("delcharge").value="";
				 

		 $('#date').jqxDateTimeInput({ disabled: false});
		
		 $('#cmbinfo').attr("disabled",false);
		 $('#remarks').attr("readonly",false);
		 $('#driverUpdate').attr("disabled",false);
	
		 $('#txtfleetno').attr("disabled",false);
		 $('#delivery_chk').attr("disabled",false);
		 $('#radrivercheck').attr("readonly",false);
		 $('#clientdrv').attr("disabled",false);
		 $('#rarenral_Agent').attr("disabled",false);
		 $('#ratariff_checkout').attr("disabled",false);
		 $('#rentalcreate').attr("disabled",false);

		 $('#jqxDateOut').jqxDateTimeInput({ disabled: false});
		 $('#jqxTimeOut').jqxDateTimeInput({ disabled: false});
		 
		 

		
		 $("#jqxDateOut").val($('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "frmdate"));
		 $("#jqxTimeOut").val($('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "frmtime"));
    	
	  document.getElementById("branchids").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  
	  document.getElementById("rdocno").value=$('#qutfollowgrid').jqxGrid('getcelltext', rowindex1, "doc_no");
	  
       document.getElementById("clname").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "name");
      
       document.getElementById("reftype").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "reftype");
       
       document.getElementById("clientid").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
        
       document.getElementById("grpid").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "grpid");
       
       document.getElementById("txtfleetno").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
      
       

       if(parseInt($('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "delivery"))==1)
       {
    
       document.getElementById("delivery_chk").checked=true;
       document.getElementById("delivery").value=1;
       $("#radrivercheck").prop("disabled", true);
       
       $('#radriverlist').attr("disabled",false);
       
       $('#delcharge').attr("disabled",false);
       
       document.getElementById("delcharge").value=$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "delchg");
       
       
       }
       else
       	{
    	   $('#delcharge').attr("disabled",true);
    	   document.getElementById("delivery_chk").checked=false; 
	        document.getElementById("delivery").value=0;
	        $("#radrivercheck").prop("disabled", false);
	        $('#radriverlist').attr("disabled",true);
	        document.getElementById("delcharge").value="";
	        if(parseInt($('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "chuef"))==1)
	        {
	     
	        document.getElementById("radrivercheck").checked=true;
	        document.getElementById("chuef").value=1;
	 	   $("#delivery_chk").prop("disabled", true);
	        $('#radriverlist').attr("disabled",false);
	        $('#clientdrv').attr("disabled",true);
	        }
	        else
	        	{
	        	
	     	   document.getElementById("radrivercheck").checked=false; 
	     	   document.getElementById("chuef").value=0;  
	     	   $("#delivery_chk").prop("disabled", false);
	            $('#radriverlist').attr("disabled",true);
	            $('#clientdrv').attr("disabled",false);
	            
	        	}
       	}
       
    
       
     
       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#qutfollowgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
    
    		 });	 
   
 
});


</script>
<div id="qutfollowgrid"></div>