   <%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
     <%ClsMarketingDAO cmd= new ClsMarketingDAO(); %>
 
 
 <%
    String barchval = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname").trim();
  	 String relodestatus = request.getParameter("relodestatus")==null?"NN":request.getParameter("relodestatus").trim();
  	
  	
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 
var enqdata;

 if(temp4!=" ")
{ 
	
	 enqdata='<%=cmd.enquirylistsearch(barchval,fromdate,todate,clientname,relodestatus)%>'; 
		 
} 
else
{ 
	
	enqdata;
	
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
					
						
						],
				    localdata: enqdata,
        
        
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
    
    
   
   
    
    $("#enqlistgrid").jqxGrid(
    {
        width: '98%',
        height: 560,
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
				     { text: 'Doc No',datafield: 'voc_no', width: '6%' },
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true },
				     { text: 'Client',datafield: 'name', width: '14%' },
					 { text: 'MOB', datafield: 'mob', width: '10%' },
					 { text: 'Remarks', datafield: 'remarks', width: '19%'},
					 { text: 'Brand Model', datafield: 'brmodel', width: '14%'},
					 { text: 'Rental Type', datafield: 'rtype', width: '6%'},
					 { text: 'From Date', datafield: 'frmdate', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy'},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="enqlistgrid"></div>