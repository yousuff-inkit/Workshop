<%@page import="com.dashboard.workshop.gateoutpass.*"%>
<%
ClsGateOutPassDAO godao=new ClsGateOutPassDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");
String status=request.getParameter("status")==null?"":request.getParameter("status");

%>
<style>
.redClass
   		{
   		   background:#FFEBEB;
   		}
</style>
<script type="text/javascript">

var id='<%=id%>';
var status='<%=status%>';
var data1=[];
var exceldata=[];

	if(id=='1'){
		data1='<%=godao.getGateOutData(fromdate,todate,id,gipno,regno,cldocno,status,brhid)%>';
	} 
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'voc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'gipdocno',type:'string'},
                  		{name : 'datetime',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'vehicledetails',type:'string'},
                  		{name : 'kilometer',type:'string'},
                  		{name : 'wfuel',type:'string'},
                  		{name : 'processstatus',type:'string'},
                  		{name : 'driver',type:'string'},
                  		{name : 'serviceadvisor',type:'string'},
                  		{name : 'clientinvpending',type:'number'},
                  		{name : 'jobvocno',type:'string'}
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateOutPassGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	check();
    	if(status==1){  
    		$("#gateOutPassGrid").jqxGrid('showcolumn', 'driver');
    	}else{
    		$("#gateOutPassGrid").jqxGrid('hidecolumn', 'driver');  
    	}
    	
    	});        
    
    var cellclassname = function (row, column, value, data) {
		if(data.processstatus=="10"){
	    	return "redClass";
	    }
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#gateOutPassGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        columnsheight:23,
        source: dataAdapter,
		showfilterrow:true,
        enabletooltips:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
       
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Client Inv Pending',datafield:'clientinvpending',hidden:true,width:'10%',format:'d0',cellclassname: cellclassname},
       				{ text: 'Job Card #',datafield:'jobvocno',width:'6%',cellclassname: cellclassname},
       				{ text: 'GIP #',datafield:'voc_no',width:'6%',cellclassname: cellclassname},
       				{ text: 'Date',datafield:'date',width:'8%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
       				{ text: 'User Name', datafield:'refname',cellclassname: cellclassname,width:'22%'},
       				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'30%',cellclassname: cellclassname},
       				{ text: 'Kilometer',datafield:'kilometer',width:'6%',cellclassname: cellclassname},
       				{ text: 'Fuel',datafield:'wfuel',width:'6%',cellclassname: cellclassname},
       				{ text: 'Service advisor',datafield:'serviceadvisor',width:'12%',cellclassname: cellclassname},
       				{ text: 'Driver',datafield:'driver',width:'9%',cellclassname: cellclassname},
       				{ text: 'Gateno',datafield:'gipdocno',hidden:true,cellclassname: cellclassname},
       				{ text: 'Process Status',datafield:'processstatus',hidden:true,cellclassname: cellclassname},
       				{ text: 'Date & Time',datafield:'datetime',width:'9%',cellsformat:'dd.MM.yyyy HH:mm',cellclassname: cellclassname},
       				
       				]
    });
    $('#gateOutPassGrid').on('rowdoubleclick', function (event)   
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			var gatedocno=$('#gateOutPassGrid').jqxGrid('getcellvalue', rowindex1, "gipdocno");
  	  			document.getElementById("Docno").value = $('#gateOutPassGrid').jqxGrid('getcellvalue', rowindex1, "gipdocno");
  	  			$("#overlay, #PleaseWait").show(); 
  	  			$.get('getClientInvPending.jsp',{'gatedocno':gatedocno},function(data){
  	  				data=JSON.parse(data);
  	  				$('#clientinvpending').val(data.restrictgop);
  	  				$("#overlay, #PleaseWait").hide(); 
  	  				if($('#clientinvpending').val()=='1'){
  	  					$.messager.alert('Warning','Client Invoices Pending');
  	  					return false;
  	  				}
  	  			});
      		});	 
     
  
    });

	
	
</script>
<div id="gateOutPassGrid"></div>
<input type="hidden" name="clientinvpending" id="clientinvpending">