<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>


 <%
           	String barchval = request.getParameter("branchid")==null?"NA":request.getParameter("branchid").trim();
          String groupval = request.getParameter("groupval")==null?"NA":request.getParameter("groupval").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=barchval%>';
	 var taridatas;
	 var bb;
	if(temp1!='NA')
{
		taridatas= '<%=cvd.searchmasterTariff(barchval,groupval)%>';
		bb=0;
}
	else{
		taridatas;
		 bb=1;
	}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'doc_no', type: 'string'  },
						{name : 'tariftype', type: 'string'  },
						
						],
				    localdata: taridatas,
        
        
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
    
    
    $("#maintariffGrid").jqxGrid(
    {
        width: '90%',
        height: 260,
        source: dataAdapter,
        rowsheight:20,
    
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
              	          { text: 'Doc NO', datafield: 'doc_no', width: '30%'},
						{ text: 'Tariff Type', datafield: 'tariftype', width: '70%' },
					
					
					
					]
    
    });
  /*   if(bb==1)
	{
	 $("#maintariffGrid").jqxGrid('addrow', null, {});
	} */
    $('#maintariffGrid').on('rowdoubleclick', function (event) 
    		{ 
    		
    		    var boundIndex = event.args.rowindex;
    		    var descval = $('#maintariffGrid').jqxGrid('getcelltext',boundIndex, "doc_no");
    		    
    		    var branchid=document.getElementById("brach").value;
    		    var group=document.getElementById("grp").value;
    		   

    		    
    		    $("#tariffdiv").load("tariffShowgrid.jsp?docval="+descval+"&groupval="+group+"&branchval="+branchid);
    		});
});

	
	
</script>
<div id="maintariffGrid"></div>