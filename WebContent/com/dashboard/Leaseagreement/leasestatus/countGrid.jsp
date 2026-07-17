<%@page import="com.dashboard.leaseagreement.leasestatus.*" %>
<%ClsLeaseStatusDAO statusdao=new ClsLeaseStatusDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var countdata;
if(id=="1"){
	countdata='<%=statusdao.getCountData(branch,fromdate,todate,id)%>';
}
else{
	countdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    {name : 'srno',type:'number'},
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  }
						
						],
				    localdata: countdata,
        
        
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
    
    
    $("#countGrid").jqxGrid(
    {
        width: '100%',
        height: 170,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Sr No',datafield: 'srno',width:'10%',hidden:true},
						{ text: 'Description', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'}
						
					
					]
    
    });
    $('#countGrid').on('rowdoubleclick', function (event) 
    		{ 
    	var rowindex=event.args.rowindex;
    	$("#overlay, #PleaseWait").show();
    	var srno=$('#countGrid').jqxGrid('getcellvalue',rowindex,'srno');
    	var branch='<%=branch%>';
    	var fromdate='<%=fromdate%>';
    	var todate='<%=todate%>';
    	$('#leasestatusdiv').load('leaseStatusGrid.jsp?srno='+srno+'&id=1&branch='+branch+'&fromdate='+fromdate+'&todate='+todate);
    	if(srno=="1"){
    		 $('#lblreqdocno,#reqdocno,#btndrop,#lblreason,#reason').css('opacity','1');
    	}else{
    		 $('#lblreqdocno,#reqdocno,#btndrop,#lblreason,#reason').css('opacity','0');
    	}
    });
});

	
</script>
<div id="countGrid"></div>