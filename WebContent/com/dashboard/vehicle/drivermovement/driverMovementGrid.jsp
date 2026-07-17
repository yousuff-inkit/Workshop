
<%-- <jsp:include page="../../../../menu.jsp"></jsp:include> --%>
<%@ page import="com.dashboard.vehicle.drivermovement.ClsDriverMovDAO" %>
 <%
    String driver = request.getParameter("driver")==null?"NA":request.getParameter("driver").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String ready = request.getParameter("ready")==null?"0":request.getParameter("ready").trim();

	ClsDriverMovDAO cdmd=new ClsDriverMovDAO();
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
 var temp4='<%=driver%>';
var drvdata;

 if(temp4!='NA')
{ 
	  
	 drvdata='<%=cdmd.drvmovementSearch(driver,fromdate,todate,ready)%>'; 
	
} 
else
{ 
	
	drvdata;

	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'rdtype', type: 'String'  },
						{name : 'rdocno', type: 'string'  },
						{name : 'flname', type: 'String'  },
						{name : 'reg_no',type:'number'},
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
						
					
						
						],
				    localdata: drvdata,
        
        
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
    
    
   
   
    
    $("#drvmovement").jqxGrid(
    {
        width: '98%',
        height: 300,
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
                  
                
					
           	         { text: 'Type', datafield: 'rdtype',  width: '4%' }, 
					 { text: 'Ref NO', datafield: 'rdocno', width: '4%'},
					 { text: 'Name', datafield: 'flname', width: '14%'},
					 { text: 'Reg No', datafield: 'reg_no', width: '6%'},
				     { text: 'Status',datafield: 'status', width: '4%' },
				     { text: 'Trancode',datafield: 'trancode', width: '11%' },
					 { text: 'Branch Out', datafield: 'obrhid', width: '6%' },
					 { text: 'Date Out', datafield: 'dout', width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time Out', datafield: 'tout', width: '5%'},
					 { text: 'KM Out', datafield: 'kmout', width: '6%'},
					 { text: 'Fuel Out', datafield: 'fout', width: '6%'},
					 { text: 'Branch In', datafield: 'ibrhid', width: '6%'},
					 { text: 'Date In', datafield: 'din', width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time In', datafield: 'tin', width: '4%'},
					 { text: 'KM In', datafield: 'kmin', width: '6%'},
					 { text: 'Fuel In', datafield: 'fin', width: '6%'},
					 
					]
   
    });
    $('#drvmovement').on('rowdoubleclick', function (event) {
     	var rowindex1=event.args.rowindex;
	/* 	//document.getElementById("temprow").value=         	
     	//document.getElementById("fleetno").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
			if($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "rdtype")=="MOV"){
				if($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "status")=="OUT"){
					//  var Data = document.getElementById("formData").value;
					var url=document.URL;
					//alert(url);
					 var reurl=url.split("com");
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
			} */
     });
    
  
});


</script>
<div id="drvmovement"></div>