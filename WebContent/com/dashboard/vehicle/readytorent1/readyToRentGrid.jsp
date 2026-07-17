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
  .yellowClass
        {
        
       
       background-color: #A4A4A4; 
        /*   background-color: #eedd82;  */
        }
</style>
             	  
<script type="text/javascript">
 var temp4='<%=brch%>';
var sssss;
var aa;
if(temp4!='NA')
{ 
	//alert("in");
	sssss='<%=cvd.searchReadyToRent(brch)%>'; 
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
						{name : 'idealdys', type: 'number'  },
						{name : 'branchid', type: 'string'  },
						{name : 'groupid', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						{name : 'days', type: 'string'  },
						{name : 'permanent', type: 'string'  },
						
						{name : 'ofleet_no', type: 'number'  },
						
						
						
						
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
    var cellclassname =  function (row, column, value, data) {


/*   var ss= $('#jqxFleetGrid').jqxGrid('getcellvalue', row, "days");
	          if(parseInt(ss)<0)
	  		{
	  		
	  		return "yellowClass";
	  	
	  		} */
    var ofleet_no=$('#jqxFleetGrid').jqxGrid('getcellvalue', row, "ofleet_no");
	          
	          if(parseInt(ofleet_no)>0)
	        	  {
	        	  
	        	  return "yellowClass";
	        	  }
	          
    	/* return "greyClass";
    	
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
	         return element[0].outerHTML;
*/

	}
        
    
    $("#jqxFleetGrid").jqxGrid(
    {
        width: '98%',
        height: 380,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        rowsheight:20,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,

        columns: [
                         { text: 'ofleet_no', datafield: 'ofleet_no', width: '8%'  ,hidden:true},         
						{ text: 'Avail. Br', datafield: 'branchname', width: '8%',cellclassname: cellclassname   },
						{ text: 'Location', datafield: 'loc_name', width: '8%',cellclassname: cellclassname  },
						{ text: 'Group', datafield: 'gname', width: '5%' ,cellclassname: cellclassname  },
						{ text: 'Brand', datafield: 'brand_name', width: '7%' ,cellclassname: cellclassname  },
						{ text: 'Fleet', datafield: 'fleet_no', width: '5%'  ,cellclassname: cellclassname },
						{ text: 'Fleet Name', datafield: 'flname', width: '14%',cellclassname: cellclassname  },
						{ text: 'YOM', datafield: 'yom', width: '4%' ,cellclassname: cellclassname  },
						{ text: 'Color', datafield: 'color', width: '5%'  ,cellclassname: cellclassname  },
						{ text: 'Reg No', datafield: 'reg_no', width: '6%'  ,cellclassname: cellclassname   },
						{ text: 'Cur. KM', datafield: 'kmin', width: '7%'  ,cellclassname: cellclassname  },
						{ text: 'Due Serv. KM', datafield: 'srvc_km', width: '7%'  ,cellclassname: cellclassname },
						{ text: 'Fuel', datafield: 'fin', width: '9%',cellclassname: cellclassname  },
						{ text: 'Rent Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname  },
						{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'},
	{ text: 'Permanent', datafield: 'permanent', width: '6%' ,cellclassname: cellclassname  },
						{ text: 'branchid', datafield: 'branchid', width: '10%',hidden:true},
						{ text: 'groupid', datafield: 'groupid', width: '10%',hidden:true},
						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'days', datafield: 'days', width: '10%',hidden:true},
						
						]
    
    });
    
    if(aa==1)
    	{
    	 $("#jqxFleetGrid").jqxGrid('addrow', null, {});
    	}
   

    $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  
	  
	  var branchid=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "branchid");
	  
     var groupval=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "groupid"); 
     
     document.getElementById("docno").value=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
     
     document.getElementById("brach").value=branchid;
     document.getElementById("grp").value=groupval;
    
    $("#mastertariff").load("masterTariffgrid.jsp?branchid="+branchid+"&groupval="+groupval); 
    $("#tariffdiv").load("tariffShowgrid.jsp");
 
    document.getElementById("fleetno").value=$('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
   
	 $('#btnvehicle').attr("disabled",false);
	 $('#btnmove').attr("disabled",false);
	 $('#btnclient').attr("disabled",false);
    
    		}); 
    
});

	
	
</script>
<div id="jqxFleetGrid"></div>