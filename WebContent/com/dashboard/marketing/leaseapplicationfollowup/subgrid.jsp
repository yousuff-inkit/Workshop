   <%@page import="com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO"%>
     <%ClsleaseApplicationFollowupDAO cmd= new ClsleaseApplicationFollowupDAO(); %>

 <%
          
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
  	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	String salperson = request.getParameter("salperson")==null?"":request.getParameter("salperson").trim();
   %> 
<script type="text/javascript">
<%-- 	var temp1='<%=branchval%>';
	 var leasedata;
	 var bb;
	if(temp1!='NA')
{
		leasedata= '<%=cmd.subDetails(fromdate,todate,branchval) %>';
		
		bb=0;
}
	else{
		leasedata;
		 bb=1;
	} --%>
	
	var id='<%=id%>';
	var temp1='<%=branchval%>';
	 var leasedata;
	 if(id=="1"){
		 leasedata= '<%=cmd.subDetails(fromdate,todate,branchval,id,salperson) %>';
		 bb=0;
	 }
	 else{
		 leasedata=[];
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

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
               		{name : 'process', type: 'string'  },
						{name : 'count', type: 'string'  },
						{name : 'short', type: 'string'  },
						
						],
				    localdata: leasedata,
        
        
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
    
    
    $("#statusdetails").jqxGrid(
    {
        width: '92%',
        height: 136,
        source: dataAdapter,
        rowsheight:18,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Process', datafield: 'process', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'short', datafield: 'short', width: '30%', hidden:true},
					
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#statusdetails").jqxGrid('addrow', null, {});
	}
    $("#overlaysub, #PleaseWaitsub").hide();
    $('#statusdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	 document.getElementById("txtfleetno").value="";
		 document.getElementById("srno").value="";
		 document.getElementById("purdealer").value="";
		 document.getElementById("dealer").value="";
		 document.getElementById("hidpurdealer").value="";
		 document.getElementById("hiddealer").value="";
		document.getElementById("brandid").value="";
		 document.getElementById("modelid").value="";
		document.getElementById("nomonth").value="";
		 document.getElementById("vehcost").value="";
		 document.getElementById("fleetdoc").value="";
		 document.getElementById("hidfleetno").value="";
		 document.getElementById("resval").value="";
		 document.getElementById("purcost").value="";
		 document.getElementById("leaseappdoc").value="";
		 document.getElementById("vendacno").value="";
		 document.getElementById("txtalloc").value="";
		 document.getElementById("txtinv").value="";
		 document.getElementById("txtallot").value="";
		 document.getElementById("txtallotremark").value="";
		 document.getElementById("txtvehremark").value="";
 document.getElementById("txtcostval").value="";
		   document.getElementById("txtcostadd").value="";
		 document.getElementById("txtcostresult").value="";
		 var boundIndex = event.args.rowindex;
    	 var stat = $('#statusdetails').jqxGrid('getcellvalue',boundIndex, "short");
    	
    	if(stat=='NA')
    		{
    		 $('#leasefollowgridid').jqxGrid({ height: 530 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    			$('#fleetdetaildiv').hide();
 			$('#fieldvehrel').hide();
    	     $('#fieldpur').hide();
    	     $('#fieldfleet').hide();
    	     $('#fieldcomp').hide();
    		 $('#fieldnoallot').show();
    		 $('#purchasePrint').attr("disabled",true);
    		 $('#vehreleasePrint').attr("disabled",true);
    		
    		}
    	else if(stat=='VR')
		{
    		 $('#leasefollowgridid').jqxGrid({ height: 530 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    			$('#fleetdetaildiv').hide();
	     $('#fieldpur').hide();
	     $('#fieldfleet').hide();
		 $('#fieldnoallot').hide();
		 $('#fieldcomp').hide();
		 $('#fieldvehrel').show();
		 $('#purchasePrint').attr("disabled",true);
		 $('#vehreleasePrint').attr("disabled",true);
		}
    	else if(stat=='PO')
		{
    		 $('#leasefollowgridid').jqxGrid({ height: 530 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    			$('#fleetdetaildiv').hide();
			$('#fieldvehrel').hide();
	     $('#fieldfleet').hide();
		 $('#fieldnoallot').hide();
		 $('#fieldcomp').hide();
		 $('#fieldpur').show();
		 $('#purchasePrint').attr("disabled",true);
		 // $('#vehreleasePrint').attr("disabled",true);
		}
    	else if(stat=='FU')
		{
    		 $('#leasefollowgridid').jqxGrid({ height: 400 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    		 $("#fleetdetailsgrid").jqxGrid('clear');
    		 $('#fleetdetaildiv').show();
			$('#fieldvehrel').hide();
	     $('#fieldpur').hide();
	     $('#fieldnoallot').hide();
	     $('#fieldcomp').hide();
	     $('#fieldfleet').show();
	     $('#purchasePrint').attr("disabled",true);
		 $('#vehreleasePrint').attr("disabled",true);
		}
    	else if(stat=='LAC')
		{
    		 $('#leasefollowgridid').jqxGrid({ height: 530 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    			$('#fleetdetaildiv').hide();
			$('#fieldvehrel').hide();
	     $('#fieldfleet').hide();
		 $('#fieldnoallot').hide();
		 $('#fieldcomp').hide();
		 $('#fieldpur').hide();
		 $('#purchasePrint').attr("disabled",true);
		 $('#vehreleasePrint').attr("disabled",true);
		}
    	/* else if(stat=='CM')
		{
    		 $('#leasefollowgridid').jqxGrid({ height: 530 });
    		 $("#leasefollowgridid").jqxGrid('clear');
    			$('#fleetdetaildiv').hide();
			$('#fieldvehrel').hide();
	     $('#fieldfleet').hide();
		 $('#fieldnoallot').hide();
		 $('#fieldpur').hide();
		 $('#fieldcomp').show();
		 $('#purchasePrint').attr("disabled",true);
		 $('#vehreleasePrint').attr("disabled",true);
		} */
    	 document.getElementById("hidstat").value=stat;
    	 $("#overlay, #PleaseWait").show();
    		 $("#fleetdetailsgrid").jqxGrid('clear');
    		 $("#leasefollowdiv").load("leasefollowGrid.jsp?stat="+stat+"&fromdate="+'<%=fromdate%>'+"&todate="+'<%=todate%>'+"&branchval="+'<%=branchval%>'+"&salperson="+'<%=salperson%>'+"&check=1");
    	 	 
    		});
});

	
	
</script>
<div id="statusdetails"></div>