<%@ page import="com.dashboard.limousine.vehicleassignment.ClsToAssign" %>
<%
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
ClsToAssign cta=new ClsToAssign();
%> 			             	  
<style type="text/css">
  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>
<script type="text/javascript">
 var temp4='<%=branchval%>';
var ssss;
if(temp4!='NA')
{
	ssss='<%=cta.searchVehAssign(branchval)%>'; 
}
else
{
	ssss=[];
} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						
						{name : 'fleet_no', type: 'string'  },
						{name : 'reg_no', type: 'int'  },
						{name : 'pltcode', type: 'string'  },
						{name : 'brand_name', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'flname',type:'string'},
						{name : 'movdate',type:'date'},
						{name : 'movtime',type:'string'},
						{name : 'movkm',type:'number'},
						{name : 'movfuel',type:'string'}
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
    	    
    	var ofleet_no=$('#vehassignmentGrid').jqxGrid('getcellvalue', row, "ofleetno");
    		          
    	if(parseInt(ofleet_no)>0)
        	  {
        	  return "yellowClass";
        	  }
    		   
    }
    
    $("#vehassignmentGrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						
						{ text: 'Fleet No.', datafield: 'fleet_no',width: '15%', cellclassname: cellclassname  },
						{ text: 'Reg No', datafield: 'reg_no',width: '15%', cellclassname: cellclassname    },
						{ text: 'Plt Code', datafield: 'pltcode', width: '15%',cellclassname: cellclassname    },
						{ text: 'Brand', datafield: 'brand_name', cellclassname: cellclassname },
						{ text: 'Model', datafield: 'model', cellclassname: cellclassname },
						{ text: 'Fleet Name',datafield:'flname',hidden:true},
						{ text: 'Mov Date',datafield:'movdate',cellsformat:'dd.MM.yyyy',hidden:true},
						{ text: 'Mov Time',datafield:'movtime',hidden:true},
						{ text: 'Mov KM',datafield:'movkm',hidden:true,cellsformat:'d2'},
						{ text: 'Mov Fuel',datafield:'movfuel',hidden:true}
						
							]
    
    });


         var rows = $('#vehassignmentGrid').jqxGrid('getrows');
	     if(rows.length==0){
	    	 $("#vehassignmentGrid").jqxGrid('addrow', null, {});
	     }
	     $('#vehassignmentGrid').on('rowdoubleclick', function (event) {
	    	 document.getElementById("driver").value="";
	    	 document.getElementById("docno").value="";
         	var rowindex1=event.args.rowindex;
			//document.getElementById("temprow").value=         	
         	document.getElementById("fleetno").value=$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
			document.getElementById("movkm").value=$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movkm");
			$('#movdate').jqxDateTimeInput('val',$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movdate"));
			$('#movtime').jqxDateTimeInput('val',$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movtime"));
			// var values1= $('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "fleetinfo");
         	// var dd = values1.toString().replace(/\*/g, ' \n');    
         	
			/* document.getElementById("fleetdetails").value=dd; */
			var details="";
			details+="Fleet : "+$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "flname")+"\n";
			details+="Reg No : "+$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "reg_no")+" - "+$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "pltcode");
			document.getElementById("fleetdetails").value=details;
			document.getElementById("btnUpdate").disabled=false;
			document.getElementById("cmbfuel").disabled=false;
			document.getElementById("cmbfuel").value="";
			$('#fleetdate').jqxDateTimeInput('val',$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movdate"));
			$('#fleettime').jqxDateTimeInput('val',$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movtime"));
			//alert($('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movfuel"));
			document.getElementById("cmbfuel").value=$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movfuel");
			document.getElementById("km").value=$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "movkm");
			document.getElementById("hidbranch").value=$('#vehassignmentGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	     });
	     //document.getElementById("txttotalvehicles").value=rowscounts;
});

	
	
</script>
<div id="vehassignmentGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">