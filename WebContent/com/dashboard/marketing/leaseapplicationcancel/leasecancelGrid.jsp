  <%@page import="com.dashboard.marketing.leaseapplicationcancel.ClsleaseApplicationCancelDAO"%>
     <%
     	ClsleaseApplicationCancelDAO cmd= new ClsleaseApplicationCancelDAO();
     %>
 
 
 <% String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim(); %>
	
 <% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>
 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var enqdata;

 if(temp4!='NA')
{ 
	
	 enqdata='<%=cmd.leasefollowtsearch(barchval,satcateg)%>' ;
	 cancelexcel='<%=cmd.leasefollowtsearchexcel(barchval,satcateg)%>' ;
	// alert(enqdata);
} 
else
{ 
	
	enqdata=[];
	
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
						{name : 'leasereqdocno', type: 'String'  },
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
							{name : 'user_name', type: 'String'  },
 						{name : 'allotno', type: 'String'  },
 						{name : 'createla', type: 'String'  },
 						{name : 'rowcolor',type:'number'},
 						{name : 'pyttotalrent', type: 'String'  },
 						{name : 'kmuse', type: 'String'  },
 						{name : 'exrate', type: 'String'  },
 						{name : 'remarks', type: 'String'  },
 						{name : 'testdate', type: 'date'  },
						],
				    localdata: enqdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    $('#enqlistgrid').on("bindingcomplete", function (event) {
    	if(document.getElementById("radio_cancel").checked==true){
			$('#enqlistgrid').jqxGrid('hidecolumn', 'remarks');
			$('#enqlistgrid').jqxGrid('hidecolumn', 'testdate');
			$('#enqlistgrid').jqxGrid('hidecolumn', 'user_name');
		} else if(document.getElementById("radio_cancellist").checked==true){
			$("#enqlistgrid").jqxGrid('showcolumn', 'remarks');
			$("#enqlistgrid").jqxGrid('showcolumn', 'testdate');
			$("#enqlistgrid").jqxGrid('showcolumn', 'user_name');
		 }
 
	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#enqlistgrid").jqxGrid(
    {
        width: '98%',
        height: 570,
        source: dataAdapter,
        
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
                    { text: 'Ref Doc', datafield: 'refdoc',  width: '6%'}, 
                    { text: 'Client', datafield: 'client',  width: '14%'},
				     { text: 'Brand', datafield: 'brand',  width: '10%' },
				     { text: 'Model',datafield: 'model', width: '10%' },
				     { text: 'Sales Person', datafield: 'sal_name', width: '14%', },
				     { text: 'Cancel Remarks', datafield: 'remarks', width: '14%', },
				     { text: 'Cancel username', datafield: 'user_name', width: '14%', },
				     { text: 'Cancel Date', datafield: 'testdate', width: '7%',cellsformat:'dd.MM.yyyy', },
				     { text: 'From Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy', },
				     { text: 'Total Value',datafield: 'vcost', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right' },
					 { text: 'Residual Value', datafield: 'residalvalue', width: '7%',cellsformat:'d2',align:'right',cellsalign:'right'},
					 { text: 'No. of Months', datafield: 'nmonth', width: '10%'},
					 { text: 'Quantity', datafield: 'qty', width: '10%'},
					 { text: ' ', datafield: 'createla', width: '7%',columntype: 'button',editable:false, filterable: false,hidden:true},
					 { text: 'updated quantity', datafield: 'updqty', width: '10%',hidden:true},
					 { text: 'Srno', datafield: 'srno', width: '10%',hidden:true},
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
					 { text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true},
					 { text: 'PaytotalRent',datafield:'pyttotalrent',width:'10%',hidden:true},
					 { text: 'Excess KM Use',datafield:'kmuse',width:'10%',hidden:true},
					 { text: 'Excess Rate',datafield:'exrate',width:'10%',hidden:true},
					]
    });
    $("#overlay, #PleaseWait").hide();
    if(document.getElementById("radio_cancel").checked==true){
    	$('#enqlistgrid').on('rowdoubleclick', function (event) 
        		{ 
	  var rowindex1=event.args.rowindex;
      document.getElementById("srno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "srno");
      //document.getElementById("username").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "username");
	  document.getElementById("leasereqdocno").value=$('#enqlistgrid').jqxGrid('getcelltext', rowindex1, "leasereqdocno");
	  document.getElementById("refno").value=$('#enqlistgrid').jqxGrid('getcelltext', rowindex1, "refdoc");
	  document.getElementById("clientname").value=$('#enqlistgrid').jqxGrid('getcelltext', rowindex1, "client");
    		});
    }
   
});


</script>
<div id="enqlistgrid"></div>