
<%@page import="com.dashboard.workshop.gateinpassfollowup.ClsGateInPassFollowupDAO"%>
<%
           	String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
	String fromdate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
  	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
  	String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();
  	
  	ClsGateInPassFollowupDAO DAO= new ClsGateInPassFollowupDAO();
  	%> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas= '<%=DAO.subDetails(fromdate,cldocno,check,salid) %>';
		
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
                    
                 
						{name : 'statistics', type: 'string'  },
						{name : 'count', type: 'string'  },
						{name : 'rds', type: 'string'  }
						
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
    
    
    $("#userdetails").jqxGrid(
    {
        width: '92%',
        height: 150,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Statistics', datafield: 'statistics', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'RDS', datafield: 'rds', width: '30%',hidden:true},
					
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#userdetails").jqxGrid('addrow', null, {});
	}
    $('#userdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
   
    		    $("#overlay, #PleaseWait").show();
    		    var rds = $('#userdetails').jqxGrid('getcelltext',boundIndex, "rds");
    		    $('#estimate').hide();
    		     /* if(rds=='A'){
    		    	$('#estimate').show();
    		    	
    		    } 
    		    if(rds=='C'){
    		    
    		    	$('#estimate').hide();
    		    	
    		    } */
    		    if(rds=='A'){
    		    	var check=1;
    		    $("#fleetdiv").load("detailsgrid.jsp?rds="+rds+"&check="+check+"&froms="+'<%=fromdate%>'+"&cldoc="+'<%=cldocno%>'+"&salid="+'<%=salid%>'+"&process=1");
    		    }
    		    if(rds=='B'){
    		    	var check=1;
    		    $("#fleetdiv").load("detailsgrid.jsp?rds="+rds+"&check="+check+"&froms="+'<%=fromdate%>'+"&cldoc="+'<%=cldocno%>'+"&salid="+'<%=salid%>'+"&process=2");
    		    }
    		    if(rds=='C'){
    		    	var check=1;
    		    $("#fleetdiv").load("detailsgrid.jsp?rds="+rds+"&check="+check+"&froms="+'<%=fromdate%>'+"&cldoc="+'<%=cldocno%>'+"&salid="+'<%=salid%>'+"&process=4");
    		    }
    		    if(rds=='D'){
    		    	var check=1;
    		    $("#fleetdiv").load("detailsgrid.jsp?rds="+rds+"&check="+check+"&froms="+'<%=fromdate%>'+"&cldoc="+'<%=cldocno%>'+"&salid="+'<%=salid%>'+"&process=5");
    		    }
    		});
});

	
	
</script>
<div id="userdetails"></div>