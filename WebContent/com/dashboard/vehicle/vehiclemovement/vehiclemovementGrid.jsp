<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<%ClsvehicleDAO cvd=new ClsvehicleDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

 <%
    String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String ready = request.getParameter("ready")==null?"0":request.getParameter("ready").trim();
 %> 
           	  
 
<script type="text/javascript">


/* function addTab(title, url){
	if ($('#tt').tabs('exists', title)){
		$('#tt').tabs('select', title);
	} else {
	 
	 var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('#tt').tabs('add',{
			title:title,
			content:content,
			closable:true
			/* showCloseButtons: true 
		 });
	} 
	
} */ 
 var temp4='<%=fleetno%>';
var datamov;

 if(temp4!='NA')
{ 
	
	 datamov='<%=cvd.vehmovementSearch(fleetno,fromdate,todate,ready)%>'; 
	
} 
else
{ 
	
	datamov;

	
	}  
//alert(datamov);
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'rdtype', type: 'String'  },
						{name : 'rdocno', type: 'string'  },
						{name : 'flname', type: 'String'  },
						{name : 'status', type: 'String'  },
						{name : 'trancode', type: 'String'  },
						{name : 'obrhid', type: 'String'  },
						{name : 'dout', type: 'date'},
						{name : 'tout', type: 'String'},
						{name : 'kmout', type: 'String'  },
					
						{name : 'fout', type: 'string'  },
						{name : 'ibrhid', type: 'string'  },
						
	
						{name : 'din', type: 'date'},
						{name : 'tin', type: 'String'},
						{name : 'kmin', type: 'String'},
						{name : 'fin', type: 'String'  },
						{name : 'fleet_no', type: 'String'},
						{name : 'reg_no', type: 'String'  },
						{name : 'empname', type: 'String'  },
						
						
					
						
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
    
    
    
  


   
   
    
    $("#vehmovement").jqxGrid(
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
        columnsresize:true,
        editable:false,
        columns: [   
                  
    
					
              	 { text: 'Fleet', datafield: 'fleet_no',  width: '5%' }, 
              	 { text: 'Reg No', datafield: 'reg_no',  width: '5%' }, 
           	         { text: 'Type', datafield: 'rdtype',  width: '4%' }, 
					 { text: 'Ref No', datafield: 'rdocno', width: '10%'},
					 { text: 'Name', datafield: 'flname', width: '12%'},
				     { text: 'Status',datafield: 'status', width: '4%' },
				     { text: 'Trancode',datafield: 'trancode', width: '10%' },
				     { text: 'User',datafield: 'empname', width: '16%' },
					 { text: 'Branch Out', datafield: 'obrhid', width: '6%' },
					 { text: 'Date Out', datafield: 'dout', width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time Out', datafield: 'tout', width: '5%'},
					 { text: 'KM Out', datafield: 'kmout', width: '6%'},
					 { text: 'Fuel Out', datafield: 'fout', width: '6%'},
					 { text: 'Branch In', datafield: 'ibrhid', width: '5%'},
					 { text: 'Date In', datafield: 'din', width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time In', datafield: 'tin', width: '4%'},
					 { text: 'KM In', datafield: 'kmin', width: '6%'},
					 { text: 'Fuel In', datafield: 'fin', width: '6%'},
					 
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
  var setvalu = $("#vehmovement").jqxGrid('getrows');
 	
 	var tempone=setvalu.length;
 	
 	if(parseInt(tempone)>0)
 		{
 	    
 	
 		
 		
 		document.getElementById("trncodeval").innerText=""+$('#vehmovement').jqxGrid('getcellvalue', 0, "rdtype")+" - "+$('#vehmovement').jqxGrid('getcellvalue', 0, "status");
 	 document.getElementById("statusval").innerText=""+$('#vehmovement').jqxGrid('getcellvalue', 0, "trancode");	 
 	
 		    			 
 		    			
 		
 		}
 	
 	
    
    $('#vehmovement').on('rowdoubleclick', function (event) {
     	var rowindex1=event.args.rowindex;
		//document.getElementById("temprow").value=         	
     	//document.getElementById("fleetno").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
			if($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "rdtype")=="MOV"){
				if($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "status")=="OUT"){
					//  var Data = document.getElementById("formData").value;
					var url=document.URL;
					//alert(url);
					 var reurl=url.split("com/");
					 var movurl=reurl[0]+"com/operations/vehicletransactions/movement/saveMovement.action?mode=View&docno="+$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "rdocno");
					//alert(movurl);
					 top.addTab('Movement',movurl); 
				}
				else{
					$.messager.alert('Message','Please select with status OUT','warning');
				}
				
			}
			else{
				$.messager.alert('Message','Please select a Movement','warning');
			}
     });
    
  
});


</script>
<div id="vehmovement"></div>