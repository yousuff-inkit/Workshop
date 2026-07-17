<%@page import="com.dashboard.leaseagreement.leasestatus.*" %>
<%ClsLeaseStatusDAO statusdao=new ClsLeaseStatusDAO();
String srno=request.getParameter("srno")==null?"":request.getParameter("srno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%>
<script type="text/javascript">
var statusdata;
var id='<%=id%>';
if(id=="1"){
	statusdata='<%=statusdao.getData(srno,id,branch,fromdate,todate)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'reqdocno', type: 'number'},
						{name : 'reqvocno',type:'number'},
						{name : 'reqsrno',type:'number'},
						{name : 'refname', type: 'string'},
						{name : 'brand', type: 'string'},
						{name : 'model',type:'string'},
						{name : 'leasefromdate', type: 'date'},
						{name : 'specification',type:'number'},
						{name : 'color',type:'number'},
						{name : 'leasemonths', type: 'String'},
						{name : 'qty',type:'number'},
						{name : 'branch',type:'string'}

						],
				    localdata: statusdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#leaseStatusGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#leaseStatusGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
					 { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					 },
                  	 { text: 'Req No', datafield: 'reqdocno', width: '8%',hidden:true},
                  	 { text: 'Req No',datafield:'reqvocno',width:'8%'},
				     { text: 'Req Srno', datafield:'reqsrno', width: '10%',hidden:true},
				     { text: 'Lease Date',datafield: 'leasefromdate', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Client',datafield:'refname',width:'20%'},
				     { text: 'Brand',datafield: 'brand', width: '10%'},
				     { text: 'Model',datafield: 'model', width: '15%'},
				     { text: 'Color',datafield: 'color',width:'10%'},
				     { text: 'Specification', datafield: 'cldocno', width: '16%' },
					 { text: 'Quantity', datafield: 'qty', width: '8%'},
					 { text: 'Branch',datafield:'branch',width:'8%',hidden:true}
				     
					 
					
					]
   
    });

    $('#leaseStatusGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	var srno='<%=srno%>';
    	if(srno=="1"){
    		document.getElementById("reqdocno").value=$('#leaseStatusGrid').jqxGrid('getcellvalue',rowindex,'reqvocno');
    		document.getElementById("reqsrno").value=$('#leaseStatusGrid').jqxGrid('getcellvalue',rowindex,'reqsrno');
    		document.getElementById("reqbranch").value=$('#leaseStatusGrid').jqxGrid('getcellvalue',rowindex,'branch');
    	}
    }); 
});
                     
  
</script>
<div id="leaseStatusGrid"></div>