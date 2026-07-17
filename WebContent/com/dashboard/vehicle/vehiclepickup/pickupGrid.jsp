<%@ page import="com.dashboard.vehicle.vehiclepickup.ClsVehiclePickUpDAO" %>
<% ClsVehiclePickUpDAO cvpd=new ClsVehiclePickUpDAO(); %>


 <%
    String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	
 %> 
           	  
 
<script type="text/javascript">
 var temp4='<%=branchval%>';

 
var pickup;
 if(temp4!='NA')
{ 
	//alert("inside");
	 pickup='<%= cvpd.getPickUpData(branchval)%>'; 
	
} 
else
{ 
	
	pickup;

	
	}  

$(document).ready(function () {
    // prepare the data
    //alert(pickup);
    var source =
    {
        datatype: "json",
        datafields: [   
                     

                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'type', type: 'String'  },
						{name : 'refname', type: 'String'  },
						{name : 'per_mob', type: 'String'  },
						{name : 'fleet_no', type: 'String'},
						{name : 'reg_no', type: 'String'},
						{name : 'startdate', type: 'String'  },						
						{name : 'starttime', type: 'String'  },
						{name : 'startfuel', type: 'String'  },
						{name : 'startkm', type: 'number'  },
						{name : 'pdate', type: 'String'  },
						{name : 'ptime', type: 'String'  },
						{name : 'pfuel', type: 'string'  },
						{name : 'pkm', type: 'number'  },
						{name : 'branch', type: 'string'  },
						{name : 'reftype', type: 'string'  },
						{name : 'cldocno', type: 'string'  },
						{name : 'flname', type: 'string'  },
						],
				    localdata: pickup,
        
        
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
    
    
   
   
    
    $("#pickupgrid").jqxGrid(
    {
        width: '98%',
        height: 560,
        source: dataAdapter,
       // showaggregates:true,
       // enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
      //  pagermode: 'default',
      //  editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
				 //   { text: 'Original Doc No',datafield: 'doc_no', width: '5%',hidden:true},
				    { text: 'Doc No',datafield: 'doc_no', width: '5%',hidden:true }, 
				    { text: 'Client',datafield: 'refname', width: '18%' },
					{ text: 'MOB', datafield: 'per_mob', width: '8%' },
					{ text: 'Fleet', datafield: 'fleet_no', width: '7%'},
					{ text: 'Reg No',datafield: 'reg_no',width:'7%'},
					{ text: 'Start Date',datafield:'startdate',width:'7%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Start Time',datafield:'starttime',width:'7%'},
					{ text: 'Start Fuel',datafield:'startfuel',width:'7%'},
					{ text: 'Start Km',datafield:'startkm',width:'7%'},
					{ text: 'Pick Up Date',datafield:'pdate',width:'7%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Pick Up Time',datafield:'ptime',width:'7%'},
					{ text: 'Pick Up Fuel',datafield:'pfuel',width:'7%'},
					{ text: 'Pick Up Km',datafield:'pkm',width:'7%',cellsformat:'d2'},
					{ text: 'branch', datafield: 'brhid', width: '7%',hidden:true},
					{ text: 'reftype', datafield: 'reftype', width: '7%',hidden:true},
					{ text: 'cldocno', datafield: 'cldocno', width: '7%',hidden:true},
					{ text: 'flname', datafield: 'flname', width: '7%',hidden:true}
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#pickupgrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  
	  document.getElementById("agmtdetails").innerText="Fleet: "+$('#pickupgrid').jqxGrid('getcellvalue', rowindex1, "flname")+" Reg No: "+$('#pickupgrid').jqxGrid('getcellvalue', rowindex1, "reg_no")+"\n"+
	  "Client: "+$('#pickupgrid').jqxGrid('getcellvalue', rowindex1, "refname")+"";
	  document.getElementById("docno").value=$('#pickupgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	 
    		 });	 
   
 
});


</script>
<div id="pickupgrid"></div>