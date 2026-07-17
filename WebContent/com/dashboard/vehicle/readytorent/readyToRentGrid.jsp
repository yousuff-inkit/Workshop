<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>



 <%
           	String descval = request.getParameter("descval")==null?"NA":request.getParameter("descval").trim();
	String chkdatails = request.getParameter("chkdatails")==null?"NA":request.getParameter("chkdatails");
	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
 
 
// String RR="RR";
 
           	  %> 
           	  
           	   <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>
<script type="text/javascript">
 var temp4='<%=descval%>';
var ssss;
var exceldata;
var aa;
if(temp4!='NA')
{ 
	//alert("in");
	ssss='<%=cvd.searchAviveh(descval,chkdatails,barchval)%>'; 
	exceldata='<%=cvd.searchAvivehexcel(descval,chkdatails,barchval)%>'; 
	
	
 

aa=0;
	
}
else
{
	
	ssss;
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
						{name : 'authority',type:'string'},
						{name : 'platecode',type:'string'},
						{name : 'cur_km', type: 'int'  },
						{name : 'srvc_km', type: 'int'  },
						{name : 'c_fuel', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'vrent', type: 'string'  },
						{name : 'renttype', type: 'string'  },
						{name : 'days', type: 'string'  },
						{name : 'empid', type: 'string'  },
						{name : 'empname', type: 'string'  },
						{name : 'grname', type: 'string'  },
						{name : 'dates', type: 'date'  },
						
						
						],
				    localdata: ssss,
        
        
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


    	  var ss= $('#jqxFleetGrid').jqxGrid('getcellvalue', row, "days");
    		          if(parseInt(ss)<0)
    		  		{
    		  		
    		  		return "yellowClass";
    		  	
    		  		}
    	    
    

    		}
    	        
    
    $("#jqxFleetGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
                  
                       { text: 'SL#', sortable: false, filterable: false, editable: false, 
                       editable: false, draggable: false, resizable: false,
                         datafield: 'sl', columntype: 'number', width: '3%',
                         cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                          }  
                          },
               
						{ text: 'Avail. Br', datafield: 'branchname',cellclassname: cellclassname /*,  width: '8%'   */},
						{ text: 'Location', datafield: 'loc_name' ,cellclassname: cellclassname/* , width: '8%' */},
						{ text: 'Group', datafield: 'gname' ,cellclassname: cellclassname/* , width: '5%' */ },
						{ text: 'Fleet', datafield: 'fleet_no' ,cellclassname: cellclassname/* , width: '5%' */  },
						{ text: 'Fleet Name', datafield: 'flname' ,cellclassname: cellclassname/* , width: '15%'  */},
						{ text: 'Type', datafield: 'empid',cellclassname: cellclassname /* , width: '4%' */ },
						{ text: 'User Name', datafield: 'empname' ,cellclassname: cellclassname , width: '12%'  },
						{ text: 'Garage', datafield: 'grname' ,cellclassname: cellclassname/* , width: '4%' */ },
						{ text: 'YOM', datafield: 'yom' ,cellclassname: cellclassname , width: '3%' },
						{ text: 'Color', datafield: 'color' ,cellclassname: cellclassname/* , width: '5%' */   },
						{ text: 'Reg No', datafield: 'reg_no' ,cellclassname: cellclassname/* , width: '6%' */   },
						{ text: 'Authority', datafield: 'authority' ,cellclassname: cellclassname/* , width: '6%' */   },
						{ text: 'Plate Code', datafield: 'platecode' ,cellclassname: cellclassname/* , width: '6%' */   },
						{ text: 'Date', datafield: 'dates' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy', width: '7%'   },

						{ text: 'Cur. KM', datafield: 'cur_km' ,cellclassname: cellclassname/* , width: '8%' */  },
						{ text: 'Due Serv.', datafield: 'srvc_km' ,cellclassname: cellclassname /* , width: '8%' */ },
						{ text: 'Fuel  ', datafield: 'c_fuel' ,cellclassname: cellclassname/* , width: '9%' */  },
						{ text: 'Rent Type', datafield: 'renttype' ,cellclassname: cellclassname /* , width: '5%'  */ },
						{ text: 'days', datafield: 'days'/* , width: '10%' */,hidden:true},
						]
    
    });
    //$('#jqxFleetGrid').jqxGrid('autoresizecolumns'); 
    
     var chkgarrage=temp4.charAt(0);
   
//alert(chkgarrage);

if(chkgarrage=="G")
{
   $('#jqxFleetGrid').jqxGrid('showcolumn', 'grname');
  
}
else
{
$('#jqxFleetGrid').jqxGrid('hidecolumn', 'grname');


}
    
    if(document.getElementById("chkdatails").value=="search")
    	{
    	   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
    	   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
    	}
    else
    	{
	   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
	   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
    
    	}
    if(aa==1)
    	{
    	 $("#jqxFleetGrid").jqxGrid('addrow', null, {});
    	}
    

         var rows = $('#jqxFleetGrid').jqxGrid('getrows');
	     var rowscounts = rows.length;
	     //document.getElementById("txttotalvehicles").value=rowscounts;
});

$("#overlay, #PleaseWait").hide();
	
</script>
<div id="jqxFleetGrid"></div>