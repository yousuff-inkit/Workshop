

  <%@page import="com.dashboard.salik.salikdetails.ClsSalikdetailsDAO"%> 
 
 <%
 
 ClsSalikdetailsDAO showDAO = new  ClsSalikdetailsDAO();
           	String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
	String fromdate = request.getParameter("from")==null?"0":request.getParameter("from").trim();
  	String todate = request.getParameter("to")==null?"0":request.getParameter("to").trim();
  	 String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	String chkincrecv = request.getParameter("chkincrecv")==null?"0":request.getParameter("chkincrecv").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas;
	 var bb;
	 var id='<%=id%>';
	if(temp1!='NA')
{
		// alert("===="+temp1);
		if(id=="1"){
			vehdatas= '<%=showDAO.subDetails(fromdate,todate,id,chkincrecv)%>'; 			
		}
		
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

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 
						{name : 'status', type: 'string'  },
						{name : 'value', type: 'string'  },
						{name : 'relodestatus', type: 'string'  }
						
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
        height: 300,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'relodestatus', width: '30%',hidden:true},
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#vehdetails").jqxGrid('addrow', null, {});
	}
    $('#vehdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
  
    		    $("#overlay, #PleaseWait").show();
 
    		    
    		    var relodestatus = $('#vehdetails').jqxGrid('getcelltext',boundIndex, "relodestatus");

    		    
    		    $("#fleetdiv").load("detailsgrid.jsp?relodestatus="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>'+"&chkincrecv="+'<%=chkincrecv%>');
    		});
 $("#suboverlay, #subPleaseWait").hide();
});

	
	
</script>
<div id="vehdetails"></div>