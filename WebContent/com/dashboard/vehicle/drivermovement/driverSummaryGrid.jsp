
<%-- <jsp:include page="../../../../menu.jsp"></jsp:include> --%>
<%@ page import="com.dashboard.vehicle.drivermovement.ClsDriverMovDAO" %>

 <%
    String driver = request.getParameter("driver")==null?"NA":request.getParameter("driver").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
	ClsDriverMovDAO cdmd=new ClsDriverMovDAO();

 %> 
           	  
 
<script type="text/javascript">


/* function addTab(title, url){
	if ($('#tt').tabs('exists', title)){
		$('#tt').tabs('select', title);
	} else {
	 
	 var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('#tt').tabs('add',{
			title:title,
			content:content,
			closable:true
			/* showCloseButtons: true 
		 });
	} 
	
} */ 
 var temp4='<%=driver%>';
var drvsummary;

 if(temp4!='NA')
{ 
	  
	 drvsummary='<%=cdmd.drvSummary(driver,fromdate,todate)%>'; 
	
} 
else
{ 
	
	drvsummary;

	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'hourdiff', type: 'number'  },
						{name : 'st_desc', type: 'string'  },
						{name : 'rdtype', type: 'String'  },
						{name : 'tfuel', type: 'number'  },
						{name : 'tkm', type: 'number'}
						
						
					
						
						],
				    localdata: drvsummary,
        
        
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
    
    
   
   
    
    $("#drvsummary").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  
                
					
           	         { text: 'Type', datafield: 'rdtype',  width: '20%' }, 
					 { text: 'Tran Code', datafield: 'st_desc', width: '20%'},
					 { text: 'Total Hours', datafield: 'hourdiff', width: '20%',cellsformat:'d2'},
					 { text: 'Total Fuel', datafield: 'tfuel', width: '20%',cellsformat:'d3'},
					 { text: 'Total Km', datafield: 'tkm', width: '20%',cellsformat:'d2'}
				     
					 
					]
   
    });
 
    
  
});


</script>
<div id="drvsummary"></div>