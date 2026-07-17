<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>

 <%
		String  fleetval=request.getParameter("fleetval")==null?"0":request.getParameter("fleetval");
	String  brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
	String  modid=request.getParameter("modid")==null?"0":request.getParameter("modid");

       
		%>
<script type="text/javascript">

var	fleet= '<%=cvp.fleetSearch(fleetval,brandid,modid)%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						
						
						{name : 'ch_no', type: 'string'  },
						{name : 'eng_no', type: 'string'  },
						{name : 'color', type: 'string'  },
						{name : 'clrid', type: 'string'  },
						
						
						 
						
				
						],
				    localdata: fleet,
        
        
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
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Fleet', datafield: 'fleet_no', width: '10%' },
						{ text: 'Name', datafield: 'flname', width: '35%'},
						{ text: 'Reg NO', datafield: 'reg_no', width: '10%'},
						
						
						{ text: 'Chassis', datafield: 'ch_no', width: '18%'},
						{ text: 'Engine', datafield: 'eng_no', width: '17%'},
						
						
						{ text: 'Color', datafield: 'color', width: '10%'},
						{ text: 'clrdoc', datafield: 'clrid', width: '25%',hidden:true},
						
				 
						
						
						
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		  /*   document.getElementById("fleetno").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "fleet_no");
    		  v //  */
    		  var rowindex1 =$('#rowindex').val();
    		  
    		 // totper
    		 
    		 var nettotal=$('#vehoredergrid').jqxGrid('getcellvalue', rowindex1, "price");
    		 
    		 
    		 
    		  var total=document.getElementById("totalamount").value;
    			  
    		 
    		 var result=(parseFloat(nettotal)/parseFloat(total))*100;
    		  
    		  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "totper" ,result);
        
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "fleet_no" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "fleet_no"));
              
              
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "reg_no" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "reg_no"));
              
              
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "chaseno" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "ch_no"));
              
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "enginno" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "eng_no"));
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "color" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "color"));
              $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "clrid" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', boundIndex, "clrid"));
             
    
    		    
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>