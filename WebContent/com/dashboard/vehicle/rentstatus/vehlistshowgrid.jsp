<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
 
 <%
 			String brch=request.getParameter("brchval")==null?"NA":request.getParameter("brchval").trim();


           	  %> 
           	  
    <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }

</style>
             	  
<script type="text/javascript">
 var temp4='<%=brch%>';
var sssss;
var aa;
if(temp4!='NA')
{ 
	//alert("in");
	sssss='<%=cvd.searchrentstatus(brch)%>'; 
	//alert(ssss);
aa=0;
	
}
else
{
	
	sssss;
	 aa=1;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'branchname' , type: 'string' },
						{name : 'loc_name', type: 'string'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'brand_name', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  },
						{name : 'color', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'kmin', type: 'int'  },
						{name : 'srvc_km', type: 'int'  },
						{name : 'fin', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'vrent', type: 'string'  },
						{name : 'renttype', type: 'string'  },
						{name : 'branchid', type: 'string'  },
						{name : 'groupid', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						
						
						
						],
				    localdata: sssss,
        
        
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
    
    
    $("#jqxFleetGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        rowsheight:20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
               
						{ text: 'Avail. Br', datafield: 'branchname', width: '10%' },
						{ text: 'Location', datafield: 'loc_name', width: '10%'},
						{ text: 'Group', datafield: 'gname', width: '5%' },
						{ text: 'Brand', datafield: 'brand_name', width: '10%' },
						{ text: 'Fleet', datafield: 'fleet_no', width: '5%'  },
						{ text: 'Fleet Name', datafield: 'flname', width: '17%' },
						{ text: 'YOM', datafield: 'yom', width: '4%' },
						{ text: 'Color', datafield: 'color', width: '5%'   },
						{ text: 'Reg No', datafield: 'reg_no', width: '6%'   },
						{ text: 'Cur. KM', datafield: 'kmin', width: '6%'  },
						{ text: 'Due Serv. KM', datafield: 'srvc_km', width: '8%' },
						{ text: 'Fuel', datafield: 'fin', width: '9%'  },
						{ text: 'Rent Type', datafield: 'renttype', width: '5%',cellclassname: 'advanceClass' },
						{ text: 'branchid', datafield: 'branchid', width: '10%',hidden:true},
						{ text: 'groupid', datafield: 'groupid', width: '10%',hidden:true},
						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true},
						
						
						]
    
    });
    /* 
    if(aa==1)
    	{
    	 $("#jqxFleetGrid").jqxGrid('addrow', null, {});
    	}
    */

    $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  
	  
	  var branchid=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "branchid");
	  
     var groupval=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "groupid"); 
     
     document.getElementById("docno").value=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
     
     document.getElementById("brach").value=branchid;
     document.getElementById("grp").value=groupval;
    

 
    document.getElementById("fleetno").value=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
    document.getElementById("typeingrid").value=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "renttype");
    
    
    
   
	 $('#btnvehicle').attr("disabled",false);
	 $('#btnmove').attr("disabled",false);
	 $('#btnupdate').attr("disabled",false);
	 
	 $('#rentaltype').attr("disabled",false);
	 $('#fleetno').attr("disabled",false);
    
    		}); 
    
});

	
	
</script>
<div id="jqxFleetGrid"></div>