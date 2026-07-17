  <%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
     <%ClsMarketingDAO cmd= new ClsMarketingDAO(); %>


 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';

 
var enqdatas;
 if(temp4!='NA')
{ 
	
	 enqdatas='<%=cmd.enquiryfollowsearch(barchval,fromdate,todate)%>'; 
	
} 
else
{ 
	
	enqdatas;
	
	
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
						{name : 'enqtype', type: 'string'  },
						{name : 'fdate', type: 'date'  },
						
						
						],
				    localdata: enqdatas,
        
        
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
    
    
   
   
    
    $("#enqfollowgrid").jqxGrid(
    {
        width: '98%',
        height: 400,
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
					 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
				     { text: 'hidDoc No',datafield: 'doc_no', width: '5%',hidden:true },
				     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
				     { text: 'Client',datafield: 'name', width: '14%' },
					 { text: 'MOB', datafield: 'mob', width: '7%' },
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Brand Model', datafield: 'brmodel', width: '12%'},
					 { text: 'Rental Type', datafield: 'rtype', width: '6%'},
					 { text: 'From Date', datafield: 'frmdate', width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					 { text: 'brhid', datafield: 'brhid', width: '7%',hidden:true},
					 { text: 'enqtype', datafield: 'enqtype', width: '7%',hidden:true},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#enqfollowgrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  // set null
	  
	  	$('#date').val(new Date());
	   	   document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("type").value=""; 

		 $('#date').jqxDateTimeInput({ disabled: false});
		
		 $('#cmbinfo').attr("disabled",false);
		 $('#remarks').attr("readonly",false);
		 $('#driverUpdate').attr("disabled",false);
	
	
	  document.getElementById("branchids").value=$('#enqfollowgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  
	  document.getElementById("rdocno").value=$('#enqfollowgrid').jqxGrid('getcelltext', rowindex1, "doc_no");
	  
       document.getElementById("clname").value=$('#enqfollowgrid').jqxGrid('getcellvalue', rowindex1, "name");
      
       document.getElementById("type").value=$('#enqfollowgrid').jqxGrid('getcellvalue', rowindex1, "enqtype");

       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#enqfollowgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
    
    		 });	 
   
 
});


</script>
<div id="enqfollowgrid"></div>