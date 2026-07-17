<%@page import="com.dashboard.analysis.abcfleet.*" %>
<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
ClsAbcFleetDAO fleetdao=new ClsAbcFleetDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
var fleetdata;
   if(id=='1'){
	 fleetdata='<%=fleetdao.getFleetData(branch, fromdate, todate, hidbrand, hidmodel, hidyom, temp, hidfleet)%>'; 
   }
else{
	fleetdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name: 'fleet_no',type:'String'},
						{name : 'flname',type:'String'},
						{name : 'rentchg',type:'number'},
						{name : 'exkmchg',type:'number'},
						{name : 'damagechg',type:'number'},
						{name : 'otherchg',type:'number'},
						{name : 'tax',type:'number'},
						{name : 'netbill',type:'number'},
						{name : 'km',type:'number'},
						{name : 'days',type:'number'},
						{name : 'bookingcount',type:'int'},
						{name : 'amtperbooking',type:'number'},
						{name : 'accchg',type:'number'}
                  		],
				    localdata: fleetdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#abcFleetGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
    
    var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {
        if (columnfield=="booking") {
            return '<span style="margin: 4px; float: ' + columnproperties.cellsalign + '; color: #0000ff;">' + value + '</span>';
        }
        else {
            return '<span style="margin: 4px; float: ' + columnproperties.cellsalign + '; color: #008000;">' + value + '</span>';
        }
    }
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#abcFleetGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        //localization: {thousandsSeparator: ""},
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Fleet',datafield:'fleet_no',width:'8%'},
       				{ text:'Fleet Name',datafield:'flname',width:'16%'},
       				{ text: 'Rent Earned',datafield:'rentchg',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Accessories Rental',datafield:'accchg',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Extra Kms Charged',datafield:'exkmchg',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Damages Charged',datafield:'damagechg',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Other Charges',datafield:'otherchg',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Tax',datafield:'tax',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				
       				{ text: 'Net Bill',datafield:'netbill',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Kms Run',datafield:'km',width:'10%',hidden:true,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Days Deployed',hidden:true,datafield:'days',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'No. of bookings',datafield:'bookingcount',width:'8%',align:'right',cellsalign:'right',cellsformat:'n',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Rev Per Booking',datafield:'amtperbooking',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
       				]

    });
    
  
   
});

	
	
</script>
<div id="abcFleetGrid"></div>