 
 <%@ page import="com.dashboard.analysis.booking.ClsAnalysisBooking" %>
 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	
  	ClsAnalysisBooking cab=new ClsAnalysisBooking();
  	
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var bookdata,exceldata;

 if(temp4!='NA')
{ 
	 exceldata='<%=cab.bookingexcelsearch(barchval,fromdate,todate)%>';
	 bookdata='<%=cab.bookinglistsearch(barchval,fromdate,todate)%>'; 
} 
else
{ 
	
	bookdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
        
                        
                        {name : 'voc_no', type: 'number'  },
						{name : 'date', type: 'date'  },
						{name : 'clientno', type: 'number'},
						{name : 'refname', type: 'String'  },
						{name : 'branchname', type: 'String'  },
						{name : 'reg_no', type: 'number'  },
						{name : 'brmodel', type: 'String'},
						
						
						{name : 'acno', type: 'number'},
						{name : 'reftype', type: 'String'  },
					
						{name : 'rano', type: 'number'  },
					
						{name : 'raopendate', type: 'date'  },
						{name : 'raclosedate', type: 'date'  },
						{name : 'tothr', type: 'number'  },
						{name : 'invoicedamt', type: 'number'  },
						{name : 'kmamt', type: 'number'  },
						{name : 'vat', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'other', type: 'number'  },
						{name : 'damege', type: 'number'  },
						{name : 'traffic', type: 'number'  },
						{name : 'delivery', type: 'number'  },
						{name : 'total', type: 'number'  }
							],
				    localdata: bookdata,
        
        
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
    
    
   
   
    
    $("#booklistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
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
                   
           	        
                    { text: 'RA No',datafield: 'rano', width: '4%' },
					 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     
					 { text: 'Client No',datafield: 'clientno', width: '10%' },
				     
				     { text: 'Account Name',datafield: 'refname', width: '14%' },
				     { text: 'Branch Name',datafield: 'branchname', width: '8%' },
					 { text: 'Reg. No.', datafield: 'reg_no', width: '6%'},
					 { text: 'Fleet Name', datafield: 'brmodel', width: '12%'},
					 { text: 'A/C No.', datafield: 'acno', width: '6%'},
					 { text: 'Rental Type', datafield: 'reftype', width: '6%'},
					
					 { text: 'RA From Date', datafield: 'raopendate', width: '10%',cellsformat:'dd.MM.yyyy hh:mm'},
					 { text: 'RA To Date', datafield: 'raclosedate', width: '10%',cellsformat:'dd.MM.yyyy hh:mm'},
					 { text: 'Total Hours ',datafield: 'tothr', width: '6%' },
					  
					  { text: 'Rental ',datafield: 'invoicedamt', width: '6%' },
					  { text: 'ExtraKM ',datafield: 'kmamt', width: '6%' },
					  { text: 'VAT ',datafield: 'vat', width: '6%' },
					  { text: 'Discount ',datafield: 'discount', width: '6%' },
					  { text: 'Other ',datafield: 'other', width: '6%' },
					  { text: 'Damage ',datafield: 'damege', width: '6%' }, 
					  { text: 'Traffic ',datafield: 'traffic', width: '6%' },
					  { text: 'Drop/Pickup ',datafield: 'delivery', width: '8%' },
					  { text: 'Tot.Amount ',datafield: 'total', width: '8%' }
					  
					  
					]
   
    });

    $("#overlay, #PleaseWait").hide();
 
});


</script>
<div id="booklistgrid"></div>