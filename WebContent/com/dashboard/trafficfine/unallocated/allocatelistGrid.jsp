 
 
 <%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO"%> 
 <%
        
 ClsTrafficfineDAO showDAO = new  ClsTrafficfineDAO();
 
           	String chval = request.getParameter("chval")==null?"NA":request.getParameter("chval").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	//System.out.println("---------"+chval);
           	  %> 
           	  

<script type="text/javascript">
 var temp4='<%=chval%>';
var dats;
if(temp4=='10')
{
	dats='<%=showDAO.allocationlist(uptodate)%>';  
}
else if(temp4=='2')
{ 
	//alert("in");
dats='<%=showDAO.unallocation(uptodate)%>'; 


	
}
else
{
	
	dats;
	
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",       
        datafields: [
       

						{name : 'regno', type: 'string'  },
						{name : 'ticket_no', type: 'String'  },
						{name : 'source', type: 'string'  },
					
						{name : 'traffic_date', type: 'date'  },
						{name : 'time', type: 'string'  },
				
					/*	{name : 'fleetno', type: 'string'  }, */
						{name : 'fine_source', type: 'string'  },
			/* 			{name : 'location', type: 'String'  }, */
						{name : 'pcolor', type: 'string'  },
					
						{name : 'amount', type: 'string'  },
						{name : 'reason', type: 'string'  },
						{name : 'rano', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'btnsave', type: 'string'  },
		/* 				{name : 'rdocno', type: 'string'  },
				
						{name : 'rdtype', type: 'string'  },
						{name : 'trancode', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						{name : 'sr_no', type: 'string'  }, */
					
						
						],
				    localdata: dats,
        
        
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
    
    
    $("#trafficGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
      
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [   	
			                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                     	
                     	{ text: 'Plate Code', datafield: 'pcolor', width: '10%'   },
						{ text: 'Reg NO', datafield: 'regno', width: '10%' },
						{ text: 'Ticket No', datafield: 'ticket_no', width: '10%' },
						{ text: 'Source', datafield: 'source', width: '18%'},
						{ text: 'Traffic Date', datafield: 'traffic_date', width: '9%',cellsformat:'dd.MM.yyyy' },

						{ text: 'Traffic Time', datafield: 'time', width: '10%'},

						{ text: 'Amount', datafield: 'amount', width: '8%',cellsalign: 'right', align:'right' },
						{ text: 'RA No', datafield: 'rano', width: '5%'},
						{ text: 'Branch', datafield: 'branch', width: '5%'},
						{ text: 'Reason', datafield: 'reason'},
						
						 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					
					/* 
						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'sr_no', datafield: 'sr_no', width: '10%' ,hidden:true}, */
						
					]
    
    });
    
    $("#overlay, #PleaseWait").hide(); 
    
    
    if(temp4=='10')
    {
    	   $('#trafficGrid').jqxGrid('hidecolumn', 'btnsave');
    	
    }
    else
    	{
    	 $('#trafficGrid').jqxGrid('showcolumn', 'btnsave');
    	
    	}
    
    
    
    $("#trafficGrid").on('cellclick', function (event) 
   		{
        var datafield = event.args.datafield;

	    var rowBoundIndex = event.args.rowindex;
	    
	    
	    if(datafield=="btnsave"){
       	 if($('#trafficGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Delete"){
       		
       		 
       		 var ticket_no= $('#trafficGrid').jqxGrid('getcellvalue',rowBoundIndex, "ticket_no");
       		 
       		 
       
		                          $.messager.confirm('Message', 'Do you want to Delete?', function(r){
		        	  
	     		       
				       		        	if(r==false)
				       		        	  {
				       		        		return false; 
				       		        	  }
				       		        	else{
				        				 savegriddatas(ticket_no);
				       		        	   }
		                      });
       	 }
       	 else {
       		 
       	
       	  $('#trafficGrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Delete");
       	    }
    	
	    }
   		});
    
    $('#trafficGrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
    	

		
		document.getElementById("ticketno").value="";
		document.getElementById("fleet_no").value="";
		document.getElementById("trftype").value="RAG";
	 
		document.getElementById("typesearch").value="";
	 
		
		document.getElementById("rentaldoc").value="";
		document.getElementById("leasedoc").value="";
		document.getElementById("drdoc").value="";
		document.getElementById("staffdoc").value="";
		
		
		 $('#ticketno').attr("disabled",false);
		 
		 $('#fleet_no').attr("disabled",false);
		 $('#trftype').attr("disabled",false);
		 $('#branchsss').attr("disabled",false);
		 $('#allocates').attr("disabled",false);
		 $('#typesearch').attr("disabled",false);
		 

  document.getElementById("ticketno").value=$('#trafficGrid').jqxGrid('getcellvalue', rowindex1, "ticket_no"); 

       
       
    
    		 });	 
   
    
    
    
    
	   
});

function savegriddatas(ticketno)
{
	  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			
			
			 
			   if(parseInt(itemval)=="99")
			    	{
			    	
			    	   $.messager.alert('Message', '  Record Successfully Deleted ');
			    	   funreload(event);
				       $("#hidediv").hide();
				       dis();
				     
	
			    	}
			    else
			    	{
			    	
			    	  $.messager.alert('Message', '  Not Deleted ');
				      // funreload(event);
				       $("#hidediv").hide();
			    	
			    	}
			    
			    
			}
		else
			{
			
			}                                                                // trftype branchsss   rentaldoc leasedoc drdoc staffdoc
	}
	x.open("GET","deletedata.jsp?ticketno="+ticketno);

	x.send();	
	
}
	
</script>
<div id="trafficGrid"></div>