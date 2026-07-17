<%@ page import="com.dashboard.leaseagreement.paymentschedule.PaymentScheduleDAO" %>
<% PaymentScheduleDAO psd=new PaymentScheduleDAO();%>
 
<% String contextPath=request.getContextPath();%>

 
 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
           String pdate = request.getParameter("pdate")==null?"0":request.getParameter("pdate").trim();
      
           	  %> 
           	  
      	  
<script type="text/javascript">
 var temp4='<%=barchval%>';
var pytdata;
if(temp4!='NA')
{ 
	
	 pytdata='<%=psd.pymtScheduleGrid(barchval,pdate)%>'; 
	//alert(ssss);
	
} 
else
{                       
	
	pytdata;
	
	
	}  

$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'lano', type: 'String'  },
						{name : 'client', type: 'String'  },
						 
						 {name : 'odate', type: 'date'  }, 
						{name : 'fleetno', type: 'String'  },
						 {name : 'fleetname', type: 'String'  }, 
						
						{name : 'dates', type: 'date'  },
						{name : 'amount', type: 'String'  },
						
						{name : 'doc_no', type: 'String'  },
						{name : 'cldocno', type: 'String'  },
						{name : 'clacno', type: 'String'  },
						
						{name : 'brhid', type: 'String'  },
						
						
						
						{name : 'period2', type: 'String'  },
						
						{name : 'srno', type: 'String'  },
						],
				    localdata: pytdata,
        
        
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
    
      
    $("#pmtschedulegrid").jqxGrid(
    {
        width: '99%',
        height: 510,
        source: dataAdapter,
       
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        
     
        columns: [   
				     { text: 'LA NO', datafield: 'lano', width: '8%' },
				     { text: 'Client Name', datafield: 'client', width: '30%' }, 
				     { text: 'Out Date',datafield: 'odate', width: '10%',cellsformat:'dd.MM.yyyy' },
					 { text: 'Fleet Reg. No', datafield: 'fleetno',width: '12%' },
					 { text: 'Fleet Name',datafield: 'fleetname',width: '17%'},
					 { text: 'Date',datafield: 'dates', width: '10%',cellsformat:'dd.MM.yyyy' },
					 { text: 'Amount', datafield: 'amount', width: '10%',align:'right',cellsformat:'d2',cellsalign:'right'},
				 
					 
					 { text: 'Doc_no', datafield: 'doc_no', width: '12%',hidden:true},
					 { text: 'cldocno', datafield: 'cldocno', width: '12%',hidden:true},
					 { text: 'clacno', datafield: 'clacno', width: '12%',hidden:true},
					 { text: 'Branch_id', datafield: 'brhid', width: '12%',hidden:true},
					// { text: 'user_id', datafield: 'userid', width: '12%',hidden:true},
					 { text: 'Period', datafield: 'period2', width: '12%',hidden:true},
					 { text: 'srno', datafield: 'srno', width: '12%',hidden:true},
					]
   
    });
    
	   $("#overlay, #PleaseWait").hide();
	      
       
     /*   $('#pmtschedulegrid').on('rowdoubleclick', function (event) 
         		{ 
     	  var rowindex1=event.args.rowindex;
    
     	  document.getElementById("docno").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
     	  
     	   document.getElementById("cldocno").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
     	  
            document.getElementById("clacno").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "clacno");
           
            document.getElementById("amt").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "amount");
            
            document.getElementById("lano").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "lano");
            
            document.getElementById("branchid").value=$('#pmtschedulegrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        				              
          
         		 });	 */
    
    
});


</script>
<div id="pmtschedulegrid"></div>
