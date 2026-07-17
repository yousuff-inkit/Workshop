   <%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
     <%ClsMarketingDAO cmd= new ClsMarketingDAO(); %>

 <%
          
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
  	
   %> 
   
<script type="text/javascript">
//alert("fdg;lfp");
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
	
	<%-- /*  */var id='<%=id%>'; --%>
	var temp1='<%=barchval%>';
	 var leasedata;
	 if(temp1!='NA'){
		 leasedata= '<%=cmd.BookingDetails(barchval,fromdate,todate) %>';
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
               		{name : 'description', type: 'string'  },
						{name : 'count', type: 'string'  },
						{name :'code',type:'String'},
						//{name : 'short', type: 'string'  },
						
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

						{ text: 'Description', datafield: 'description', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Code', datafield: 'code', width: '30%', hidden: true},
					
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
    	

	    var boundIndex = event.args.rowindex;
	    var barchval = document.getElementById("cmbbranch").value;
	    var fromdate= $("#fromdate").val();
		var todate= $("#todate").val();


	    $("#overlay, #PleaseWait").show();
	    var code = $('#statusdetails').jqxGrid('getcelltext',boundIndex, "code");
	    $("#booklistdiv").load("bookinglistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&code="+code);
    		    

    		});
});

	
	
</script>
<div id="statusdetails"></div>