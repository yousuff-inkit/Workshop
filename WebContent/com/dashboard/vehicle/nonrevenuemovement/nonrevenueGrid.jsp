<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
 

       <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
           String expdate = request.getParameter("exdate")==null?"0":request.getParameter("exdate").trim();
           

         %> 

    	  
<script type="text/javascript">
 var temp4='<%=barchval%>';
var expdatass;

 if(temp4!='NA')
{ 
	
	 expdatass='<%=cvd.nonmovement(barchval,expdate)%>'; 
	//alert(ssss);

} 
else
{ 
	
	expdatass;

	}  
$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",  
        datafields: [   
                         {name : 'doc_no', type: 'String'  },
						 {name : 'branchname', type: 'String'  },
						 {name : 'dout', type: 'date'  }, 
						 {name : 'tout', type: 'string'  },
						 {name : 'kmout', type: 'number'  }, 
						 {name : 'fout', type: 'String'  },
						 {name : 'movetype', type: 'String'  },
						 {name : 'drorstaff', type: 'String'  },
						 {name : 'delivery', type: 'String'},
		        		 {name : 'collection', type: 'string'  },
		        		 {name : 'idealdays', type: 'string'  }
						
						],
				    localdata: expdatass,
        
        
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
    
    
   
   
    
    $("#nonmovement").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',               
        editable:true,
       
        columns: [                    
				     { text: 'DocNO', datafield: 'doc_no', editable:false, width: '5%' },
				     { text: 'Brach', datafield: 'branchname', editable:false, width: '11%' }, 
				     { text: 'OUT '+'    '+'Date',datafield: 'dout',editable:false, width: '8%',cellsformat:'dd.MM.yyyy' },
					 { text: 'Time', datafield: 'tout', editable:false,width: '6%' },
					 { text: 'Km',datafield: 'kmout', editable:false,width: '10%' },
					 { text: 'Fuel',datafield: 'fout',editable:false, width: '8%' },
					 { text: 'Movement Type', datafield: 'movetype',editable:false, width: '12%'},
					 { text: 'Usedby(Driver/Staff)', datafield: 'drorstaff',editable:false, width: '16%'},
					 { text: 'Delivery', datafield: 'delivery',editable:false, width: '6%'},
					 { text: 'Collection', datafield: 'collection', width: '6%',editable:false},
					 { text: 'Used In Days(Idle days)', datafield: 'idealdays',editable:false, width: '12%'},
					
					]
   
    });

 

    
});


</script>



<div id="nonmovement"></div>