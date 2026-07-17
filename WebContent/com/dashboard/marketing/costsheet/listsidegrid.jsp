 <%@page import="com.dashboard.marketing.costsheet.ClscostSheetDAO" %>
 
 <%ClscostSheetDAO vewDAO= new ClscostSheetDAO();
 
 
           	String grpid = request.getParameter("grpid")==null?"NA":request.getParameter("grpid").trim();
	String doc_no = request.getParameter("doc_no")==null?"NA":request.getParameter("doc_no").trim();
           	  %> 
           	  
           	  
           	   <style type="text/css">
      
        .yellowClass
        {
            color: green;
        }
       </style>
<script type="text/javascript">
	var temp1='<%=grpid%>';
	 var data;
	 var bb;
	if(temp1!='NA')
{
		data= '<%=vewDAO.loadbeanAndmodel(grpid)%>';
 
		bb=0;
}
	else{
		data;
		 bb=1;
	}
	
	
	
$(document).ready(function () {
	 
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'brand_name', type: 'string'  },
					{name : 'model_name', type: 'string'  },
						 
						
						],
				    localdata: data,
        
        
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
    
    
    $("#subsidegrid").jqxGrid(
    {
        width: '100%',
        height: 360,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
       // showstatusbar:true,
        //statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Brand', datafield: 'brand_name', width: '50%'  },
						{ text: 'Model', datafield: 'model_name', width: '50%' },
						 
					
					]
    
    });
    if(bb==1)
	{
	 $("#subsidegrid").jqxGrid('addrow', null, {});
	}
    
    

});

	
	
</script>
<div id="subsidegrid"></div>