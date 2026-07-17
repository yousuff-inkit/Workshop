
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<%@ page import="com.dashboard.invoices.damageinvoicelist.ClsDamageInvoiceListDAO" %>
 <%
 String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	
  	String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno").trim();
  	String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
  	ClsDamageInvoiceListDAO cdl=new ClsDamageInvoiceListDAO();
 %> 
           	  
 
<script type="text/javascript">


 var temp4='<%=branchval%>';

var datamov;
var damageinvoiceexceldata;
 if(temp4!='')
{ 
	
	 datamov='<%=cdl.damageinvSearch(branchval,fromdate,todate,cldocno,fleetno)%>'; 
	 damageinvoiceexceldata='<%=cdl.damageinvoicelistExcel(branchval,fromdate,todate,cldocno,fleetno)%>';
	//alert("======"+vehdat);
} 
else
{ 
	
	datamov;
	damageinvoiceexceldata;
	
	}  
//alert(datamov);
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'fleet_no', type: 'String'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'pltcode', type: 'String'  },
						{name : 'doc_no', type: 'String'  },
						{name : 'branch', type: 'String'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'},
						{name : 'acno', type: 'String'},
						{name : 'acname', type: 'String'  },
						{name : 'amount', type: 'string'  },
						{name : 'insurex', type: 'String'},
					
						
						{name : 'inspdocno', type: 'String'},
						
						{name : 'type', type: 'String'},
						{name : 'reftype', type: 'String'  },
						{name : 'refdocno', type: 'string'  },
						
					
						
						],
				    localdata: datamov,
        
        
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
    
    
    
  


   
   
    
    $("#damageinvoicelist").jqxGrid(
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
                  
    
					
              		 { text: 'Fleet No', datafield: 'fleet_no',  width: '5%' }, 
              		 { text: 'Reg No', datafield: 'reg_no',  width: '5%' }, 
           	         { text: 'Plate Code', datafield: 'pltcode',  width: '6%' }, 
					 { text: 'Invoice No', datafield: 'doc_no', width: '6%'},
					 { text: 'Branch', datafield: 'branch', width: '12%'},
				     { text: 'From Date',datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy' },
				     { text: 'To Date',datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy' },
				     { text: 'Account',datafield: 'acno', width: '6%' },
					 { text: 'Account Name', datafield: 'acname', width: '15%' },
					 { text: 'Amount', datafield: 'amount', width: '6%'},
					 { text: 'Insurance Excess', datafield: 'insurex', width: '9%'},
					 
					 { text: 'Inspection Doc No', datafield: 'inspdocno', width: '10%'},
					
					 
					 { text: 'Type', datafield: 'type', width: '5%'},
					 { text: 'Ref Type', datafield: 'reftype', width: '5%'},
					 { text: 'Ref Doc No', datafield: 'refdocno', width: '6%'},
					 
					 
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();

   
});


</script>
<div id="damageinvoicelist"></div>