<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>


 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
           	  %> 
           	  
           	  
           	   <style type="text/css">
      
        .yellowClass
        {
            color: green;
        }
       </style>
<script type="text/javascript">
	var temp1='<%=barchval%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas= '<%=cvd.searchVehDeatails(barchval)%>';
 
		bb=0;
}
	else{
		vehdatas;
		 bb=1;
	}
	
	
	
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }
        var cellclassname = function (row, column, value, data) {
 
            if (value=='All') {
                      return "yellowClass";
                      }
                 
                  
              };
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'tran_code', type: 'string'  },
						{name : 'st_desc', type: 'string'  },
						{name : 'value', type: 'string'  }
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#vehdetails").jqxGrid(
    {
        width: '90%',
        height: 360,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'st_desc', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
						{ text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Tran Code', datafield: 'tran_code', width: '10%',hidden:true },
					
					]
    
    });
    if(bb==1)
	{
	 $("#vehdetails").jqxGrid('addrow', null, {});
	}
    $('#vehdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
    		    $("#chart").hide();
    		    
    		    var status=$('#vehdetails').jqxGrid('getcelltext',boundIndex, "st_desc");
    		    
    	
    		     if(status=='All')
    		    	{
    		   	  $("#overlay, #PleaseWait").show();
    				  $("#grid2").show();
    				  $("#grid1").hide();
        		    var chkdatails=document.getElementById("chkdatails").value; 
        		    
        		   var  aa="chk";
        		   
        		   document.getElementById("chkgrid").value="chkgrids";
        		   
        		    
        		    var barchval = document.getElementById("cmbbranch").value;
        		    
        		    $("#fleetdiv1").load("vehiclelistgrid.jsp?chkdatails="+chkdatails+"&barchval="+barchval+"&aa="+aa);
    		    	}
    		    else
    		    	{  
    		  	  $("#overlay, #PleaseWait").show();
    			  $("#grid1").show();
    			  $("#grid2").hide();
    			  document.getElementById("chkgrid").value="";
    		    var chkdatails=document.getElementById("chkdatails").value;
    		    
    		    var descval = $('#vehdetails').jqxGrid('getcelltext',boundIndex, "tran_code");
    		    
    		    var barchval = document.getElementById("cmbbranch").value;
    		    
    		    $("#fleetdiv").load("readyToRentGrid.jsp?descval="+descval+"&chkdatails="+chkdatails+"&barchval="+barchval);
    		    
    		    
    		     	}  
    		    
    		    
    		    $('#branchwisediv').hide();
    		});
    
    

});

	
	
</script>
<div id="vehdetails"></div>